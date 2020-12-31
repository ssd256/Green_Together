package com.kh.green.alarm.model.vo;

import java.sql.Date;

public class Alarm {
	private int alarmNo;
	private String alarmTitle;
	private String alarmContent;
	private String alarmType;
	private Date alarmDate;
	private String alarmIsread;
	private String alarmURL;
	private int bNo;
	private String userId;
	private String alarmStatus;
	
	public Alarm() {
		// TODO Auto-generated constructor stub
	}

	public Alarm(int alarmNo, String alarmTitle, String alarmContent, String alarmType, Date alarmDate,
			String alarmIsread, String alarmURL, int bNo, String userId, String alarmStatus) {
		super();
		this.alarmNo = alarmNo;
		this.alarmTitle = alarmTitle;
		this.alarmContent = alarmContent;
		this.alarmType = alarmType;
		this.alarmDate = alarmDate;
		this.alarmIsread = alarmIsread;
		this.alarmURL = alarmURL;
		this.bNo = bNo;
		this.userId = userId;
		this.alarmStatus = alarmStatus;
	}

	public int getAlarmNo() {
		return alarmNo;
	}

	public void setAlarmNo(int alarmNo) {
		this.alarmNo = alarmNo;
	}

	public String getAlarmTitle() {
		return alarmTitle;
	}

	public void setAlarmTitle(String alarmTitle) {
		this.alarmTitle = alarmTitle;
	}

	public String getAlarmContent() {
		return alarmContent;
	}

	public void setAlarmContent(String alarmContent) {
		this.alarmContent = alarmContent;
	}

	public String getAlarmType() {
		return alarmType;
	}

	public void setAlarmType(String alarmType) {
		this.alarmType = alarmType;
	}

	public Date getAlarmDate() {
		return alarmDate;
	}

	public void setAlarmDate(Date alarmDate) {
		this.alarmDate = alarmDate;
	}

	public String getAlarmIsread() {
		return alarmIsread;
	}

	public void setAlarmIsread(String alarmIsread) {
		this.alarmIsread = alarmIsread;
	}

	public String getAlarmURL() {
		return alarmURL;
	}

	public void setAlarmURL(String alarmURL) {
		this.alarmURL = alarmURL;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAlarmStatus() {
		return alarmStatus;
	}

	public void setAlarmStatus(String alarmStatus) {
		this.alarmStatus = alarmStatus;
	}

	@Override
	public String toString() {
		return "Alarm [alarmNo=" + alarmNo + ", alarmTitle=" + alarmTitle + ", alarmContent=" + alarmContent
				+ ", alarmType=" + alarmType + ", alarmDate=" + alarmDate + ", alarmIsread=" + alarmIsread
				+ ", alarmURL=" + alarmURL + ", bNo=" + bNo + ", userId=" + userId + ", alarmStatus=" + alarmStatus
				+ "]";
	}
}
	