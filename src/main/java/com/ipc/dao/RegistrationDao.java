package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.RegistrationPatentVo;

@Mapper
public interface RegistrationDao {
	public void makeidea(HashMap<String,String> map);
	public void maketempidea(HashMap<String,String> map);
	public void updatetempidea(HashMap<String,String> map);
	public List<RegistrationPatentVo>getInventorProcessList(int uid);
	public List<RegistrationPatentVo>getPlProcessList(int lid);
	public int countTempIdea(int uid);
}
