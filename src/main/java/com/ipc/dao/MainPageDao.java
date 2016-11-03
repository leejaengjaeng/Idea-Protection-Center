package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.mainPageVo;

@Mapper
public interface MainPageDao {
	public void insertFirstRow(mainPageVo mainPageVo);
	public List<mainPageVo> getMainPageList(int uid);
	public List<mainPageVo> getPlMainPageList(int uid);
	public void updateMainPageLid(HashMap<String,String> map);
	public void updateMainPagerid(RegistrationPatentVo rv);
	public void updateMainPageApplyDate(HashMap<String,String> apply_date_map);
}
