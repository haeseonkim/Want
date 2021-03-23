package com.exam.model1.pictureReply;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.pictureReply.ReplyTO;



@Repository
public class ReplyDAO {

	@Autowired
	private SqlSession sqlSession;
	
	
}
