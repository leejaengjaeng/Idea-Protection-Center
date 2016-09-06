package com.ipc.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ipc.dao.UserDao;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/signup")
public class SignUpController {
	
	@Autowired
	UserDao usermapper;
	
	@RequestMapping("/signupPage")
	public String signupPage(Model model){
		return "signup/signup";
	}
	@RequestMapping(value="/inputsignup", method=RequestMethod.POST)
	public String inputsignup(Model model,HttpServletRequest request,userVo uv){
		String email = request.getParameter("email1") + request.getParameter("email2");
		System.out.println(uv.getId());
		System.out.println(uv.getPw());
		System.out.println(email);
		System.out.println(uv.getName());
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("id", uv.getId());
		map.put("pw", uv.getPw());
		map.put("email", email);
		map.put("name", uv.getName());
		if(request.getParameter("role")=="1"){
			map.put("role", "1");
		}
		else{
			map.put("role", "2");
//			HashMap<String,String> map2=new HashMap<String,String>();
//			map2.put("uid", uv.getUid());
//			map2.put("license_scan_img", "")
		}
		usermapper.makeuser(map);
		return "/";
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
		if(uv.getIs_member()==key){
			uv.setIs_member("TRUE");
		}
		return "/";
	}
}
