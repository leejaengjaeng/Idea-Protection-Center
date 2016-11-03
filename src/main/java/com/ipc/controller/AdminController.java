package com.ipc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ipc.dao.NoticeDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.TypeOfInventDao;
import com.ipc.dao.UserDao;
import com.ipc.vo.LawyerProfileVo;
import com.ipc.vo.QnaVo;
import com.ipc.vo.TypeOfInventVo;
import com.ipc.vo.adminListVo;
import com.ipc.vo.adminNoticeVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/IPC_admin")
public class AdminController {

	private static final int pagePerContents = 10;
	private static final int pagesPerView = 5;

	@Autowired
	RegistrationDao regDao;
	@Autowired
	UserDao userDao;
	@Autowired
	NoticeDao noticeDao;
	@Autowired
	TypeOfInventDao typeDao;

	// 아이디어 관리
	@RequestMapping("/")
	public String admin2(Model model) {
		// 권한 검사하기 -> security가 해줌
		List<adminListVo> ideaList = regDao.adminGetIdeaList();
		List<userVo> lawyers = userDao.getLawyerList();
		model.addAttribute("ideaList", ideaList);
		model.addAttribute("lawyerList", lawyers);
		return "admin/admin_management";
	}

	// 공지사항 관리
	@RequestMapping("/admin_notice")
	public String admin_notice_Default(Model model) {
		return admin_notice(model, 1);
	}

	@RequestMapping("/admin_notice/{pageNum}")
	public String admin_notice(Model model, @PathVariable int pageNum) {
		// 전체 페이지 수 계산
		int totalContents = noticeDao.getTotalSize();
		int totalPages;
		if (totalContents % pagePerContents == 0)
			totalPages = totalContents / pagePerContents;
		else
			totalPages = totalContents / pagePerContents + 1;
		// 이상한 경로로 접근했다 권한에러
		if (pageNum > totalPages || pageNum <= 0)
			return "redirect:/authError";

		// 시작 글 위치 계산
		int start;
		if (totalPages == 1)
			start = 0;
		else if (pageNum == totalPages)
			start = totalContents - 10; // 마지막 페이지인 경우
		else
			start = (pageNum - 1) * 10;

		// 페이지네이션 버튼 값 들
		// if 총 페이지가 5개 안되면 : < 1 2 >
		// if 총 페이지가 충분하면 : < 3 4 5 6 7 >
		List<Integer> pages = new ArrayList();
		if (totalPages < 5) {
			for (int i = 1; i <= totalPages; i++)
				pages.add(i);
		} else {
			for (int i = pageNum; i <= pagesPerView && i <= totalPages; i++)
				pages.add(i);
		}

		// notice리스트 받아오기
		HashMap<String, Integer> startAndPPC = new HashMap<String, Integer>();
		startAndPPC.put("start", start);
		startAndPPC.put("pagePerContents", pagePerContents);
		List<QnaVo> noticeList = noticeDao.getNotices(startAndPPC);

		// 방향 표들
		int leftArrow = (pageNum - pagesPerView) < 0 ? 1 : (pageNum - pagesPerView);
		int rightArrow = (pageNum + pagesPerView) >= totalPages ? totalPages : pageNum + pagesPerView;

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pages", pages);
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("leftArrow", leftArrow);
		model.addAttribute("rightArrow", rightArrow);
		return "/admin/admin_notice";
	}

	// 회원 관리
	@RequestMapping("/userList")
	public String userList(Model model) {
		List<userVo> userList = userDao.getAllUsers();
		model.addAttribute("userList", userList);
		return "/admin/userList";
	}

	@RequestMapping("/viewLawyer")
	@ResponseBody
	public HashMap<String, String> viewLawyer(HttpServletRequest request) {
		int uid = Integer.parseInt(request.getParameter("uid"));
		LawyerProfileVo lpv = userDao.getLawyerProfile(uid);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("name", lpv.getName());
		map.put("major", lpv.getMajor());
		map.put("email", lpv.getEmail());
		map.put("introduce", lpv.getIntroduce());
		map.put("ID", lpv.getId());
		return map;
	}

	@RequestMapping("/manageType")
	public String manageType(HttpServletRequest request, Model model) {
		List<TypeOfInventVo> toi = typeDao.getTypeList();
		model.addAttribute("vo", toi);

		return "/admin/manageType";
	}

	@RequestMapping("/rmtype")
	@ResponseBody
	public String rmType(HttpServletRequest request) {
		int id = Integer.parseInt(request.getParameter("tid"));
		typeDao.rmType(id);
		return Integer.toString(id);
	}

	@RequestMapping("/addtype")
	@ResponseBody
	public HashMap<String, String> addtype(HttpServletRequest request) {

		String type = request.getParameter("type");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("type", type);
		typeDao.addType(map);

		return map;
	}
}
