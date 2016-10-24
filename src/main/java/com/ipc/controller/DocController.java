package com.ipc.controller;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.util.Units;
import org.apache.poi.xwpf.usermodel.Borders;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ipc.dao.RegistrationDao;
import com.ipc.dao.RegistrationFileDao;
import com.ipc.service.RegistrationService;
import com.ipc.service.SignUpService;
import com.ipc.vo.RegistrationFileVo;
import com.ipc.vo.RegistrationPatentVo;

import java.awt.image.BufferedImage;
import java.io.*;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
@Controller
public class DocController {
	@Autowired
	RegistrationFileDao regisFileMapper;
	@Autowired
	RegistrationDao regisMapper;
	
	public String savefile(RegistrationPatentVo rv,String root_path,List<RegistrationFileVo> rfv) throws InvalidFormatException, IOException{
		RegistrationService ss = new RegistrationService();
		XWPFDocument document = new XWPFDocument();
		XWPFParagraph paragraph=document.createParagraph();
		XWPFRun run = paragraph.createRun();
		String path=root_path+"/resources/uploadimgs/document/";
		//String img_path=root_path+"/resources/uploadimgs/inventor";
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
		
		System.out.println("start_rid:"+rv.getStart_rid());
		
		//int start_rid=regisMapper.getStartRidByRid(rv.getRid());
		
		
		System.out.println(rfv.get(0).getFile_path());
		FileInputStream is = null;
		for(int i=0;i<rfv.size();i++){
			String imgFile=(root_path+rfv.get(i).getFile_path());
			//String imgFile="C:\\Users\\HP\\Desktop\\idea-Protection\\Idea-Protection-Center\\src\\main\\webapp\\resources\\uploadimgs\\inventor\\asdf\\201610141721170.jpg";
			System.out.println("imgFilePath:"+imgFile);
			File file=new File(imgFile);
			
			BufferedImage bi=ImageIO.read(file);
			float width=bi.getWidth();
			float height=bi.getHeight();
			
			float rate = height/width;
			int realWidth=200;
			int realHeight=(int) (realWidth*rate);
			System.out.println("realHeight : "+realHeight);
			System.out.println("width : "+bi.getWidth()+", height : "+bi.getHeight());
			is = new FileInputStream(imgFile);
		    run.addBreak();
		    System.out.println("fileName : "+file.getName());
		    int pathPoint = file.getName().trim().lastIndexOf(".");
		    String filePoint = file.getName().trim().substring(pathPoint + 1,
		    		file.getName().trim().length());
			String fileType = filePoint.toLowerCase();
			int picture_type=0;
			System.out.println("fileType:"+fileType);
			if(fileType.equals("jpg")){
				System.out.println("jpg!!");
				picture_type=XWPFDocument.PICTURE_TYPE_JPEG;
			}
			else if(fileType.equals("png")){
				picture_type=XWPFDocument.PICTURE_TYPE_PNG;
			}
			else if(fileType.equals("png")){
				picture_type=XWPFDocument.PICTURE_TYPE_BMP;
			}
			run.addPicture(is, picture_type, imgFile,Units.toEMU(realWidth),Units.toEMU(realHeight)); // 200x200 pixels
			
		}
		is.close();
//		String imgFile="C:\\Users\\HP\\Desktop\\idea-Protection\\Idea-Protection-Center\\src\\main\\webapp\\resources\\uploadimgs\\inventor\\asdf\\201610141721170.jpg";
//
//		FileInputStream is = new FileInputStream(imgFile);
//		run.addBreak();
//		run.addPicture(is, XWPFDocument.PICTURE_TYPE_JPEG, imgFile, Units.toEMU(200), Units.toEMU(200)); // 200x200 pixels
//		is.close();
			//정렬
		paragraph.setAlignment(ParagraphAlignment.LEFT);
		//들여쓰기..?
		//paragraph.setIndentationHanging(1000);
		
		//paragraph.setBorderBottom(Borders.BASIC_THIN_LINES);
		String name=rv.getTitle()+ss.getToday(1)+".docx";
		String full_path=path+name;
		try{
			
			FileOutputStream output = new FileOutputStream(full_path);
			System.out.println("full path: "+full_path);
			document.write(output);
			output.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return name;
	}
	@RequestMapping(value="/getFile/{file_name}",method=RequestMethod.GET)
	public ModelAndView downLoadFile(HttpServletRequest request,@PathVariable String file_name) {
		System.out.println("downcome");
        String root_path=request.getSession().getServletContext().getRealPath("/");
        //String doc_name=request.getParameter("file_name");
        String doc_name=file_name+".docx";
        String fullPath = request.getSession().getServletContext().getRealPath("resources/uploadimgs/document/")+doc_name;
        System.out.println(fullPath);
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
