package com.exam.model1;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccomCommentDAO {

	@Autowired
	private SqlSession sqlSession;

	// 숙소 view comment write ok
	public int accomViewCommentOk(AccomCommentTO to) {
		int flag = 1;
		
		int result = sqlSession.insert( "accomViewCommentOk", to );
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}

	// 숙소 댓글 list
	public ArrayList<AccomCommentTO> accomListComment(AccomCommentTO to) {
		
		ArrayList<AccomCommentTO> commentLists = (ArrayList)sqlSession.selectList("accomListComment", to);
		
		return commentLists;
	}
	
}
