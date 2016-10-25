package com.ipc.controller;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/upload")
public class DocumentUpLoadController {
	@RequestMapping("/inputFile")
	public String inputFile(HttpRequest request){
		return "/";
	}
	@RequestMapping("/uploadFile")
	public String uploadFile(){
		return "/apply/uploaddocument";
	}
}
