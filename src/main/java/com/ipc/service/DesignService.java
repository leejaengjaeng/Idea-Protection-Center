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
	public void designInput(HttpServletRequest request,userVo uv){
		RegistrationService rs = new RegistrationService();
		
		
		
		DesignVo dv=new DesignVo();
		dv.setUid(Integer.parseInt(request.getParameter("uid")));
		dv.setLuid(Integer.parseInt(request.getParameter("luid")));
		dv.setDeid(Integer.parseInt(request.getParameter("deid")));
		dv.setRe_sasi(request.getParameter("re_sasi"));
		dv.setRe_bae(request.getParameter("re_bae"));
		dv.setRe_front(request.getParameter("re_front"));
		dv.setRe_inside(request.getParameter("re_inside"));
		dv.setRe_leftside(request.getParameter("re_leftside"));
		dv.setRe_rightside(request.getParameter("re_rightside"));
		dv.setRe_plane(request.getParameter("re_plane"));
		dv.setRe_title(request.getParameter("re_title"));
		dv.setRe_whereapply(request.getParameter("re_whereapply"));
		dv.setRe_mean(request.getParameter("re_mean"));
		designmapper.updateRowComment(dv);
		//designmapper.insertNewRow(upDv);
	}
}
