package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import com.ipc.vo.CopyRightVo;
import com.ipc.vo.IndexVo;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.adminListVo;
import com.ipc.vo.adminNoticeVo;

@Mapper
public interface CopyrightDao {
	public void addCopyright(CopyRightVo cv);
	/*
	public void makeidea(RegistrationPatentVo rv);
	public void maketempidea(HashMap<String,String> map);
	public void updatetempidea(HashMap<String,String> map);
	public List<RegistrationPatentVo> gettempidea(int uid);
	public int countTempIdea(int uid);
	public RegistrationPatentVo getloadtemp(int rid);
	public List<RegistrationPatentVo> getInventorProcessList(int uid);
	public List<RegistrationPatentVo> getPlProcessList(int uid);
	*/
}
