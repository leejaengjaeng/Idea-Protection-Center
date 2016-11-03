package com.ipc.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ipc.dao.NoticeDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.TypeOfInventDao;
import com.ipc.dao.UserDao;
import com.ipc.vo.LawyerProfileVo;
import com.ipc.vo.TypeOfInventVo;
import com.ipc.vo.adminListVo;
import com.ipc.vo.adminNoticeVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/IPC_admin")
public class AdminController {
	
	@Autowired
	RegistrationDao regDao;
	@Autowired
	UserDao userDao;
	@Autowired
	NoticeDao noticeDao;
	@Autowired
	TypeOfInventDao typeDao;
	//아이디어 관리
	@RequestMapping("/")
	public String admin2(Model model)
	{
		//권한 검사하기 -> security가 해줌 
		List<adminListVo> ideaList = regDao.adminGetIdeaList();
		List<userVo> lawyers = userDao.getLawyerList();
		model.addAttribute("ideaList", ideaList);
		model.addAttribute("lawyerList",lawyers);
		return "admin/admin_management";
	}
	//공지사항 관리
	@RequestMapping("/admin_notice")
	public String admin_notice(Model model){
		List<adminNoticeVo> noticeList=noticeDao.getNoticeListDesc();
		model.addAttribute("noticeList", noticeList);
		return "/admin/admin_notice";
	}
	
	//회원 관리
	@RequestMapping("/userList")
	public String userList(Model model){
		List<userVo> userList = userDao.getAllUsers();
		model.addAttribute("userList", userList);
		return "/admin/userList";
	}
	
	@RequestMapping("/viewLawyer")
	@ResponseBody
	public HashMap<String,String> viewLawyer(HttpServletRequest request){
		int uid=Integer.parseInt(request.getParameter("uid"));
		LawyerProfileVo lpv=userDao.getLawyerProfile(uid);
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("name", lpv.getName());
		map.put("major", lpv.getMajor());
		map.put("email", lpv.getEmail());
		map.put("introduce", lpv.getIntroduce());
		map.put("ID", lpv.getId());
		return map;
	}
	@RequestMapping("/manageType")
	public String manageType(HttpServletRequest request,Model model){
		List<TypeOfInventVo> toi=typeDao.getTypeList();
		model.addAttribute("vo", toi);
		
		
		return "/admin/manageType";
	}
	@RequestMapping("/rmtype")
	@ResponseBody
	public String rmType(HttpServletRequest request){
		int id=Integer.parseInt(request.getParameter("tid"));
		typeDao.rmType(id);
		return Integer.toString(id);
	}
	@RequestMapping("/addtype")
	@ResponseBody
	public HashMap<String,String> addtype(HttpServletRequest request){
		
		String type=request.getParameter("type");
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("type", type);
		typeDao.addType(map);
		
		return map;
	}
}
