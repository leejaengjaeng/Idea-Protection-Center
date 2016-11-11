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
	public String inputsignup(Model model,HttpServletRequest request,userVo uv)throws IOException, EmailException{
		String role;
		String fileType="";
		if(request.getParameter("role").equals("1")){
			role="inventor";
		}
		else{
			role="lawyer";
		}
		
		String email = request.getParameter("email1") + request.getParameter("email2");
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> files = multipartRequest.getFiles("profileImg");
		
		MultipartHttpServletRequest multipartRequestScan =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> filesScan = multipartRequestScan.getFiles("license_scan_img");
		
		System.out.println();
		
		SignUpService ss=new SignUpService();
		String root_path=request.getSession().getServletContext().getRealPath("/");
		if(!files.get(0).isEmpty()){
			fileType=ss.makeimageFile(files.get(0),uv.getId(),role,root_path,"profile");
		}
		String fileTypeScan=ss.makeimageFile(filesScan.get(0), uv.getId(), role, root_path, "Scan");

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
		System.out.println("hashPwd : " + hashedPwd);
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("id", uv.getId());
		map.put("pw", uv.getPw());
		map.put("email", email);
		map.put("name", uv.getName());
		//System.out.println("filType: "+fileType);
		
		if(files.get(0).isEmpty()){
			if(request.getParameter("role").equals("1")){
				map.put("profileimg", "/resources/image/attonrney_profile.jpg");
			}else{
				map.put("profileimg", "/resources/image/val1.png");
			}			
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
			map2.put("license_scan_img", "/resources/uploadimgs/lawyer_scan/"+uv.getId()+"."+fileTypeScan);
			usermapper.makelawyer(map2);
		}
		System.out.println("uid is "+uv2.getUid());
		if(ss.sendhtmlmail(uv2.getUid(),key.toString(),uv2.getEmail()).equals("NOTOK")){
			return "signup/emailError";
		}
		
		//System.out.println("lawyerVo : "+lv.getIntroduce()+","+lv.getAccount_number()+","+lv.getLicense_number()+","+lv.getMajor());
		
		//에러 안나면 로그인 되고 , 에러나면 login 페이지 띄움 
		return signupService.afterSignUp(uv.getId(), uv.getPw());
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
	public String editinput(HttpServletRequest request) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException{
		userVo currentUser = (userVo) session.getAttribute("currentUser");
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
		System.out.println("File Size : "+files.get(0).getSize());
		System.out.println("File idEmpty : "+files.get(0).isEmpty());
		
		
		if(!files.get(0).isEmpty()){
			int pathPoint = files.get(0).getOriginalFilename().trim().lastIndexOf(".");
			String filePoint = files.get(0).getOriginalFilename().trim().substring(pathPoint + 1,
					files.get(0).getOriginalFilename().trim().length());
			fileType = filePoint.toLowerCase();
			System.out.println(fileType);
			HashMap<String,String> map2=new HashMap<String,String>();
			userVo uv=usermapper.getUserByUid(Integer.toString(currentUser.getUid()));
			File file=new File(request.getSession().getServletContext().getRealPath("/")+uv.getProfileimg());
			file.delete();
			SignUpService ss=new SignUpService();
			String root_path=request.getSession().getServletContext().getRealPath("/");
			ss.makeimageFile(files.get(0),currentUser.getId(),role,root_path,"profile");
			map2.put("uid", Integer.toString(currentUser.getUid()));
			map2.put("url", "/resources/uploadimgs/profileImg/"+currentUser.getId()+"."+fileType);
			usermapper.updateProfileImg(map2);
		}
		
		
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
		try{
			String aa=ss.sendpwmail(uid2, key, uv.getEmail());
			System.out.println("aa : "+aa);
		}
		catch(Exception e){
			return "NO";
		}
		return "OK";
	}
}
