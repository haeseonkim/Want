package com.exam.model1.accom;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.shopping.ShoppingListTO;
import com.exam.model1.shopping.ShoppingTO;


@Repository
public class AccomDAO {
	@Autowired
	private SqlSession sqlSession;
	
	//숙소 write
	public Integer accom_write_ok( AccomTO accomTo ) {
		int flag = 1;
		
		int result = sqlSession.insert( "accom_write_ok", accomTo );
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}
	
	//로그인 아닐 때 숙소 list
	public ArrayList<AccomTO> accomList(AccomTO to) {

		ArrayList<AccomTO> list = (ArrayList)sqlSession.selectList( "accomList", to );

		return list;
	}
	
	//로그인 후 숙소 list
	public ArrayList<AccomTO> accomListLogin(AccomTO to) {

		ArrayList<AccomTO> list = (ArrayList)sqlSession.selectList( "accomListLogin", to );
		
		return list;
	}
	
	// 게시물 갯수 가져오기
	public int accomCount(AccomTO to) {
		
		// 게시물 갯수를 구한다.
		// 검색 키워드가 들어온 경우 검색결과의 게시물갯수가 된다.
		int result = sqlSession.selectOne("accom_count", to);
		
		return result;
	}
	
	//로그인 아닐 때 숙소 view
	public AccomTO accomView( AccomTO to ) {
		
		sqlSession.update( "accomViewHit", to );
		sqlSession.update( "accomViewReply",to );
		to = sqlSession.selectOne( "accomView", to );
		
		return to;
	}
	
	//로그인일 때 숙소 view
	public AccomTO accomViewLogin( AccomTO to ) {
		
		sqlSession.update( "accomViewHit", to );
		sqlSession.update( "accomViewReply",to );
		to = sqlSession.selectOne( "accomViewLogin", to );
		
		return to;
	}
	
	//숙소 delete
	public int accomDelete( AccomTO to ) {
		
		int flag = 1;	//delete 실패시
		int result = sqlSession.delete( "accomDelete", to );
		
		if( result == 0 ) {	}	//sql delete문 실패시
		else if( result == 1 ) {	//sql delete문 성공시
			flag = 0;	//delete 성공시
		}
		
		return flag;
	}
	
	//숙소 modify_ok
	public int accomModifyOk( AccomTO to ) {
		
		int flag = 1;	//modify 실패시
		int result = sqlSession.update( "accomModifyOk", to );
		
		if( result == 0 ) {	}	//sql update문 실패시
		else if( result == 1 ) {	//sql update문 성공시
			flag = 0;	//modify 성공시
		}
		
		return flag;
	}
}
