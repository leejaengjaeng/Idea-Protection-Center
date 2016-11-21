package com.ipc.util;

import java.io.IOException;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class SendEmailUtils {
	public String sendpwmail(int uid,String key,String email) throws IOException, EmailException{
		System.out.println("Email : "+email);
		HtmlEmail sendemail = new HtmlEmail();
		sendemail.setCharset("euc-kr");
		sendemail.setHostName("smtp.worksmobile.com");
		sendemail.addTo(email);
		sendemail.setFrom("jinuk@ideaconcert.com", "김진욱");
		sendemail.setSubject("아이디어보호센터 새로운 비밀번호입니다.");
		sendemail.setAuthentication("jinuk@ideaconcert.com", "tpxmapsb1");
	    sendemail.setSmtpPort(465);
	    sendemail.setSSL(true);   //紐⑤Ⅴ寃좎쓬
		sendemail.setTLS(true);
		sendemail.setDebug(true);
		String htmlmsg="<html><div style='width:1000px; float:left; border-bottom:2px solid #45d4fe; padding-bottom:5px;box-sizing:border-box;'></div><div style='width:1000px;float:left; box-sizing:border-box; padding:15px;'><h2>아이디어 보호센터 새로운 비밀번호입니다.</h2><div style='width:100%; float:left; box-sizing:border-box; border:5px solid #f9f9f9; text-align:center; padding:40px 0 40px 0;'><span>아래 비밀번호로 로그인 하셔서 <br>비밀번호를 바꿔주세요.<br>"+key+"</span></html>";
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
	
	public String sendhtmlmail(int uid,String key,String email) throws IOException, EmailException{
		HtmlEmail sendemail = new HtmlEmail();
		sendemail.setCharset("euc-kr");
		sendemail.setHostName("smtp.worksmobile.com");
		sendemail.addTo(email);
		sendemail.setFrom("jinuk@ideaconcert.com", "김진욱");
		sendemail.setSubject("아이디어보호센터 가입 인증 메일입니다.");
		sendemail.setAuthentication("jinuk@ideaconcert.com", "tpxmapsb1");
	    sendemail.setSmtpPort(465);
	    sendemail.setSSL(true);   //紐⑤Ⅴ寃좎쓬
		sendemail.setTLS(true);
		sendemail.setDebug(true);
		String htmlmsg="<html><div style='width:1000px; float:left; border-bottom:2px solid #45d4fe; padding-bottom:5px;box-sizing:border-box;'></div><div style='width:1000px;float:left; box-sizing:border-box; padding:15px;'><h2>가입을 원하시면 아래 버튼을 눌러주세요.</h2><div style='width:100%; float:left; box-sizing:border-box; border:5px solid #f9f9f9; text-align:center; padding:40px 0 40px 0;'><span>�븘�옒 �듅�씤踰꾪듉�쓣 �겢由� �빐 二쇱꽭�슂.</span><br><a href='http://localhost:8088/signup/permit?uid="+uid+"&key="+key+"'><button style='width:150px; height:40px; background:none; border:2px solid #45d4fe; font-size:1.1rem; text-decoration: none;font-weight:bold; margin-top:10px;'>�듅�씤</button></a></div></div></html>";
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
	public String sendEmail(String emailTo,String mailTitle,String mailContents) throws IOException, EmailException{
		HtmlEmail sendemail = new HtmlEmail();
		sendemail.setCharset("euc-kr");
		sendemail.setHostName("smtp.worksmobile.com");
		sendemail.addTo(emailTo);
		sendemail.setFrom("jinuk@ideaconcert.com", "김진욱");
		sendemail.setSubject(mailTitle);
		sendemail.setAuthentication("jinuk@ideaconcert.com", "tpxmapsb1");
	    sendemail.setSmtpPort(465);
	    sendemail.setSSL(true);   //紐⑤Ⅴ寃좎쓬
		sendemail.setTLS(true);
		sendemail.setDebug(true);
		String htmlmsg=mailContents;
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
}
