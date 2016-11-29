package com.ipc.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.ApplyDocVo;
import com.ipc.vo.UpLoadDocVoOther;

@Mapper
public interface DocumentDao {
	public void saveDocument(HashMap<String,String> name);
	public int isPersonal(int rid);
	public ApplyDocVo getVoByrid(int rid);
	public void updateDocumentForApply(HashMap<String,String> map);
	public int countDocumentForApplyByRid(int rid);
	public UpLoadDocVoOther getUpLoadDocVoOtherByHashMap(HashMap<String,String> map);
	public void updateDocumentForApplyOther(HashMap<String,String> map);
	public int countFinalDoc(HashMap<String,String> map);
	public String getFinalDocDesign(int died);
	public String getDocumentName(HashMap<String,String> map);
	
}
