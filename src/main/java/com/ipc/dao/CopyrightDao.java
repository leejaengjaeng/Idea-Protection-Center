package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import com.ipc.vo.CopyRightInfoVo;
import com.ipc.vo.CopyRightVo;
import com.ipc.vo.IndexVo;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.adminListVo;
import com.ipc.vo.adminNoticeVo;

@Mapper
public interface CopyrightDao {

	//insert
	public void addCopyright(CopyRightVo cv);
	
	//select
	public CopyRightVo getStartCidByCid(int cid);
	public List<CopyRightVo> getAssosiatedList(int start_cid);
	public CopyRightVo getOneRowByCid(int cid);
	
	//update
	public void	updateCopyright_pl(CopyRightVo cv);
	public void updateStartCid(CopyRightVo cv);
	public void setLidtoRow(HashMap map);
	
}
