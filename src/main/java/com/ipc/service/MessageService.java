package com.ipc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ipc.dao.MessageDao;
import com.ipc.vo.MessageVo;
import com.ipc.vo.RegistrationPatentVo;

@Service
public class MessageService {
	@Autowired
	MessageDao messagemapper;
	
	public List<MessageVo> getMessageList(String uid){
		return messagemapper.getMessageVoList(uid);
	}
	public List<MessageVo> getMessageListPL(String uid){
		return messagemapper.getMessageVoListPL(uid);
	}
	
	//결제대기
	public void payWait(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoInventor(rv,payWait(rv.getTitle())));
	}
	//변리사검토-발명가
	public void reviewLawerInventor(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoInventor(rv,reviewLawerInventor(rv.getTitle())));
	}
	//변리사검토-변리사
	public void reviewLawerPL(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoPL(rv,reviewLawerPL(rv.getTitle())));
	}
	//발명가수정중-발명가
	public void editInventor(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoInventor(rv,editInventor(rv.getTitle())));
	}
	//발명가수정중-변리사
	public void editPL(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoPL(rv,editPL(rv.getTitle())));
	}
	//최종 작성본-발명가
	public void editCompleteInventor(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoInventor(rv,editCompleteInventor(rv.getTitle())));
	}
	//최종 작성본-변리사
	public void editCompletePL(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoPL(rv,editCompletePL(rv.getTitle())));
	}
	//발명가 출원 승인-발명가
	public void assignInventor(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoInventor(rv,assignInventor(rv.getTitle())));
	}
	//발명가 출원 승인-변리사
	public void assignPL(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoPL(rv,assignPL(rv.getTitle())));
	}
	//필요서류 준비중-발명가
	public void uploadDocumentInventor(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoInventor(rv,uploadDocumentInventor(rv.getTitle())));
	}
	//필요서류 준비중-변리사
	public void uploadDocumentPL(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoPL(rv,uploadDocumentPL(rv.getTitle())));
	}
	//출원중-방명가
	public void applyingInventor(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoInventor(rv,applyingInventor(rv.getTitle())));
	}
	//출원중-변리사
	public void applyingPL(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoPL(rv,applyingPL(rv.getTitle())));
	}
	//출원완료-발명가
	public void completeApplyInventor(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoInventor(rv,completeApplyInventor(rv.getTitle())));
	}
	//출원완료-변리사
	public void completeApplyPL(RegistrationPatentVo rv){
		messagemapper.insertMessage(makeMessageVoPL(rv,completeApplyPL(rv.getTitle())));
	}
	
	private MessageVo makeMessageVoInventor(RegistrationPatentVo rv,String content){
		MessageVo mv=new MessageVo();
		mv.setContent(content);
		mv.setDate(rv.getRegistration_date());
		mv.setRid(Integer.toString(rv.getRid()));
		mv.setUid(Integer.toString(rv.getUid()));
		return mv;
	}
	private MessageVo makeMessageVoPL(RegistrationPatentVo rv,String content){
		MessageVo mv=new MessageVo();
		mv.setContent(content);
		mv.setDate(rv.getRegistration_date());
		mv.setRid(Integer.toString(rv.getRid()));
		mv.setUid(Integer.toString(rv.getLid()));
		return mv;
	}
	private  String payWait(String title){
		return title+"에 대해 진행하시려면 결제를 진행해주세요";
	}
	private  String payComplete(String title){
		return title+"에 대해 결제가 완료되었습니다.";
	}
	private  String reviewLawerInventor(String title){
		return title+"에 대해 변리사 검토중입니다.";
	}
	private  String reviewLawerPL(String title){
		return title+"에 대한 코멘트 작성 요청이 있습니다.";
	}
	private  String editInventor(String title){
		return title+"에 대한 수정 요청이 왔습니다.";
	}
	private  String editPL(String title){
		return title+"에 대해 발명가 수정중입니다.";
	}
	private  String editCompleteInventor(String title){
		return title+"에 대해 최종 작성본을 확인해주세요.";
	}
	private  String editCompletePL(String title){
		return title+"에 대해 최종 작성본을 발명가가 확인중입니다.";
	}
	private  String assignInventor(String title){
		return title+"의 출원에 대한 최종승인을 요청드립니다.";
	}
	private  String assignPL(String title){
		return title+"에 대해 최종승인을 기다리는 중입니다.";
	}
	private  String uploadDocumentInventor(String title){
		return title+"에 대해 출원시 필요서류를 업로드 해주세요";
	}
	private  String uploadDocumentPL(String title){
		return title+"에 대한 필요서류에 대한 최종 확인 후 다음 단계를 진행해주세요";
	}
	private  String applyingInventor(String title){
		return title+"에 대해 출원중입니다.";
	}
	public  String applyingPL(String title){
		return title+"에 대한 출원 절차를 진행해주세요. 절차를 진행하신 후에 출원서를 업로드 해주시길 바랍니다.";
	}
	public  String completeApplyInventor(String title){
		return title+"에 대한 특허출원이 완료되었습니다. 특허 출원서를 다운로드 받으세요";
	}
	public  String completeApplyPL(String title){
		return title+"에 대한 출원서 업로드가 완료되었습니다.";
	}
}
