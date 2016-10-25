package com.ipc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/upload")
public class DocumentUpLoadController {
	@RequestMapping(value="/inputFile",method=RequestMethod.POST)
	public String inputFile(HttpServletRequest request){
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> resident_registration = multipartRequest.getFiles("resident_registration");
		List<MultipartFile> certificate = multipartRequest.getFiles("certificate");
		List<MultipartFile> business_license = multipartRequest.getFiles("business_license");
		List<MultipartFile> smallsale;
		
		if(request.getParameter("ispersonal").equals("0"))
			 smallsale= multipartRequest.getFiles("smallsale");
		
		
		return "/";
	}
	@RequestMapping("/uploadFile")
	public String uploadFile(){
		return "/apply/uploaddocument";
	}
}
