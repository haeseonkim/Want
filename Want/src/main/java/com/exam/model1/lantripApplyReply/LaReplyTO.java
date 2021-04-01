package com.exam.model1.lantripApplyReply;

public class LaReplyTO {
	private String no;
	private String bno;	//	댓글이 속한 게시글 번호 (받아와야 하는 값)
	private int grp;	//	댓글 그룹 번호 (모댓글과 거기에 속한 대댓글은 같은 grp를 가짐)
	private int grps;	//	그룹 내 댓글 순서 (오래된글 ~ 최신글  오름차순)
	private int grpl;	//	그룹내 댓글 깊이(댓글인지 대댓글인지)
	private String writer;
	private String content;
	private String wdate;
	
	// wdate과 현재시간의 차이를 계산후 받아오기 위함
	private String wgap;
	
	// writer의 프로필사진을 가져온다.
	private String profile;
	
	
	public String getWgap() {
		return wgap;
	}
	public void setWgap(String wgap) {
		this.wgap = wgap;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getBno() {
		return bno;
	}
	public void setBno(String bno) {
		this.bno = bno;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public int getGrps() {
		return grps;
	}
	public void setGrps(int grps) {
		this.grps = grps;
	}
	public int getGrpl() {
		return grpl;
	}
	public void setGrpl(int grpl) {
		this.grpl = grpl;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
}
