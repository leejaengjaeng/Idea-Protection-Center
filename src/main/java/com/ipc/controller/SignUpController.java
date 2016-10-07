package com.ipc.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.UserDao;
import com.ipc.service.SignUpService;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/signup")
public class SignUpController {
	@Autowired
	UserDao usermapper;
	@Autowired
	HttpSession session;
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	@RequestMapping("/signupPage")
	public String signupPage(Model model){
		return "signup/signup";
	}
	@RequestMapping(value="/inputsignup", method=RequestMethod.POST)
	public String inputsignup(Model model,HttpServletRequest request,userVo uv)throws IOException, EmailException{
		String role;
		if(request.getParameter("role").equals("1")){
			role="inventor";
		}
		else{
			role="lawyer";
		}
		String email = request.getParameter("email1") + request.getParameter("email2");
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //다중파일 업로드
		List<MultipartFile> files = multipartRequest.getFiles("profileImg");
		
		SignUpService ss=new SignUpService();
		String root_path=request.getSession().getServletContext().getRealPath("/");
		String fileType=ss.makeimageFile(files.get(0),uv.getId(),role,root_path);
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("id", uv.getId());
		map.put("pw", uv.getPw());
		map.put("email", email);
		map.put("name", uv.getName());
		System.out.println("filType: "+fileType);
		if(fileType.equals("")){
			map.put("profileimg", "/resources/image/attonrney_profile.jpg");
		}
		else{
			map.put("profileimg", "/resources/uploadimgs/profileImg/"+uv.getId()+"."+fileType);
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
		usermapper.makeuser(map);
		userVo uv2=usermapper.getUserById(uv.getId());
		if(request.getParameter("role").equals("2")){
			map2.put("uid", Integer.toString(uv2.getUid()));
			map2.put("license_number", request.getParameter("license_number"));
			usermapper.makelawyer(map2);
		}
		System.out.println("uid is "+uv2.getUid());
		if(ss.sendhtmlmail(uv2.getUid(),key.toString(),uv2.getEmail()).equals("NOTOK")){
			return "signup/emailError";
		}
		return "redirect:/";
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
	public String editinput(HttpServletRequest request) throws IOException{
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		HashMap<String,String> map = new HashMap<String,String>();
		String pw=request.getParameter("pw");
		String email = request.getParameter("email1") + request.getParameter("email3");
		String role=request.getParameter("role");
		map.put("uid", Integer.toString(currentUser.getUid()));
		map.put("pw", pw);
		map.put("email",email);
		map.put("role", role);
		if(role.equals("lawyer")){
			String license_number=request.getParameter("license_number");
			map.put("license_number", license_number);
		}
		usermapper.editinput(map);
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //다중파일 업로드
		List<MultipartFile> files = multipartRequest.getFiles("profileImg");
		
		int pathPoint = files.get(0).getOriginalFilename().trim().lastIndexOf(".");
		String filePoint = files.get(0).getOriginalFilename().trim().substring(pathPoint + 1,
				files.get(0).getOriginalFilename().trim().length());
		String fileType = filePoint.toLowerCase();
		System.out.println(fileType);
		if(fileType.equals("")){
			return "redirect:/mainPage";
		}
		HashMap<String,String> map2=new HashMap<String,String>();
		userVo uv=usermapper.getUserByUid(Integer.toString(currentUser.getUid()));
		File file=new File("../Idea-Protection-Center/src/main/webapp/"+uv.getProfileimg());
		file.delete();
		SignUpService ss=new SignUpService();
		String root_path=request.getSession().getServletContext().getRealPath("/");
		ss.makeimageFile(files.get(0),currentUser.getId(),role,root_path);
		map2.put("uid", Integer.toString(currentUser.getUid()));
		map2.put("url", "/resources/uploadimgs/profileImg/"+currentUser.getId()+"."+fileType);
		usermapper.updateProfileImg(map2);
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
}
