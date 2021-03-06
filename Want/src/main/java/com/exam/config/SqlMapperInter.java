package com.exam.config;

import java.util.ArrayList;
import java.util.List;

import com.exam.model1.accom.AccomTO;
import com.exam.model1.accomComment.AccomCommentTO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.lantripApply.LanTripApplyTO;
import com.exam.model1.lantripReply.LanTripReplyTO;
import com.exam.model1.shopping.ShoppingTO;
import com.exam.model1.shoppingComment.ShoppingCommentTO;
import com.exam.model1.user.UserTO;
import com.exam.model1.with.withTO;


public interface SqlMapperInter {
	// mapper.xml의 sql 이름과 같게 선언해주기
	
	
	public abstract void signup(UserTO to);
	public abstract int signup_ok(UserTO to);
	
	public abstract void login(UserTO to);
	public abstract int login_ok(UserTO to);
	public abstract int login_lookup(UserTO to);
	
	
	
	public abstract int login_decry(UserTO to);
	
	public abstract void pwFind(UserTO to);
	public abstract int pwFind_ok(UserTO to);
	public abstract int pwFind_lookup(UserTO to);
	
	
	//============ 랜선여행신청 ============
	// list
	public abstract ArrayList<LanTripApplyTO> LanTripApplyList();
	
	// write
	public abstract int lanTrip_apply_write_ok(LanTripApplyTO to);
	
	// view
	public abstract void LanTrip_apply_View(LanTripApplyTO to);
	
	// delete
	public abstract int lanTrip_apply_delete_ok(LanTripApplyTO to);
	
	// modify
	public abstract void lanTrip_apply_modify(LanTripApplyTO to);
	public abstract int lanTrip_apply_modify_ok(LanTripApplyTO to);
	
	//============ 랜선여행 ============
	// list
	public abstract ArrayList<LanTripTO> lanTripList(LanTripTO to);
	// wirte
	public abstract void lanTrip_write(LanTripTO to);
	public abstract int lanTrip_write_ok(LanTripTO to);
	
	// modify
	public abstract void lanTrip_modify(LanTripTO to);
	public abstract int lanTrip_modify_ok(LanTripTO to);
	
	// delete
	public abstract int lanTrip_delete_ok(LanTripTO to);
	
	//view
	public abstract LanTripTO lanTrip_view(LanTripTO to);
	
	// view reply 
	public abstract int lanViewReply(LanTripTO to);
	
	// view hit 수 올리기
	public abstract int view_hit(LanTripTO to);
	
	// comment list
	public abstract ArrayList<LanTripReplyTO> lantripReplyList(LanTripReplyTO to);
	
	// comment write ok
	public abstract void lanTripReplyOk(LanTripReplyTO to);
	
	
	//============ 여행지관련 ============
	//===== 쇼핑관련 ======
	//쇼핑 write ok
	public abstract int shop_write_ok(ShoppingTO to);
	
	//로그인전 쇼핑 list
	public abstract ArrayList<ShoppingTO> shopList(ShoppingTO to);
	
	//로그인후 쇼핑 list
	public abstract ArrayList<ShoppingTO> shopListLogin(ShoppingTO to);
	
	//쇼핑 view
	public abstract ShoppingTO shopView(ShoppingTO to);
	
	//쇼핑 view reply 수 불러오기
	public abstract int shopViewReply(ShoppingTO to);
	
	//쇼핑 view hit 수 올리기
	public abstract int shopViewHit(ShoppingTO to);
	
	//쇼핑 comment list
	public abstract ArrayList<ShoppingCommentTO> shopListComment(ShoppingCommentTO to);
	
	//쇼핑 comment write ok
	public abstract void shopViewCommentOk(ShoppingCommentTO to);
	
	
	//===== 숙소관련 ======
	//숙소 write
	public abstract int accom_write_ok(AccomTO to);
	
	//숙소 list
	public abstract ArrayList<AccomTO> shopList(AccomTO to);
	
	//숙소 view
	public abstract AccomTO accomView(AccomTO to);
	
	//숙소 view reply 수 불러오기
	public abstract int accomViewReply(AccomTO to);
	
	//숙소 view hit 수 올리기
	public abstract int accomViewHit(AccomTO to);
	
	//숙소 comment list
	public abstract ArrayList<AccomCommentTO> accomListComment(AccomCommentTO to);
	
	//숙소 comment write ok
	public abstract void accomViewCommentOk(AccomCommentTO to);
	
	
	//============ 동행구해요 ============
	// list
	public abstract ArrayList<withTO> withList();
	
	// write
	public abstract int with_write_ok(withTO to);
	
	// view
	public abstract void with_view(withTO to);
	
	// delete
	public abstract int with_delete_ok(withTO to);
	
	// modify
	public abstract void with_modify(withTO to);
	public abstract int with_modify_ok(withTO to);	
	
	
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
