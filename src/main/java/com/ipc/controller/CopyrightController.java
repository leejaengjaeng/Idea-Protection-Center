package com.ipc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/copyRight")
public class CopyrightController {

	@RequestMapping("/reg")
	public String copyRightReg(Model model)
	{
		return "registration/idea_copyright";
	}
}


