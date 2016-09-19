package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.adminListVo;

@Mapper
@Transactional
public interface RegistrationDao {
	public void makeidea(RegistrationPatentVo rv);
	public void maketempidea(HashMap<String,String> map);
	public void updatetempidea(HashMap<String,String> map);
	public RegistrationPatentVo gettempidea(int uid);
	public int countTempIdea(int uid);

	public List<RegistrationPatentVo> getInventorProcessList(int uid);
	public List<RegistrationPatentVo> getPlProcessList(int lid);
	public RegistrationPatentVo getInventorProcessByRid(int rid);
	public RegistrationPatentVo getPlProcessByRid(int rid);
	
	public RegistrationPatentVo getAssociatedMembersByRid(int start_rid);
	public List<RegistrationPatentVo> getAssociatedProcessList(int start_rid);
	
	public RegistrationPatentVo getPrevInventorModifyByPrevRid(int prev_rid);
	public RegistrationPatentVo getPrevPlCommentByPrevRid(int prev_rid);
	public RegistrationPatentVo getAfterInventorModifyByRid(int rid);
	public RegistrationPatentVo getAfterPlCommentByRid(int rid);
	
	public void removeTempIdea(int uid);
	
	public void inventorSave (RegistrationPatentVo rvo);
	public void plUpdate (RegistrationPatentVo rvo);
	public void plSave (RegistrationPatentVo rvo);
	
	public RegistrationPatentVo getResourceForPlSaveByRid(int rid);
	public int getLastRidInProcessList (int start_rid);
	
	public int checkIsCompletedByRid(int rid);
	public void updateStartId(int rid);
	
	public List<adminListVo> adminGetIdeaList();
}
