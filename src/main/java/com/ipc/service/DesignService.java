package com.ipc.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.DesignDao;
import com.ipc.util.CreateFileUtils;
import com.ipc.vo.DesignVo;
import com.ipc.vo.userVo;

@Service
public class DesignService {
	@Autowired
	DesignDao designmapper;
	public void designInput(HttpServletRequest request,userVo uv,DesignVo dv){
		RegistrationService rs = new RegistrationService();
		
		
		
		DesignVo upDv=new DesignVo();
		upDv.setUid(Integer.parseInt(request.getParameter("uid")));
		upDv.setLuid(Integer.parseInt(request.getParameter("luid")));
		designmapper.updateRowComment(dv);
	}
}
