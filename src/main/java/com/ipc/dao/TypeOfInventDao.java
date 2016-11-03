package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.TypeOfInventVo;

@Mapper
public interface TypeOfInventDao {
	public List<TypeOfInventVo> getTypeList();
	public void rmType(int id);
	public void addType(HashMap<String,String> map);
}
