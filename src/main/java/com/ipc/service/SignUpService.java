package com.ipc.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.RegistrationDao;
import com.ipc.dao.TypeOfInventDao;
import com.ipc.dao.UserDao;
import com.ipc.security.SecAlgorithm;
import com.ipc.util.CreateFileUtils;
import com.ipc.vo.userVo;
@Service
public class SignUpService {
	@Autowired 
	TypeOfInventDao typeOfmapper; 

	@Autowired
	UserDao usermapper;
	@Autowired
	HttpSession session;
	@Autowired
	AuthenticationManager authManager;
	@Autowired
	SecAlgorithm secAlgo;
	public void makeUser(HttpServletRequest request,userVo uv){
		CreateFileUtils createFileObj = new CreateFileUtils();
		//이메일 문자열 합치기
		String email = request.getParameter("email1") + request.getParameter("email2");
		
		//첨부파일 MultipartFile로 받기
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;
		List<MultipartFile> files = multipartRequest.getFiles("profileImg");
		List<MultipartFile> filesScan = multipartRequest.getFiles("license_scan_img");
		
		//프로필 이미지와 변리사등록증 첨부파일 확장자 저장
		String profileImgFileType=CreateFileUtils.getFileType(files.get(0).getOriginalFilename());
		String licenseScanImgFileType=CreateFileUtils.getFileType(filesScan.get(0).getOriginalFilename());
				
		SignUpService ss=new SignUpService();
		
		//프로필 이미지와 변리사등록증 첨부파일 저장(com.ipc.util.CreateFileUtils)
		if(!files.get(0).isEmpty()){
			//fileType=ss.makeimageFile(files.get(0),uv.getId(),role,root_path,"profile");
			createFileObj.CreateFile(files.get(0), request, "/resources/uploadimgs/profileImg/", uv.getId()+"."+profileImgFileType);
		}
		createFileObj.CreateFile(filesScan.get(0), request,"/resources/lawyer_scan/",uv.getId()+"."+licenseScanImgFileType);

		//패스워드 암호화 
		String rawPwd = uv.getPw();
		String hashedPwd ="";
		try {
			hashedPwd = secAlgo.createHash(rawPwd);
		} catch (Exception e) {
			System.out.println("ERROR] 회원가입 : pw암호화 잘못됨");
			hashedPwd = rawPwd;
		} finally
		{
			uv.setPw(hashedPwd);
		}
		
		//HashMap에  유저 정보 담기
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("id", uv.getId());
		map.put("pw", uv.getPw());
		map.put("email", email);
		map.put("name", uv.getName());
		if(files.get(0).isEmpty()){
			if(request.getParameter("role").equals("1")){
				map.put("profileimg", "/resources/image/attonrney_profile.jpg");
			}else{
				map.put("profileimg", "/resources/image/val1.png");
			}			
		}
		else{
			map.put("profileimg", "/resources/uploadimgs/profileImg/"+uv.getId()+"."+profileImgFileType);
		}
		StringBuffer key=ss.makekey();
		map.put("is_member", key.toString());
		
		System.out.println("key is "+key.toString());
		HashMap<String,String> map2=new HashMap<String,String>();
		if(request.getParameter("role").equals("1")){
			System.out.println("role is 1");
			map.put("role", "ROLE_INVENTOR");
		}
		else{
			System.out.println("role is 2");
			map.put("role", "ROLE_PATIENTENTLAWYER");
		}
		
		//유저 만듬
		usermapper.makeuser(map);
		
		//변리사 정보
		userVo uv2=usermapper.getUserById(uv.getId());
		if(request.getParameter("role").equals("2")){
			String[] majorArr=request.getParameterValues("major");
			String major="";
			for(int i=0;i<majorArr.length;i++){
				major+=majorArr[i]+" ";
			}
			map2.put("uid", Integer.toString(uv2.getUid()));
			map2.put("license_number", request.getParameter("license_number"));
			map2.put("major", major);
			map2.put("account_number", request.getParameter("account_number"));
			map2.put("bank_name", request.getParameter("bank_name"));
			map2.put("introduce", request.getParameter("introduce"));
			map2.put("license_scan_img", "/resources/uploadimgs/lawyer_scan/"+uv.getId()+"."+licenseScanImgFileType);
			usermapper.makelawyer(map2);
		}
		//if(ss.sendhtmlmail(uv2.getUid(),key.toString(),uv2.getEmail()).equals("NOTOK")){
		//	return "signup/emailError";
		//}
		
		//에러 안나면 로그인 되고 , 에러나면 login 페이지 띄움 
	}
	
	public void editUser(HttpServletRequest request, userVo currentUser) throws NoSuchAlgorithmException, InvalidKeySpecException{
		CreateFileUtils createFileObj = new CreateFileUtils();
		
		HashMap<String,String> map = new HashMap<String,String>();
		String pw=request.getParameter("pw");
		String hashPw=secAlgo.createHash(pw);
		String email = request.getParameter("email1") + request.getParameter("email3");
		String role=request.getParameter("role");
		String fileType="";
		map.put("uid", Integer.toString(currentUser.getUid()));
		map.put("pw", hashPw);
		map.put("email",email);
		map.put("role", role);
		if(role.equals("lawyer")){
			String license_number=request.getParameter("license_number");
			map.put("license_number", license_number);
		}
		usermapper.editinput(map);
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> files = multipartRequest.getFiles("profileImg");
		String profileImgFileType = CreateFileUtils.getFileType(files.get(0).getOriginalFilename());
		System.out.println("File Size : "+files.get(0).getSize());
		System.out.println("File idEmpty : "+files.get(0).isEmpty());
		
		
		if(!files.get(0).isEmpty()){
			
			HashMap<String,String> map2=new HashMap<String,String>();
			userVo uv=usermapper.getUserByUid(Integer.toString(currentUser.getUid()));
			createFileObj.CreateFile(files.get(0), request, "/resources/uploadimgs/profileImg/", uv.getId()+"."+profileImgFileType);
			try{
				File file=new File(request.getSession().getServletContext().getRealPath("/")+uv.getProfileimg());
				file.delete();
			}catch(Exception e){
				
			}
			
			map2.put("uid", Integer.toString(currentUser.getUid()));
			map2.put("url", "/resources/uploadimgs/profileImg/"+currentUser.getId()+"."+profileImgFileType);
			usermapper.updateProfileImg(map2);
		}
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
	
	//회원 가입 후 자동 로그인
	public String afterSignUp(String uid, String pw)
	{
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(uid, pw);
		Authentication auth;
		try
		{
			auth = authManager.authenticate(token);
		}
		catch(Exception e)
		{
			return "redirect:/login.do";
		}
		SecurityContextHolder.getContext().setAuthentication(auth);
		userVo currentUser = usermapper.getUserById(uid);
		session.setAttribute("currentUser", currentUser);
		
		return "redirect:/";
	}
}
