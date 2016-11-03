package com.ipc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ipc.dao.NoticeDao;
import com.ipc.service.RegistrationService;
import com.ipc.vo.QnaVo;
import com.ipc.vo.adminNoticeVo;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	private static final int pagePerContents = 10;
	private static final int pagesPerView = 5;
	
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
	
	//Notice 디테일 페이지 
	//TODO: 경로 noticeDetail로 바꾸기
	@RequestMapping(value="/noticeList/{nid}",method=RequestMethod.GET)
	public String noticeList(Model model,@PathVariable int nid){
		adminNoticeVo an = noticeDao.getNoticeByNid(nid);
		model.addAttribute("noticeVo", an);
		return "notice/noticeDetail";
	}
	
	@RequestMapping("/noticePage")
	public String noticePageDefault(Model model){
		return noticePage(model,1);
	}
	@RequestMapping("/noticePage/{pageNum}")
	public String noticePage(Model model,@PathVariable int pageNum){
		
		//전체 페이지 수 계산
		int totalContents = noticeDao.getTotalSize();
		int totalPages;
		if(totalContents%pagePerContents==0) totalPages= totalContents/pagePerContents;
		else totalPages = totalContents/pagePerContents+1;
	
		//이상한 경로로 접근했다 권한에러
		if(pageNum > totalPages || pageNum <= 0)
			return "redirect:/authError";
		
		//시작 글 위치 계산 
		int start;
		if(totalPages==1) start=0;
		else if(pageNum==totalPages) start = totalContents - 10; //마지막 페이지인 경우
		else start = (pageNum-1)*10;
	

		//페이지네이션 버튼 값 들 
		//if 총 페이지가 5개 안되면 : < 1 2 >
		//if 총 페이지가 충분하면    : < 3 4 5 6 7 > 
		List<Integer> pages = new ArrayList();
		if(totalPages<5)
		{
			for(int i=1 ; i<=totalPages; i++)
				pages.add(i);
		}
		else
		{
			for(int i=pageNum ; i<=pagesPerView && i<=totalPages ; i++)
				pages.add(i);
		}
	
		//notice리스트 받아오기
		HashMap<String,Integer> startAndPPC = new HashMap<String,Integer>();
		startAndPPC.put("start",start);
		startAndPPC.put("pagePerContents",pagePerContents);
		List<QnaVo> noticeList=noticeDao.getNotices(startAndPPC);
	
		//방향 표들 
		int leftArrow = (pageNum - pagesPerView)<0 ? 1:(pageNum - pagesPerView);
		int rightArrow = (pageNum + pagesPerView)>=totalPages ? totalPages : pageNum + pagesPerView;
		
		model.addAttribute("noticeList",noticeList);
		model.addAttribute("pages",pages);
		model.addAttribute("currentPage",pageNum);
		model.addAttribute("leftArrow",leftArrow);
		model.addAttribute("rightArrow",rightArrow);

		return "/notice/noticeList";
	}
}
