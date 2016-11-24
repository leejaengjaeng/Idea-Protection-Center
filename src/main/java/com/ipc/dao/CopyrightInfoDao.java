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
public interface CopyrightInfoDao {
	public void addCopyrightInfo(CopyRightInfoVo cv);
	
}
