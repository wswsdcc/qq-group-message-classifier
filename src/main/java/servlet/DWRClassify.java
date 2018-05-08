package servlet;  

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.nio.channels.FileChannel;
import java.util.Map;
import java.util.Set;

import com.xq.bayesian.ChineseTokenizer;
import com.xq.bayesian.DefaultStopWordsHandler;
import com.xq.bayesian.MultinomialModelNaiveBayes;
import com.xq.bayesian.TrainSampleDataManager;

public class DWRClassify {
	
	public static final String DEFAULT_DIR="../webapps/qqgmc2/data/";//训练集
	//public static final String DEFAULT_DIR="F:/apache-tomcat-7.0.77/webapps/qqgmc2/data/";//训练集
	
	static String filePathClassify = new String("../webapps/qqgmc2/records/classify.txt");
	//static String filePathClassify = new String("F:/test1.txt"); 
	
	static String filePathDisCla = new String("../webapps/qqgmc2/records/discla.txt");
	
	public static void classRecord(String msg,String classno,String userid){
		String filePathClarec = new String("../webapps/qqgmc2/records/"+userid+"_class"+classno+".txt");//记录含有关键字的消息
		File fileClarec = new File(filePathClarec);
	    if(!fileClarec.exists()){
	    	try {
				fileClarec.createNewFile();
			} catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
	    }
	    try {
	    	FileWriter fileWritterClarec = new FileWriter(filePathClarec,true);
		    fileWritterClarec.write(msg+"\r\n");
		    fileWritterClarec.close();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
	
	public static void keyRecord(String msg,String key,String userid){
		String filePathKeyrec = new String("../webapps/qqgmc2/records/"+userid+"_keyrec.txt");//记录含有关键字的消息
		File fileKeyrec = new File(filePathKeyrec);
	    if(!fileKeyrec.exists()){
	    	try {
				fileKeyrec.createNewFile();
			} catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
	    }
	    try {
	    	FileWriter fileWritterKeyrec = new FileWriter(filePathKeyrec,true);
	    	fileWritterKeyrec.write("关键字为："+key+"\r\n");
		    fileWritterKeyrec.write(msg+"\r\n");
		    fileWritterKeyrec.close();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
	
	public static String display(){
		FileInputStream file = null;
	    BufferedReader reader = null;
	    InputStreamReader inputFileReader = null;
        String tempLine = null;
        StringBuffer fileContent = new StringBuffer();
        try {
            file = new FileInputStream(filePathDisCla);

            inputFileReader = new InputStreamReader(file, "GBK");
            reader = new BufferedReader(inputFileReader);
            // 一次读入一行，直到读入null为文件结束
            while((tempLine = reader.readLine()) != null) {
            	System.out.println("tempLine:"+tempLine);
            	fileContent.append(tempLine + "\r\n");
            }
            reader.close();
            RandomAccessFile rf = new RandomAccessFile(filePathDisCla, "rw");
    	    FileChannel fc = rf.getChannel();
    	    fc.truncate(0);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
		return fileContent.toString();
	}
	
	public static String classifyFirstLine(){
		FileInputStream file = null;
	    BufferedReader reader = null;
	    InputStreamReader inputFileReader = null;
        String firstLine = null;
        try {
            file = new FileInputStream(filePathClassify);
            inputFileReader = new InputStreamReader(file, "GBK");
            reader = new BufferedReader(inputFileReader);
            // 一次读入一行
            if ((firstLine = reader.readLine()) != null) {
            	RandomAccessFile rf = new RandomAccessFile(filePathClassify, "rw");
        	    FileChannel fc = rf.getChannel();
        	    fc.truncate(0);
                reader.close();
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
        System.out.println("["+firstLine+"]");
	    if(firstLine == null){
	    	return "EMPTYSTRING";
	    }
		TrainSampleDataManager.process();		
		Set<String> words=ChineseTokenizer.segStr(firstLine).keySet();
		System.out.println("分词结果：");
		for (String str : words) {  
			System.out.println(str);  
		}
		//句子太短判定为闲聊
		if(words.size()<3){
			return "5";
		}

		Map<String,BigDecimal> resultMap=MultinomialModelNaiveBayes.classifyResult(DefaultStopWordsHandler.dropStopWords(words));
		Set<String> set=resultMap.keySet();
		for(String s: set){
			System.out.println("classifer:"+s+"     probability:"+resultMap.get(s));
		}
		System.out.println("The final result:"+MultinomialModelNaiveBayes.getClassifyResultName());
        return MultinomialModelNaiveBayes.getClassifyResultName();
	}
	
	public static void main(String[] args) {
	   /* String firstLine = getFirstLine();
	    String strClass = classify(firstLine);*/
		String strClass = classifyFirstLine();
	    System.out.println("类别为："+strClass);
	}
} 