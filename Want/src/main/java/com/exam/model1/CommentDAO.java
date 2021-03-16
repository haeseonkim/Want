package com.exam.model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.LanTripListTO;
import com.exam.model1.LanTripTO;

@Repository
public class CommentDAO {

	@Autowired
	private SqlSession sqlSession;

	// writer_ok - flag 값있어야함
	public int commentWriteOk(CommentTO cto) {
		int flag = 1;

		sqlSession.update("comment_update", cto);		
		int result = sqlSession.insert("cwrite_ok", cto);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}

	// list
	public ArrayList<CommentTO> commentList(LanTripTO to) {

		ArrayList<CommentTO> commentLists = (ArrayList)sqlSession.selectList("clist", to);
		
		return commentLists;
	}

}
