package com.ipc.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Random;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
@Service
public class SignUpService {
	public String sendhtmlmail(int uid,String key,String email) throws IOException, EmailException{
		HtmlEmail sendemail = new HtmlEmail();
		sendemail.setCharset("euc-kr");
		sendemail.setHostName("smtp.worksmobile.com");
		sendemail.addTo(email);
		sendemail.setFrom("jinuk@ideaconcert.com", "김진욱");
		sendemail.setSubject("아이디어 보호센터 가입 인증 메일 입니다.");
		sendemail.setAuthentication("jinuk@ideaconcert.com", "tpxmapsb1");
	    sendemail.setSmtpPort(465);
	    sendemail.setSSL(true);   //모르겠음
		sendemail.setTLS(true);
		sendemail.setDebug(true);
		String htmlmsg="<html><div style='width:1000px; float:left; border-bottom:2px solid #45d4fe; padding-bottom:5px;box-sizing:border-box;'></div><div style='width:1000px;float:left; box-sizing:border-box; padding:15px;'><h2>아이디어 보호센터에서 요청하신 인증메일을 발송해 드립니다.</h2><div style='width:100%; float:left; box-sizing:border-box; border:5px solid #f9f9f9; text-align:center; padding:40px 0 40px 0;'><span>아래 승인버튼을 클릭 해 주세요.</span><br><a href='http://localhost:8088/signup/permit?uid="+uid+"&key="+key+"'><button style='width:150px; height:40px; background:none; border:2px solid #45d4fe; font-size:1.1rem; text-decoration: none;font-weight:bold; margin-top:10px;'>승인</button></a></div></div></html>";
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
		sendemail.setFrom("jinuk@ideaconcert.com", "김진욱");
		sendemail.setSubject("아이디어 보호센터 비밀번호 확인 메일 입니다.");
		sendemail.setAuthentication("jinuk@ideaconcert.com", "tpxmapsb1");
	    sendemail.setSmtpPort(465);
	    sendemail.setSSL(true);   //모르겠음
		sendemail.setTLS(true);
		sendemail.setDebug(true);
		String htmlmsg="<html><div style='width:1000px; float:left; border-bottom:2px solid #45d4fe; padding-bottom:5px;box-sizing:border-box;'></div><div style='width:1000px;float:left; box-sizing:border-box; padding:15px;'><h2>아이디어 보호센터에서 임시비밀번호를 발송해 드립니다.</h2><div style='width:100%; float:left; box-sizing:border-box; border:5px solid #f9f9f9; text-align:center; padding:40px 0 40px 0;'><span>임시비밀번호로 로그인 하시고 <br>반드시 비밀번호를 변경해주세요.<br>"+key+"</span></html>";
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
	public String makeimageFile(MultipartFile file,String ID,String role,String root_path){
		try {
			
			//Windows
				//String dirpath=root_path+"\\resources\\uploadimgs\\profileImg\\";
			//Linux
				String dirpath=root_path+"/resources/uploadimgs/profileImg/";
			
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
}
