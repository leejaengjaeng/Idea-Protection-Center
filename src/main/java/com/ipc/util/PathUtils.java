package com.ipc.util;

import javax.servlet.http.HttpServletRequest;
//경로관련 클래스
public class PathUtils {
	//리눅스 root_path(서버나 버전 변경시에 바꿔주기)
	private static final String linuxRootPath = "/home/hosting_users/ideapatents/tomcat/webapps/IPC-v0.1/";
	//private static final String windowRootPath="";
	
	//os이름 판별해서 root_path 반환
	public static String getRootPath(HttpServletRequest request){
		String exactOs=System.getProperty("os.name");
		String os=exactOs.split(" ")[0];
		if(os.equals("Windows")){
			return request.getSession().getServletContext().getRealPath("/");
		}
		else{
			return linuxRootPath;
		}
	}
	
}
