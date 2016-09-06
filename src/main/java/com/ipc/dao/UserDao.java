package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import com.ipc.vo.userVo;

public interface UserDao {
	
	
	public userVo getUserById(String id);
	public void makeuser(HashMap<String,String> map);
	public int checkid(String id);
	public void makelawyer(HashMap<String,String> map);
	
}
