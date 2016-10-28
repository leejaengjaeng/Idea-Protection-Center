package com.ipc.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.UpLoadDocVo;

@Mapper
public interface UpLoadDocDao {
	public void saveUpLoadDocument(UpLoadDocVo upv);

}
