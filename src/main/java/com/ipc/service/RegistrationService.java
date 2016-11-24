package com.ipc.service;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.DesignDao;
import com.ipc.dao.RegistrationFileDao;
import com.ipc.util.CreateFileUtils;
import com.ipc.vo.DesignVo;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.userVo;
@Service
public class RegistrationService {
	@Autowired
	RegistrationFileDao registrationfilemapper;
	@Autowired
	HttpSession session;
	@Autowired
	DesignDao designmapper;
	
	public String getToday(int i){
		Calendar calendar = Calendar.getInstance();
		java.util.Date date = calendar.getTime();
		String today;
		if(i==0){
			today = (new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(date));
		}
		else{
			today = (new SimpleDateFormat("yyyyMMddHHmmss").format(date));
		}
		return today;
	}
	private FileOutputStream fos;
	public String makeimageFile(MultipartFile file,String filename,String ID,int rid,String root_path){
		try {
			
			mkdir(ID,root_path);
			byte fileData[] = file.getBytes();
			int pathPoint = file.getOriginalFilename().trim().lastIndexOf(".");
			String filePoint = file.getOriginalFilename().trim().substring(pathPoint + 1,
					file.getOriginalFilename().trim().length());
			String fileType = filePoint.toLowerCase();
			//Windows
				//fos = new FileOutputStream(root_path+"resources\\uploadimgs\\inventor\\"+ID+"\\"+filename+ "." + fileType);
			//Linux
			fos = new FileOutputStream(root_path+"resources/uploadimgs/inventor/"+ID+"/"+filename+ "." + fileType);
			fos.write(fileData);
			HashMap<String,String> map=new HashMap<String,String>();
			//map.put("start_rid", Integer.toString(rid));
			//map.put("file_path", "/resource/uploadimgs/inventor/"+ID+filename+ "." + fileType);
			try{
				//registrationfilemapper.makeFile(map);
				return fileType;
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fos != null) {
				try {
					fos.close();
				} catch (Exception e) {
				}
			}
		} // try end;
		return "..";
		
	}
	public String mkdir(String ID,String root_path){
		String path=root_path+"/resources/uploadimgs/inventor/"+ID;
		File dir=new File(path);
		if(!dir.exists())
		{	
			dir.mkdirs();
			System.out.println("mkdir!");
		}
		return "OK";
	}
	public void designInput(HttpServletRequest request){
		DesignVo dv = new DesignVo();
		CreateFileUtils createFileObj = new CreateFileUtils();
		String date=getToday(1);
		userVo uv = (userVo)session.getAttribute("currentUser");
		String file_name_default = uv.getId()+date;
		
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		
		MultipartFile sasiFile = multipartRequest.getFiles("sasi").get(0);
		createFileObj.CreateFile(sasiFile, request, "/resources/uploadimgs/design/sasi/", "sasi"+file_name_default+"."+CreateFileUtils.getFileType(sasiFile.getOriginalFilename()));
		
		MultipartFile frontFile = multipartRequest.getFiles("front").get(0);
		createFileObj.CreateFile(frontFile, request, "/resources/uploadimgs/design/front/", "front"+file_name_default+"."+CreateFileUtils.getFileType(frontFile.getOriginalFilename()));
		
		MultipartFile baeFile = multipartRequest.getFiles("bae").get(0);
		createFileObj.CreateFile(baeFile, request, "/resources/uploadimgs/design/bae/", "bae"+file_name_default+"."+CreateFileUtils.getFileType(baeFile.getOriginalFilename()));
		
		MultipartFile left_sideFile = multipartRequest.getFiles("left_side").get(0);
		createFileObj.CreateFile(left_sideFile, request, "/resources/uploadimgs/design/left_side/", "left_side"+file_name_default+"."+CreateFileUtils.getFileType(left_sideFile.getOriginalFilename()));
		
		MultipartFile right_sideFile= multipartRequest.getFiles("right_side").get(0);
		createFileObj.CreateFile(right_sideFile, request, "/resources/uploadimgs/design/right_side/", "right_side"+file_name_default+"."+CreateFileUtils.getFileType(right_sideFile.getOriginalFilename()));
		
		MultipartFile planeFile = multipartRequest.getFiles("plane").get(0);
		createFileObj.CreateFile(planeFile, request, "/resources/uploadimgs/design/plane/", "plane"+file_name_default+"."+CreateFileUtils.getFileType(planeFile.getOriginalFilename()));
		
		MultipartFile insideFile= multipartRequest.getFiles("inside").get(0);
		createFileObj.CreateFile(insideFile, request, "/resources/uploadimgs/design/inside/", "inside"+file_name_default+"."+CreateFileUtils.getFileType(insideFile.getOriginalFilename()));
		
		dv.setUid(uv.getUid());
		dv.setTitle(request.getParameter("title"));
		dv.setWhereapply(request.getParameter("whereapply"));
		dv.setMean(request.getParameter("mean"));
		dv.setSasi("/resources/uploadimgs/design/sasi/sasi"+file_name_default+"."+CreateFileUtils.getFileType(sasiFile.getOriginalFilename()));
		dv.setFront("/resources/uploadimgs/design/front/front"+file_name_default+"."+CreateFileUtils.getFileType(frontFile.getOriginalFilename()));
		dv.setBae("/resources/uploadimgs/design/bae/bae"+file_name_default+"."+CreateFileUtils.getFileType(baeFile.getOriginalFilename()));
		dv.setLeft_side("/resources/uploadimgs/design/left_side/left_side"+file_name_default+"."+CreateFileUtils.getFileType(left_sideFile.getOriginalFilename()));
		dv.setRight_side("/resources/uploadimgs/design/right_side/right_side"+file_name_default+"."+CreateFileUtils.getFileType(right_sideFile.getOriginalFilename()));
		dv.setPlane("/resources/uploadimgs/design/plane/plane"+file_name_default+"."+CreateFileUtils.getFileType(planeFile.getOriginalFilename()));
		dv.setInside("/resources/uploadimgs/design/inside/inside"+file_name_default+"."+CreateFileUtils.getFileType(insideFile.getOriginalFilename()));
		
		
		designmapper.insertFirstDesign(dv);
		designmapper.updatedeid(dv.getDeid());
	}
}