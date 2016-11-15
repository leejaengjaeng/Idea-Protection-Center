package com.ipc.vo;

public class mainPageVo {
	int mprid;
	int rid;
	int uid;
	String reg_condition;
	String pre_apply_date;
	String apply_date;
	String registration_date;
	String title;
	String typeOfInvent;
	int lid;
	String lName;
	
	public String getlName() {
		return lName;
	}
	public void setlName(String lName) {
		this.lName = lName;
	}
	public int getLid() {
		return lid;
	}
	public void setLid(int lid) {
		this.lid = lid;
	}
	public String getTypeOfInvent() {
		return typeOfInvent;
	}
	public void setTypeOfInvent(String typeOfInvent) {
		this.typeOfInvent = typeOfInvent;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getMprid() {
		return mprid;
	}
	public void setMprid(int mprid) {
		this.mprid = mprid;
	}
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getRegistration_date() {
		return registration_date;
	}
	public void setRegistration_date(String registration_date) {
		this.registration_date = registration_date.split(" ")[0];
	}
	public String getReg_condition() {
		return reg_condition;
	}
	public void setReg_condition(String reg_condition) {
		this.reg_condition = reg_condition;
	}
	public String getPre_apply_date() {
		return pre_apply_date;
	}
	public void setPre_apply_date(String pre_apply_date){
		this.pre_apply_date = pre_apply_date.split(" ")[0];
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date.split(" ")[0];
	}
	
}
