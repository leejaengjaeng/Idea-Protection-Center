package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.MarkAdminVo;
import com.ipc.vo.MarkVo;

@Mapper
public interface MarkDao {
	public void insertFirstMark(MarkVo mv);
	public void updateFirstMarkStart_mid(int mid);
	public List<MarkAdminVo> getMarkListAdmin();
	public List<MarkAdminVo> getMarkListIn(int uid);
	public List<MarkAdminVo> getMarkListPl(int uid);
	public void updatePatent(HashMap<String,String> map);
	public int countMarkByStart_mid(int start_mid);
	public int getStart_midByMid(int mid);
	public MarkVo getMarkByMid(int mid);
	public List<MarkVo> getMarkListByStart_mid(int start_mid);
	public void saveMarkRegPL(MarkVo mv);
}
