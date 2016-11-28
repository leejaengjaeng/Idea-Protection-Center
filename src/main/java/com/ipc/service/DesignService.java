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
	public void designInputPl(HttpServletRequest request,userVo uv){
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
	public void designInputIn(HttpServletRequest request,userVo uv){
		DesignVo dv=new DesignVo();
		RegistrationService rs = new RegistrationService();
		dv.setUid(Integer.parseInt(request.getParameter("uid")));
		dv.setLuid(Integer.parseInt(request.getParameter("luid")));
		dv.setDeid(Integer.parseInt(request.getParameter("deid")));
		dv.setTitle(request.getParameter("title"));
		dv.setWhereapply(request.getParameter("whereapply"));
		dv.setMean(request.getParameter("mean"));
		CreateFileUtils createFileObj = new CreateFileUtils();
		String date=rs.getToday(1);
		
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
		int deid=Integer.parseInt(request.getParameter("deid"));
		dv.setStart_deid(designmapper.getStart_deid(deid));
		dv.setSasi("/resources/uploadimgs/design/sasi/sasi"+file_name_default+"."+CreateFileUtils.getFileType(sasiFile.getOriginalFilename()));
		dv.setFront("/resources/uploadimgs/design/front/front"+file_name_default+"."+CreateFileUtils.getFileType(frontFile.getOriginalFilename()));
		dv.setBae("/resources/uploadimgs/design/bae/bae"+file_name_default+"."+CreateFileUtils.getFileType(baeFile.getOriginalFilename()));
		dv.setLeft_side("/resources/uploadimgs/design/left_side/left_side"+file_name_default+"."+CreateFileUtils.getFileType(left_sideFile.getOriginalFilename()));
		dv.setRight_side("/resources/uploadimgs/design/right_side/right_side"+file_name_default+"."+CreateFileUtils.getFileType(right_sideFile.getOriginalFilename()));
		dv.setPlane("/resources/uploadimgs/design/plane/plane"+file_name_default+"."+CreateFileUtils.getFileType(planeFile.getOriginalFilename()));
		dv.setInside("/resources/uploadimgs/design/inside/inside"+file_name_default+"."+CreateFileUtils.getFileType(insideFile.getOriginalFilename()));
		designmapper.insertNewRow(dv);
	}
}
