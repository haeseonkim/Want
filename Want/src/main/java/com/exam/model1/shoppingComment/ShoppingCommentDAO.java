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
	
	//기존에 있던 댓글중에서 부모 댓글과 같은 grp이고 부모 grps보다 큰 댓글들은 모두 grps를 1씩 늘려주는 메서드
	public int shopUpdateGrps(ShoppingCommentTO to) {
		int result = sqlSession.update( "shopUpdateGrps", to );
		return result;
	}
	
	//새로운 답글을 추가하는 메서드
	public int shopRereplyInsertOk(ShoppingCommentTO to) {
		int result = sqlSession.insert( "shopRereplyInsertOk", to );
		return result;
	}
	
	//댓글 삭제하는 메서드
	public int shopping_reply_deleteOk( ShoppingCommentTO to ) {
		int flag = 1;
		int result = sqlSession.delete( "shopping_reply_deleteOk", to );
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

}
