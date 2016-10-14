package com.ipc.controller;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.util.Units;
import org.apache.poi.xwpf.usermodel.Borders;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ipc.dao.RegistrationFileDao;
import com.ipc.service.RegistrationService;
import com.ipc.service.SignUpService;
import com.ipc.vo.RegistrationPatentVo;

import java.io.*;

import javax.servlet.http.HttpServletRequest;
@Controller
public class DocController {
	@Autowired
	RegistrationFileDao regisFileMapper;
	
	public String savefile(RegistrationPatentVo rv,String root_path) throws InvalidFormatException, IOException{
		RegistrationService ss = new RegistrationService();
		XWPFDocument document = new XWPFDocument();
		XWPFParagraph paragraph=document.createParagraph();
		XWPFRun run = paragraph.createRun();
		String path=root_path+"/resources/uploadimgs/document/";
		String img_path=root_path+"/resources/uploadimgs/inventor";
		run.setText("【발명의 분야】");
		run.addBreak();
		run.setText(rv.getTypeOfInvent());
		run.addBreak();
		run.setText("【발명의 제목】");
		run.addBreak();
		run.setText(rv.getTitle());
		run.addBreak();
		run.setText("【요약】");
		run.addBreak();
		if(rv.getSummary().contains("\n")){
			String[] stringline = rv.getSummary().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		else{
			run.setText(rv.getSummary());
		}
		run.addBreak();
		run.setText("【발명의 목적】");
		run.addBreak();
		run.setText("【필요이유】");
		run.addBreak();
		if(rv.getWhyInvent().contains("\n")){
			String[] stringline = rv.getWhyInvent().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		else{
			run.setText(rv.getWhyInvent());
		}
		run.addBreak();
		run.setText("【기존제품 설명 및 문제점】");
		run.addBreak();
		if(rv.getProblem().contains("\n")){
			String[] stringline = rv.getProblem().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		else{
			run.setText(rv.getProblem());
		}
		run.addBreak();
		run.setText("【문제해결방법】");
		run.addBreak();
		if(rv.getSolution().contains("\n")){
			String[] stringline = rv.getProblem().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		else{
			run.setText(rv.getSolution());
		}
		run.addBreak();
		run.setText("【권리를 보장받고자 하는 내용】");
		run.addBreak();
		if(rv.getHope_content().contains("\n")){
			String[] stringline = rv.getProblem().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		else{
			run.setText(rv.getHope_content());
		}
		run.addBreak();
		run.setText("【도면에 대한 설명】");
		run.addBreak();
		if(rv.getPicture_explain().contains("\n")){
			String[] stringline = rv.getProblem().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		else{
			run.setText(rv.getPicture_explain());
		}
		run.addBreak();
		String imgFile=(img_path+"/asdf/201610041118400.jpg");
		FileInputStream is = new FileInputStream(imgFile);
	    run.addBreak();
	    run.addPicture(is, XWPFDocument.PICTURE_TYPE_JPEG, imgFile, Units.toEMU(200), Units.toEMU(200)); // 200x200 pixels
	    
			//정렬
		paragraph.setAlignment(ParagraphAlignment.LEFT);
		//들여쓰기..?
		//paragraph.setIndentationHanging(1000);
		
		//paragraph.setBorderBottom(Borders.BASIC_THIN_LINES);
		String name=rv.getTitle()+ss.getToday(1)+".docx";
		String full_path=path+name;
		try{
			
			FileOutputStream output = new FileOutputStream(full_path);
			document.write(output);
			output.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return name;
	}
	@RequestMapping(value="/getFile",method=RequestMethod.GET)
	public ModelAndView downLoadFile(HttpServletRequest request) {
        String root_path=request.getSession().getServletContext().getRealPath("/");
        String doc_name=request.getParameter("file_name");
        String fullPath = root_path+"resources\\uploadimgs\\document\\"+doc_name;
        File downloadFile = new File(fullPath);
        System.out.println(fullPath);
        System.out.println(downloadFile.exists());
        System.out.println(downloadFile.getName());
        ModelAndView mav = new ModelAndView();
        mav.addObject("downloadFile", downloadFile);
        mav.addObject("downloadFileName", doc_name);
        mav.setViewName("downloadFileView");
        return mav;
    }
//	public ModelAndView downLoadFile(HttpServletRequest request,String doc_name) {
//        String root_path=request.getSession().getServletContext().getRealPath("/");
//        String fullPath = root_path+"resources\\uploadimgs\\document\\"+doc_name;
//        File downloadFile = new File(fullPath);
//        System.out.println(fullPath);
//        System.out.println(downloadFile.exists());
//        System.out.println(downloadFile.getName());
//        ModelAndView mav = new ModelAndView();
//        mav.addObject("downloadFile", downloadFile);
//        mav.addObject("downloadFileName", doc_name+".docx");
//        mav.setViewName("downloadFileView");
//        return mav;
//    }
}
