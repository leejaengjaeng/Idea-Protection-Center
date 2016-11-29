package com.ipc.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ipc.dao.DesignDao;
import com.ipc.dao.MarkDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.UpLoadDocDao;
import com.ipc.util.CreateFileUtils;
import com.ipc.util.PathUtils;
import com.ipc.vo.UpLoadDocVo;
import com.ipc.vo.UpLoadDocVoOther;

@Service
public class UploadDocumentService {
	@Autowired
	RegistrationService ss;
	@Autowired
	UpLoadDocDao upDao;
	@Autowired
	RegistrationDao regDao;
	@Autowired
	DesignDao designmapper;
	@Autowired
	MarkDao markmapper;
	private FileOutputStream fos;
	public void saveFile(HashMap<String,List<MultipartFile>> fileList,String root_path,UpLoadDocVo upv,HttpServletRequest request) throws IOException{	
		System.out.println();
		String date=ss.getToday(1);
		
		upv.setResident_registration("resident_registration"+date+"."+ CreateFileUtils.getFileType(fileList.get("resident_registration").get(0).getOriginalFilename()));
		upv.setCertificate("certificate"+date+"."+ CreateFileUtils.getFileType(fileList.get("certificate").get(0).getOriginalFilename()));
		upv.setBusiness_license("business_license"+date+"."+ CreateFileUtils.getFileType(fileList.get("business_license").get(0).getOriginalFilename()));
		
		CreateFileUtils createFileObj = new CreateFileUtils();
		createFileObj.CreateFile(fileList.get("resident_registration").get(0), request, "resources/uploadimgs/uploadDocument/", "resident_registration"+date+ "." + CreateFileUtils.getFileType(fileList.get("resident_registration").get(0).getOriginalFilename()));
		createFileObj.CreateFile(fileList.get("certificate").get(0), request, "resources/uploadimgs/uploadDocument/", "certificate"+date+ "." + CreateFileUtils.getFileType(fileList.get("certificate").get(0).getOriginalFilename()));
		createFileObj.CreateFile(fileList.get("business_license").get(0), request, "resources/uploadimgs/uploadDocument/", "business_license"+date+ "." + CreateFileUtils.getFileType(fileList.get("business_license").get(0).getOriginalFilename()));

		if(fileList.size()==4){
			upv.setSmallsale("smallsale"+date+"."+CreateFileUtils.getFileType(fileList.get("smallsale").get(0).getOriginalFilename()));
			createFileObj.CreateFile(fileList.get("smallsale").get(0), request, "resources/uploadimgs/uploadDocument/", "smallsale"+date+ "." + CreateFileUtils.getFileType(fileList.get("smallsale").get(0).getOriginalFilename()));
		}
		saveDocToDb(upv);
		changeIsComplete(upv.getRid());
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
	public void saveFileOther(HashMap<String,List<MultipartFile>> fileList,String root_path,UpLoadDocVoOther upv,HttpServletRequest request) throws IOException{	
		System.out.println();
		String date=ss.getToday(1);
		
		upv.setResident_registration("resident_registration"+date+"."+ CreateFileUtils.getFileType(fileList.get("resident_registration").get(0).getOriginalFilename()));
		upv.setCertificate("certificate"+date+"."+ CreateFileUtils.getFileType(fileList.get("certificate").get(0).getOriginalFilename()));
		upv.setBusiness_license("business_license"+date+"."+ CreateFileUtils.getFileType(fileList.get("business_license").get(0).getOriginalFilename()));
		
		CreateFileUtils createFileObj = new CreateFileUtils();
		createFileObj.CreateFile(fileList.get("resident_registration").get(0), request, "resources/uploadimgs/uploadDocument/", "resident_registration"+date+ "." + CreateFileUtils.getFileType(fileList.get("resident_registration").get(0).getOriginalFilename()));
		createFileObj.CreateFile(fileList.get("certificate").get(0), request, "resources/uploadimgs/uploadDocument/", "certificate"+date+ "." + CreateFileUtils.getFileType(fileList.get("certificate").get(0).getOriginalFilename()));
		createFileObj.CreateFile(fileList.get("business_license").get(0), request, "resources/uploadimgs/uploadDocument/", "business_license"+date+ "." + CreateFileUtils.getFileType(fileList.get("business_license").get(0).getOriginalFilename()));

		if(fileList.size()==4){
			upv.setSmallsale("smallsale"+date+"."+CreateFileUtils.getFileType(fileList.get("smallsale").get(0).getOriginalFilename()));
			createFileObj.CreateFile(fileList.get("smallsale").get(0), request, "resources/uploadimgs/uploadDocument/", "smallsale"+date+ "." + CreateFileUtils.getFileType(fileList.get("smallsale").get(0).getOriginalFilename()));
		}
		upDao.saveUpLoadDocumentOther(upv);
		
		
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		if(upv.getPatent_kind()=="Design"){
			map.put("deid", Integer.toString(upv.getSeq()));
			map.put("iscomplete", "4");
			designmapper.changeIsCompleteByHashMap(map);
		}
		else if(upv.getPatent_kind()=="Mark"){
			map.put("mid", Integer.toString(upv.getSeq()));
			map.put("iscomplete", "4");
			markmapper.updateIscomplete(map);
		}
	}
}
