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
import com.ipc.util.PathUtils;
import com.ipc.vo.DesignVo;
import com.ipc.vo.RegistrationFileVo;
import com.ipc.vo.RegistrationPatentVo;

import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.io.*;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.http.HttpServletRequest;
@Controller
public class DocController {
	@Autowired
	RegistrationFileDao regisFileMapper;
	@Autowired
	RegistrationDao regisMapper;
	public String saveDesignFile(DesignVo dv,String root_path){
		String dir_path=root_path+"/resources/uploadimgs/document/";
		RegistrationService ss = new RegistrationService();
		XWPFDocument document = new XWPFDocument();
		XWPFParagraph paragraph=document.createParagraph();
		XWPFRun run = paragraph.createRun();
		
		File sasiFile=new File(root_path+dv.getSasi());
		File frontFile=new File(root_path+dv.getFront());
		File baeFile=new File(root_path+dv.getBae());
		File left_sideFile=new File(root_path+dv.getLeft_side());
		File right_sideFile=new File(root_path+dv.getRight_side());
		File planeFile=new File(root_path+dv.getPlane());
		File insideFile=new File(root_path+dv.getInside());
		
		run.setText("디자인 제목");
		run.addBreak();
		run.setText(dv.getTitle());
		run.addBreak();
		run.setText("디자인이 적용된 곳");
		run.addBreak();
		if(dv.getWhereapply().contains("\n")){
			String[] stringline = dv.getWhereapply().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		else{
			run.setText(dv.getWhereapply());
		}
		run.addBreak();
		run.setText("디자인의 의미");
		run.addBreak();
		if(dv.getMean().contains("\n")){
			String[] stringline = dv.getMean().split("\n");
			for(int i=0;i<stringline.length;i++){
				run.setText(stringline[i]);
				run.addBreak();
			}
		}
		else{
			run.setText(dv.getMean());
		}
		run.addBreak();
		run.setText("사시도");
		run.addBreak();
		try{
			FileInputStream is = null;
			
				
				System.out.println("파일이름 : "+sasiFile.getName());
				BufferedImage bi;
				try{
					bi=ImageIO.read(sasiFile);
				}
				catch(Exception e){
					Iterator readers = ImageIO.getImageReadersByFormatName("JPEG");
					ImageReader reader = null;
					while(readers.hasNext()) {
					    reader = (ImageReader)readers.next();
					    if(reader.canReadRaster()) {
					        break;
					    }
					}

					//Stream the image file (the original CMYK image)
					ImageInputStream input =   ImageIO.createImageInputStream(sasiFile); 
					reader.setInput(input); 

					//Read the image raster
					Raster raster = reader.readRaster(0, null); 

					//Create a new RGB image
					bi = new BufferedImage(raster.getWidth(),raster.getHeight(),BufferedImage.TYPE_4BYTE_ABGR); 

					//Fill the new image with the old raster
					bi.getRaster().setRect(raster);
				}
				float width=bi.getWidth();
				float height=bi.getHeight();
				
				float rate = height/width;
				int realWidth=200;
				int realHeight=(int) (realWidth*rate);
				System.out.println("realHeight : "+realHeight);
				System.out.println("width : "+bi.getWidth()+", height : "+bi.getHeight());
				is = new FileInputStream(root_path+dv.getSasi());
			    run.addBreak();
			    System.out.println("fileName : "+sasiFile.getName());
			    int pathPoint = sasiFile.getName().trim().lastIndexOf(".");
			    String filePoint = sasiFile.getName().trim().substring(pathPoint + 1,
			    		sasiFile.getName().trim().length());
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
				else if(fileType.equals("bmp")){
					picture_type=XWPFDocument.PICTURE_TYPE_BMP;
				}
				else if(fileType.equals("jpeg")){
					picture_type=XWPFDocument.PICTURE_TYPE_JPEG;
				}
				run.addPicture(is, picture_type, root_path+dv.getSasi(),Units.toEMU(realWidth),Units.toEMU(realHeight)); // 200x200 pixels
			
			
			is.close();
			}catch(Exception e){}
			run.addBreak();
			run.setText("전면도");
			run.addBreak();
			try{
				FileInputStream is = null;
				
					
					System.out.println("파일이름 : "+frontFile.getName());
					BufferedImage bi;
					try{
						bi=ImageIO.read(frontFile);
					}
					catch(Exception e){
						Iterator readers = ImageIO.getImageReadersByFormatName("JPEG");
						ImageReader reader = null;
						while(readers.hasNext()) {
						    reader = (ImageReader)readers.next();
						    if(reader.canReadRaster()) {
						        break;
						    }
						}

						//Stream the image file (the original CMYK image)
						ImageInputStream input =   ImageIO.createImageInputStream(frontFile); 
						reader.setInput(input); 

						//Read the image raster
						Raster raster = reader.readRaster(0, null); 

						//Create a new RGB image
						bi = new BufferedImage(raster.getWidth(),raster.getHeight(),BufferedImage.TYPE_4BYTE_ABGR); 

						//Fill the new image with the old raster
						bi.getRaster().setRect(raster);
					}
					float width=bi.getWidth();
					float height=bi.getHeight();
					
					float rate = height/width;
					int realWidth=200;
					int realHeight=(int) (realWidth*rate);
					System.out.println("realHeight : "+realHeight);
					System.out.println("width : "+bi.getWidth()+", height : "+bi.getHeight());
					is = new FileInputStream(root_path+dv.getFront());
				    run.addBreak();
				    System.out.println("fileName : "+frontFile.getName());
				    int pathPoint = frontFile.getName().trim().lastIndexOf(".");
				    String filePoint = frontFile.getName().trim().substring(pathPoint + 1,
				    		frontFile.getName().trim().length());
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
					else if(fileType.equals("bmp")){
						picture_type=XWPFDocument.PICTURE_TYPE_BMP;
					}
					else if(fileType.equals("jpeg")){
						picture_type=XWPFDocument.PICTURE_TYPE_JPEG;
					}
					run.addPicture(is, picture_type, root_path+dv.getSasi(),Units.toEMU(realWidth),Units.toEMU(realHeight)); // 200x200 pixels
				
				
				is.close();
				}catch(Exception e){}
			paragraph.setAlignment(ParagraphAlignment.LEFT);
			
			String name=ss.getToday(1)+".docx";
			
			String full_path=dir_path+name;
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
	public String savefile(RegistrationPatentVo rv,String root_path,List<RegistrationFileVo> rfv) throws InvalidFormatException, IOException{
		System.out.println("rootpath in savefile : "+root_path);
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
		
		try{
		System.out.println(rfv.get(0).getFile_path());
		FileInputStream is = null;
		for(int i=0;i<rfv.size();i++){
			String imgFile=(root_path+rfv.get(i).getFile_path());
			//String imgFile="C:\\Users\\HP\\Desktop\\idea-Protection\\Idea-Protection-Center\\src\\main\\webapp\\resources\\uploadimgs\\inventor\\asdf\\201610141721170.jpg";
			System.out.println("imgFilePath:"+imgFile);
			File file=new File(imgFile);
			System.out.println("파일이름 : "+file.getName());
			BufferedImage bi;
			try{
				bi=ImageIO.read(file);
			}
			catch(Exception e){
				Iterator readers = ImageIO.getImageReadersByFormatName("JPEG");
				ImageReader reader = null;
				while(readers.hasNext()) {
				    reader = (ImageReader)readers.next();
				    if(reader.canReadRaster()) {
				        break;
				    }
				}

				//Stream the image file (the original CMYK image)
				ImageInputStream input =   ImageIO.createImageInputStream(file); 
				reader.setInput(input); 

				//Read the image raster
				Raster raster = reader.readRaster(0, null); 

				//Create a new RGB image
				bi = new BufferedImage(raster.getWidth(),raster.getHeight(),BufferedImage.TYPE_4BYTE_ABGR); 

				//Fill the new image with the old raster
				bi.getRaster().setRect(raster);
			}
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
			else if(fileType.equals("bmp")){
				picture_type=XWPFDocument.PICTURE_TYPE_BMP;
			}
			else if(fileType.equals("jpeg")){
				picture_type=XWPFDocument.PICTURE_TYPE_JPEG;
			}
			run.addPicture(is, picture_type, imgFile,Units.toEMU(realWidth),Units.toEMU(realHeight)); // 200x200 pixels
		}
		
		is.close();
		}catch(Exception e){}

		paragraph.setAlignment(ParagraphAlignment.LEFT);
		
		String name=ss.getToday(1)+".docx";
		
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
        String root_path=PathUtils.getRootPath(request);
        //String doc_name=request.getParameter("file_name");
        String doc_name=file_name+".docx";
        //String fullPath = request.getSession().getServletContext().getRealPath("resources/uploadimgs/document/")+doc_name;
        String fullPath=PathUtils.getRootPath(request)+"/resources/uploadimgs/document/"+doc_name;
        File downloadFile = new File(fullPath);
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
