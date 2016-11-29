package com.ipc.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ipc.dao.MarkDao;
import com.ipc.vo.MarkVo;

@Service
public class MarkService {
	@Autowired
	MarkDao markmapper;
	
	public void saveMarkRegPL(HttpServletRequest request,MarkVo mv){
		System.out.println("mid : "+mv.getMid());
		markmapper.saveMarkRegPL(mv);
	}

	
}
