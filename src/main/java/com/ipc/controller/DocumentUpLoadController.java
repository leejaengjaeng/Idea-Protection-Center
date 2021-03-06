package com.ipc.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.imageio.spi.RegisterableService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ipc.dao.DesignDao;
import com.ipc.dao.DocumentDao;
import com.ipc.dao.MainPageDao;
import com.ipc.dao.MarkDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.service.MessageService;
import com.ipc.service.RegistrationService;
import com.ipc.service.UploadDocumentService;
import com.ipc.util.CreateFileUtils;
import com.ipc.util.PathUtils;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.UpLoadDocVo;
import com.ipc.vo.UpLoadDocVoOther;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/upload")
public class DocumentUpLoadController {
	@Autowired
	RegistrationDao regDao;
	@Autowired
	HttpSession session;
	@Autowired
	UploadDocumentService uploadService;
	@Autowired
	DocumentDao docmapper;
	@Autowired
	MainPageDao mainpagemapper;
	@Autowired
	MessageService mService;
	@Autowired
	RegistrationService rService;
	@Autowired
	DesignDao designmapper;
	@Autowired
	MarkDao markmapper;
	
	@RequestMapping(value="/inputFile",method=RequestMethod.POST)
	public String inputFile(HttpServletRequest request) throws IOException{
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> resident_registration = multipartRequest.getFiles("resident_registration");
		List<MultipartFile> certificate = multipartRequest.getFiles("certificate");
		List<MultipartFile> business_license = multipartRequest.getFiles("business_license");
		List<MultipartFile> smallsale;
		HashMap<String,List<MultipartFile>> map = new HashMap<String,List<MultipartFile>>();
		map.put("resident_registration", resident_registration);
		map.put("certificate",certificate);
		map.put("business_license",business_license);
		if(request.getParameter("is_personal").equals("0")){
			 smallsale= multipartRequest.getFiles("smallsale");
			 map.put("smallsale", smallsale);
		}
		
		UpLoadDocVo upv = new UpLoadDocVo();
		System.out.println("patentsName : "+request.getParameter("patentsName"));
		if(request.getParameter("patentsName").equals("1")){
			upv.setPatentscode(request.getParameter("patentsClientCode"));
		}
		upv.setIs_personal(request.getParameter("is_personal"));
		upv.setRid(Integer.parseInt(request.getParameter("rid")));
		String root_path=PathUtils.getRootPath(request);
		
		uploadService.saveFile(map, root_path,upv,request);
		return "redirect:/";
	}
	@RequestMapping(value="/uploadFile")
	public String uploadFile(Model model){
		String start_rid=(String) session.getAttribute("start_rid");
		
		model.addAttribute("isExist", docmapper.countDocumentForApplyByRid(regDao.getLastRidInProcessList(Integer.parseInt(start_rid))));
		if(docmapper.countDocumentForApplyByRid(regDao.getLastRidInProcessList(Integer.parseInt(start_rid)))==0){
			RegistrationPatentVo rvo = regDao.getRegistrationByRidOrPrevRid((int) session.getAttribute("currentPosition"));
			rvo.setRegistration_date(rService.getToday(0));
			mService.uploadDocumentInventor(rvo);
			mService.assignPL(rvo);
		}
		if(start_rid==null){
			return "redirect:/authError";
		}
		model.addAttribute("regis", regDao.getRegistrationByRidOrPrevRid(regDao.getLastRidInProcessList(Integer.parseInt(start_rid))));
		return "apply/uploaddocument";
	}
	private FileOutputStream fos;

	@RequestMapping(value="/inputFileOther")
	public String inputFileOther(HttpServletRequest request) throws IOException{
		String applyKind=(String)session.getAttribute("currentApply");
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> resident_registration = multipartRequest.getFiles("resident_registration");
		List<MultipartFile> certificate = multipartRequest.getFiles("certificate");
		List<MultipartFile> business_license = multipartRequest.getFiles("business_license");
		List<MultipartFile> smallsale;
		HashMap<String,List<MultipartFile>> map = new HashMap<String,List<MultipartFile>>();
		map.put("resident_registration", resident_registration);
		map.put("certificate",certificate);
		map.put("business_license",business_license);
		if(request.getParameter("is_personal").equals("0")){
			 smallsale= multipartRequest.getFiles("smallsale");
			 map.put("smallsale", smallsale);
		}
		
		UpLoadDocVoOther upv = new UpLoadDocVoOther();
		System.out.println("patentsName : "+request.getParameter("patentsName"));
		if(request.getParameter("patentsName").equals("1")){
			upv.setPatentscode(request.getParameter("patentsClientCode"));
		}
		upv.setIs_personal(request.getParameter("is_personal"));
		if(applyKind.equals("DesignId")){
			upv.setSeq((int)session.getAttribute("DesignId"));
		}
		else if(applyKind.equals("Mark")){
			upv.setSeq((int)session.getAttribute("MarkId"));
		}
		
		upv.setPatent_kind(applyKind);
		String root_path=PathUtils.getRootPath(request);
		
		uploadService.saveFileOther(map, root_path,upv,request);
		
		
		
		return "redirect:/mainPage";
	}
	@RequestMapping(value="/uploadfinalApplyDoc",method=RequestMethod.POST)
	public String uploadfinalApplyDoc(HttpServletRequest request) throws IOException{
		int year=Integer.parseInt(request.getParameter("year"));
		int month=Integer.parseInt(request.getParameter("month"));
		int day=Integer.parseInt(request.getParameter("day"));
		int rid=(int) session.getAttribute("currentPosition");
		HashMap<String,String> map = new HashMap<String,String>();
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> apply_doc = multipartRequest.getFiles("finalApplyDoc");
		//String dirpath=request.getSession().getServletContext().getRealPath("resources/uploadimgs/apply_doc/");
		String dirpath=PathUtils.getRootPath(request)+"/resources/uploadimgs/apply_doc/";
		
		String doc_name="applydoc"+rService.getToday(1)+"."+CreateFileUtils.getFileType(apply_doc.get(0).getOriginalFilename());
		String full_path=dirpath+doc_name;
		byte fileData[] = apply_doc.get(0).getBytes();
		
		fos = new FileOutputStream(full_path);
		
		fos.write(fileData);
		
		map.put("rid", Integer.toString(rid));
		map.put("finalApplyDoc", doc_name);
		regDao.gotoApply(rid);
		docmapper.updateDocumentForApply(map);
		
		regDao.upLoadApplyDoc(rid);
		
		Calendar applyDate = Calendar.getInstance();
		applyDate.set(Calendar.YEAR,year);
		applyDate.set(Calendar.MONTH,month-1);
		applyDate.set(Calendar.DATE,day);
		
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		
		String pre_apply_date = format1.format(applyDate.getTime());
		applyDate.add(Calendar.DATE, 300);
		String apply_date = format1.format(applyDate.getTime());
		
		HashMap<String,String> apply_date_map = new HashMap<String,String>();
		apply_date_map.put("pre_apply_date", pre_apply_date);
		apply_date_map.put("apply_date",apply_date);
		apply_date_map.put("rid", Integer.toString(rid));
		
		regDao.updateApplyDate(apply_date_map);
		mainpagemapper.updateMainPageApplyDate(apply_date_map);
		
		HashMap<String,String> upCon=new HashMap<String,String>();
		upCon.put("rid", Integer.toString(regDao.getStartRidByRid(rid)));
		upCon.put("ment","출원완료");
		
		regDao.updateRegCondition(upCon);
		
		RegistrationPatentVo rvo = regDao.getRegistrationByRidOrPrevRid(rid);
		rvo.setRegistration_date(rService.getToday(0));
		mService.completeApplyInventor(rvo);
		mService.completeApplyPL(rvo);
		return "redirect:/";
	}
	@RequestMapping(value="/uploadfinalApplyDocOther",method=RequestMethod.POST)
	public String uploadfinalApplyDocOther(HttpServletRequest request) throws IOException{
		int year=Integer.parseInt(request.getParameter("year"));
		int month=Integer.parseInt(request.getParameter("month"));
		int day=Integer.parseInt(request.getParameter("day"));
		
		String apply_kind=(String) session.getAttribute("currentApply");
		int seq = 0;
		if(apply_kind.equals("Design")){
			seq=(int) session.getAttribute("DesignId");
		}
		else if(apply_kind.equals("Mark")){
			seq=(int) session.getAttribute("MarkId");
		}
		HashMap<String,String> map = new HashMap<String,String>();
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> apply_doc = multipartRequest.getFiles("finalApplyDoc");
		//String dirpath=request.getSession().getServletContext().getRealPath("resources/uploadimgs/apply_doc/");
		String dirpath=PathUtils.getRootPath(request)+"/resources/uploadimgs/apply_doc/";
		
		String doc_name="applydoc"+rService.getToday(1)+"."+CreateFileUtils.getFileType(apply_doc.get(0).getOriginalFilename());
		String full_path=dirpath+doc_name;
		byte fileData[] = apply_doc.get(0).getBytes();
		
		fos = new FileOutputStream(full_path);
		
		fos.write(fileData);
		map.put("patent_kind", apply_kind);
		map.put("seq", Integer.toString(seq));
		map.put("finalApplyDoc", doc_name);
		
		HashMap<String,String> map2 = new HashMap<String,String>();
		if(apply_kind.equals("Design")){
			map2.put("iscomplete", "5");
			map2.put("deid", Integer.toString(seq));
			
			designmapper.changeIsCompleteByHashMap(map2);
		}
		else if(apply_kind.equals("Mark")){
			map2.put("iscomplete", "5");
			map2.put("mid", Integer.toString(seq));
			
			markmapper.updateIscomplete(map2);
		}
		//docmapper.updateDocumentForApply(map);
		docmapper.updateDocumentForApplyOther(map);
				
		Calendar applyDate = Calendar.getInstance();
		applyDate.set(Calendar.YEAR,year);
		applyDate.set(Calendar.MONTH,month-1);
		applyDate.set(Calendar.DATE,day);
		
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		
		String pre_apply_date = format1.format(applyDate.getTime());
		applyDate.add(Calendar.DATE, 300);
		String apply_date = format1.format(applyDate.getTime());
		
		HashMap<String,String> apply_date_map = new HashMap<String,String>();
		apply_date_map.put("pre_apply_date", pre_apply_date);
		apply_date_map.put("apply_date",apply_date);
		apply_date_map.put("seq", Integer.toString(seq));
		if(apply_kind.equals("Design")){
			designmapper.updateApplyDate(apply_date_map);
		}
		else if(apply_kind.equals("Mark")){
			markmapper.updateApplyDate(apply_date_map);
		}
		
		return "redirect:/";
	}
	
}
