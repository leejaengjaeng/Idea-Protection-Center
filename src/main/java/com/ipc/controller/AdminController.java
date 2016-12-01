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

import com.ipc.dao.CopyrightDao;
import com.ipc.dao.CopyrightInfoDao;
import com.ipc.dao.DesignDao;
import com.ipc.dao.MainPageDao;
import com.ipc.dao.MarkDao;
import com.ipc.dao.NoticeDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.TypeOfInventDao;
import com.ipc.dao.UserDao;
import com.ipc.util.ViewUtils;
import com.ipc.vo.CopyRightInfoVo;
import com.ipc.vo.CopyrightAdminVo;
import com.ipc.vo.DesignAdminVo;
import com.ipc.vo.LawyerProfileVo;
import com.ipc.vo.MarkAdminVo;
import com.ipc.vo.QnaVo;
import com.ipc.vo.TypeOfInventVo;
import com.ipc.vo.adminListVo;
import com.ipc.vo.adminNoticeVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/IPC_admin")
public class AdminController {

	private static final int pagePerContents = 10;
	private static final int pagePerbuttons = 5;

	@Autowired
	RegistrationDao regDao;
	@Autowired
	UserDao userDao;
	@Autowired
	NoticeDao noticeDao;
	@Autowired
	TypeOfInventDao typeDao;
	@Autowired
	ViewUtils viewUtils;
	@Autowired
	MainPageDao mainPageDao;
	@Autowired
	DesignDao designmapper;
	@Autowired
	MarkDao markmapper;
	@Autowired
	CopyrightInfoDao copyrightInfoDao;
	@Autowired
	CopyrightDao copyrightDao;
	
	
	// 아이디어 관리
	@RequestMapping("/")
	public String admin2(Model model) {
		
		return ideaList(model,1);
	}
	@RequestMapping("/mark")
	public String mark(Model model){
		List<MarkAdminVo> mav = markmapper.getMarkListAdmin();
		List<userVo> lawyers = userDao.getLawyerList();
		model.addAttribute("lawyerList",lawyers);
		model.addAttribute("markAdminKist", mav);
		return "admin/admin_mark";
	}
	@RequestMapping("/design")
	public String design(Model model){
		List<DesignAdminVo> designAdminList = designmapper.getDesignListAdmin();
		List<userVo> lawyers = userDao.getLawyerList();
		model.addAttribute("lawyerList",lawyers);
		model.addAttribute("designAdminList", designAdminList);
		return "admin/admin_design";
	}
	
	@RequestMapping("/copyright")
	public String copyright(Model model)
	{
		List<CopyrightAdminVo> copyrightList = copyrightInfoDao.getCopyrightListAtAdmin();
		List<userVo> lawyers = userDao.getLawyerList();
		model.addAttribute("copyrightList", copyrightList);
		model.addAttribute("lawyerList",lawyers);
		return "admin/admin_copyright";
	}
	
	@RequestMapping("/ideas/{pageNum}")
	public String ideaList(Model model, @PathVariable int pageNum) {
		
		// 페이지 네이션
		int totalIdea = mainPageDao.countIdeas();
		try {
			/*
			 * List<Integer> pageButtons : 페이지네이션 버튼 값 리스트
			 * HashMap<String,Integer> arrows : 페이지네이션 버튼 양 옆 화살표의 값 맵
			 * HashMap<String,Integer> bounds : Dao에서 사용할 시작~끝 범위
			 */
			HashMap<String, Object> pageNationAttrs 
			= viewUtils.getPageNationAttributes(pageNum, totalIdea,	pagePerContents, pagePerbuttons);

			List<Integer> pageButtons = (List<Integer>) pageNationAttrs.get("pageButtons");
			HashMap<String, Integer> arrows = (HashMap<String, Integer>) pageNationAttrs.get("arrows");
			HashMap<String, Integer> bounds = (HashMap<String, Integer>) pageNationAttrs.get("bounds");

			List<adminListVo> ideaList = regDao.getIdeaListInBound(bounds);
			List<userVo> lawyers = userDao.getLawyerList();

			model.addAttribute("ideaList", ideaList);
			model.addAttribute("lawyerList", lawyers);
			model.addAttribute("pageNationButtons", pageButtons);
			model.addAttribute("currentPage", pageNum);
			model.addAttribute("leftArrow", arrows.get("leftArrow"));
			model.addAttribute("rightArrow", arrows.get("rightArrow"));
			return "admin/admin_management";

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/authError";
		}
	}

	// 공지사항 관리
	@RequestMapping("/admin_notice")
	public String admin_notice_Default(Model model) {
		return admin_notice(model, 1);
	}

	@RequestMapping("/admin_notice/{pageNum}")
	public String admin_notice(Model model, @PathVariable int pageNum) {
		// 페이지 네이션
		int totalNotice = noticeDao.getTotalSize();
		try {
			/*
			 * List<Integer> pageButtons : 페이지네이션 버튼 값 리스트
			 * HashMap<String,Integer> arrows : 페이지네이션 버튼 양 옆 화살표의 값 맵
			 * HashMap<String,Integer> bounds : Dao에서 사용할 시작~끝 범위
			 */
			HashMap<String, Object> pageNationAttrs = viewUtils.getPageNationAttributes(pageNum, totalNotice,
					pagePerContents, pagePerbuttons);

			List<Integer> pageButtons = (List<Integer>) pageNationAttrs.get("pageButtons");
			HashMap<String, Integer> arrows = (HashMap<String, Integer>) pageNationAttrs.get("arrows");
			HashMap<String, Integer> bounds = (HashMap<String, Integer>) pageNationAttrs.get("bounds");

			List<QnaVo> noticeList = noticeDao.getNotices(bounds);

			model.addAttribute("noticeList", noticeList);
			model.addAttribute("pageNationButtons", pageButtons);
			model.addAttribute("currentPage", pageNum);
			model.addAttribute("leftArrow", arrows.get("leftArrow"));
			model.addAttribute("rightArrow", arrows.get("rightArrow"));
			return "/admin/admin_notice";

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/authError";
		}
	}

	// 회원 관리
	@RequestMapping("/userList")
	public String defaultUserList(Model model) {
		return userList(model, 1);
	}

	@RequestMapping("/userList/{pageNum}")
	public String userList(Model model, @PathVariable int pageNum) {

		// 페이지 네이션
		int totalUser = userDao.counTotalUser();
		try {
			/*
			 * List<Integer> pageButtons : 페이지네이션 버튼 값 리스트
			 * HashMap<String,Integer> arrows : 페이지네이션 버튼 양 옆 화살표의 값 맵
			 * HashMap<String,Integer> bounds : Dao에서 사용할 시작~끝 범위
			 */
			HashMap<String, Object> pageNationAttrs = viewUtils.getPageNationAttributes(pageNum, totalUser,
					pagePerContents, pagePerbuttons);

			List<Integer> pageButtons = (List<Integer>) pageNationAttrs.get("pageButtons");
			HashMap<String, Integer> arrows = (HashMap<String, Integer>) pageNationAttrs.get("arrows");
			HashMap<String, Integer> bounds = (HashMap<String, Integer>) pageNationAttrs.get("bounds");

			List<userVo> userList = userDao.getUsersInBounds(bounds);

			model.addAttribute("userList", userList);
			model.addAttribute("pageNationButtons", pageButtons);
			model.addAttribute("currentPage", pageNum);
			model.addAttribute("leftArrow", arrows.get("leftArrow"));
			model.addAttribute("rightArrow", arrows.get("rightArrow"));
			return "/admin/userList";

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/authError";
		}
	}

	@RequestMapping("/viewLawyer")
	@ResponseBody
	public HashMap<String, String> viewLawyer(HttpServletRequest request) {
		int uid = Integer.parseInt(request.getParameter("uid"));
		System.out.println("luid : "+uid);
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
	
	@RequestMapping("/assignDesign")
	@ResponseBody
	public HashMap<String,String> assignDesign(HttpServletRequest request){
		String deid=request.getParameter("deid");
		String uid = request.getParameter("uid");
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("deid", deid);
		map.put("uid", uid);
		
		designmapper.updatePatent(map);
		
		
		HashMap<String,String> resultMap = new HashMap<String,String>();
		resultMap.put("lawyerName", userDao.getUserByUid(uid).getName());
		return resultMap;
	}
	@RequestMapping("/assignMark")
	@ResponseBody
	public HashMap<String,String> assignMark(HttpServletRequest request){
		String mid=request.getParameter("mid");
		String uid = request.getParameter("uid");
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("mid", mid);
		map.put("uid", uid);
		
		markmapper.updatePatent(map);
		
		
		HashMap<String,String> resultMap = new HashMap<String,String>();
		resultMap.put("lawyerName", userDao.getUserByUid(uid).getName());
		return resultMap;
	}
	//
	@RequestMapping("/assignCopyright")
	@ResponseBody
	public HashMap<String,String> assignCopyright(HttpServletRequest request){
		int cid = Integer.parseInt(request.getParameter("cid"));
		int lid = Integer.parseInt(request.getParameter("plId"));
		
		CopyRightInfoVo mpcid = copyrightInfoDao.getMpcidByCid(cid);
		String plName = userDao.getNameByUid(lid);
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("mpcid", mpcid.getMpcid()+"");
		map.put("lid", lid+"");
		map.put("pl_name",plName);
		map.put("reg_condition", "변리사 수정중");

		copyrightInfoDao.asignPl(map);
		map.put("cid", cid+"");
		copyrightDao.setLidtoRow(map);
		
		HashMap<String,String> resultMap = new HashMap<String,String>();
		resultMap.put("plName", plName);
		resultMap.put("condition", "변리사 수정중");
		
		
		return resultMap;
	}
}
