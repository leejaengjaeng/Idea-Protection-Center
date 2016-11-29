package com.ipc.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.UpLoadDocVo;
import com.ipc.vo.UpLoadDocVoOther;

@Mapper
public interface UpLoadDocDao {
	public void saveUpLoadDocument(UpLoadDocVo upv);
	public UpLoadDocVo getVoByRid(int rid);
	
	public void saveUpLoadDocumentOther(UpLoadDocVoOther upv);

	public int isExist(HashMap<String,String> map);
}
