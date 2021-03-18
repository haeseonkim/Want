package com.exam.model1;

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

import com.exam.model1.LanTripListTO;
import com.exam.model1.LanTripTO;

@Repository
public class ShoppingCommentDAO {

	@Autowired
	private SqlSession sqlSession;

	// 쇼핑 view comment write ok
	public int shopViewCommentOk(ShoppingCommentTO to) {
		int flag = 1;
		
		int result = sqlSession.insert( "shopViewCommentOk", to );
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}

	// 쇼핑 댓글 list
	public ArrayList<ShoppingCommentTO> shopListComment(ShoppingCommentTO to) {
		
		ArrayList<ShoppingCommentTO> commentLists = (ArrayList)sqlSession.selectList("shopListComment", to);
		
		return commentLists;
	}
	
	

}
