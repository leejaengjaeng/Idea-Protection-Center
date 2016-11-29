package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.DesignAdminVo;
import com.ipc.vo.DesignVo;

@Mapper
public interface DesignDao {
	public void insertFirstDesign(DesignVo dv);
	public void updatedeid(int deid);
	public List<DesignAdminVo> getDesignListAdmin();
	public void updatePatent(HashMap<String,String> map);
	public List<DesignAdminVo> getDesignListIn(int uid);
	public int getStart_deid(int deid);
	public DesignVo getDesignByDeid(int deid);
	public int countDesignByStart_deid(int start_deid);
	public List<DesignAdminVo> getDesignListPl(int uid);
	public void updateRowComment(DesignVo dv);
	public void insertNewRow(DesignVo dv);
	public DesignVo getDesignByNum(HashMap<String,Integer> map);
	public void changeIsCompleteByHashMap(HashMap<String,String> map);
	public void updateApplyDate(HashMap<String,String> map);
}
