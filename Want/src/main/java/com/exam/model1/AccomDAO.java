package com.exam.model1;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	//숙소 list
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
	
	//숙소 view
	public AccomTO accomView( AccomTO to ) {
		
		sqlSession.update( "accomViewHit", to );
		sqlSession.update( "accomViewReply",to );
		to = sqlSession.selectOne( "accomView", to );
		
		return to;
	}
}
