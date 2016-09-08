package com.ipc.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.RegistrationDao;
import com.ipc.dao.UserDao;
import com.ipc.service.RegistrationService;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
	@Autowired
	HttpSession session;
	@Autowired
	RegistrationDao regismapper;
	@Autowired
	UserDao usermapper;
	
	@RequestMapping("/addidea")
	public String addidea(){
		return "registration/idea_registration";
	}
	@RequestMapping("/inventor_main")
	public String inventor_main(){
		return "inventor/inventor_main";
	}
	@RequestMapping(value="/inputidea",method=RequestMethod.POST)
	public String inputidea(HttpServletRequest request){
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //다중파일 업로드
		List<MultipartFile> files = multipartRequest.getFiles("imgs");
		String uid=request.getParameter("uid");
		String typeOfInvent=request.getParameter("typeOfInvent");
		String title=request.getParameter("title");
		String summary=request.getParameter("summary");
		String whyInvent=request.getParameter("whyInvent");
		String solution=request.getParameter("solution");
		String effect=request.getParameter("effect");
		String core_element=request.getParameter("core_element");
		HashMap<String,String> map=new HashMap();
		map.put("uid", "1111");
		map.put("typeOfInvent", typeOfInvent);
		map.put("title", title);
		map.put("summary", summary);
		map.put("whyInvent", whyInvent);
		map.put("solution", solution);
		map.put("effect", effect);
		map.put("core_element", core_element);
		RegistrationService rs=new RegistrationService();
		map.put("registrtaion_date",rs.getToday(0) );
		regismapper.makeidea(map);
		//userVo uv=usermapper.getUserByUid(uid);
		for(int i=0;i<files.size();i++){
			rs.makeimageFile(files.get(0), "111"+rs.getToday(1)+i,"inventor\\" );
		}
		return "home/index";
	}
	
	@RequestMapping(value="/tempsave",method=RequestMethod.POST)
	@ResponseBody
	public HashMap <String,Object> tempsave(HttpServletRequest request,@RequestParam HashMap<String, Object> param){
		System.out.println(param.get("summary").toString());
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		hashmap.put("aa", "aa");
		return hashmap;
		
	}
}
