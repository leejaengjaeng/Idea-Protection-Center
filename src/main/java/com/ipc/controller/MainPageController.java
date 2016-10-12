package com.ipc.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.ipc.dao.MainPageDao;
import com.ipc.service.RegistrationService;
import com.ipc.service.SignUpService;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.mainPageVo;
@Controller
public class MainPageController {
	@Autowired
	MainPageDao mainpagemapper;
	
	RegistrationService ss=new RegistrationService();
	public void regisControllerInsert(RegistrationPatentVo rv){
		System.out.println("rv: "+rv.getTitle());
		mainPageVo mv=new mainPageVo();
		mv=shiftData(rv,"결제대기중");
		mainpagemapper.insertFirstRow(mv);
	}
	public mainPageVo shiftData(RegistrationPatentVo rv,String condition){
		mainPageVo mpv=new mainPageVo();
		mpv.setUid(rv.getUid());
		mpv.setRid(rv.getRid());
		mpv.setReg_condition(condition);
		mpv.setRegistration_date(rv.getRegistration_date());
		mpv.setTitle(rv.getTitle());
		mpv.setTypeOfInvent(rv.getTypeOfInvent());
		mpv.setLid(rv.getLid());
		return mpv;
	}
}
