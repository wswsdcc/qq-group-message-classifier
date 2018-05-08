package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.QQMsgRsvMgr;

public class QRVServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public QRVServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		String msg = null; 
		QQMsgRsvMgr QQMR = (QQMsgRsvMgr) session.getAttribute("QQMsgRsver");
		QQMR.verifyQRCode();
		int qrvalidity = QQMR.getQrValidity();
		if(qrvalidity == 1){
			System.out.println("[in QRVServlet]二维码验证成功");
			msg = "扫码成功！页面即将自动跳转";
		}
		else{
			System.out.println("[in QRVServlet]二维码验证失败");
			msg = "扫码失败了，请刷新二维码"; 
		}
		session.setAttribute("QQMsgRsver", QQMR);
		response.getWriter().println(string2Unicode(msg));
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	public static String string2Unicode(String string) {
	    StringBuffer unicode = new StringBuffer();		 
		for (int i = 0; i < string.length(); i++) {		 
		    // 取出每一个字符
		    char c = string.charAt(i);		 
		    // 转换为unicode
		    unicode.append("\\u" + Integer.toHexString(c));
		}  
		return unicode.toString();
    }
	
}
