package com.exam.config;

import java.util.ArrayList;
import java.util.List;

import com.exam.model1.UserTO;

public interface SqlMapperInter {
	// mapper.xml의 sql 이름과 같게 선언해주기
	
	
	public abstract void signup(UserTO to);
	public abstract int signup_ok(UserTO to);
	
	public abstract void login(UserTO to);
	public abstract int login_ok(UserTO to);
	public abstract int login_lookup(UserTO to);
	
//	public abstract ArrayList<BoardTO> list();
//	public abstract void write(BoardTO to);
//	public abstract int write_ok(BoardTO to);
//	public abstract BoardTO view(BoardTO to);
//	public abstract BoardTO modify(BoardTO to);
//	public abstract int modify_ok(BoardTO to);
//	public abstract BoardTO delete(BoardTO to);
//	public abstract int delete_ok(BoardTO to);
//	public abstract ArrayList<BoardTO> clist(BoardTO to);
//	public abstract int cwrite_ok(BoardTO to);
}
