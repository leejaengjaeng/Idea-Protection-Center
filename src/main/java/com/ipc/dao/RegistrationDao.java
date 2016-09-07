package com.ipc.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RegistrationDao {
	public void makeidea(HashMap<String,String> map);
}
