package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.QnaVo;
import com.ipc.vo.adminNoticeVo;

@Mapper
public interface NoticeDao {
	public void 				regisNotice(adminNoticeVo an);
	public adminNoticeVo 		getNoticeByNid(int nid);
	public List<adminNoticeVo> 	getNoticeListDescLimit(int num);

	//pagenation
	public List<QnaVo> 			getNotices(HashMap<String,Integer> pageAndPagePerContents);	
	public int 					getTotalSize();
	
}
