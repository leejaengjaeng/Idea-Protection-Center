package com.ipc.service;

import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.web.multipart.MultipartFile;

import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.userVo;

public class RegistrationService {
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
	public void makeimageFile(MultipartFile file,String filename,String path,String ID){
		try {
			String dirpath="../Idea-Protection-Center\\src\\main\\webapp\\resources\\uploadimgs\\";
			makedir(dirpath,ID);
			byte fileData[] = file.getBytes();
			int pathPoint = file.getOriginalFilename().trim().lastIndexOf(".");
			String filePoint = file.getOriginalFilename().trim().substring(pathPoint + 1,
					file.getOriginalFilename().trim().length());
			String fileType = filePoint.toLowerCase();
//			fos = new FileOutputStream("../sting\\src\\main\\webapp\\resource\\uploadimgs\\"+path+filename+ "." + fileType);
			fos = new FileOutputStream(dirpath+path+filename+ "." + fileType);

			fos.write(fileData);
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
	}
	public void makedir(String dirpath,String ID){
		String path=dirpath+ID;
	}
}