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
import org.springframework.ui.Model;
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
public class RegistrationController {	//localhost:8088/registration/inventor_main
	@Autowired
	HttpSession session;
	@Autowired
	RegistrationDao regismapper;
	@Autowired
	UserDao usermapper;
	
	@RequestMapping("/addidea")
	public String addidea(Model model,HttpSession session, HttpServletRequest request){
		userVo uv=(userVo) request.getSession().getAttribute("currentUser");
		System.out.println(uv.getUid());
		if(regismapper.countTempIdea(uv.getUid())!=0){
			model.addAttribute("isTemp", "1");
			
		}
		else{
			model.addAttribute("isTemp", "0");
		}
			
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
		System.out.println(files.size());
		String uid=request.getParameter("uid");
		String typeOfInvent=request.getParameter("typeOfInvent");
		String title=request.getParameter("title");
		String summary=request.getParameter("summary");
		String whyInvent=request.getParameter("whyInvent");
		String solution=request.getParameter("solution");
		String effect=request.getParameter("effect");
		String core_element=request.getParameter("core_element");
		String problem = request.getParameter("problem");
		HashMap<String,String> map=new HashMap();
		map.put("uid", uid);
		map.put("typeOfInvent", typeOfInvent);
		map.put("title", title);
		map.put("summary", summary);
		map.put("whyInvent", whyInvent);
		map.put("solution", solution);
		map.put("effect", effect);
		map.put("core_element", core_element);
		map.put("problem",problem);
		RegistrationService rs=new RegistrationService();
		map.put("registrtaion_date",rs.getToday(0) );
		regismapper.makeidea(map);
		
		//userVo uv=usermapper.getUserByUid(uid);
		for(int i=0;i<files.size();i++){
			rs.makeimageFile(files.get(i), rs.getToday(1)+i,"inventor\\");
		}
		return "home/index";
	}
	
	@RequestMapping(value="/tempsave",method=RequestMethod.POST)
	@ResponseBody
	public HashMap <String,Object> tempsave(HttpServletRequest request,@RequestParam HashMap<String, Object> param){
		String typeOfInvent= param.get("typeOfInvent").toString();
		String title = param.get("title").toString();
		String whyInvent= param.get("whyInvent").toString();
		String summary=param.get("summary").toString();
		String problem= param.get("problem").toString();
		String solution= param.get("solution").toString();
		String effect= param.get("effect").toString();
		String core_element= param.get("core_element").toString();
		String uid=param.get("uid").toString();
		System.out.println("title : "+title);
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("typeOfInvent", typeOfInvent);
		hashmap.put("title", title);
		hashmap.put("whyInvent", whyInvent);
		hashmap.put("solution", solution);
		hashmap.put("effect", effect);
		hashmap.put("summary", summary);
		hashmap.put("problem", problem);
		hashmap.put("core_element", core_element);
		hashmap.put("uid", uid);
		int rv = regismapper.countTempIdea(Integer.parseInt(uid));
		System.out.println("rv: "+rv);
		if(rv!=0){
			regismapper.updatetempidea(hashmap);
		}
		else{
			regismapper.maketempidea(hashmap);
		}
		HashMap<String, Object> hashmap2 = new HashMap<String, Object>();
		hashmap2.put("aa", "aa");
		return hashmap2;
		
	}
	
	@RequestMapping(value="/loadTempIdea",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> loadTempIdea(HttpServletRequest request){
		
		String uid=request.getParameter("uid");
		System.out.println(uid);
		RegistrationPatentVo rv=regismapper.gettempidea(Integer.parseInt(uid));
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("typeOfInvent", rv.getTypeOfInvent());
		hashmap.put("title", rv.getTitle());
		hashmap.put("whyInvent", rv.getWhyInvent());
		hashmap.put("solution", rv.getSolution());
		hashmap.put("effect", rv.getEffect());
		hashmap.put("summary", rv.getSummary());
		hashmap.put("problem", rv.getProblem());
		hashmap.put("core_element", rv.getCore_element());
		System.out.println(rv.getTypeOfInvent());
		System.out.println(rv.getSummary());
		return hashmap;
	}
	@RequestMapping(value="/removeTempIdea",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> removeTempIdea(HttpServletRequest request){
		String uid=request.getParameter("uid");
		regismapper.removeTempIdea(Integer.parseInt(uid));
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("aa","aa");
		return hashmap;
	}
}
