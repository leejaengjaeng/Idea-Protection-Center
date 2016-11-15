package com.ipc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.MessageVo;
import com.ipc.vo.RegistrationPatentVo;

@Mapper
public interface MessageDao {
	public void insertMessage(MessageVo rv);
	public List<MessageVo> getMessageVoList(String uid);
	public List<MessageVo> getMessageVoListPL(String uid);
	public void changeIsread(String mid);
}
