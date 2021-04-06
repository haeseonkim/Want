package com.exam.model1.accomComment;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.accom.AccomTO;
import com.exam.model1.shopping.ShoppingTO;
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
	
	//기존에 있던 댓글중에서 부모 댓글과 같은 grp이고 부모 grpl(0)보다 자식 grps가 큰 댓글들은 모두 grps를 1씩 늘려준다.
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
		String no = to.getNo();
		String grp = to.getGrp();
		
		int result = 0;
		if( no.equals(grp) ) {	//부모 댓글일 경우 댓글번호랑 grp가 같다.
			//부모 댓글과 그 밑에 있는 자식댓글까지 모두 삭제
			result = sqlSession.delete( "accom_reply_deleteOk_parent", to );
		} else {
			result = sqlSession.delete( "accom_reply_deleteOk_child", to );
		}
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
	
	// ==========================내 프로필 숙소 부분 ===========================
	//  댓글 list
	public ArrayList<AccomCommentTO> accomReplyList(AccomCommentTO to) {
		ArrayList<AccomCommentTO> commentLists = (ArrayList)sqlSession.selectList("accomListComment", to);
		return commentLists;
	}
	
	//내프로필 - 댓글 추가하기
	public AccomTO accomWriteReply(AccomCommentTO to) {
		AccomTO ato = new AccomTO();
		ato.setNo( to.getBno() );
		
		// grp뺴고 나머지 컬럼값 저장
		int result = sqlSession.insert( "accomReplyOk", to );
		
		if( result == 1 ) {
			//현재 테이블에서 가장 높은 no값 가져오기
			String no = sqlSession.selectOne( "accom_noSelect" );
			to.setNo(no);
			to.setGrp(no);
			
			// 위에서 가져온 최근에 no값을 해당 no댓글의 grp에 update시켜주는 문장
			int result_grp = sqlSession.update( "accom_grpUpdate", to );
			
			if( result_grp == 1 ) {
				sqlSession.update( "accomViewReply", ato );
				ato = sqlSession.selectOne( "accom_reply_count", ato );
			}
		}
		return ato;
	}
	
	// 답글 작성
	public AccomTO accomWriteReReply(AccomCommentTO to) {
		AccomTO ato = new AccomTO();
		ato.setNo(to.getBno());
		
		// l_reply 테이블에 답글 내용 추가
		int result = sqlSession.insert("accomRereplyOk", to);
		
		if (result == 1) {	// l_reply 테이블에 새로운 댓글 추가가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			sqlSession.update( "accomViewReply", ato );
			ato = sqlSession.selectOne("accom_reply_count", ato);
		}
		return ato;
	}
	
	// 댓글 삭제하는 메서드(부모댓글 지우기)
	public AccomTO accomDeleteReply(AccomCommentTO to) {
		
		AccomTO ato = new AccomTO();
		String no = to.getBno();
		String grp = to.getGrp();
		ato.setNo(no);
		
		int result = 0;
		// 부모 댓글과 그 밑에 있는 자식댓글까지 모두 삭제
		result = sqlSession.delete("accom_reply_deleteOk_parent", to);

		System.out.println( "1. 댓글삭제 no확인중 : " + ato.getNo() );
		if (result != 0) {
			sqlSession.update( "accomViewReply", ato );
			ato = sqlSession.selectOne( "accom_reply_count", ato );
		}
		return ato;
	}
	
	// 댓글 삭제하는 메서드(자식댓글 지우기)
	public AccomTO accomDeleteRereply(AccomCommentTO to) {
		
		AccomTO ato = new AccomTO();
		String no = to.getBno();
		String grp = to.getGrp();
		ato.setNo(no);
		
		int result = 0;
		// 부모 댓글과 그 밑에 있는 자식댓글까지 모두 삭제
		System.out.println( "자식 지우기" );
		result = sqlSession.delete("accom_reply_deleteOk_child", to);

		
		if (result != 0) {
			sqlSession.update( "accomViewReply", ato );
			ato = sqlSession.selectOne( "accom_reply_count", ato );
		}
		return ato;
	}			
	
	

	
}
