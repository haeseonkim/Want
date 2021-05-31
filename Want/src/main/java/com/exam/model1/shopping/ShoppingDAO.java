package com.exam.model1.shopping;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.picture.PictureTO;

@Repository
public class ShoppingDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	//쇼핑 write_ok
	public Integer shopping_write_ok( ShoppingTO shopTo ) {
		int flag = 1;
		
		int result = sqlSession.insert( "shop_write_ok", shopTo );
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}
	
	//로그인 아닐 때 쇼핑 list
	public ArrayList<ShoppingTO> shopList(ShoppingTO to) {

		ArrayList<ShoppingTO> list = (ArrayList)sqlSession.selectList( "shopList", to );

		return list;
	}
	
	//로그인 후 쇼핑 list
	public ArrayList<ShoppingTO> shopListLogin(ShoppingTO to) {

		ArrayList<ShoppingTO> list = (ArrayList)sqlSession.selectList( "shopListLogin", to );
		
		return list;
	}
	
	// 게시물 갯수 가져오기
	public int shopCount(ShoppingTO to) {
		
		// 게시물 갯수를 구한다.
		// 검색 키워드가 들어온 경우 검색결과의 게시물갯수가 된다.
		int result = sqlSession.selectOne("shop_count", to);
		
		return result;
	}
	
	
	//로그인 아닐 때 쇼핑 view
	public ShoppingTO shopView( ShoppingTO to ) {
		
		sqlSession.update( "shopViewHit", to );
		sqlSession.update( "shopViewReply",to );
		to = sqlSession.selectOne( "shopView", to );
		
		return to;
	}
	
	//로그인일 때 쇼핑 view
	public ShoppingTO shopViewLogin( ShoppingTO to ) {
		
		sqlSession.update( "shopViewHit", to );
		sqlSession.update( "shopViewReply",to );
		to = sqlSession.selectOne( "shopViewLogin", to );
		
		return to;
	}
	
	
	//쇼핑 delete
	public int shopDeleteOk( ShoppingTO to ) {
		
		int flag = 1;	//delete 실패시
		int result = sqlSession.delete( "shopDeleteOk", to );
		
		if( result == 0 ) {	}	//sql delete문 실패시
		else if( result == 1 ) {	//sql delete문 성공시
			flag = 0;	//delete 성공시
		}
		
		return flag;
	}
	
	// modify
	public ShoppingTO shopModify(ShoppingTO to) {
		ShoppingTO board = sqlSession.selectOne("shop_modify", to);

		return board;
	}
	
	
	//쇼핑 modify_ok
	public int shopModifyOk( ShoppingTO to ) {
		
		int flag = 1;	//modify 실패시
		int result = sqlSession.update( "shopModifyOk", to );
		
		if( result == 0 ) {	}	//sql update문 실패시
		else if( result == 1 ) {	//sql update문 성공시
			flag = 0;	//modify 성공시
		}
		
		return flag;
	}
	
	//마이페이지 즐겨찾기 쇼핑게시판 출력
	public ArrayList<ShoppingTO> shop_favoriteList( ShoppingTO sto ) {
		
		ArrayList<ShoppingTO> list = (ArrayList)sqlSession.selectList( "shop_favoriteList", sto );
		
		return list;
	}
	
	
	
	
	// 내프로필 랜선여행하기 글목록
	public ArrayList<ShoppingTO> shop_MyProfileList(ShoppingTO to) {

		ArrayList<ShoppingTO> list = (ArrayList) sqlSession.selectList("shop_MyProfileList", to);

		return list;
	}

	// 내프로필 - 게시물 갯수 가져오기
	public int profileShopCount(ShoppingTO sto) {

		// 게시물 갯수를 구한다.
		// 검색 키워드가 들어온 경우 검색결과의 게시물갯수가 된다.
		int result = sqlSession.selectOne("profileShopCount", sto);

		return result;
	}
	
	
}
