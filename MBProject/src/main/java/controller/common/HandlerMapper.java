package controller.common;

import java.util.HashMap;
import java.util.Map;

import controller.board.DeleteBoardAction;
import controller.board.ListBoardsAction;
import controller.board.SearchBoardsAction;
import controller.board.ViewBoardAction;
import controller.member.CheckPasswordAction;
import controller.member.LoginAction;
import controller.member.LogoutAction;
import controller.member.MemberDeleteAction;
import controller.member.UpdatePwAction;
import controller.member.ViewMemberAction;
import controller.page.CheckBoardPageAction;
import controller.page.CheckPasswordPageAction;
import controller.page.CheckProductPageAction;
import controller.page.DeleteMemberPageAction;
import controller.page.FailInfoPageAction;
import controller.page.FindPwPage;
import controller.page.InsertStorePageAction;
import controller.page.JoinPageAction;
import controller.page.LoginPageAction;
//import controller.page.LikeBoardListPageAction;
import controller.page.MainPageAction;
import controller.page.MyBoardListPageAction;
import controller.page.MyPageAction;
import controller.page.NewBoardPageAction;
import controller.page.NewMemberListPageAction;
import controller.page.NewProductPageAction;
import controller.page.ProfileUpdatePageAction;
import controller.page.UpdateStorePageAction;
import controller.product.DeleteProductMDAction;
import controller.product.ListProductMDAction;
import controller.product.SearchProductMDAction;
import controller.product.ViewProductMDAction;
import controller.reply.AddReplyAction;
import controller.reply.DeleteReplyAction;
import controller.reply.ListReplyAction;
import controller.reply.UpdateReplyAction;
import controller.store.InsertStoreAction;
import controller.store.SearchStoreAction;
import controller.store.UpdateStoreAction;
import controller.store.ViewStoreAction;


public class HandlerMapper {
	// Key : ~.do (요청)에 대해서 Value : Action 을 반환
	private Map<String, Action> mapper;

	public HandlerMapper() {
		this.mapper = new HashMap<String, Action>();

		// 해당 코드는 View에 맞춰서 변경
		// page.do
		
		// commonPage
		this.mapper.put("/mainPage.do", new MainPageAction());							// main 페이지 이동
		this.mapper.put("/failInfo.do", new FailInfoPageAction());						// 스크립트 페이지 이동
		
		// boardPage
		this.mapper.put("/checkBoardPage.do", new CheckBoardPageAction());				// 게시글 수정 페이지 이동
		this.mapper.put("/newBoardPage.do", new NewBoardPageAction());	      			// 신규게시글 페이지 이동
		this.mapper.put("/myBoardListPage.do", new MyBoardListPageAction());			// 자신이 작성한 게시글 목록 페이지 이동
		//this.mapper.put("/likeBoardListPage.do", new LikeBoardListPageAction());	    // 좋아요한 게시글 목록 페이지 이동
		
		// memberPage
		this.mapper.put("/checkPWPage.do", new CheckPasswordPageAction());              // 마이페이지에 들어가기 전 비밀번호를 확인하는 페이지
		this.mapper.put("/deleteAccountPage.do", new DeleteMemberPageAction());         // 회원탈퇴 페이지 이동
		this.mapper.put("/signupPage.do", new JoinPageAction());                        // 회원가입 페이지 이동
		this.mapper.put("/loginPage.do", new LoginPageAction());                        // 로그인 페이지 이동
		this.mapper.put("/myPage.do", new MyPageAction());                              // 마이페이지 이동
		this.mapper.put("/newMemberPage.do", new NewMemberListPageAction());            // 신규회원 목록 Action
		this.mapper.put("/updateProfilePage.do", new ProfileUpdatePageAction());        // 프로필 수정 페이지 이동
		this.mapper.put("/viewMemberPage.do", new ViewMemberAction());                  // 회원 상세 정보 페이지 이동
		this.mapper.put("/findPwPage.do", new FindPwPage());              		        // 비밀번호 찾기 페이지 이동
		
		// productPage
		this.mapper.put("/newProductPage.do", new NewProductPageAction());				// 신규상품 등록 페이지 이동
		this.mapper.put("/checkProductPage.do", new CheckProductPageAction());		    // 상품 등록 페이지 이동
		
		// storePage
	    this.mapper.put("/insertStorePage.do", new InsertStorePageAction());            // 가게 추가 페이지 이동
	    this.mapper.put("/updateStorePage.do", new UpdateStorePageAction());            // 가게 업데이트 페이지 이동

		// store.do
	    this.mapper.put("/searchStore.do", new SearchStoreAction());                    // 가게 검색 Action, and 페이지 이동
	    this.mapper.put("/viewStorePage.do", new ViewStoreAction());					// 가게 보기 Action
	    this.mapper.put("/storeRegister.do", new InsertStoreAction());                  // 가게 추가 Action
	    this.mapper.put("/updateStore.do", new UpdateStoreAction());                    // 가게 업데이트 Action

		// member.do
		this.mapper.put("/checkPw.do", new CheckPasswordAction());						// 마이페이지에 들어갈 때 비밀번호를 확인하는 Action
		this.mapper.put("/login.do", new LoginAction());								// 로그인 Action
		this.mapper.put("/logout.do", new LogoutAction());								// 로그아웃 Action
		this.mapper.put("/deleteAccount.do", new MemberDeleteAction());					// 회원탈퇴 Action	 			
	    this.mapper.put("/updatePw.do", new UpdatePwAction());                          // 비밀번호 변경 변경 Action
		
	    // board.do
		this.mapper.put("/deleteBoard.do", new DeleteBoardAction()); 					// 게시글 삭제 Action
		this.mapper.put("/listBoards.do", new ListBoardsAction()); 						// 전체게시글 보기 Action
		this.mapper.put("/searchBoards.do", new SearchBoardsAction()); 					// 게시글 검색 Action
		this.mapper.put("/viewBoard.do", new ViewBoardAction()); 						// 게시글 보기 Action

		//reply.do
		this.mapper.put("/addReply.do", new AddReplyAction()); 							// 댓글 추가 Action
		this.mapper.put("/deleteReply.do", new DeleteReplyAction()); 					// 댓글 삭제 Action
		this.mapper.put("/listReply.do", new ListReplyAction()); 						// 댓글 리스트 Action
		this.mapper.put("/updateReply.do", new UpdateReplyAction()); 					// 댓글 수정 Action

		//product.do
		this.mapper.put("/deleteProduct.do", new DeleteProductMDAction()); 				//상품 제거 Action
		this.mapper.put("/listProduct.do", new ListProductMDAction()); 					//상품 출력 Action
		this.mapper.put("/viewProduct.do", new ViewProductMDAction()); 					//상품 상세보기 Action
		this.mapper.put("/searchProductMD.do", new SearchProductMDAction());			//상품 검색 Action


	}

	public Action getAction(String command) {
		return this.mapper.get(command);
	}
}