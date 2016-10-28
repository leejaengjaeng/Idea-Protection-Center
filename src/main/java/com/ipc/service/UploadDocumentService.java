package com.ipc.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ipc.dao.RegistrationDao;
import com.ipc.dao.UpLoadDocDao;
import com.ipc.vo.UpLoadDocVo;

@Service
public class UploadDocumentService {
	@Autowired
	RegistrationService ss;
	@Autowired
	UpLoadDocDao upDao;
	@Autowired
	RegistrationDao regDao;
	private FileOutputStream fos;
	public void saveFile(HashMap<String,List<MultipartFile>> fileList,String root_path,UpLoadDocVo upv) throws IOException{	
		System.out.println();
		String date=ss.getToday(1);
		
		upv.setResident_registration("resident_registration"+date+"."+makeFile(fileList.get("resident_registration").get(0),root_path,"resident_registration",date));
		upv.setCertificate("certificate"+date+"."+makeFile(fileList.get("certificate").get(0),root_path,"certificate",date));
		upv.setBusiness_license("business_license"+date+"."+makeFile(fileList.get("business_license").get(0),root_path,"business_license",date));
		if(fileList.size()==4)
			upv.setSmallsale("smallsale"+date+"."+makeFile(fileList.get("smallsale").get(0),root_path,"smallsale",date));
		
		saveDocToDb(upv);
		changeIsComplete(upv.getRid());
	}
	private String makeFile(MultipartFile file,String root_path,String type,String date) throws IOException{
		byte fileData[] = file.getBytes();
		int pathPoint = file.getOriginalFilename().trim().lastIndexOf(".");
		String filePoint = file.getOriginalFilename().trim().substring(pathPoint + 1,
				file.getOriginalFilename().trim().length());
		String fileType = filePoint.toLowerCase();
		fos = new FileOutputStream(root_path+"resources/uploadimgs/uploadDocument/"+type+date+ "." + fileType);
		fos.write(fileData);
		return fileType;
	}
	private void saveDocToDb(UpLoadDocVo upv){
		upDao.saveUpLoadDocument(upv);
	}
	private void changeIsComplete(int rid){
		HashMap<String,String> upCon = new HashMap<String,String>();
		
		String stRid=Integer.toString(regDao.getStartRidByRid(rid));
		
		upCon.put("rid", stRid);
		upCon.put("ment","출원중");
		
		regDao.updateRegCondition(upCon);
		
		regDao.apply(rid);
	}
}
