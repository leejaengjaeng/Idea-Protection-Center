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
		String htmlmsg="<html>클릭하세요 -<a href='http://localhost:8088/signup/permit?uid="+uid+"&key="+key+"'><button>승인</button></a> </html>";
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
