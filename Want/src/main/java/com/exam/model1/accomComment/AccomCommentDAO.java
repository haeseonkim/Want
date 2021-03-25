package com.exam.model1.accomComment;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.shoppingComment.ShoppingCommentTO;

@Repository
public class AccomCommentDAO {

	@Autowired
	private SqlSession sqlSession;

	// 숙소 view에서 댓글 추가하기
	public int accomViewCommentOk(AccomCommentTO to) {
		int flag = 1;
		
		//grp빼고 나머지 컬럼값 저장
		int result = sqlSession.insert( "accomViewCommentOk", to );
				
		if( result == 1 ) {
			String no = sqlSession.selectOne( "accom_noSelect" );
			to.setNo(no);
			to.setGrp(no);
			
			//위에서 가져온 최근에 no값을 해당 no댓글의 grp에 update시켜주는 문장
			int result_grp = sqlSession.update( "accom_grpUpdate", to );
			
			if( result_grp == 1 ) {
				flag = 0;
			}
		}
		return flag;
	}

	// 숙소 댓글 list
	public ArrayList<AccomCommentTO> accomListComment(AccomCommentTO to) {
		ArrayList<AccomCommentTO> commentLists = (ArrayList)sqlSession.selectList("accomListComment", to);
		return commentLists;
	}
	
	// 부모글의 grp, grps, grpl 가져오는 메서드
	public AccomCommentTO accomParentSelect(AccomCommentTO to) {
		AccomCommentTO commentTo = sqlSession.selectOne( "accomParentSelect", to );
		return commentTo;
	}
	
	//기존에 있던 댓글중에서 부모 댓글과 같은 grp이고 부모 grps보다 큰 댓글들은 모두 grps를 1씩 늘려주는 메서드
	public int accomUpdateGrps(AccomCommentTO to) {
		int result = sqlSession.update( "accomUpdateGrps", to );
		return result;
	}
	
	//새로운 답글을 추가하는 메서드
	public int accomRereplyInsertOk(AccomCommentTO to) {
		int result = sqlSession.insert( "accomRereplyInsertOk", to );
		return result;
	}
	
	//댓글 삭제하는 메서드
	public int accom_reply_deleteOk( AccomCommentTO to ) {
		int flag = 1;
		int result = sqlSession.delete( "accom_reply_deleteOk", to );
		if( result != 0 ) {
			flag = 0;
		}
		return flag;
	}
	
	//댓글 수정하는 메서드
	public int accom_reply_modifyOk( AccomCommentTO to ) {
		int flag = 1;
		int result = sqlSession.update( "accom_reply_modifyOk", to );
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}		
	
}