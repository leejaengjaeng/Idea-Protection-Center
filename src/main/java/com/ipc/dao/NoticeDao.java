package com.ipc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.adminNoticeVo;

@Mapper
public interface NoticeDao {
	public void regisNotice(adminNoticeVo an);
	public List<adminNoticeVo> getNoticeListDesc();
	public adminNoticeVo getNoticeByNid(int nid);
	public List<adminNoticeVo> getNoticeListDescLimit(int num);

	
}
