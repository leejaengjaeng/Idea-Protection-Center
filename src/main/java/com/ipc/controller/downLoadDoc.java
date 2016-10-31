package com.ipc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ipc.dao.DocumentDao;
import com.ipc.vo.ApplyDocVo;

@Controller
public class downLoadDoc {
	@Autowired
	HttpSession session;
	@Autowired
	DocumentDao docmapper;
	
	@RequestMapping("/downLoadPage")
	public String downLoadPage(Model model){
		int rid=(int) session.getAttribute("rid");
		if(docmapper.isPersonal(rid)==1){
			model.addAttribute("first", "주민등록등본");
			model.addAttribute("smallexist", "1");
		}
		else{
			model.addAttribute("first", "법인등기부등본");
			model.addAttribute("smallexist", "0");
		}
		
		return "apply/downLoadDoc";
	}
	
	@RequestMapping(value="/downDoc",method=RequestMethod.POST)
	@ResponseBody
	public String downDoc(HttpServletRequest request){
		String data=request.getParameter("kind");
		int rid=(int) session.getAttribute("rid");
		//String root_path=request.getSession().getServletContext().getRealPath("/")+"resources/uploadimgs/uploadDocument/";
		//String full_path;
		ApplyDocVo adv=docmapper.getVoByrid(rid);
		
		if(data.equals("resident")){
			//full_path=root_path+adv.getResident_registration();
			return adv.getResident_registration();
		}
		else if(data.equals("business")){
			//full_path=root_path+adv.getBusiness_license();
			return adv.getBusiness_license();
		}
		else if(data.equals("certificate")){
			//full_path=root_path+adv.getCertificate();
			return adv.getCertificate();
		}
		else if(data.equals("small")){
			//full_path=root_path+adv.getSmallsale();
			return adv.getSmallsale();
		}
		return "false";
	}
	@RequestMapping(value="/executeDownLoad/{file_name}",method=RequestMethod.GET)
	public ModelAndView executeDownLoad(HttpServletRequest request,@PathVariable String file_name){
		String root_path=request.getSession().getServletContext().getRealPath("/")+"resources/uploadimgs/uploadDocument/";
		String full_path=root_path+file_name;
		ModelAndView mav = new ModelAndView();
        mav.addObject("downloadFile", full_path);
        mav.addObject("downloadFileName", file_name);
        mav.setViewName("downloadFileView");
        return mav;
	}
}
