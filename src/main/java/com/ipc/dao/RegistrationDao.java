package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.RegistrationPatentVo;

@Mapper
public interface RegistrationDao {
	public void makeidea(HashMap<String,String> map);
	public void maketempidea(HashMap<String,String> map);
	public void updatetempidea(HashMap<String,String> map);
	public RegistrationPatentVo gettempidea(int uid);
	public List<RegistrationPatentVo> getInventorProcessList(int uid);

	public int countTempIdea(int uid);

	public List<RegistrationPatentVo> getPlProcessList(int lid);
	public RegistrationPatentVo getAssociatedMembersByRid(int start_rid);
	
	public List<RegistrationPatentVo> getAssociatedProcessList(int start_rid);
	public RegistrationPatentVo getInventorProcessByRid(int rid);
	public RegistrationPatentVo getPrevCommentByPrevRid(int prev_rid);
	public RegistrationPatentVo getPlProcessByRid(int rid);
	public void removeTempIdea(int uid);
}
