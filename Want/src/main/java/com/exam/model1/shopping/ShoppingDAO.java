package com.exam.model1.shopping;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	public ShoppingListTO shopList(ShoppingListTO listTO) {

		ArrayList<ShoppingTO> totalLists = (ArrayList)sqlSession.selectList( "shopList", listTO );
		
		// 페이지를 위한 기본 요소
		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage(); // 한페이지에 보이는 글의 개수 10개
		int BlockPerPage = listTO.getBlockPerPage(); // 한 화면에 보일 페이지의 수 3개

		// 총 글의 개수 얻기
		listTO.setTotalRecord( totalLists.size() );

		// 총 페이지 수 얻기
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);
		int skip = (cpage * recordPerPage) - recordPerPage;
		
		ArrayList<ShoppingTO> lists = new ArrayList<ShoppingTO>();
		
		for( int i=0; i<10; i++ ) {
			if( skip+i != totalLists.size() ) {
				ShoppingTO to = new ShoppingTO();
				to.setNo( totalLists.get(skip+i).getNo() );
				to.setSubject( totalLists.get(skip+i).getSubject() );
				to.setWriter( totalLists.get(skip+i).getWriter() );
				to.setPicture( totalLists.get(skip+i).getPicture() );
				to.setWdate( totalLists.get(skip+i).getWdate() );
				to.setHit( totalLists.get(skip+i).getHit() );
				to.setWgap( totalLists.get(skip+i).getWgap() );
				to.setReply( totalLists.get(skip+i).getReply() );
				to.setHeart( totalLists.get(skip+i).getHeart() );
				
				lists.add(to);
				
			} else { break; }
		}
		listTO.setShopLists( lists );
		
		
		listTO.setStartBlock(((cpage - 1) / BlockPerPage) * BlockPerPage + 1);
		listTO.setEndBlock(((cpage - 1) / BlockPerPage) * BlockPerPage + BlockPerPage);
		if (listTO.getEndBlock() >= listTO.getTotalPage()) {
			listTO.setEndBlock(listTO.getTotalPage());
		}

		return listTO;
	}
	
	//로그인 후 쇼핑 list
	public ShoppingListTO shopListLogin(ShoppingListTO listTO, ShoppingTO to) {

		ArrayList<ShoppingTO> totalLists = (ArrayList)sqlSession.selectList( "shopListLogin", to );
		
		// 페이지를 위한 기본 요소
		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage(); // 한페이지에 보이는 글의 개수 10개
		int BlockPerPage = listTO.getBlockPerPage(); // 한 화면에 보일 페이지의 수 3개

		// 총 글의 개수 얻기
		listTO.setTotalRecord( totalLists.size() );

		// 총 페이지 수 얻기
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);
		int skip = (cpage * recordPerPage) - recordPerPage;
		
		ArrayList<ShoppingTO> lists = new ArrayList<ShoppingTO>();
		
		for( int i=0; i<10; i++ ) {
			if( skip+i != totalLists.size() ) {
				ShoppingTO sto = new ShoppingTO();
				sto.setNo( totalLists.get(skip+i).getNo() );
				sto.setSubject( totalLists.get(skip+i).getSubject() );
				sto.setWriter( totalLists.get(skip+i).getWriter() );
				sto.setPicture( totalLists.get(skip+i).getPicture() );
				sto.setWdate( totalLists.get(skip+i).getWdate() );
				sto.setHit( totalLists.get(skip+i).getHit() );
				sto.setReply( totalLists.get(skip+i).getReply() );
				sto.setHeart( totalLists.get(skip+i).getHeart() );
				sto.setHno( totalLists.get(skip+i).getHno() );
				sto.setFno( totalLists.get(skip+i).getFno() );
				
				lists.add(sto);
				
			} else { break; }
		}
		listTO.setShopLists( lists );
		
		
		listTO.setStartBlock(((cpage - 1) / BlockPerPage) * BlockPerPage + 1);
		listTO.setEndBlock(((cpage - 1) / BlockPerPage) * BlockPerPage + BlockPerPage);
		if (listTO.getEndBlock() >= listTO.getTotalPage()) {
			listTO.setEndBlock(listTO.getTotalPage());
		}

		return listTO;
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
	
}