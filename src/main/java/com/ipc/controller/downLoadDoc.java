package com.ipc.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ipc.dao.DesignDao;
import com.ipc.dao.DocumentDao;
import com.ipc.dao.MarkDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.RegistrationFileDao;
import com.ipc.dao.UpLoadDocDao;
import com.ipc.util.CreateFileUtils;
import com.ipc.util.PathUtils;
import com.ipc.vo.ApplyDocVo;
import com.ipc.vo.DesignVo;
import com.ipc.vo.MarkVo;
import com.ipc.vo.RegistrationFileVo;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.UpLoadDocVo;
import com.ipc.vo.UpLoadDocVoOther;

@Controller
public class downLoadDoc {
	@Autowired
	HttpSession session;
	@Autowired
	DocumentDao docmapper;
	@Autowired
	UpLoadDocDao uploaddocmapper;
	@Autowired
	RegistrationDao regismapper;
	@Autowired
	RegistrationFileDao regisfilemapper;
	@Autowired
	DocController docController;
	@Autowired
	DocumentDao docDao;
	@Autowired
	DesignDao designDao;
	@Autowired
	MarkDao markmapper;
	
	@RequestMapping("/downLoadDoc/{apply_kind}")
	public String downLoadDocOther(Model model,HttpServletRequest request,@PathVariable String apply_kind){
		int seq=0;
		if(apply_kind.equals("Design")){
			seq=(int)session.getAttribute("DesignId");
		}
		else if(apply_kind.equals("Mark")){
			seq=(int)session.getAttribute("MarkId");
		}
		System.out.println("apply_kind,seq : "+apply_kind+","+seq);
		HashMap<String,String> map = new HashMap<String,String>();
		
		map.put("seq",Integer.toString(seq));
		map.put("patent_kind", apply_kind);
		
		int isExist=docmapper.countFinalDoc(map);
		
		model.addAttribute("isExist", isExist);
		
		UpLoadDocVoOther uldoVo= docDao.getUpLoadDocVoOtherByHashMap(map);
		System.out.println(uldoVo.getBusiness_license());
		model.addAttribute("docVo", uldoVo);
		return "apply/downloaddocument";
	}
	@RequestMapping("/execute/{file_name}")
	public ModelAndView execute(HttpServletRequest request,@PathVariable String file_name){
		System.out.println(file_name);
		file_name=file_name.replace("ideaconcert", ".");
		System.out.println("file_name : "+file_name);
		ModelAndView mav = new ModelAndView();
		String root_path = PathUtils.getRootPath(request);
		File file=new File(root_path+"/resources/uploadimgs/uploadDocument/"+file_name);
		mav.addObject("downloadFile", file);
        mav.addObject("downloadFileName", file_name);
        mav.setViewName("downloadFileView");
		
		
		return mav;
	}
	@RequestMapping("/makeDoc")
	public ModelAndView makeDoc(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		String apply_kind = (String)session.getAttribute("currentApply");
		String file_name="";
		String full_path="";
		HashMap<String,String> map = new HashMap<String,String>();
		if(apply_kind.equals("Design")){
			map.put("patent_kind", "Design");
			map.put("seq", Integer.toString((int)session.getAttribute("DesignId")));
			
			DesignVo dv = designDao.getDesignByDeid((int)session.getAttribute("DesignId"));
			file_name=docController.saveDesignFile(dv, PathUtils.getRootPath(request));
			full_path=PathUtils.getRootPath(request)+"/resources/uploadimgs/document/"+file_name;
			
		}
		else if(apply_kind.equals("Mark")){
			map.put("patent_kind", "Mark");
			map.put("seq", Integer.toString((int)session.getAttribute("MarkId")));
			MarkVo mv = markmapper.getMarkByMid((int)session.getAttribute("MarkId"));
			file_name=docController.saveMarkFile(mv, PathUtils.getRootPath(request));
			full_path=PathUtils.getRootPath(request)+"/resources/mark/"+file_name;
		}
		File file = new File(full_path);
		mav.addObject("downloadFile", file);
        mav.addObject("downloadFileName", file_name);
        mav.setViewName("downloadFileView");
		return mav;
	}
	@RequestMapping("/downLoadPage")
	public String downLoadPage(Model model){
		int rid=(int) session.getAttribute("currentPosition");
//		if(docmapper.isPersonal(rid)==1){
//			model.addAttribute("first", "주민등록등본");
//		}
//		else{
//			model.addAttribute("first", "법인등기부등본");
//		}
		ApplyDocVo adv = docmapper.getVoByrid(rid);
		model.addAttribute("docVo",adv);
		model.addAttribute("iscomplete",regismapper.getIscompleteByrid(rid));
		System.out.println(adv.getBusiness_license());
		System.out.println(adv.getCertificate());
		System.out.println(adv.getFinalApplyDoc());
		return "apply/downLoadDoc";
	}
	
	@RequestMapping(value="/downDoc",method=RequestMethod.POST)
	@ResponseBody
	public String downDoc(HttpServletRequest request){
		String data=request.getParameter("kind");
		int rid=(int) session.getAttribute("currentPosition");
		//String root_path=request.getSession().getServletContext().getRealPath("/")+"resources/uploadimgs/uploadDocument/";
		//String full_path;
		ApplyDocVo adv=docmapper.getVoByrid(rid);
		
		if(data.equals("resident")){
			//full_path=root_path+adv.getResident_registration();
			System.out.println("resident");
			System.out.println(adv.getResident_registration());
			return "resident";
		}
		else if(data.equals("business")){
			//full_path=root_path+adv.getBusiness_license();
			System.out.println("business");
			return "business";
		}
		else if(data.equals("certificate")){
			//full_path=root_path+adv.getCertificate();
			System.out.println("certificate");
			return "certificate";
		}
		else if(data.equals("small")){
			//full_path=root_path+adv.getSmallsale();
			System.out.println("small");
			return "small";
		}
		else if(data.equals("apply")){
			return "apply";
		}
		System.out.println("else");
		return "false";
	}
	
	@RequestMapping(value="/executeDownLoad/{file_kind}",method=RequestMethod.GET)
	public ModelAndView executeDownLoad(HttpServletRequest request,@PathVariable String file_kind) throws InvalidFormatException, IOException{
		int rid=(int) session.getAttribute("currentPosition");
		String applyDocRootPath= PathUtils.getRootPath(request);
		System.out.println("applyDocRootPath : "+applyDocRootPath+"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

		String file_name="";
		ApplyDocVo adv=docmapper.getVoByrid(rid);
		if(file_kind.equals("resident")){
			file_name=adv.getResident_registration();
		}
		else if(file_kind.equals("business")){
			file_name=adv.getBusiness_license();
		}
		else if(file_kind.equals("certificate")){
			file_name=adv.getCertificate();
		}
		else if(file_kind.equals("small")){
			file_name=adv.getSmallsale();
		}
		else if(file_kind.equals("apply")){
			RegistrationPatentVo rv=regismapper.getRegistrationByRidOrPrevRid(rid);
			List<RegistrationFileVo> imgList=regisfilemapper.getImgListByStartRid(regismapper.getStartRidByRid(rid));
			System.out.println("root path123 : "+applyDocRootPath);
			file_name=docController.savefile(rv, applyDocRootPath, imgList);
			
			HashMap<String,String> map= new HashMap<String,String>();
			
			map.put("file_name", file_name);
			map.put("start_rid", Integer.toString(regismapper.getStartRidByRid(rid)));
			
			docDao.saveDocument(map);
			
			String full_path=applyDocRootPath+"/resources/uploadimgs/document/"+file_name;
			File downloadFile = new File(full_path);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("downloadFile", downloadFile);
		    mav.addObject("downloadFileName", file_name);
		        
		    mav.setViewName("downloadFileView");
		    return mav;
		}
		String root_path=applyDocRootPath+"/resources/uploadimgs/uploadDocument/";
		String full_path=root_path+file_name;
		File downloadFile = new File(full_path);
		System.out.println(full_path);
		ModelAndView mav = new ModelAndView();
        mav.addObject("downloadFile", downloadFile);
        mav.addObject("downloadFileName", file_name);
        
        mav.setViewName("downloadFileView");
        return mav;
	}
	
	@RequestMapping("/downApplyDoc")
	public String downApplyDoc(Model model,HttpServletRequest request){
		//session.setAttribute("currentPosition", lastRid);
		int rid=(int)session.getAttribute("currentPosition");
		
		ApplyDocVo adv = docmapper.getVoByrid(rid);
		if(adv.getFinalApplyDoc().equals("")||adv.getFinalApplyDoc().equals(null)){
			return "redirect:/authError";
		}
		
		model.addAttribute("vo", regismapper.getRegistrationByRidOrPrevRid(rid));
		return "apply/getApplyDoc";
	}
	
	@RequestMapping("/getDoc/{start_rid}")
	public ModelAndView getDoc(HttpServletRequest request,@PathVariable int start_rid){
		int rid=regismapper.getLastRidInProcessList(start_rid);
		String root_path=PathUtils.getRootPath(request)+"/resources/uploadimgs/apply_doc/";
		ApplyDocVo adv = docDao.getVoByrid(rid);
		String applyDocName=adv.getFinalApplyDoc();
		File applyDoc=new File(root_path+applyDocName);
        ModelAndView mav = new ModelAndView();

		mav.addObject("downloadFile", applyDoc);
        mav.addObject("downloadFileName", applyDocName);
        mav.setViewName("downloadFileView");
		return mav;
	}
	@RequestMapping("/downContents/attorney")
	public ModelAndView downContents(HttpServletRequest request) throws InvalidFormatException, IOException{
		String root_path=PathUtils.getRootPath(request)+"/resources/downContents/";
		String doc_name="attorney.docx";
		System.out.println(root_path);
		File downFile= new File(root_path+doc_name);
		ModelAndView mav = new ModelAndView();

		mav.addObject("downloadFile", downFile);
        mav.addObject("downloadFileName", doc_name);
        mav.setViewName("downloadFileView");
		return mav;

	}
	@RequestMapping(value="/downContents/envelope")
	public ModelAndView downContents2(HttpServletRequest request) throws InvalidFormatException, IOException{
		String root_path=PathUtils.getRootPath(request)+"/resources/downContents/";
		String doc_name="envelope.docx";
		System.out.println(root_path);
		File downFile= new File(root_path+doc_name);
		ModelAndView mav = new ModelAndView();

		mav.addObject("downloadFile", downFile);
        mav.addObject("downloadFileName", doc_name);
        mav.setViewName("downloadFileView");
		return mav;

	}
	@RequestMapping("/downPaperDesign/{died}")
	public ModelAndView downPaper(HttpServletRequest request,@PathVariable int died){
		ModelAndView mav=new ModelAndView();
		String finalApplyDoc = docDao.getFinalDocDesign(died);
		String root_path=PathUtils.getRootPath(request)+"/resources/uploadimgs/apply_doc/";
		File downFile=new File(root_path+finalApplyDoc);
		
		mav.addObject("downloadFile", downFile);
        mav.addObject("downloadFileName", finalApplyDoc);
        mav.setViewName("downloadFileView");
		return mav;
	}
	@RequestMapping("/downPaperMark/{mid}")
	public ModelAndView downPaperMark(HttpServletRequest request,@PathVariable int mid){
		ModelAndView mav=new ModelAndView();
		String finalApplyDoc = docDao.getFinalDocMark(mid);
		String root_path=PathUtils.getRootPath(request)+"/resources/uploadimgs/apply_doc/";
		File downFile=new File(root_path+finalApplyDoc);
		
		mav.addObject("downloadFile", downFile);
        mav.addObject("downloadFileName", finalApplyDoc);
        mav.setViewName("downloadFileView");
		return mav;
	}
}
