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
	public AccomListTO accomList(AccomListTO listTO) {
		ArrayList<AccomTO> totalLists = (ArrayList)sqlSession.selectList( "accomList", listTO );
		
		// 페이지를 위한 기본 요소
		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage(); // 한페이지에 보이는 글의 개수 5개
		int BlockPerPage = listTO.getBlockPerPage(); // 한 화면에 보일 페이지의 수 3개

		// 총 글의 개수 얻기
		listTO.setTotalRecord( totalLists.size() );

		// 총 페이지 수 얻기
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);
		int skip = (cpage * recordPerPage) - recordPerPage;
		
		ArrayList<AccomTO> lists = new ArrayList<AccomTO>();
		
		for( int i=0; i<10; i++ ) {
			if( skip+i != totalLists.size() ) {
				AccomTO to = new AccomTO();
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
		listTO.setAccomLists( lists );
		
		
		listTO.setStartBlock(((cpage - 1) / BlockPerPage) * BlockPerPage + 1);
		listTO.setEndBlock(((cpage - 1) / BlockPerPage) * BlockPerPage + BlockPerPage);
		if (listTO.getEndBlock() >= listTO.getTotalPage()) {
			listTO.setEndBlock(listTO.getTotalPage());
		}

		return listTO;
	}
	
	//로그인 후 숙소 list
	public AccomListTO accomListLogin(AccomListTO listTO, AccomTO to) {

		ArrayList<AccomTO> totalLists = (ArrayList)sqlSession.selectList( "accomListLogin", to );
		
		// 페이지를 위한 기본 요소
		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage(); // 한페이지에 보이는 글의 개수 10개
		int BlockPerPage = listTO.getBlockPerPage(); // 한 화면에 보일 페이지의 수 3개

		// 총 글의 개수 얻기
		listTO.setTotalRecord( totalLists.size() );

		// 총 페이지 수 얻기
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);
		int skip = (cpage * recordPerPage) - recordPerPage;
		
		ArrayList<AccomTO> lists = new ArrayList<AccomTO>();
		
		for( int i=0; i<10; i++ ) {
			if( skip+i != totalLists.size() ) {
				AccomTO ato = new AccomTO();
				ato.setNo( totalLists.get(skip+i).getNo() );
				ato.setSubject( totalLists.get(skip+i).getSubject() );
				ato.setWriter( totalLists.get(skip+i).getWriter() );
				ato.setPicture( totalLists.get(skip+i).getPicture() );
				ato.setWdate( totalLists.get(skip+i).getWdate() );
				ato.setHit( totalLists.get(skip+i).getHit() );
				ato.setReply( totalLists.get(skip+i).getReply() );
				ato.setHeart( totalLists.get(skip+i).getHeart() );
				ato.setHno( totalLists.get(skip+i).getHno() );
				ato.setFno( totalLists.get(skip+i).getFno() );
				
				lists.add(ato);
				
			} else { break; }
		}
		listTO.setAccomLists( lists );
		
		
		listTO.setStartBlock(((cpage - 1) / BlockPerPage) * BlockPerPage + 1);
		listTO.setEndBlock(((cpage - 1) / BlockPerPage) * BlockPerPage + BlockPerPage);
		if (listTO.getEndBlock() >= listTO.getTotalPage()) {
			listTO.setEndBlock(listTO.getTotalPage());
		}

		return listTO;
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
