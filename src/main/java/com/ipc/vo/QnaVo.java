package com.ipc.vo;


public class QnaVo {
	private int qid;
	private String title;
	private String content;
	private String date;
	private String del_pw;
	private String uid;
	private String isRegular;
	private String id;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getIsRegular() {
		return isRegular;
	}
	public void setIsRegular(String isRegular) {
		this.isRegular = isRegular;
	}
	public String getDel_pw() {
		return del_pw;
	}
	public void setDel_pw(String del_pw) {
		this.del_pw = del_pw;
	}
	public int getQid() {
		return qid;
	}
	public void setQid(int qid) {
		this.qid = qid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
