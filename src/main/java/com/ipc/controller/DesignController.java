package com.ipc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ipc.dao.DesignDao;
import com.ipc.vo.DesignVo;

@Controller
@RequestMapping("/design")
public class DesignController {
	@Autowired
	DesignDao designmapper;
	@RequestMapping("/detail/{deid}")
	public String designDetail(@PathVariable int deid,Model model){
		DesignVo nowDv = designmapper.getDesignByDeid(deid);
		model.addAttribute("nowDv", nowDv);
		System.out.println("sasi : "+nowDv.getSasi());
		return "comment/d_comment_inventor";
	}
}
