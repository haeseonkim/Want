package com.exam.model1.shoppingComment;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import com.exam.model1.lantrip.LanTripListTO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.lantripReply.LanTripReplyTO;
import com.exam.model1.shopping.ShoppingTO;

@Repository
public class ShoppingCommentDAO {

	@Autowired
	private SqlSession sqlSession;

	// 쇼핑 view에서 댓글 추가하기
	public int shopViewCommentOk(ShoppingCommentTO to) {
		int flag = 1;
		
		//grp빼고 나머지 컬럼값 저장
		int result = sqlSession.insert( "shopViewCommentOk", to );
				
		if( result == 1 ) {
			String no = sqlSession.selectOne( "shop_noSelect" );
			to.setNo(no);
			to.setGrp(no);
			
			//위에서 가져온 최근에 no값을 해당 no댓글의 grp에 update시켜주는 문장
			int result_grp = sqlSession.update( "shop_grpUpdate", to );
			
			if( result_grp == 1 ) {
				flag = 0;
			}
		}
		return flag;
	}

	// 쇼핑 댓글 list
	public ArrayList<ShoppingCommentTO> shopListComment(ShoppingCommentTO to) {
		ArrayList<ShoppingCommentTO> commentLists = (ArrayList)sqlSession.selectList("shopListComment", to);
		return commentLists;
	}
	
	
	// 부모글의 grp, grps, grpl 가져오는 메서드
	public ShoppingCommentTO shopParentSelect(ShoppingCommentTO to) {
		ShoppingCommentTO commentTo = sqlSession.selectOne( "shopParentSelect", to );
		return commentTo;
	}
	
	//기존에 있던 댓글중에서 부모 댓글과 같은 grp이고 부모 grpl(0)보다 자식 grps가 큰 댓글들은 모두 grps를 1씩 늘려준다.
	public int shopUpdateGrps(ShoppingCommentTO to) {
		int result = sqlSession.update( "shopUpdateGrps", to );
		return result;
	}
	
	//새로운 답글을 추가하는 메서드
	public int shopRereplyInsertOk(ShoppingCommentTO to) {
		int result = sqlSession.insert( "shopRereplyInsertOk", to );
		return result;
	}
	
	//댓글 삭제하는 메서드(부모댓글 지우기와 자식댓글 지우기)
	public int shopping_reply_deleteOk( ShoppingCommentTO to ) {
		int flag = 1;
		String no = to.getNo();
		String grp = to.getGrp();
		
		int result = 0;
		if( no.equals(grp) ) {	//부모 댓글일 경우 댓글번호랑 grp가 같다.
			//부모 댓글과 그 밑에 있는 자식댓글까지 모두 삭제
			result = sqlSession.delete( "shopping_reply_deleteOk_parent", to );
		} else {
			result = sqlSession.delete( "shopping_reply_deleteOk_child", to );
		}
		if( result != 0 ) {
			flag = 0;
		}
		return flag;
	}
	
	//댓글 수정하는 메서드
	public int shopping_reply_modifyOk( ShoppingCommentTO to ) {
		int flag = 1;
		int result = sqlSession.update( "shopping_reply_modifyOk", to );
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}

	
	// ==========================내 프로필 쇼핑 부분 ===========================
	// 쇼핑 댓글 list
	public ArrayList<ShoppingCommentTO> shopReplyList(ShoppingCommentTO to) {
		ArrayList<ShoppingCommentTO> commentLists = (ArrayList)sqlSession.selectList("shopListComment", to);
		return commentLists;
	}
	
	//내프로필 - 댓글 추가하기
	public ShoppingTO shopWriteReply(ShoppingCommentTO to) {
		ShoppingTO sto = new ShoppingTO();
		sto.setNo( to.getBno() );
		
		// grp뺴고 나머지 컬럼값 저장
		int result = sqlSession.insert( "shopReplyOk", to );
		
		if( result == 1 ) {
			//현재 테이블에서 가장 높은 no값 가져오기
			String no = sqlSession.selectOne( "shop_noSelect" );
			to.setNo(no);
			to.setGrp(no);
			
			// 위에서 가져온 최근에 no값을 해당 no댓글의 grp에 update시켜주는 문장
			int result_grp = sqlSession.update( "shop_grpUpdate", to );
			
			if( result_grp == 1 ) {
				sqlSession.update( "shopViewReply", sto );
				sto = sqlSession.selectOne( "shop_reply_count", sto );
			}
		}
		return sto;
	}
	
	// 댓글 삭제하는 메서드(부모댓글 지우기)
	public ShoppingTO shopDeleteReply(ShoppingCommentTO to) {
		
		ShoppingTO sto = new ShoppingTO();
		String no = to.getBno();
		String grp = to.getGrp();
		sto.setNo(no);
		
		int result = 0;
		// 부모 댓글과 그 밑에 있는 자식댓글까지 모두 삭제
		result = sqlSession.delete("shop_reply_deleteOk_parent", to);

		System.out.println( "1. 댓글삭제 no확인중 : " + sto.getNo() );
		if (result != 0) {
			sqlSession.update( "shopViewReply", sto );
			sto = sqlSession.selectOne( "shop_reply_count", sto );
		}
		return sto;
	}
	
	// 댓글 삭제하는 메서드(자식댓글 지우기)
	public ShoppingTO shopDeleteRereply(ShoppingCommentTO to) {
		
		ShoppingTO sto = new ShoppingTO();
		String no = to.getBno();
		String grp = to.getGrp();
		sto.setNo(no);
		
		int result = 0;
		// 부모 댓글과 그 밑에 있는 자식댓글까지 모두 삭제
		System.out.println( "자식 지우기" );
		result = sqlSession.delete("shop_reply_deleteOk_child", to);

		
		if (result != 0) {
			sqlSession.update( "shopViewReply", sto );
			sto = sqlSession.selectOne( "shop_reply_count", sto );
		}
		return sto;
	}			
	
	
	// 답글 작성
	public ShoppingTO shopWriteReReply(ShoppingCommentTO to) {
		ShoppingTO sto = new ShoppingTO();
		sto.setNo(to.getBno());
		
		// l_reply 테이블에 답글 내용 추가
		int result = sqlSession.insert("shopRereplyOk", to);
		
		if (result == 1) {	// l_reply 테이블에 새로운 댓글 추가가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			sqlSession.update( "shopViewReply", sto );
			sto = sqlSession.selectOne("shop_reply_count", sto);
		}
		return sto;
	}
}
