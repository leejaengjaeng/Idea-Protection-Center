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
		DesignVo dv = new DesignVo();
		CreateFileUtils createFileObj = new CreateFileUtils();
		String date=rs.getToday(1);
		String file_name_default = uv.getId()+date;
		int deid=Integer.parseInt(request.getParameter("deid"));
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
		
		
		dv.setRe_title(request.getParameter("re_title"));
		dv.setRe_whereapply(request.getParameter("re_whereapply"));
		dv.setRe_mean(request.getParameter("re_mean"));
		dv.setRe_sasi("/resources/uploadimgs/design/sasi/sasi"+file_name_default+"."+CreateFileUtils.getFileType(sasiFile.getOriginalFilename()));
		dv.setRe_front("/resources/uploadimgs/design/front/front"+file_name_default+"."+CreateFileUtils.getFileType(frontFile.getOriginalFilename()));
		dv.setRe_bae("/resources/uploadimgs/design/bae/bae"+file_name_default+"."+CreateFileUtils.getFileType(baeFile.getOriginalFilename()));
		dv.setRe_leftside("/resources/uploadimgs/design/left_side/left_side"+file_name_default+"."+CreateFileUtils.getFileType(left_sideFile.getOriginalFilename()));
		dv.setRe_rightside("/resources/uploadimgs/design/right_side/right_side"+file_name_default+"."+CreateFileUtils.getFileType(right_sideFile.getOriginalFilename()));
		dv.setRe_plane("/resources/uploadimgs/design/plane/plane"+file_name_default+"."+CreateFileUtils.getFileType(planeFile.getOriginalFilename()));
		dv.setRe_inside("/resources/uploadimgs/design/inside/inside"+file_name_default+"."+CreateFileUtils.getFileType(insideFile.getOriginalFilename()));
		dv.setDeid(deid);
		
		DesignVo upDv=new DesignVo();
		upDv.setUid(Integer.parseInt(request.getParameter("uid")));
		upDv.setLuid(Integer.parseInt(request.getParameter("luid")));
		designmapper.updateRowComment(dv);
	}
}
