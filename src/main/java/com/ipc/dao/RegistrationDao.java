package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.RegistrationPatentVo;

@Mapper
public interface RegistrationDao {
	public void makeidea(HashMap<String,String> map);
	public List<RegistrationPatentVo> getProcessList(int uid);
	
}
