package com.ipc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ipc.dao.NoticeDao;
import com.ipc.service.RegistrationService;
import com.ipc.vo.adminNoticeVo;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	NoticeDao noticeDao;
	
	@RequestMapping(value="/admin_notice_registration")
	public String adminNotice(){
		return "admin/admin_regis_notice";
	}
	@RequestMapping(value="/noticeRegistration",method=RequestMethod.POST)
	public String noticeRegistration(adminNoticeVo an){
		RegistrationService rs = new RegistrationService();
		an.setDate(rs.getToday(0));
		noticeDao.regisNotice(an);
		return "admin/admin_management";
		
	}
	@RequestMapping(value="/noticeList/{nid}",method=RequestMethod.GET)
	public String noticeList(Model model,@PathVariable int nid){
		adminNoticeVo an = noticeDao.getNoticeByNid(nid);
		model.addAttribute("noticeVo", an);
		return "admin/noticeDetail";
	}
	@RequestMapping("/noticePage")
	public String noticePage(Model model){
		List<adminNoticeVo> noticeList=noticeDao.getNoticeListDesc();
		model.addAttribute("noticeList", noticeList);
		return "/admin/noticeList";
	}
}
