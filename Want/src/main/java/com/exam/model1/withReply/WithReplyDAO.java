package com.exam.model1.withReply;


import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.with.withTO;
import com.exam.model1.withReply.WithReplyTO;



@Repository
public class WithReplyDAO {

	@Autowired
	private SqlSession sqlSession;
	
	// 모댓글 작성
	public withTO WithWriteReply(WithReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
		
		withTO wto = new withTO();
		wto.setNo(to.getBno());
		
		// 해당 게시물의 reply를 +1 한다.
		sqlSession.update("with_reply_up", wto);
		
		// 현재 p_reply 테이블의 가장 큰 no값을 가져온다.
		int grp = sqlSession.selectOne("with_reply_max_no");
		
		// grp 세팅
		to.setGrp(grp+1);
		/* System.out.println(grp); */
		
		int result = sqlSession.insert("with_reply_write", to);

		int check = sqlSession.selectOne("with_reply_max_no");
		// grp를 현재 가장 큰 no 즉 방금 넣은 데이터의 no값로 세팅함
		to.setGrp(check);
		
		// no 와 grp가 다르면 grp를 no로 없데이트
		int check_update = sqlSession.update("with_reply_check", to);
		
		if (result == 1) {	// p_reply 테이블에 새로운 댓글 추가가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			wto = sqlSession.selectOne("with_reply_count", wto);
		}
		return wto;
	}
	
	// 답글 작성
	public withTO WithWriteReReply(WithReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
		withTO wto = new withTO();
		wto.setNo(to.getBno());
		
		// 해당 게시물의 reply를 +1 한다.
		sqlSession.update("with_reply_up", wto);
		
		// la_reply 테이블에 추가 (댓글 작성과 동일)
		int result = sqlSession.insert("with_rereply_write", to);
		
		if (result == 1) {	// la_reply 테이블에 새로운 댓글 추가가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			wto = sqlSession.selectOne("with_reply_count", wto);
		}
		return wto;
	}
	
	// 댓글 리스트
	public ArrayList<WithReplyTO> replyList(WithReplyTO to){
		
		ArrayList<WithReplyTO> replyList = new ArrayList();
		
		replyList = (ArrayList)sqlSession.selectList("with_replyList", to);
		
		return replyList;
	}
	
	// 모댓글 삭제
	public withTO With_DeleteReply(WithReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
		withTO wto = new withTO();
		wto.setNo(to.getBno());
		
		// grp가 reply의 no와 일치하는 댓글이 몇갠지 카운트한다. 모댓글에 딸린 답글이 몇갠지 카운트하기 위함
		int count_rereply = sqlSession.selectOne("with_count_rereply", to);
		
		int result = 0;
		
		// 해당 게시물의 reply를 -1 한다.
		sqlSession.update("with_reply_down", wto);
		
		if(count_rereply==0) {	// 답글이 없을 때 - 그냥 삭제
			// la_reply 테이블에서 삭제
			
			result = sqlSession.delete("with_reply_delete", to);
			
		}else {					// 답글이 있을 때 - content에 공백을 넣음 ("삭제된 게시물입니다" 라고 표기하기 위함)
			// la_reply 테이블에서 삭제하지 않고 content에 공백을 넣음 
			result = sqlSession.update("with_reply_not_delete", to);
			
		}
		
		if (result == 1) {	// p_reply 테이블에서 댓글삭제가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			wto = sqlSession.selectOne("with_reply_count", wto);
		}
		return wto;
	}
	
	// 답글 삭제
	public withTO With_DeleteReReply(WithReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
		withTO wto = new withTO();
		wto.setNo(to.getBno());
			
		// 해당 게시물의 reply를 -1 한다.
		sqlSession.update("with_reply_down", wto);
				
		// la_reply 테이블에서 삭제
		int result = sqlSession.delete("with_rereply_delete", to);
		
		// grp가  일치하는 답글이 몇갠지 카운트 한다. 없고 모댓글의 content가 ""이면 모댓글을 삭제하기 위함.
		int count_rereply = sqlSession.selectOne("with_count_rereply_fromrereply", to);
		
		/* System.out.println("count_rereply = " + count_rereply); */
		if(count_rereply == 0) {
			sqlSession.delete("with_reply_delete_after_rereply_delete", to);
		}
		
		if (result == 1) {	// la_reply 테이블에서 댓글삭제가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			wto = sqlSession.selectOne("with_reply_count", wto);
		}
		return wto;
	}
	
}
