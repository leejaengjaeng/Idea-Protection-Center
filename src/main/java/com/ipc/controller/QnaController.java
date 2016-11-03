package com.ipc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
	//한 페이지에 나올 글 갯수 
	private final static int pagePerContents = 10;
	//페이지네이션 < 1,2,3,4,5 > 이거 갯수
	private final static int pagesPerView = 5;	
	

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
	public String qnaBoardDefault(Model model)
	{
		return qnaBoard(model,1);
	}
	
	@RequestMapping(value="/qnaBoard/{pageNum}")
	public String qnaBoard(Model model, @PathVariable int pageNum)
	{
		int totalContents = qnaDao.getTotalSize();
		
		int totalPages;
		if(totalContents%pagePerContents==0) totalPages= totalContents/pagePerContents;
		else totalPages = totalContents/pagePerContents+1;
		
		if(pageNum > totalPages || pageNum <= 0)
			return "redirect:/authError";
		
		int start;
		if(totalPages==1) start=0;
		else if(pageNum==totalPages) start = totalContents - 10; //마지막 페이지인 경우
		else start = (pageNum-1)*10;
	
		//페이지 선택 리스트에 나올값들 
		List<Integer> pages = new ArrayList();
		if(totalPages<5)
		{
			for(int i=1 ; i<=totalPages; i++)
				pages.add(i);
		}
		else
		{
			for(int i=pageNum ; i<=pagesPerView && i<=totalPages ; i++)
				pages.add(i);
		}
		
		//qna리스트 받아오기
		HashMap<String,Integer> startAndPPC = new HashMap<String,Integer>();
		startAndPPC.put("start",start);
		startAndPPC.put("pagePerContents",pagePerContents);
		List<QnaVo> qnaList=qnaDao.getQuestions(startAndPPC);
		
		//방향 표들 
		int leftArrow = (pageNum - pagesPerView)<0 ? 1:(pageNum - pagesPerView);
		int rightArrow = (pageNum + pagesPerView)>=totalPages ? totalPages : pageNum + pagesPerView;
		
		model.addAttribute("qnaList",qnaList);
		model.addAttribute("pages",pages);
		model.addAttribute("currentPage",pageNum);
		model.addAttribute("leftArrow",leftArrow);
		model.addAttribute("rightArrow",rightArrow);

		return "/qna/oneOnOne";
	}
	
	//질문 등록 페이지 처리 하기
	@RequestMapping(value="/regisOneQna",method=RequestMethod.POST)
	public String regisOneQna(QnaVo qv){
		RegistrationService rs=new RegistrationService();
		qv.setDate(rs.getToday(0));
		System.out.println(qv.getDate());
		qnaDao.addOneQuestion(qv);
		return "redirect:/qna/qnaBoard";
	}
	
	//질문 등록 페이지 띄우기
	@RequestMapping(value="/addOneQna")
	public String addOneQna(){
		return "/qna/addOneQna";
	}
	
	//질문에 댓글 달기
	@RequestMapping(value="/regisreply",method=RequestMethod.POST)
	public String regisreply(ReplyVo rv,HttpServletRequest request){
		System.out.println(rv.getQid());
		System.out.println(request.getParameter("qid"));
		qnaDao.addReply(rv);
		return "redirect:/qna/detail/"+rv.getQid();
	}
	
	//
	@RequestMapping(value="/regularQnaAdd",method=RequestMethod.GET)
	public String showAddRegularQuestion()
	{
		return "/qna/addRegularQna";
	}
	
	//
	@RequestMapping(value="/regularQnaAddProcess",method=RequestMethod.POST)
	public String addRegularQuestion(QnaVo qnaVo){
		
		qnaDao.addRegularQuestion(qnaVo);
		return "redirect:/IPC_admin/";

	}
}
