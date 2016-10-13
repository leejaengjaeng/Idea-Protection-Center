package com.ipc.controller;

import org.apache.poi.xwpf.usermodel.Borders;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ipc.dao.RegistrationFileDao;
import com.ipc.service.RegistrationService;
import com.ipc.service.SignUpService;
import com.ipc.vo.RegistrationPatentVo;

import java.io.*;
@Controller
public class DocController {
	@Autowired
	RegistrationFileDao regisFileMapper;
	
	public String savefile(RegistrationPatentVo rv,String root_path){
		RegistrationService ss = new RegistrationService();
		XWPFDocument document = new XWPFDocument();
		XWPFParagraph paragraph=document.createParagraph();
		XWPFRun run = paragraph.createRun();
		String path=root_path+"/resources/uploadimgs/document/";
		
		run.setText("【발명의 명칭】");
		run.addBreak();
		run.setText(rv.getTitle());
		run.addBreak();
		run.setText("【도면의 간단한 설명】");
		run.addBreak();
		run.setText("-");
		run.addBreak();
		run.setText("【발명의 상세한 설명】");
		run.addBreak();
		run.setText("	【발명의 목적】");
		run.addBreak();
		run.setText("		【발명이 속하는 기술분야 및 그 분야의 종래기술】");
		run.addBreak();
		//run.setText(rv.getProblem());
		if(rv.getProblem().contains("\n")){
			String[] stringline = rv.getProblem().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		run.addBreak();
		run.setText("	【발명이 이루고자 하는 기술적 과제】");
		run.addBreak();
		run.setText(rv.getSolution());
		run.addBreak();
		run.setText("	【발명의 구성 및 작용】");
		run.addBreak();
		run.setText(rv.getWhyInvent());
		run.addBreak();
		run.setText("【발명의 효과】");
		run.addBreak();
		//run.setText(rv.getEffect().replaceAll("\n", "^p"));
		if(rv.getEffect().contains("\n")){
			String[] stringline = rv.getEffect().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		//정렬
		paragraph.setAlignment(ParagraphAlignment.LEFT);
		//들여쓰기..?
		//paragraph.setIndentationHanging(1000);
		
		//paragraph.setBorderBottom(Borders.BASIC_THIN_LINES);
		try{
			FileOutputStream output = new FileOutputStream(path+rv.getTitle()+ss.getToday(0)+".docx");
			document.write(output);
			output.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return "home/index";
	}
}
