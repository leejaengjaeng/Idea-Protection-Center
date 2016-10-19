package com.ipc.vo;

public class patientent_lawyerVo {
	int lid;
	char uid;
	String license_scan_img;
	String license_number;
	String major;
	String bank_name;
	String introduce;
	String account_number;
	public String getAccount_number() {
		return account_number;
	}
	public void setAccount_number(String account_number) {
		this.account_number = account_number;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public int getLid() {
		return lid;
	}
	public void setLid(int lid) {
		this.lid = lid;
	}
	public char getUid() {
		return uid;
	}
	public void setUid(char uid) {
		this.uid = uid;
	}
	public String getLicense_scan_img() {
		return license_scan_img;
	}
	public void setLicense_scan_img(String license_scan_img) {
		this.license_scan_img = license_scan_img;
	}
	public String getLicense_number() {
		return license_number;
	}
	public void setLicense_number(String license_number) {
		this.license_number = license_number;
	}
}
