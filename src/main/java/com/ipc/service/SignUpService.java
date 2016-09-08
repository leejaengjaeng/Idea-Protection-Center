package com.ipc.service;

import java.io.IOException;
import java.util.Random;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

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
		String htmlmsg="<html><div style='width:1000px; float:left; border-bottom:2px solid #45d4fe; padding-bottom:5px;box-sizing:border-box;'></div><div style='width:1000px;float:left; box-sizing:border-box; padding:15px;'><h2>아이디어 콘서트에서 요청하신 인증메일을 발송해 드립니다.</h2><div style='width:100%; float:left; box-sizing:border-box; border:5px solid #f9f9f9; text-align:center; padding:40px 0 40px 0;'><span>아래 승인버튼을 클릭 해 주세요.</span><br><a href='http://localhost:8088/signup/permit?uid="+uid+"&key="+key+"'><button style='width:150px; height:40px; background:none; border:2px solid #45d4fe; font-size:1.1rem; text-decoration: none;font-weight:bold; margin-top:10px;'>승인</button></a></div></div></html>";
		System.out.println(htmlmsg);
		sendemail.setHtmlMsg(htmlmsg);
		sendemail.send();
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
	
}
