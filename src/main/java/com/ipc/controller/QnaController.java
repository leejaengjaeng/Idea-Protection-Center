package com.ipc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ipc.dao.QnaDao;
import com.ipc.vo.QnaVo;

@Controller
@RequestMapping("/qna")
public class QnaController {

	@Autowired
	QnaDao qnaDao;
	
	@RequestMapping("/regularQna")
	public String regularQna(Model model){
		
		List<QnaVo> qnaList = qnaDao.getRegularQuestions();
		model.addAttribute("qnaList",qnaList);
		return "/qna/regularQna";
	}
	
	@RequestMapping(value="/detail/{qid}",method=RequestMethod.GET)
	public String detailView(Model model,@PathVariable int qid){
		
		QnaVo qna = qnaDao.getQuestionByQid(qid);
		if(qna==null)
		{
			return "/authError";
		}
		model.addAttribute("qna",qna);
		return "/qna/qnaDetail";
	}
}
