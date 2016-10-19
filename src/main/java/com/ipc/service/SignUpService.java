package com.ipc.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Random;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ipc.dao.TypeOfInventDao;
@Service
public class SignUpService {
	@Autowired 
	TypeOfInventDao typeOfmapper; 
	
	public String sendhtmlmail(int uid,String key,String email) throws IOException, EmailException{
		HtmlEmail sendemail = new HtmlEmail();
		sendemail.setCharset("euc-kr");
		sendemail.setHostName("smtp.worksmobile.com");
		sendemail.addTo(email);
		sendemail.setFrom("jinuk@ideaconcert.com", "源�吏꾩슧");
		sendemail.setSubject("�븘�씠�뵒�뼱 蹂댄샇�꽱�꽣 媛��엯 �씤利� 硫붿씪 �엯�땲�떎.");
		sendemail.setAuthentication("jinuk@ideaconcert.com", "tpxmapsb1");
	    sendemail.setSmtpPort(465);
	    sendemail.setSSL(true);   //紐⑤Ⅴ寃좎쓬
		sendemail.setTLS(true);
		sendemail.setDebug(true);
		String htmlmsg="<html><div style='width:1000px; float:left; border-bottom:2px solid #45d4fe; padding-bottom:5px;box-sizing:border-box;'></div><div style='width:1000px;float:left; box-sizing:border-box; padding:15px;'><h2>�븘�씠�뵒�뼱 蹂댄샇�꽱�꽣�뿉�꽌 �슂泥��븯�떊 �씤利앸찓�씪�쓣 諛쒖넚�빐 �뱶由쎈땲�떎.</h2><div style='width:100%; float:left; box-sizing:border-box; border:5px solid #f9f9f9; text-align:center; padding:40px 0 40px 0;'><span>�븘�옒 �듅�씤踰꾪듉�쓣 �겢由� �빐 二쇱꽭�슂.</span><br><a href='http://localhost:8088/signup/permit?uid="+uid+"&key="+key+"'><button style='width:150px; height:40px; background:none; border:2px solid #45d4fe; font-size:1.1rem; text-decoration: none;font-weight:bold; margin-top:10px;'>�듅�씤</button></a></div></div></html>";
		System.out.println(htmlmsg);
		sendemail.setHtmlMsg(htmlmsg);
		try{
			sendemail.send();
		}
		catch(Exception e){
			System.out.println("NOTOK");
			return "NOTOK";
		}
		return "OK";
	}
	public String sendpwmail(int uid,String key,String email) throws IOException, EmailException{
		HtmlEmail sendemail = new HtmlEmail();
		sendemail.setCharset("euc-kr");
		sendemail.setHostName("smtp.worksmobile.com");
		sendemail.addTo(email);
		sendemail.setFrom("jinuk@ideaconcert.com", "源�吏꾩슧");
		sendemail.setSubject("�븘�씠�뵒�뼱 蹂댄샇�꽱�꽣 鍮꾨�踰덊샇 �솗�씤 硫붿씪 �엯�땲�떎.");
		sendemail.setAuthentication("jinuk@ideaconcert.com", "tpxmapsb1");
	    sendemail.setSmtpPort(465);
	    sendemail.setSSL(true);   //紐⑤Ⅴ寃좎쓬
		sendemail.setTLS(true);
		sendemail.setDebug(true);
		String htmlmsg="<html><div style='width:1000px; float:left; border-bottom:2px solid #45d4fe; padding-bottom:5px;box-sizing:border-box;'></div><div style='width:1000px;float:left; box-sizing:border-box; padding:15px;'><h2>�븘�씠�뵒�뼱 蹂댄샇�꽱�꽣�뿉�꽌 �엫�떆鍮꾨�踰덊샇瑜� 諛쒖넚�빐 �뱶由쎈땲�떎.</h2><div style='width:100%; float:left; box-sizing:border-box; border:5px solid #f9f9f9; text-align:center; padding:40px 0 40px 0;'><span>�엫�떆鍮꾨�踰덊샇濡� 濡쒓렇�씤 �븯�떆怨� <br>諛섎뱶�떆 鍮꾨�踰덊샇瑜� 蹂�寃쏀빐二쇱꽭�슂.<br>"+key+"</span></html>";
		System.out.println(htmlmsg);
		sendemail.setHtmlMsg(htmlmsg);
		try{
			sendemail.send();
		}
		catch(Exception e){
			System.out.println("NOTOK");
			return "NOTOK";
		}
		return "OK";
	}
	public StringBuffer makekey(){
		Random rnd =new Random();
		StringBuffer buf =new StringBuffer();
		for(int i=0;i<20;i++){
		    if(rnd.nextBoolean()){
		        buf.append((char)((int)(rnd.nextInt(26))+97));
		    }else{
		        buf.append((rnd.nextInt(10))); 
		    }
		}
		return buf;
	}
	public String makeNumber(int num){
		Random rnd =new Random();
		StringBuffer buf =new StringBuffer();
		for(int i=0;i<num;i++){
		    if(rnd.nextBoolean()){
		        buf.append((char)((int)(rnd.nextInt(26))+97));
		    }else{
		        buf.append((rnd.nextInt(10))); 
		    }
		}
		return buf.toString();
	}
	private FileOutputStream fos;
	public String makeimageFile(MultipartFile file,String ID,String role,String root_path,String kind){
		try {
			
			//Windows
				//String dirpath=root_path+"\\resources\\uploadimgs\\profileImg\\";
			//Linux
			String dirpath=null;
			if(kind.equals("profile"))
			{
				dirpath=root_path+"/resources/uploadimgs/profileImg/";
			}
			else{
				dirpath=root_path+"/resources/uploadimgs/lawyer_scan/";
			}
			byte fileData[] = file.getBytes();
			int pathPoint = file.getOriginalFilename().trim().lastIndexOf(".");
			String filePoint = file.getOriginalFilename().trim().substring(pathPoint + 1,
					file.getOriginalFilename().trim().length());
			String fileType = filePoint.toLowerCase();
			fos = new FileOutputStream(dirpath+ID+ "." + fileType);
			fos.write(fileData);
			return fileType;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fos != null) {
				try {
					fos.close();
				} catch (Exception e) {
				}
			}
		} // try end;
		return "..";
	}
	public String mkdir(String ID){
		String path="../IdeaProtectionCenter/src/main/webapp/resources/uploadimgs/inventor/"+ID;
		File dir=new File(path);
		if(!dir.exists())
		{	
			dir.mkdirs();
		}
		return "OK";
	}
	
	public void list(){
		System.out.println(typeOfmapper.getTypeList().size());
	}
}
