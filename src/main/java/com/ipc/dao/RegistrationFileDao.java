package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.RegistrationFileVo;

@Mapper
public interface RegistrationFileDao {
	public void makeFile(HashMap<String,String> map);
	public List<RegistrationFileVo> getImgListByStartRid(int start_rid);
	public void deleteFile(int id);
	public RegistrationFileVo getVoById(int id);
}
