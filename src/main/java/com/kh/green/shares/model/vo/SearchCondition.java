package com.kh.green.shares.model.vo;

public class SearchCondition {
	private String writer;
	private String title;
	private String content;
	private String tAndC;
	
	public SearchCondition() {}

	public SearchCondition(String writer, String title, String content, String tAndC) {
		super();
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.tAndC = tAndC;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
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

	public String gettAndC() {
		return tAndC;
	}

	public void settAndC(String tAndC) {
		this.tAndC = tAndC;
	}

	@Override
	public String toString() {
		return "SearchCondition [writer=" + writer + ", title=" + title + ", content=" + content + ", tAndC=" + tAndC
				+ "]";
	}

	

}