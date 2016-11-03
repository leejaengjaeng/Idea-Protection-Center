package com.ipc.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.QnaVo;
import com.ipc.vo.ReplyVo;
import com.ipc.vo.adminNoticeVo;

@Mapper
public interface QnaDao 
{
	public List<QnaVo> 	getRegularQuestions();
	public void 		addRegularQuestion(QnaVo qnaVo);
	public QnaVo 		getQuestionByQid(int qid);
	public void 		addOneQuestion(QnaVo qnaVo);
	public void 		addReply(ReplyVo rv);
	public List<QnaVo> 	getReplyByQid(int qid);
	
	//pagenation
	public List<QnaVo> 	getQuestions(HashMap<String,Integer> pageAndPagePerContents);	
	public int 			getTotalSize();
}
