package com.ipc.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocumentDao {
	public void saveDocument(HashMap<String,String> name);

}
