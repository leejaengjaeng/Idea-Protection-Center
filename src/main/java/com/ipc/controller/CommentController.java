package com.ipc.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.DocumentDao;
import com.ipc.dao.MainPageDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.RegistrationFileDao;
import com.ipc.dao.TypeOfInventDao;
import com.ipc.service.MessageService;
import com.ipc.service.RegistrationService;
import com.ipc.service.SignUpService;
import com.ipc.vo.RegistrationFileVo;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.TypeOfInventVo;
import com.ipc.vo.userVo;


@Controller
public class CommentController {
	
	@Autowired
	RegistrationDao regDao;
	@Autowired
	HttpSession session;
	@Autowired
	RegistrationFileDao regFileDao;
	@Autowired
	MainPageDao mainPageDao;
	@Autowired
	DocumentDao docDao;
	@Autowired
	RegistrationFileDao regisFileMapper; 
	@Autowired
	MessageService mService;
	@Autowired
	RegistrationService ss;
	@Autowired
	TypeOfInventDao typemapper;
	
	/*
	발명가

		-이전 작성
		코멘트   -
		
		-새로 작성
		
   	변리사
		
		이전 코멘트 - 
		
		-발명가 작성 
		새로운 코멘트-
		
		//iscomplete 0 고객 작성 차례, 1 변리사 작성 차례
			
	 */
	@RequestMapping(value="/detail/{start_rid}",method=RequestMethod.GET)
	public String detail(@PathVariable int start_rid,Model model)
	{
		//접근한 경로에 대한 권한 확인
		RegistrationPatentVo assosiatedMemberId = regDao.getAssociatedMembersByRid(start_rid);		

		Object isAuthenticated = session.getAttribute("currentUser");
		List<TypeOfInventVo> tv = typemapper.getTypeList();
		model.addAttribute("typeList", tv);
		if(assosiatedMemberId != null && isAuthenticated != null )
		{

			int inventorId = assosiatedMemberId.getUid();
			int plId = assosiatedMemberId.getLid();
			int userId = ((userVo)isAuthenticated).getUid();
			int lastRid = regDao.getLastRidInProcessList(start_rid);
			System.out.println("lastRid is "+lastRid);
			//현재 나타내는 rid 저장
			session.setAttribute("currentPosition", lastRid);

			List<RegistrationFileVo> imgList= regFileDao.getImgListByStartRid(start_rid);
			List<RegistrationPatentVo> processList = regDao.getAssociatedProcessList(start_rid);
			int start_iscomplete = regDao.getIscompleteByrid(start_rid);
			model.addAttribute("imgs", imgList);
			model.addAttribute("processList",processList);
			model.addAttribute("lastRid",lastRid);
			model.addAttribute("start_iscomplete",start_iscomplete);

			//발명가가 보는 경우
			if(inventorId==userId) 
			{
				//getRegistrationByRidOrPrevRid(prevRid) + getInventorModifyByRid
				RegistrationPatentVo currentAnswer = regDao.getInventorModifyByRid(lastRid);
				RegistrationPatentVo beforeReg = regDao.getRegistrationByRidOrPrevRid(currentAnswer.getPrev_rid());
					
				model.addAttribute("user","inventor");
				model.addAttribute("beforeReg",beforeReg);
				model.addAttribute("currentAnswer", currentAnswer);
				model.addAttribute("start_rid",start_rid);

				if(beforeReg == null)
					model.addAttribute("isFirst","true");
				else
					model.addAttribute("isFirst","false");
				
				return "comment/comment_inventor";
			}
			//변리사가 보는 경우
			if(plId==userId)
			{
				//getRegistrationByRidOrPrevRid(rid) + getPrevPlCommentByPrevRid
				RegistrationPatentVo currentAnswer = regDao.getRegistrationByRidOrPrevRid(lastRid);
				RegistrationPatentVo beforeComment = regDao.getPrevPlCommentByPrevRid(currentAnswer.getPrev_rid());
					
				model.addAttribute("user","pl");
				model.addAttribute("beforeComment", beforeComment);
				model.addAttribute("currentAnswer", currentAnswer);
				
				if(beforeComment == null)
					model.addAttribute("isFirst","true");
				else
					model.addAttribute("isFirst","false");
			
				return "comment/comment_pl";
			}
		}
		return "redirect:/authError";
	}
	
	//Ajax용
	@RequestMapping(value="/detailByRid/{rid}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> detailByRid(@PathVariable int rid)
	{
		//접근한 경로에 대한 권한 확인
		RegistrationPatentVo assosiatedMemberId= regDao.getAssociatedMembersByRid(rid);		
		Object isAuthenticated = session.getAttribute("currentUser");
		
		if(assosiatedMemberId != null && isAuthenticated != null )
		{
			int inventorId = assosiatedMemberId.getUid();
			int plId = assosiatedMemberId.getLid();
			int userId = ((userVo)isAuthenticated).getUid();
			
			session.setAttribute("currentPosition", rid);
			
			Map<String,Object> retVal = new HashMap<String,Object>();
			
			//발명가가 보는 경우
			if(inventorId==userId) 
			{
				//getRegistrationByRidOrPrevRid(prevRid) + getInventorModifyByRid
				
				RegistrationPatentVo currentAnswer = regDao.getInventorModifyByRid(rid);
				RegistrationPatentVo beforeReg = regDao.getRegistrationByRidOrPrevRid(currentAnswer.getPrev_rid());
				
				retVal.put("user", "inventor");
				retVal.put("beforeReg", beforeReg);
				retVal.put("currentAnswer", currentAnswer);

				if(beforeReg == null)
					retVal.put("isFirst","true");
				else
					retVal.put("isFirst","false");
				
				return retVal;
			}
			//변리사가 보는 경우
			if(plId==userId)
			{
				//getRegistrationByRidOrPrevRid(rid) + getPrevPlCommentByPrevRid
				
				RegistrationPatentVo currentAnswer = regDao.getRegistrationByRidOrPrevRid(rid);
				RegistrationPatentVo beforeComment = regDao.getPrevPlCommentByPrevRid(currentAnswer.getPrev_rid());
					
				retVal.put("user", "pl");
				retVal.put("beforeComment", beforeComment);
				retVal.put("currentAnswer", currentAnswer);

				if(beforeComment == null)
					retVal.put("isFirst","true");
				else
					retVal.put("isFirst","false");
				
				return retVal;
			}
		}
		
		return null;
	}
	
	//Ajax용
	@RequestMapping(value="/tmpSave",method=RequestMethod.POST,produces="application/text;charset=utf8")
	@ResponseBody
	public String tmpSave(RegistrationPatentVo regVo, HttpServletRequest req)
	{
		String role = req.getParameter("role");
		
		//현재 페이지의 rid와 수정 요청한 rid가 같은지 확인 
		if((int)session.getAttribute("currentPosition") != regVo.getRid())
			return "잘못된 접근입니다.";
			
		if(role.equals("pl"))
		{
			//완료여부에 따른 체크 
			if(0 == regDao.checkIsCompletedByRid(regVo.getRid()))
				return "이미 완료된 사항입니다.";
			
			regVo.setIscomplete(1);
			
			regDao.plUpdate(regVo);
		}
		else if(role.equals("inventor"))
		{
			//완료여부에 따른 체크 
			if(1 == regDao.checkIsCompletedByRid(regVo.getRid()))
				return "이미 완료된 사항입니다.";

			regVo.setIscomplete(0);
			
			regDao.inventorSave(regVo);
		}
		else
		{
			return "저장 실패";
		}
		return "임시 저장 성공";
	}
	
	@RequestMapping(value="/ideaSave",method=RequestMethod.POST,produces="application/text;charset=utf8")
	@ResponseBody
	public String ideaSave(RegistrationPatentVo regVo, HttpServletRequest req)
	{
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String role = req.getParameter("role");
		//완료여부에 따른 체크 
		//현재 페이지의 rid와 수정 요청한 rid가 같은지 확인 
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		if((int)session.getAttribute("currentPosition") != regVo.getRid())
		{
			return "잘못된 접근입니다.";
		}
			
		if(role.equals("pl"))
		{
			if(0 == regDao.checkIsCompletedByRid(regVo.getRid()))
				return "이미 완료된 사항입니다.";
			
			//답변 달기
			regVo.setIscomplete(0);
			regDao.plUpdate(regVo);
			
			//
			int countOfRow=regDao.countNumOfEdit(regVo.getRid());
			String ment;
			
			if(countOfRow==1){
				ment = "초안수정";
			}
			else{
				ment = "발명가 수정중";
			}
			
			int start_rid=regDao.getStartRidByRid(regVo.getRid());
			
			HashMap<String,String> map= new HashMap<String,String>();
			map.put("ment", ment);
			map.put("rid",Integer.toString(start_rid));
			regDao.updateRegCondition(map);
	
			//새로운 ROW만들기
			RegistrationPatentVo tmpVo = regDao.getResourceForPlSaveByRid(regVo.getRid());
			tmpVo.setIscomplete(0);
			tmpVo.setPrev_rid(regVo.getRid());
			tmpVo.setRid(0); //autoIncrese
			regDao.plSave(tmpVo);
			tmpVo.setTitle(regDao.getRegistrationByRidOrPrevRid(regVo.getRid()).getTitle());
			tmpVo.setRegistration_date(ss.getToday(0));
			mService.editInventor(tmpVo);
			mService.editPL(tmpVo);
		
			System.out.println("hihi");
			
			return "저장 성공";
		}
		else if(role.equals("inventor"))
		{
			if(1 == regDao.checkIsCompletedByRid(regVo.getRid()))
				return "이미 완료된 사항입니다.";
		
			regVo.setIscomplete(1);
			
			regDao.inventorSave(regVo);
			
			System.out.println("lid==============="+regVo.getLid());
			RegistrationPatentVo rvo = regDao.getRegistrationByRidOrPrevRid(regVo.getRid());
			rvo.setRegistration_date(ss.getToday(0));
			mService.reviewLawerInventor(rvo);
			mService.reviewLawerPL(rvo);
			
			//mainPage띄우는 테이블에 update
			mainPageDao.updateMainPagerid(rvo);

			System.out.println("hihi");
			int countOfRow=regDao.countNumOfEdit(regVo.getRid());

			String ment;
			
			if(countOfRow==1){
				ment = "초안수정";
			}
			else{
				ment = "변리사 검토중";
			}
			
			int start_rid=regDao.getStartRidByRid(regVo.getRid());
			
			HashMap<String,String> map= new HashMap<String,String>();
			map.put("ment", ment);
			map.put("rid",Integer.toString(start_rid));
			regDao.updateRegCondition(map);
			
			return "저장 성공";
			
		}
		else
		{
			System.out.println(role+"잉?");
			
			return "저장 실패";
		}
		
	}
	@RequestMapping(value="/deleteFile",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> deleteFile(HttpServletRequest request){
		String rfid=request.getParameter("id");
		System.out.println("rfid="+rfid);
		int id=Integer.parseInt(rfid);
		System.out.println("id="+id);
		RegistrationFileVo rfv = regisFileMapper.getVoById(id);
		File file=new File(request.getSession().getServletContext().getRealPath("/")+rfv.getFile_path());
		file.delete();
		regFileDao.deleteFile(id);
		
		
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("result", "aa");
		return map;
	}
	@RequestMapping(value="/commentFileSave",method=RequestMethod.POST)
	//@ResponseBody
	public String commentFileSave(HttpServletRequest request){
		System.out.println("commentFileSaveComeIn@");
		String userID=request.getParameter("userID_file");
		String start_rid_file=request.getParameter("start_rid_file");
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //다중파일 업로드
		List<MultipartFile> files = multipartRequest.getFiles("imgs");
		RegistrationService rs = new RegistrationService();
		String root_path=request.getSession().getServletContext().getRealPath("/");
		for(int i=0;i<files.size();i++){
			if(!files.get(i).isEmpty()){
				String today=rs.getToday(1)+i;
				String fileType=rs.makeimageFile(files.get(i),today ,userID,Integer.parseInt(start_rid_file),root_path);
				System.out.println(fileType);
				HashMap<String,String> map = new HashMap<String,String>();
				map.put("start_rid", start_rid_file);
				map.put("file_path", "/resources/uploadimgs/inventor/"+userID+"/"+today+"."+fileType);
				regFileDao.makeFile(map);
			}
		}
		HashMap<String,String> map2=new HashMap<String,String>();
		map2.put("aa","aa");
		return "redirect:/mainPage";
	}
	@RequestMapping(value="/tempApply",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> tempApply(HttpServletRequest request) throws InvalidFormatException, IOException{
		
		HashMap<String,String> map= new HashMap<String,String>();
		HashMap<String,String> retVal=new HashMap<String,String>();
		HashMap<String,String> upCon=new HashMap<String,String>();
		String rid=request.getParameter("rid");
		String stRid=Integer.toString(regDao.getStartRidByRid(Integer.parseInt(rid)));
		
		upCon.put("rid", stRid);
		upCon.put("ment","가출원상태");
		
		regDao.updateRegCondition(upCon);
		
		regDao.tempApply(Integer.parseInt(rid));
		
		System.out.println(rid);
		
		RegistrationPatentVo rv = regDao.getLastIdea(Integer.parseInt(stRid));
		
		rv.setStart_rid(Integer.parseInt(stRid));
		
		System.out.println(rv.getTitle()+","+rv.getEffect()+","+rv.getCore_element()+","+rv.getHope_content()+","+rv.getProblem()+",");
		
		DocController dc = new DocController();
		String root_path=request.getSession().getServletContext().getRealPath("/");
		
		List<RegistrationFileVo> rfv = regisFileMapper.getImgListByStartRid(Integer.parseInt(stRid));
		
		String doc_name=dc.savefile(rv,root_path,rfv);
		
		
		map.put("file_name", doc_name);
		map.put("start_rid", stRid);
		
		docDao.saveDocument(map);
		
		//DocController dctl = new DocController();
		
		retVal.put("file_name", doc_name);
		
		//dctl.downLoadFile(request,doc_name);
		return retVal;
	}
	
	@RequestMapping(value="/lastConfirm",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> lastConfirm(HttpServletRequest request){
		HashMap<String,String> retVal = new HashMap<String,String>();
		HashMap<String,String> upCon=new HashMap<String,String>();

		String rid=request.getParameter("rid");
		System.out.println("lastConfirm rid is "+rid);
		String stRid=Integer.toString(regDao.getStartRidByRid(Integer.parseInt(rid)));
		
		upCon.put("rid", stRid);
		upCon.put("ment","최종확인중");
		
		RegistrationPatentVo rvo = regDao.getRegistrationByRidOrPrevRid(Integer.parseInt(rid));
		rvo.setRegistration_date(ss.getToday(0));
		mService.editCompleteInventor(rvo);
		mService.editCompletePL(rvo);
		
		regDao.updateRegCondition(upCon);
		
		regDao.lastConfirm(Integer.parseInt(rid));
		
		retVal.put("retVal", "저장 성공");
		return retVal;
	}
	@RequestMapping(value="/gotoApply",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> gotoApply(HttpServletRequest request){
		HashMap<String,String> retVal = new HashMap<String,String>();
		HashMap<String,String> upCon=new HashMap<String,String>();
		
		String rid=request.getParameter("rid");
		String stRid=Integer.toString(regDao.getStartRidByRid(Integer.parseInt(rid)));
		
		session.setAttribute("start_rid", stRid);
		
		RegistrationPatentVo rvo = regDao.getRegistrationByRidOrPrevRid(Integer.parseInt(rid));
		rvo.setRegistration_date(ss.getToday(0));
		mService.uploadDocumentInventor(rvo);
		mService.assignPL(rvo);
		
		upCon.put("rid", stRid);
		upCon.put("ment","서류업로드중");
		
		regDao.updateRegCondition(upCon);
		
		//regDao.gotoApply(Integer.parseInt(rid));
		
		retVal.put("retVal", "저장 성공");
		retVal.put("start_rid", Integer.toString(regDao.getStartRidByRid(Integer.parseInt(rid))));
		return retVal;
	}
	
}
