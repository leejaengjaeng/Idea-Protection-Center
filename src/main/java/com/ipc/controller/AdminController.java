package com.ipc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ipc.dao.NoticeDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.UserDao;
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
}
