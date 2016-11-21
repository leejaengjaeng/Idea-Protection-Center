package com.ipc.util;

import java.io.IOException;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class SendEmailUtils {

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
