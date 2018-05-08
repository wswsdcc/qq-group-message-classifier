package servlet;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.nio.channels.FileChannel;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.scienjus.smartqq.callback.MessageCallback;
import com.scienjus.smartqq.model.Discuss;
import com.scienjus.smartqq.model.DiscussMessage;
import com.scienjus.smartqq.model.DiscussUser;
import com.scienjus.smartqq.model.Group;
import com.scienjus.smartqq.model.GroupMessage;
import com.scienjus.smartqq.model.GroupUser;
import com.scienjus.smartqq.model.Message;
import com.scienjus.smartqq.model.UserInfo;

import entity.QQMsgRsvMgr;

public class GetMsgServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public GetMsgServlet() {
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
	public void doGet(HttpServletRequest request, final HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		HttpSession session = request.getSession();
        QQMsgRsvMgr QQMR = (QQMsgRsvMgr) session.getAttribute("QQMsgRsver"); 
        String filePathTemp = new String("../webapps/qqgmc2/records/temp.txt");
        
        //将输出到网页上的文本内容清空
        RandomAccessFile rftemp = new RandomAccessFile(filePathTemp, "rw");
	    FileChannel fctemp = rftemp.getChannel();
	    fctemp.truncate(0);
	    
        UserInfo myInfo = QQMR.getAccountInfo();
        final String myQQ = myInfo.getUin();//登录者的QQ号
        
        List<Group> gList = QQMR.getGroupList();        
        final Map<Long,Group> gIDNameMap = QQMR.getGroupIDMap(gList);
        final Map<Long,GroupUser> gUserMap = QQMR.getGUser(gList);
        
        List<Discuss> dList = QQMR.getDiscussList();        
        final Map<Long,String> dIDNameMap = QQMR.getDiscussIDNameMap(dList);
        final Map<Long,DiscussUser> dUserMap = QQMR.getDUser(dList);
        
		System.out.println("[in GetMsgServlet]开始获取消息");
		QQMR.listenMessege(new MessageCallback(){
			@Override
			public void onMessage(Message message) {
		        new Thread(new Runnable() {
                    @Override
                    public void run() {
                        
                    }
                }).start();
			}

			@Override
			public void onGroupMessage(final GroupMessage message) {
				new Thread(new Runnable() {
                    @Override
                    public void run() {
                    	final Long senderid = message.getUserId();//消息发送者的uid
        				final String senderQQNick = gUserMap.get(senderid).getNick();
        				final Long groupid = message.getGroupId();//消息来自的群gid
        				final String groupName = gIDNameMap.get(groupid).getName();
        				final Long msgTime = message.getTime();//消息发送的时间
        				//消息发送时间：Long转换为String
        				SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        				Date dt = new Date(msgTime * 1000);  
        				String msgDateTime = sdf.format(dt);  //得到精确到秒的表示
        				
        				//保存文件时间：获取系统时间截取到天
        				SimpleDateFormat sdf2= new SimpleDateFormat("yyyyMMdd");
        				long now = System.currentTimeMillis();
        				Date dt2 = new Date(now);
        				String saveTime = sdf2.format(dt2);
        				
        				String record = new String("群【"+groupName+"】：\r\n"+senderQQNick+"（"+msgDateTime+"）："+message.getContent()+"\r\n");
        				try{
        					String filePath = new String("../webapps/qqgmc2/records/"+myQQ+"_"+saveTime+".txt");
        					String filePathTemp = new String("../webapps/qqgmc2/records/temp.txt");//供前台显示的文本
        					String filePathClassify = new String("../webapps/qqgmc2/records/classify.txt");//供分类的文本，只有消息内容
        					String filePathDisCla = new String("../webapps/qqgmc2/records/discla.txt");//供展示经过分类的文本，不止有消息内容
        					//写入供展示经过分类的文本
        					File fileDisCla = new File(filePathDisCla);
        				    if(!fileDisCla.exists()){
        				    	fileDisCla.createNewFile();
        				    }
        				    FileWriter fileWritterDisCla = new FileWriter(filePathDisCla,true);
        				    fileWritterDisCla.write(record);
        				    fileWritterDisCla.close();
        					//写入供分类的文本
        					File fileClassify = new File(filePathClassify);
        				    if(!fileClassify.exists()){
        				    	fileClassify.createNewFile();
        				    }
        				    FileWriter fileWritterClassify = new FileWriter(filePathClassify,true);
        				    fileWritterClassify.write(message.getContent()+"\r\n");
        				    fileWritterClassify.close();
        					//写入供前台显示的文本        					
        					File fileTemp = new File(filePathTemp);
        				    if(!fileTemp.exists()){
        				    	fileTemp.createNewFile();
        				    }
        				    FileWriter fileWritterTemp = new FileWriter(filePathTemp,true);
        				    fileWritterTemp.write(record);
        				    fileWritterTemp.close();
        				    //写入消息记录
        				    File file = new File(filePath);
        				    if(!file.exists()){
        				        file.createNewFile();
        				    }
        				    FileWriter fileWritter = new FileWriter(filePath,true);
        				    fileWritter.write(record);
        				    fileWritter.close();
        				}catch(IOException e){
        				     e.printStackTrace();
        				}
        				System.out.println(record);
        				
                    }
                }).start();		
			}

			@Override
			public void onDiscussMessage(final DiscussMessage message) {
				String msg = null;
				new Thread(new Runnable() {
                    @Override
                    public void run() {
                    	final Long senderid = message.getUserId();//消息发送者的uid
        				final String senderQQNick = dUserMap.get(senderid).getNick();
        				final Long discussid = message.getDiscussId();//消息来自的讨论组did
        				final String discussName = dIDNameMap.get(discussid);
        				final Long msgTime = message.getTime();//消息发送的时间
        				//消息发送时间：Long转换为String
        				SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        				Date dt = new Date(msgTime * 1000);  
        				String msgDateTime = sdf.format(dt);  //得到精确到秒的表示
        				
        				//保存文件时间：获取系统时间截取到天
        				SimpleDateFormat sdf2= new SimpleDateFormat("yyyyMMdd");
        				long now = System.currentTimeMillis();
        				Date dt2 = new Date(now);
        				String saveTime = sdf2.format(dt2);
        				
        				String record = new String("讨论组【"+discussName+"】：\r\n"+senderQQNick+"（"+msgDateTime+"）："+message.getContent()+"\r\n");
        				try{
        					String filePath = new String("../webapps/qqgmc2/records/"+myQQ+"_"+saveTime+".txt");
        					String filePathTemp = new String("../webapps/qqgmc2/records/temp.txt");//供前台显示的文本
        					String filePathClassify = new String("../webapps/qqgmc2/records/classify.txt");//供分类的文本，只有消息内容
        					String filePathDisCla = new String("../webapps/qqgmc2/records/discla.txt");//供展示经过分类的文本，不止有消息内容
        					//写入供展示经过分类的文本
        					File fileDisCla = new File(filePathDisCla);
        				    if(!fileDisCla.exists()){
        				    	fileDisCla.createNewFile();
        				    }
        				    FileWriter fileWritterDisCla = new FileWriter(filePathDisCla,true);
        				    fileWritterDisCla.write(record);
        				    fileWritterDisCla.close();
        					//写入供分类的文本
        					File fileClassify = new File(filePathClassify);
        				    if(!fileClassify.exists()){
        				    	fileClassify.createNewFile();
        				    }
        				    FileWriter fileWritterClassify = new FileWriter(filePathClassify,true);
        				    fileWritterClassify.write(message.getContent()+"\r\n");
        				    fileWritterClassify.close();
        					//写入供前台显示的文本        					
        					File fileTemp = new File(filePathTemp);
        				    if(!fileTemp.exists()){
        				    	fileTemp.createNewFile();
        				    }
        				    FileWriter fileWritterTemp = new FileWriter(filePathTemp,true);
        				    fileWritterTemp.write(record);
        				    fileWritterTemp.close();
        				    //写入消息记录
        				    File file = new File(filePath);
        				    if(!file.exists()){
        				        file.createNewFile();
        				    }
        				    FileWriter fileWritter = new FileWriter(filePath,true);
        				    fileWritter.write(record);
        				    fileWritter.close();
        				}catch(IOException e){
        				     e.printStackTrace();
        				}
        				System.out.println(record);
                    }
                }).start();
			}
		});

		System.out.println("[in GetMsgServlet]返回前端");
		response.getWriter().println("1");
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
