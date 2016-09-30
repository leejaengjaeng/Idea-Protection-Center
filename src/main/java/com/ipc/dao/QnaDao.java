package com.ipc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ipc.vo.QnaVo;
import com.ipc.vo.adminNoticeVo;

@Mapper
public interface QnaDao {
	public List<QnaVo> getRegularQuestions();
	public void addRegularQuestion(QnaVo qnaVo);
	public QnaVo getQuestionByQid(int qid);

}
