package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import com.ipc.vo.CopyRightInfoVo;
import com.ipc.vo.CopyRightVo;
import com.ipc.vo.CopyrightAdminVo;
import com.ipc.vo.IndexVo;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.adminListVo;
import com.ipc.vo.adminNoticeVo;

@Mapper
public interface CopyrightInfoDao {
	//insert
	public void addCopyrightInfo(CopyRightInfoVo cv);
	
	//select
	public List getCopyrightListInventer(int uid);
	public List getCopyrightListPl(int uid);
	public CopyRightInfoVo getMpcidByCid(int cid);
	public List<CopyrightAdminVo> getCopyrightListAtAdmin();
	
	//update
	public void updateInfoByMpcid(CopyRightInfoVo cv);
	public void asignPl(HashMap map);
	
}
