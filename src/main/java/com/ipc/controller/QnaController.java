package com.ipc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ipc.dao.QnaDao;
import com.ipc.service.RegistrationService;
import com.ipc.vo.QnaVo;
import com.ipc.vo.ReplyVo;

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
		List<QnaVo> replyList = qnaDao.getReplyByQid(qid);
		if(qna==null)
		{
			return "/authError";
		}
		model.addAttribute("qna",qna);
		model.addAttribute("replyList",replyList);
		return "/qna/qnaDetail";
	}

	@RequestMapping(value="/qnaBoard")
	public String qnaBoard(Model model){
		List<QnaVo> qnaList=qnaDao.getOneQuestions();
		model.addAttribute("qnaList",qnaList);
		return "/qna/oneOnOne";
	}
	@RequestMapping(value="/regisOneQna",method=RequestMethod.POST)
	public String regisOneQna(QnaVo qv){
		RegistrationService rs=new RegistrationService();
		qv.setDate(rs.getToday(0));
		System.out.println(qv.getDate());
		qnaDao.addOneQuestion(qv);
		return "redirect:/qna/qnaBoard";
	}
	@RequestMapping(value="/addOneQna")
	public String addOneQna(){
		return "/qna/addOneQna";
	}
	@RequestMapping(value="/regisreply",method=RequestMethod.POST)
	public String regisreply(ReplyVo rv){
		System.out.println(rv.getQid());
		System.out.println(rv.getContent());
		qnaDao.addReply(rv);
		return "/qna/detail/"+rv.getQid();
	}
	@RequestMapping(value="/regularQnaAdd",method=RequestMethod.GET)
	public String showAddRegularQuestion()
	{
		return "/qna/addRegularQna";
	}
	
	@RequestMapping(value="/regularQnaAddProcess",method=RequestMethod.POST)
	public String addRegularQuestion(QnaVo qnaVo){
		
		qnaDao.addRegularQuestion(qnaVo);
		return "redirect:/IPC_admin/";

	}
}
