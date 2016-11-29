package com.ipc.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.MarkDao;
import com.ipc.dao.UpLoadDocDao;
import com.ipc.service.MarkService;
import com.ipc.service.RegistrationService;
import com.ipc.util.CreateFileUtils;
import com.ipc.util.PathUtils;
import com.ipc.vo.DesignVo;
import com.ipc.vo.MarkVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/mark")
public class MarkController {
	@Autowired
	HttpSession session;
	@Autowired
	MarkDao markmapper;
	@Autowired
	MarkService markService;
	@Autowired
	UpLoadDocDao upDao;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	@RequestMapping(value="/regMark",method=RequestMethod.POST)
	public String regMark(HttpServletRequest request,MarkVo mv){
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> files = multipartRequest.getFiles("logo_file");
		RegistrationService rs = new RegistrationService();
		CreateFileUtils cfu = new CreateFileUtils();
		
		String file_name="mark"+rs.getToday(1)+"."+CreateFileUtils.getFileType(files.get(0).getOriginalFilename());
		cfu.CreateFile(files.get(0), request, "/resources/mark/", file_name);
		
		mv.setLogo("/resources/mark/"+file_name);
		mv.setUid(currentUser.getUid());
		
		markmapper.insertFirstMark(mv);
		markmapper.updateFirstMarkStart_mid(mv.getMid());
		return "user/userMain";
	}
	@RequestMapping("/detail/{mid}")
	public String markDetail(HttpServletRequest request,@PathVariable int mid,Model model){
		MarkVo mv=markmapper.getMarkByMid(mid);
		MarkVo prev_mv;
		session.removeAttribute("currentApply");
		session.setAttribute("currentApply", "Mark");
		session.setAttribute("MarkId", mid);
		int start_mid=markmapper.getStart_midByMid(mid);
		int countMark=markmapper.countMarkByStart_mid(start_mid);
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		if(currentUser!=null){
			if(countMark>1){
				prev_mv=markmapper.getMarkByMid(mv.getPrev_mid());
				model.addAttribute("prev_mv", prev_mv);
			}
			model.addAttribute("countMark", countMark);
			model.addAttribute("mv", mv);
			if(currentUser.getRole().equals(roleInventor))
			{
				if(currentUser.getUid()!=mv.getUid()){
					return "redirect:/authError";
				}
				
				
				
				return "comment/mark_comment_inventor";
			}
			else if(currentUser.getRole().equals(rolePatientntLawyer))
			{
				if(currentUser.getUid()!=mv.getLuid()){
					return "redirect:/authError";
				}
				
				
				
				return "comment/mark_comment_pl";
			}
		}
		
		
		return "aa";
	}
	@RequestMapping(value="/regMarkPl",method=RequestMethod.POST)
	public String regMarkPl(HttpServletRequest request,MarkVo mv){
		markService.saveMarkRegPL(request, mv);
		return "redirect:/mainPage";
				
	}
	@RequestMapping(value="/regMarkIn",method=RequestMethod.POST)
	public String regMarkIn(HttpServletRequest request,MarkVo mv){
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		RegistrationService rs = new RegistrationService();
		CreateFileUtils cfu = new CreateFileUtils();
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> files = multipartRequest.getFiles("logo_file");
		String file_name="mark"+rs.getToday(1)+"."+CreateFileUtils.getFileType(files.get(0).getOriginalFilename());
		cfu.CreateFile(files.get(0), request, "/resources/mark/", file_name);
		int start_mid=markmapper.getStart_midByMid(Integer.parseInt(request.getParameter("mid")));
		MarkVo mv2 = markmapper.getMarkByMid(Integer.parseInt(request.getParameter("mid")));
		mv.setLogo("/resources/mark/"+file_name);
		mv.setUid(currentUser.getUid());
		mv.setPrev_mid(Integer.parseInt(request.getParameter("mid")));
		mv.setStart_mid(start_mid);
		mv.setLuid(mv2.getLuid());
		markService.saveMarkRegIn(request, mv);
		return "redirect:/mainPage";
	}
	
	@RequestMapping(value="/changeMark",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> changeMark(HttpServletRequest request){
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		HashMap<String,Object> resultmap=new HashMap<String,Object>();
		String mid= request.getParameter("mid");
		int num = Integer.parseInt(request.getParameter("num"));
		int count = Integer.parseInt(request.getParameter("count"));
		int start_mid=markmapper.getStart_midByMid(Integer.parseInt(mid));
		num=num-1;
		map.put("start_mid", start_mid);
		map.put("num", num);
		System.out.println("start_mid,num : "+start_mid+","+num);
		MarkVo beVo=markmapper.getMarkByNum(map);
		System.out.println("1");
		resultmap.put("beVo", beVo);
		if(count!=num){
			num=num+1;
			map.put("num", num);
			MarkVo cuVo=markmapper.getMarkByNum(map);
			System.out.println("2");

			resultmap.put("cuVo", cuVo);
		}
		return resultmap;
	}
	@RequestMapping(value="/changeMarkPl",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> changeDesignPL(HttpServletRequest request){
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Integer> parameterMap = new HashMap<String,Integer>();
		int num = Integer.parseInt(request.getParameter("num"));
		
		int mid = Integer.parseInt(request.getParameter("mid"));
		int start_mid=markmapper.getStart_midByMid(mid);
		if(num!=1){
			parameterMap.put("num", num-2);
			parameterMap.put("start_mid", start_mid);

			MarkVo beVo = markmapper.getMarkByNum(parameterMap);
			System.out.println("beVo's title : "+beVo.getTitle1());
			resultMap.put("beVo", beVo);
			parameterMap.remove("num");

		}
		parameterMap.put("num", num-1);
		parameterMap.put("start_mid", start_mid);

		MarkVo cuVo = markmapper.getMarkByNum(parameterMap);
		System.out.println("cuVo's title : "+cuVo.getTitle1());
		resultMap.put("cuVo", cuVo);
		
		System.out.println("Ajax request : "+num);
		
		
		return resultMap;
	}
	@RequestMapping("/gotoApply")
	public String gotoApply(HttpServletRequest request){
		int mid=(int)session.getAttribute("MarkId");
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("mid", Integer.toString(mid));
		map.put("iscomplete", "3");
		markmapper.updateIscomplete(map);
		
		return "redirect:/mainPage";
	}
	@RequestMapping("/gotoUpLoad")
	public String gotoUpLoad(HttpServletRequest request,Model model){
		HashMap<String,String> mapExist = new HashMap<String,String>();
		mapExist.put("seq", Integer.toString((int)session.getAttribute("MarkId")));
		
		
		mapExist.put("patent_kind", "Mark");
		int isExist=upDao.isExist(mapExist);
		
		model.addAttribute("isExist", isExist);
		return "apply/uploadother";
	}
}
