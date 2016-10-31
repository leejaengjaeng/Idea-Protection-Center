package com.ipc.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.ApplyDocVo;

@Mapper
public interface DocumentDao {
	public void saveDocument(HashMap<String,String> name);
	public int isPersonal(int rid);
	public ApplyDocVo getVoByrid(int rid);
}
