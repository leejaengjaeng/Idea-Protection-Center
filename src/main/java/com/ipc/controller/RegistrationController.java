package com.ipc.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.MainPageDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.RegistrationFileDao;
import com.ipc.dao.UserDao;
import com.ipc.service.RegistrationService;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.mainPageVo;
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
	@Autowired
	RegistrationFileDao regisfilemapper;
	@Autowired
	MainPageDao mainpagemapper;
	MainPageController mpc=new MainPageController();
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	
	
	@RequestMapping("/addidea")
	public String addidea(Model model,HttpSession session, HttpServletRequest request)
	{
		
		if(request.getSession().getAttribute("currentUser")==null)
		{
			return "redirect:/login";
		}
		
		userVo uv=(userVo) request.getSession().getAttribute("currentUser");
		
		if(uv.getRole().equals("ROLE_PATIENTENTLAWYER"))
		{
			return "redirect:/authError";
		}
		
		if(regismapper.countTempIdea(uv.getUid())!=0){
			List<RegistrationPatentVo> tempList = regismapper.gettempidea(uv.getUid());
			model.addAttribute("isTemp", "1");
			model.addAttribute("tempList",tempList);
			
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
	public String inputidea(HttpServletRequest request,RegistrationPatentVo rv){
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //다중파일 업로드
		List<MultipartFile> files = multipartRequest.getFiles("imgs");
		int rm = regismapper.countTempIdea(rv.getUid());
		System.out.println("rm : "+rm);
		if (rm!=0){
			regismapper.removeTempIdea(rv.getUid());
		}
		String root_path=request.getSession().getServletContext().getRealPath("/");
		
		System.out.println(root_path);
		System.out.println(rv.getEffect());
		RegistrationService rs=new RegistrationService();
		rv.setRegistration_date(rs.getToday(0));
		regismapper.makeidea(rv);		
		System.out.println(rv.getRid());
		regismapper.updateStartId(rv.getRid());
		int uid=rv.getUid();
		userVo uv=usermapper.getUserByUid(Integer.toString(uid));
		System.out.println("uid:"+uid);
		for(int i=0;i<files.size();i++){
			String today=rs.getToday(1)+i;
			String fileType=rs.makeimageFile(files.get(i),today ,uv.getId(),rv.getRid(),root_path);
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("start_rid", Integer.toString(rv.getRid()));
			map.put("file_path", "/resources/uploadimgs/inventor/"+uv.getId()+"/"+today+"."+fileType);
			regisfilemapper.makeFile(map);
		}
		
		
		//mainPage 테이블에 추가
		mainPageVo mpv=new mainPageVo();
		mpv=mpc.shiftData(rv, "결제대기중");
		mainpagemapper.insertFirstRow(mpv);
		return "home/index";
	}
	
	@RequestMapping(value="/tempsave",method=RequestMethod.POST)
	@ResponseBody
	public HashMap <String,Object> tempsave(HttpServletRequest request,@RequestParam HashMap<String, Object> param){
		
		System.out.println("FOR YOU -> " +request.getSession().getServletContext().getRealPath("/"));
		
		RegistrationService rs = new RegistrationService();
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
		hashmap.put("registration_date", rs.getToday(0));
//		int rv = regismapper.countTempIdea(Integer.parseInt(uid));
//		System.out.println("rv: "+rv);
//		if(rv!=0){
//			regismapper.updatetempidea(hashmap);
//		}
//		else{
			regismapper.maketempidea(hashmap);
		//}
		HashMap<String, Object> hashmap2 = new HashMap<String, Object>();
		hashmap2.put("aa", "aa");
		return hashmap2;
		
	}
	
	@RequestMapping(value="/loadTempIdea",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> loadTempIdea(HttpServletRequest request){
		
		String rid=request.getParameter("rid");
		System.out.println(rid);
		RegistrationPatentVo rv=regismapper.getloadtemp(Integer.parseInt(rid));
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
		String rid=request.getParameter("rid");
		regismapper.removeTempIdea(Integer.parseInt(rid));
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("aa","aa");
		return hashmap;
	}
	@RequestMapping("/addDesign")
	public String addDesign(){
		return "registration/idea_design";
	}
}
	
