package com.ipc.controller;

import java.io.File;
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
import org.apache.commons.mail.SimpleEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.TypeOfInventDao;
import com.ipc.dao.UserDao;
import com.ipc.security.SecAlgorithm;
import com.ipc.vo.TypeOfInventVo;
import com.ipc.vo.patientent_lawyerVo;
import com.ipc.vo.userVo;

//TODO : 지우고 new 한 것들 Autowired한 signupService로 대체하기
import com.ipc.service.SignUpService;
import com.ipc.util.CreateFileUtils;
import com.ipc.util.PathUtils;
import com.ipc.util.SendEmailUtils;


@Controller
@RequestMapping("/signup")
public class SignUpController{
	@Autowired
	UserDao usermapper;
	@Autowired
	HttpSession session;
	@Autowired
	TypeOfInventDao typemapper;
	@Autowired
	SignUpService signupService;
	@Autowired
	SecAlgorithm secAlgo;
	
	//private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	
	@RequestMapping("/signupPage")
	public String signupPage(Model model){
		List<TypeOfInventVo> tvList = typemapper.getTypeList();
		model.addAttribute("typeList", tvList);
		return "signup/signup";
	}
	
	
	@RequestMapping(value="/inputsignup", method=RequestMethod.POST)
	public String inputsignup(HttpServletRequest request,userVo uv)throws IOException, EmailException{
		signupService.makeUser(request, uv);
		
		//에러 안나면 로그인 되고 , 에러나면 login 페이지 띄움 
		return signupService.afterSignUp(request.getParameter("id"), request.getParameter("pw"));
	}
	
	
	@RequestMapping(value="/checkid",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> checkid(HttpServletRequest request,@RequestParam HashMap<String, Object> param){
		System.out.println(param.get("id").toString());
		String id=param.get("id").toString();
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		if(usermapper.checkid(id)==0){
			hashmap.put("KEY", "YES");
		}
		else{
			hashmap.put("KEY", "NO");
		}
		return hashmap;
	}
	
	
	@RequestMapping(value="/permit",method=RequestMethod.GET)
	public String permit(@RequestParam("uid") String uid,@RequestParam("key") String key){
		userVo uv=usermapper.getUserByUid(uid);
		if(key.equals(uv.getIs_member())){
			System.out.println("TRUE");
			usermapper.permit(uid);
		}
		else{
			System.out.println("FALSE");
		}
		return "home/index";
	}
	
	
	@RequestMapping(value="/compeletesignup")
	public String compeletesignup(){
		return "home/index";
	}
	
	
	@RequestMapping(value="/editUser")
	public String editUser(Model model){
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		try{
			model.addAttribute("email1","@"+currentUser.getEmail().split("@")[0]);
			model.addAttribute("email2","@"+currentUser.getEmail().split("@")[1]);
		}catch(Exception e){}
		if(currentUser.getRole().equals(roleInventor)){
			model.addAttribute("uv",currentUser); 
			model.addAttribute("role","inventor");
			
		}                                
		else if(currentUser.getRole().equals(rolePatientntLawyer)){
			model.addAttribute("uv",currentUser); 
			model.addAttribute("role","lawyer");
			String num=usermapper.getLicense_numberByUid(currentUser.getUid());
			model.addAttribute("liNum",num);
		}
		return "signup/EditUser";
	}
	
	
	@RequestMapping(value="/editinput",method=RequestMethod.POST)
	public String editinput(HttpServletRequest request) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException{
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		signupService.editUser(request, currentUser);

		return "redirect:/mainPage";
	}
	@RequestMapping(value="/findAccount")
	public String findAccount(){
		return "signup/findidpw";
	}
	
	
	@RequestMapping(value="/findId",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> findId(HttpServletRequest request){
		HashMap<String,String> mapresult=new HashMap<String,String>();
		String name= request.getParameter("name");
		String email= request.getParameter("email");
		System.out.println(name+","+email);
		mapresult.put("id", reId(name,email));
		return mapresult;
	}
	
	
	private String reId(String name, String email){
		HashMap<String,String> parameter=new HashMap<String,String>();
		parameter.put("name", name);
		parameter.put("email", email);
		String ID=usermapper.getIdByNameAndEmail(parameter);
		System.out.println(ID);
		return ID;
	}
	
	
	@RequestMapping(value="/findPw",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> findPw(HttpServletRequest request) throws IOException, EmailException, NoSuchAlgorithmException, InvalidKeySpecException{
		HashMap<String,String> mapresult=new HashMap<String,String>();
		String ID=request.getParameter("id");
		String email=request.getParameter("email");
		System.out.println(ID+","+email);
		//String ie=isExist(ID,email);
		if(isExist(ID,email).equals("NO")){
			mapresult.put("result", "False");
			return mapresult;
		}
		else{
			mapresult.put("result", "OK");
			//mapresult.put("uid", value);
		}
		return mapresult;
	}
	
	
	private String isExist(String ID,String email) throws IOException, EmailException, NoSuchAlgorithmException, InvalidKeySpecException{
		HashMap<String,String> parameter=new HashMap<String,String>();
		parameter.put("ID",ID);
		parameter.put("email", email);
		String uid=usermapper.getUidByIdAndEmail(parameter);
		System.out.println(uid);
		if(uid==null){
			return "NO";
		}
		else{
			HashMap<String,String> param=new HashMap<String,String>();
			SignUpService ss=new SignUpService();
			String key=ss.makeNumber(7);
			String hashKey=secAlgo.createHash(key);
			param.put("key", hashKey);
			param.put("uid", uid);
			usermapper.updateKey(param);
			String condition=sendKey(key, uid);
		}
		return uid;
	}
	
	
	private String sendKey(String key,String uid) throws IOException, EmailException{
		SignUpService ss=new SignUpService();
		int uid2=Integer.parseInt(uid);
		userVo uv=usermapper.getUserByUid(uid);
		String htmlmsg="<html><div style='width:1000px; float:left; border-bottom:2px solid #45d4fe; padding-bottom:5px;box-sizing:border-box;'></div><div style='width:1000px;float:left; box-sizing:border-box; padding:15px;'><h2>아이디어 보호센터 새로운 비밀번호입니다.</h2><div style='width:100%; float:left; box-sizing:border-box; border:5px solid #f9f9f9; text-align:center; padding:40px 0 40px 0;'><span>아래 비밀번호로 로그인 하셔서 <br>비밀번호를 바꿔주세요.<br>"+key+"</span></html>";
		
		
		try{
			SendEmailUtils emailObj = new SendEmailUtils();
			System.out.println(uv.getEmail());
			emailObj.sendEmail(uv.getEmail(), "아이디어보호센터 새로운 메일 입니다.", htmlmsg);
		}
		catch(Exception e){
			return "NO";
		}
		return "OK";
	}
}
