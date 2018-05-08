package servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.nio.channels.FileChannel;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MsgDisplay extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public MsgDisplay() {
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
		String msgDisplay = null;
		System.out.println("[in MsgDisplay]读取信息文件");
		String filePathTemp = new String("../webapps/qqgmc2/records/temp.txt");	
		File temp = new File(filePathTemp);	
		msgDisplay = txt2String(temp);
		//读取完清空文件
		RandomAccessFile rf = new RandomAccessFile(filePathTemp, "rw");
	    FileChannel fc = rf.getChannel();
	    fc.truncate(0);
		
		response.getWriter().println(string2Unicode(msgDisplay));
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
	
	public static String txt2String(File file){
        StringBuilder result = new StringBuilder();
        try{
            BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
            String s = null;
            while((s = br.readLine())!=null){//使用readLine方法，一次读一行
                result.append(System.lineSeparator()+s);
            }
            br.close();    
        }catch(Exception e){
            e.printStackTrace();
        }
        return result.toString();
    }
	
	public String string2Unicode(String str) 
	{ 
	    str = (str == null ? "" : str); 
	    String tmp; 
	    StringBuffer sb = new StringBuffer(1000); 
	    char c; 
	    int i, j; 
	    sb.setLength(0); 
	    for (i = 0; i < str.length(); i++) 
	    { 
	    	c = str.charAt(i); 
	    	sb.append("\\u"); 
	    	j = (c >>>8); //取出高8位 
	    	tmp = Integer.toHexString(j); 
	    	if (tmp.length() == 1) 
	    		sb.append("0"); 
	    	sb.append(tmp); 
	    	j = (c & 0xFF); //取出低8位 
	    	tmp = Integer.toHexString(j); 
	    	if (tmp.length() == 1) 
	    		sb.append("0"); 
	    	sb.append(tmp); 

	    } 
	    return (new String(sb)); 
	}
	
}
