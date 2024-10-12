package controller.common;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 핸들러 매퍼 생성
	private HandlerMapper mappings;

    public FrontController() {
        super();
        
        // 핸들러 매퍼 초기화
        mappings = new HandlerMapper();
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doAction(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doAction(request, response);
    }
	
	private void doAction(HttpServletRequest request, HttpServletResponse response) {
		// 1. 사용자가 무슨 요청을 했는지 추출 및 확인

		// uri를 꺼냄
		// 프로젝트 + 파일 경로를 가져옴
		String uri =request.getRequestURI();

		// day034 (서버) 자름
		// 프로젝트 패스만 가져옴
		String cp=request.getContextPath();
		// 프로젝트 패스만큼 자름
		String command = uri.substring(cp.length());
		// 서버를 자르는 이유는 코더들마다 다를 수  있기 때문에
		System.out.println("command : "+command);

		// 2. 요청을 수행
		// HandlerMapper 사용
		// command에 알맞은 action을 가져옴
		Action action = this.mappings.getAction(command);
		
		// 모든 action이 ActionForward를 받으므로
		ActionForward forward = action.execute(request, response);
	
		// 3. 응답(페이지 이동 등)
		// 	1) 전달할 데이터가 있니? 없니? == 포워드? 리다이렉트?
		// 	2) 어디로 갈까? == 경로
		if(forward == null) {
			// command 요청이 없는 경우
		}
		else {
			// 리다이렉트
			if(forward.isRedirect()) {
				try {
					response.sendRedirect(forward.getPath());
				}catch (IOException e) {
					e.printStackTrace();
				}
			}
			// forward
			else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				try {
					// 기존의 요청을 유지하면서 전달
					dispatcher.forward(request, response);
				}catch (ServletException e) {
					e.printStackTrace();
				}catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}