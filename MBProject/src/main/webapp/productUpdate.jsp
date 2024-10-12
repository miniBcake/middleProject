<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"
   import="java.util.ArrayList, java.util.HashMap, java.util.Map, java.util.List"%>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>

<html>
<head>
<title>갈빵질빵 - 상품 정보 수정</title>
<meta charset="utf-8" />
<meta name="viewport"
   content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />

</head>

<body class="subpage">
   <div id="page-wrapper">

      <!-- Header -->
      <custom:header />

      <!-- Content -->
     <form action="productUpdate.do" id="productUpdateForm" method="POST" enctype="multipart/form-data">
      <section id="content">
         <div class="container">
            <div class="row">
               <div class="col-3 col-12-medium">

                  <!-- Sidebar -->
                     <section>
                        <header>
                           <h2>상품 정보 수정</h2>
                           <input type="hidden" id="productNum" name="productNum" value="${product.productNum}" />
                           <input type="hidden" id="boardNum" name="boardNum" value="${product.boardNum}" />
                        </header>
                        <!-- 수정 코드 -->
                        <div>
                           <label for="productName">상품명</label> <input type="text"
                              id="productName" name="productName" value="${product.productName}"
                              required>
                        </div>
                        <div>
                           <label for="productPrice">상품 가격</label> <input type="number"
                              id="productPrice" name="productPrice" value="${product.productPrice}"
                              required> 원
                        </div>
                        <div>
                           <label for="productTitle">상품 제목</label> <input type="text"
                              id="productTitle" name="productTitle" value="${product.boardTitle}"
                              required>
                        </div>
                        <br>
                        <div>
                        <select id="productCateName" name="productCateName" value="${product.productCateName}">
	                        <option value="stationery">문구류</option>
	                        <option value="accessory">악세사리</option>
	                        <option value="daily">생활용품</option>
	                        <option value="clothes">의류</option>
	                        <option value="electronics">전자제품 및 관련 상품</option>
                        </select>
                        </div>
                        <br>
						<div>
						    <label for="productPic">상품 사진</label>
						    <input type="file" id="productPic" name="productPic" accept="image/*" onchange="previewImage(event)">
						    
						    <!-- 기존 이미지 미리보기 -->
						    <c:if test="${not empty product.productProfileWay}">
						        <img id="imagePreview" src="${product.productProfileWay}" alt="상품 사진" style="max-width: 200px; height: auto;">
						    </c:if>
						</div>
                     </section>
               </div>
               <script>
				// 이미지 미리보기 기능을 위한 자바스크립트 함수
				function previewImage(event) {
				    var reader = new FileReader(); // 파일을 읽기 위한 FileReader 객체 생성
				    reader.onload = function() {
				        var output = document.getElementById('imagePreview'); // 이미지 미리보기 요소
				        output.src = reader.result; // 선택된 파일을 이미지 미리보기로 설정
				    };
				    reader.readAsDataURL(event.target.files[0]); // 파일을 읽어서 데이터 URL로 변환
				}
				</script>
               <div class="col-9 col-12-medium imp-medium">

                  <!-- Main Content -->
                  <section>
                  
                        <h2>상품 상세 정보 게시글</h2>
                     
                     <section>
                        <div>
                           <label for="productDetailTitle"><span>${product.productName}</span></label>
                           <input type="hidden" id="productDetailTitle"
                              name="productDetailTitle">
                        </div>
                        <br>
                        <!-- CKEditor를 사용할 게시글 내용 입력 필드 -->
                        <div>
                           <label for="productDetailContent">상품 상세 정보</label><br>
                           <!-- 기존 내용이 있을 경우 입력 필드에 표시 -->
                           <textarea id="productDetailContent" name="productDetailContent">
                                <c:out value="${product.boardContent}" escapeXml="false" />
                           </textarea>
                           <!-- 게시글 등록 버튼 -->
                        </div>
                     </section>
                           <button class="btn btn-primary w-100 py-3" id="postButton"
                              type="submit">상품 정보 수정</button>
                  </section>
               </div>
            </div>
         </div>
      </section>
                        </form>

      <custom:footer />
   </div>

   <!-- Scripts -->
   <script src="assets/js/jquery.min.js"></script>
   <script src="assets/js/browser.min.js"></script>
   <script src="assets/js/breakpoints.min.js"></script>
   <script src="assets/js/util.js"></script>
   <script src="assets/js/main.js"></script>

   <!-- CKEditor 5 스크립트 로드 -->
   <!-- CKEditor 메인 라이브러리 (ckeditor.js): 이 스크립트는 CKEditor 5의 메인 라이브러리 파일입니다. ckeditor.js는 CKEditor 에디터의 핵심 기능을 제공합니다. -->
   <script
      src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
   <script
      src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>


   <!-- CKEditor Scripts -->
   <script>
   let editorInstance;
   let previousData = ''; // 이전 에디터 데이터를 저장할 변수
   console.log("[DEBUG] CKEDitor 인스턴스 저장 변수 생성 완료");
   
   const fileUploadUrl = '<%= request.getAttribute("uploadUrl") %>';
   const fileDeleteUrl = '<%= request.getAttribute("deleteUrl") %>';
   
      
   //페이지 로드 시 CKEditor 인스턴스 초기화
   document.addEventListener('DOMContentLoaded', () => {
      console.log("[DEBUG] CKEDitor초기화 완료 업로드 시작:");
      ClassicEditor
       .create(document.querySelector('#productDetailContent'), { // CKEditor의 ClassicEditor.create() 메서드를 사용하여 CKEditor 인스턴스를 생성합니다. 이 메서드는 주어진 DOM 요소(여기서는 #postContent)에 CKEditor를 초기화합니다.
           language: 'ko',         
           ckfinder: { // ckfinder 설정은 CKEditor에서 파일 업로드와 관련된 기능을 관리하는 부분입니다
               uploadUrl: fileUploadUrl, // 업로드 처리 url
               options: { 
                   resourceType: 'Images', 
                   deleteUrl: fileDeleteUrl // 삭제 처리 url
               }
           },
           height: 500
       })
       .then(editor => {
           editorInstance = editor; // CKEditor가 사용자가 입력한 값으로 초기화가 되었을 때 실행되는 함수입니다.
           // 초기 데이터 설정
           const initialContent = `<c:out value="${product.boardContent}" escapeXml="false" />`;
           editor.setData(initialContent);
           // 초기 데이터 설정 후 previousData에 저장
           previousData = editor.getData();
           console.log("[DEBUG] CKEditor 초기화 완료, 기존 데이터 로드됨:", previousData);
           
           // 에디터 데이터 변경 감지
           editor.model.document.on('change:data', () => { // editor의 데이터를 변경될 때 마다 호출되는 이벤트
              // CKEditor가 초기화되면 editorInstance에 CKEditor 인스턴스를 저장합니다.
              
               const currentData = editor.getData(); // 현재의 데이터에 editor에 작성된 data를 덮어씌우기
               console.log("[DEBUG] 현재 에디터 데이터:", currentData);
               
               if (previousData) { // 이 조건문은 previousData 변수가 존재할 때만 실행됩니다. / 이전 데이터
                   const deletedImages = findDeletedImages(previousData, currentData); // findDeletedImages 함수가 두 값을 비교하여 삭제된 url을 찾습니다. (281번줄 함수 수행)
                   deletedImages.forEach(imageUrl => { // deletedImages == 삭제된 이미지를 담고 있는 배열 / imageUrl == 배열의 현재 요소 즉 삭제할 이미지의 url
                      // change:data (281번) 이벤트를 통해 사용자가 에디터의 데이터를 변경할 때마다 현재의 데이터(currentData)를 가져와서 이전 데이터(previousData)와 비교합니다.
                      // 이전 데이터와 현재 데이터의 차이를 분석하여 삭제된 이미지 URL을 찾고, 이를 삭제하는 함수(deleteFile)를 호출합니다.
                       console.log("[INFO] 삭제 요청할 이미지 URL:", imageUrl);
                       deleteFile(imageUrl); // deleteFile 함수는 imageUrl을 인자로 받아 해당 이미지 파일을 서버에서 삭제하도록 요청합니다.
                   });
               }
               
               previousData = currentData; // 현재 데이터를 previousData 변수에 저장하여 다음 데이터 변경 시 비교할 수 있게 합니다.
               console.log("[DEBUG] 이전 에디터 데이터 업데이트됨");
           });
       })
       .catch(error => {
           console.error("[ERROR] CKEditor 초기화 실패:", error);
       });
   });
   
//-------------------------------------------------------------------------<수행되는 함수>---------------------------------------------------------------------------------------//
   
   
   function deleteFile(filePath) {
   	// 서버에서 설정된 deleteUrl을 JSP에서 JavaScript로 전달
    const deleteUrl = '<%= request.getAttribute("deleteFetchUrl") %>'; 
    //ckEditor.delteFileFetchUrl=/MBProject/FileUpload?action=delete&filePath=
    console.log("[INFO] 파일 삭제 요청 중:", filePath); // 파일 삭제 요청 로그
    fetch(deleteUrl + encodeURIComponent(filePath), { // 파일 삭제 요청을 서버로 보냄
                                                 // ncodeURIComponent(filePath)는 파일 경로에 포함될 수 있는 특수 문자를 URL 인코딩하여 URL의 안전성을 확보합니다.
       method: 'POST',
         headers: {
             'Content-Type': 'application/x-www-form-urlencoded' // 명시적으로 Content-Type 설정
         }
    })
    .then(response => response.json()) // 응답을 JSON으로 파싱 / 
    .then(data => {
        if (data.deleted) {
            console.log('[INFO] 파일이 성공적으로 삭제되었습니다.'); // 파일 삭제 성공 로그
        } else {
            console.error('[ERROR] 파일 삭제 실패:', data.message); // 파일 삭제 실패 로그
        }
    })
    .catch(error => console.error('[ERROR] 파일 삭제 요청 오류:', error)); // 파일 삭제 요청 중 오류 발생 시 로그
   }
   
//------------------------------------------------------------------------------------------------------------------------------------------------------------------//
   
   // < 서버에 보낼 삭제된 url을 전송할 때 삭제된 이미지의 url을 찾는 함수 >
   //이전 데이터와 현재 데이터를 비교하여 삭제된 이미지를 찾는 함수
   function findDeletedImages(previousData, currentData) {
    // 이전 데이터에서 이미지 URL을 추출
    const prevImageUrls = Array.from(previousData.matchAll(/<img[^>]+src="([^">]+)"/g)).map(match => match[1]);
    console.log("[DEBUG] 이전 이미지 URL 목록:", prevImageUrls); // 이전 이미지 URL 목록 로그
    // prevImageUrls: 함수가 실행될 때, previousData로부터 이미지 URL들을 추출하여 동적으로 생성됩니다. 이전 데이터에 포함된 이미지 URL 목록을 담고 있습니다.

  
    // 현재 데이터에서 이미지 URL을 추출
    const currImageUrls = Array.from(currentData.matchAll(/<img[^>]+src="([^">]+)"/g)).map(match => match[1]);
    console.log("[DEBUG] 현재 이미지 URL 목록:", currImageUrls); // 현재 이미지 URL 목록 로그
    //currImageUrls: 함수가 실행될 때, currentData로부터 이미지 URL들을 추출하여 동적으로 생성됩니다. 현재 데이터에 포함된 이미지 URL 목록을 담고 있습니다.

   
    // 이전 데이터에 있었으나 현재 데이터에 없는 이미지 URL을 필터링하여 반환
    const deletedImages = prevImageUrls.filter(url => !currImageUrls.includes(url));
    console.log("[DEBUG] 삭제된 이미지 URL 목록:", deletedImages); // 삭제된 이미지 URL 목록 로그
    return deletedImages;
    }
   
//------------------------------------------------------------------------------------------------------------------------------------------------------------------//
   
   // CKEditor에서 입력된 데이터에서 이미지 경로를 추출하는 함수
   function getImagePathsFromEditorData(editorData) {
    // editorData에서 <img> 태그의 src 속성을 찾아서 배열로 반환
       return Array.from(editorData.matchAll(/<img[^>]+src="([^">]+)"/g)).map(match => match[1]);
   }
   
 //------------------------------------------------------------------------------------------------------------------------------------------------------------------//
   
    // CKEditor에서 입력된 데이터 가져오기
    function getEditorData() {
        if (editorInstance) {
            return editorInstance.getData(); // CKEditor에서 데이터 가져오기
        }
        return ''; // CKEditor가 초기화되지 않았을 경우 빈 문자열 반환
    }

//------------------------------------------------------------------------------------------------------------------------------------------------------------------//

    // 게시글 등록 함수
    function submitPost() { 
    	const submitPostFetchUrl = '<%= request.getAttribute("submitPostProductFetchUrl") %>';
        const formData = new FormData(); // 전달할 데이터를 담을 변수 생성 / 주로 파일 업로드, 텍스트 필드, 체크박스 등 다양한 폼 필드를 서버로 전송할 때 사용
        const editorData = getEditorData(); // CKEditor에 작성된 데이터를 담을 변수 생성 / 이 함수는 CKEditor의 인스턴스에서 현재 작성된 콘텐츠를 문자열 형태로 반환
		
        formData.append('productNum', document.getElementById('productNum').value);   // 상품 번호
        formData.append('boardNum', document.getElementById('boardNum').value); // 상품 이름
        
        formData.append('productName', document.getElementById('productName').value); // 상품 이름
        formData.append('productPrice', document.getElementById('productPrice').value); // 상품 가격
        formData.append('boardTitle', document.getElementById('productTitle').value); // 상품 소개 제목
        formData.append('productCateName', document.getElementById('productCateName').value); // 카테고리
        
        //boardTitle 은 productName으로 고정
        formData.append('boardContent', editorData); // CKEditor 데이터 : 게시판 내용
        // 파일 업로드 처리
        const productProfileWay = document.getElementById('productPic').files[0];
        if (productProfileWay) {
            formData.append('productProfileWay', productProfileWay);
        } else {
            console.log('[INFO] 파일이 선택되지 않았습니다.');
        }

        const imagePaths = getImagePathsFromEditorData(editorData).join(','); // CKEditor의 콘텐츠(editorData)에서 이미지 URL을 추출 하는 함수
        console.log('[INFO] Image 경로 전송 직전:', imagePaths);
        formData.append('newImagePath', imagePaths); // formData객체에 imagePaths 값을 추가

        console.log('[DEBUG] Form Data:', formData);

        return fetch(submitPostFetchUrl, { // fetch 함수는 웹 브라우저에서 HTTP 요청을 보내는 메서드 / 첫번째 인자에서는 요청을 보낼 url을 지정
            method: 'POST', // 두 번째 인자는 요청의 옵션을 설정하는 객체 여기서는 HTTP 메서드와 요청 본문(body)을 설정
            body: formData // FormData 객체를 그대로 전송
            });
        }
   		 // 게시글 등록 버튼 클릭 시 게시글 등록 함수 호출
	    document.getElementById('postButton').addEventListener('click', (event) => { // 사용자가 게시글 등록 버튼을 누르면 수행되는 함수
	        event.preventDefault(); // 기본 폼 제출 동작 방지
	        submitPost() // submitPost()함수 실행 시작 / fetch 함수가 실행된 후 promise를 반환하므로 이 함수도 promise를 반환
	        .then(response => { // fetch 함수가 호출이 완료되면 반환된 promise가 해결됨
	            if (response.ok) { // response.ok는 서버로부터 응답받은 성공 여부 (게시글 등록)
	                alert('상품이 성공적으로 수정되었습니다!'); // 성공이라면 alert에 게시글 등록 성공 출력
	                window.location.href="mainPage.do";
	            } else { // 실패라면 게시글 등록 실패 출력
	                alert('상품 등록에 실패했습니다.');
	            }
	        });
	    });
</script>


</body>
</html>