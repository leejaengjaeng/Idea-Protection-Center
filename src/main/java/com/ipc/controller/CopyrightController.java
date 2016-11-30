package com.ipc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.CopyrightDao;
import com.ipc.dao.CopyrightInfoDao;
import com.ipc.dao.TypeOfCopyrightDao;
import com.ipc.dao.UserDao;
import com.ipc.service.RegistrationService;
import com.ipc.util.CreateFileUtils;
import com.ipc.vo.CopyRightInfoVo;
import com.ipc.vo.CopyRightVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/copyRight")
public class CopyrightController {

	@Autowired
	TypeOfCopyrightDao typeOfCopyrightDao;
	@Autowired
	UserDao userDao;
	@Autowired
	CopyrightDao copyrightDao;
	@Autowired
	CopyrightInfoDao copyrightInfoDao;
	@Autowired
	HttpSession session;
	
	
	@RequestMapping("/showRegPage")
	public String copyRightShow(Model model)
	{
		List typeList = typeOfCopyrightDao.getTypeList();
		model.addAttribute("typeList", typeList);
		return "registration/idea_copyright";
	}
	
	@RequestMapping(value="/regCopyright", method=RequestMethod.POST)
	public String copyRightReg(HttpServletRequest req, Model model)
	{
		RegistrationService rs = new RegistrationService();
		CreateFileUtils cfu = new CreateFileUtils();
		
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)req;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> files = multipartRequest.getFiles("plane_img");
		String file_name="mark"+rs.getToday(1);
		cfu.CreateFile(files.get(0), req, "/resources/uploadimgs/mark/", file_name);
		
		String title	= req.getParameter("idea_kind");
		String field	= req.getParameter("field_selected");
		String type 	= req.getParameter("kind");
		String meaning  = req.getParameter("meaning");
		int uid			= Integer.parseInt(req.getParameter("uid"));
		
		CopyRightVo cv = new CopyRightVo();
		cv.setTitle(title);
		cv.setField(field);
		cv.setType(type);
		cv.setMeaning(meaning);
		cv.setUid(uid);
		
		CopyRightInfoVo civ = new CopyRightInfoVo();
		civ.setCid(cv.getCid());
		civ.setUid(uid);
		civ.setTitle(title);
		civ.setInventor_name(userDao.getNameByUid(uid));
		
		copyrightDao.addCopyright(cv);
		copyrightDao.updateStartCid(cv);
		copyrightInfoDao.addCopyrightInfo(civ);
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/regCopyright_inventor", method=RequestMethod.POST)
	public String copyRightUpdate_Inventor(HttpServletRequest req, Model model)
	{
		/*
		 *  XXX
		 *  cid가 무조건 가장 마지막 cid를 가지고 와야함
		 *  안그러면 개박살!
		 */
		
		int cid = Integer.parseInt(req.getParameter("cid"));
		CopyRightVo cv = copyrightDao.getOneRowByCid(cid);
		CopyRightInfoVo civ = new CopyRightInfoVo();

		civ.setMpcid(copyrightInfoDao.getMpcidByCid(cid).getMpcid());
		
		String title	= req.getParameter("re_idea_kind_inventor");
		if(!title.equals(""))
		{
			cv.setTitle(title);
			civ.setTitle(title);
		}
		
		String field	= req.getParameter("re_field_selected");
		if(!field.equals("")) cv.setField(field);
		
		String type 	= req.getParameter("re_kind");
		if(!type.equals("")) cv.setType(type);
		
		String meaning  = req.getParameter("re_meaning");
		if(!meaning.equals("")) cv.setMeaning(meaning);

		cv.setCid(0);
		cv.setPrev_cid(cid);
		copyrightDao.addCopyright(cv);
		
		System.out.println(cv.getCid());
		civ.setCid(cv.getCid());
		copyrightInfoDao.updateInfoByMpcid(civ);
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/regCopyright_pl", method=RequestMethod.POST)
	public String copyRightUpdate_pl(HttpServletRequest req, Model model)
	{
		
		int cid = Integer.parseInt(req.getParameter("cid"));
		
		String title	= req.getParameter("re_idea_kind");
		String field	= req.getParameter("re_field_selected");
		String type 	= req.getParameter("re_kind");
		String meaning  = req.getParameter("re_meaning");
		int uid			= Integer.parseInt(req.getParameter("uid"));

		CopyRightVo cv = new CopyRightVo();
		cv.setCid(cid);
		cv.setRe_title(title);
		cv.setRe_field(field);
		cv.setRe_type(type);
		cv.setRe_meaning(meaning);
		cv.setFlag(1); 	
		
		/*
		 * Flag
		 * 0 : 변리사 작성 차례
		 * 1 : 완료된 row
		 */
		
		copyrightDao.updateCopyright_pl(cv);
		
		return "redirect:/";
	}
	
	@RequestMapping("/detail/{cid}")
	public String detailView(Model model,@PathVariable int cid)
	{
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		CopyRightVo cv = copyrightDao.getOneRowByCid(cid);
		if(cv==null) return "redirect:/authError";
		
		List typeList = typeOfCopyrightDao.getTypeList();
		List<CopyRightVo> chasuList = copyrightDao.getAssosiatedList(cv.getStart_cid());
		
		if(currentUser.getRole().equals("ROLE_INVENTOR"))
		{
			if(cv.getUid()!=currentUser.getUid()) return "redirect:/authError";
			
			model.addAttribute("copyrightVo",cv);
			model.addAttribute("typeList", typeList);
			model.addAttribute("chasuList", chasuList);
			model.addAttribute("role", "inventor");
			
			return "comment/copy_comment_inventor";
		}
		else if(currentUser.getRole().equals("ROLE_PATIENTENTLAWYER"))
		{
			if(cv.getLid()!=currentUser.getUid()) return "redirect:/authError";
		
			CopyRightVo beforeCv = copyrightDao.getOneRowByCid(cv.getPrev_cid());
			
			model.addAttribute("copyrightVo",cv);
			model.addAttribute("beforeCv",beforeCv);
			
			model.addAttribute("typeList", typeList);
			model.addAttribute("chasuList", chasuList);
			model.addAttribute("role", "pl");
			
			return "comment/copy_comment_pl";
		}
		else
			return "redirect:/";
	}

	
	
}


