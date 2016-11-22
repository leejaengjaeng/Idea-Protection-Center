package com.ipc.util;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public class CreateFileUtils {
	private FileOutputStream fos;

	public String CreateFile(MultipartFile file,HttpServletRequest request,String dir_path,String fileName){
		try {
			
			//Windows
				//String dirpath=root_path+"\\resources\\uploadimgs\\profileImg\\";
			//Linux
			
			String root_path=PathUtils.getRootPath(request);
			mkdir(root_path+dir_path);
			String full_path=root_path+dir_path+fileName;
			byte fileData[] = file.getBytes();
			
			fos = new FileOutputStream(full_path);
			fos.write(fileData);
			return "OK";
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
		return "NO";
	}
	private String mkdir(String dir_path){
		File dir=new File(dir_path);
		if(!dir.exists())
		{	
			dir.mkdirs();
		}
		return "OK";
	}
	public static String getFileType(String fileName){
		int pathPoint = fileName.trim().lastIndexOf(".");
		String filePoint = fileName.trim().substring(pathPoint + 1,fileName.trim().length());
		String fileType = filePoint.toLowerCase();
		return fileType;
	}
}
