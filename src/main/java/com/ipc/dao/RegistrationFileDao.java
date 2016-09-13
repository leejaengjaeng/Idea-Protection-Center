package com.ipc.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.RegistrationFileVo;

@Mapper
public interface RegistrationFileDao {
	public void makeFile(HashMap<String,String> map);
}
