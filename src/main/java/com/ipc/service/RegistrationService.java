package com.ipc.service;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ipc.dao.RegistrationFileDao;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.userVo;
@Service
public class RegistrationService {
	@Autowired
	RegistrationFileDao registrationfilemapper;
	
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
			fos = new FileOutputStream(root_path+"resources\\uploadimgs\\inventor\\"+ID+"\\"+filename+ "." + fileType);
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
}