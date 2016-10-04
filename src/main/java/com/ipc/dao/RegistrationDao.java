package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.adminListVo;
import com.ipc.vo.adminNoticeVo;

@Mapper
@Transactional
public interface RegistrationDao {
	public void makeidea(RegistrationPatentVo rv);
	public void maketempidea(HashMap<String,String> map);
	public void updatetempidea(HashMap<String,String> map);
	public List<RegistrationPatentVo> gettempidea(int uid);
	public int countTempIdea(int uid);
	public RegistrationPatentVo getloadtemp(int rid);
	public List<RegistrationPatentVo> getInventorProcessList(int uid);
	public List<RegistrationPatentVo> getPlProcessList(int uid);
	
	public RegistrationPatentVo getAssociatedMembersByRid(int start_rid);
	public List<RegistrationPatentVo> getAssociatedProcessList(int start_rid);
	
	//(발명가<prevRid>, 변리사<Rid>) rid에 맞는 발명가 작성 내용 + 변리사 코멘트 
	public RegistrationPatentVo getRegistrationByRidOrPrevRid(int rid);
	//(발명가) after칸에 들어갈 발명가 작성 내용
	public RegistrationPatentVo getInventorModifyByRid(int rid);
	//(변리사) before칸에 들어갈 변리사 작성 내용
	public RegistrationPatentVo getPrevPlCommentByPrevRid(int prev_rid);
	
	//start_rid로 연결된 마지막 rid를 찾음
	public int getLastRidInProcessList (int start_rid);
	
	public void removeTempIdea(int uid);
	
	public void inventorSave (RegistrationPatentVo rvo);
	public void plUpdate (RegistrationPatentVo rvo);
	public void plSave (RegistrationPatentVo rvo);
	
	public RegistrationPatentVo getResourceForPlSaveByRid(int rid);
	
	public int checkIsCompletedByRid(int rid);
	public void updateStartId(int rid);
	
	public List<adminListVo> adminGetIdeaList();
	public void regisNotice(adminNoticeVo an);
	public void tempApply(int rid);
	
	public int getIscompleteByrid(int rid);
	
	public int countCompleteIdeaIn(int uid);
	public int countIngIdeaIn(int uid);
	public int countCompleteIdeaPl(int uid);
	public int countIngIdeaPl(int uid);
	
	public int counTotalIdea();
}
