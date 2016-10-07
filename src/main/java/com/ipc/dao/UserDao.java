package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ipc.vo.userVo;



@Mapper
public interface UserDao {
	
	public userVo getUserById(String id);
	
	public userVo getUserByUid(String uid);
	
	public void makeuser(HashMap<String,String> map);
	
	public int checkid(String id);
	
	public void makelawyer(HashMap<String,String> map);
	
	public void permit(String uid);
	
	public List<userVo> getLawyerList();
	
	public void assign(HashMap<String,String> map);
	
	public int counTotalUser();
	
	public List<userVo> getAllUsers();
	
	public String getLicense_numberByUid(int uid);
	
	public void editinput(HashMap<String,String> map);
	
	public void updateProfileImg(HashMap<String,String> map);
	
	public String getIdByNameAndEmail(HashMap<String,String> map);
	
	public String getUidByIdAndEmail(HashMap<String,String> map);
	
	public void updateKey(HashMap<String,String> map);
}
