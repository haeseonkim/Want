package com.exam.model1.lantrip;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.lantrip.LanTripListTO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.picture.PictureTO;

@Repository
public class LanTripDAO {

	@Autowired
	private SqlSession sqlSession;

	// writer - dao 통과 안해도됨
	public void boardWrite() {
	}

	// writer_ok - flag 값있어야함
	public int boardWriteOk(LanTripTO to) {
		int flag = 1;

		int result = sqlSession.insert("lanTrip_write_ok", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}
	


	// list (비로그인)
	public ArrayList<LanTripTO> boardLists(LanTripTO to) {

//		int cpage = to.get
//		int recordPerPage = to.getRecordPerPage();
//		int blockPerPage = to.getBlockPerPage();
		
		// 게시물 리스트 가져오기
		ArrayList<LanTripTO> lists = (ArrayList)sqlSession.selectList("lanTripList", to);

//		listTO.setTotalRecord(lists.size());
//		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);
//
//		int skip = (cpage - 1) * recordPerPage;

//		ArrayList<LanTripTO> boardLists = new ArrayList();
//
//		int cnt = 0;
//		for (int i = skip; i < lists.size(); i++) {
//			if (cnt == recordPerPage) {
//				break;
//			}
//			if (lists.get(i) != null) {
//				LanTripTO to = lists.get(i);
//				boardLists.add(to);
//			}
//			cnt++;
//		}
//
//		listTO.setBoardList(boardLists);
//
//		listTO.setStartBlock(((cpage - 1) / blockPerPage) * blockPerPage + 1);
//		listTO.setEndBlock(((cpage - 1) / blockPerPage) * blockPerPage + blockPerPage);
//		if (listTO.getEndBlock() >= listTO.getTotalPage()) {
//			listTO.setEndBlock(listTO.getTotalPage());
//		}

		return lists;
	}


	// list(로그인)
	public ArrayList<LanTripTO> lanTripListLogin(LanTripTO to) {

//		int cpage = listTO.getCpage();
//		int recordPerPage = listTO.getRecordPerPage();
//		int blockPerPage = listTO.getBlockPerPage();
		
		// 게시물 리스트 가져오기
		ArrayList<LanTripTO> lists = (ArrayList)sqlSession.selectList( "lanTrip_list_login", to );
//		
//		listTO.setTotalRecord(lists.size());
//		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);
//
//		int skip = (cpage - 1) * recordPerPage;
//
//		ArrayList<LanTripTO> boardLists = new ArrayList();
//
//		int cnt = 0;
//		for (int i = skip; i < lists.size(); i++) {
//			if (cnt == recordPerPage) {
//				break;
//			}
//			if (lists.get(i) != null) {
//				LanTripTO to1 = lists.get(i);
//				boardLists.add(to1);
//			}
//			cnt++;
//		}
//
//		listTO.setBoardList(boardLists);
//
//		listTO.setStartBlock(((cpage - 1) / blockPerPage) * blockPerPage + 1);
//		listTO.setEndBlock(((cpage - 1) / blockPerPage) * blockPerPage + blockPerPage);
//		if (listTO.getEndBlock() >= listTO.getTotalPage()) {
//			listTO.setEndBlock(listTO.getTotalPage());
//		}

		return lists;
	}
	
	
	// 게시물 갯수 가져오기
	public int LanTripCount(LanTripTO to) {
		
		// 게시물 갯수를 구한다.
		// 검색 키워드가 들어온 경우 검색결과의 게시물갯수가 된다.
		int result = sqlSession.selectOne("lantrip_count", to);
		
		return result;
	}
	
	// view
	public LanTripTO boardView(LanTripTO to) {
		sqlSession.update("view_hit", to);
		sqlSession.update("lanViewReply", to);
		to = sqlSession.selectOne("lanTrip_view", to);

		return to;
	}

	// delete
	public LanTripTO boardDelete(LanTripTO to) {
		LanTripTO board = sqlSession.selectOne("delete", to);

		return board;
	}

	// delete_ok
	public int boardDeleteOk(LanTripTO to) {
		int flag = 2;

		int result = sqlSession.delete("lanTrip_delete_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}

		return flag;
	}

	// modify
	public LanTripTO boardModify(LanTripTO to) {
		LanTripTO board = sqlSession.selectOne("lanTrip_modify", to);

		return board;
	}

	// modify_ok
	public int boardModifyOk(LanTripTO to) {
		int flag = 2;
		int result = sqlSession.update("lanTrip_modify_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}

		return flag;
	}
	// 베스트5 list
		public ArrayList<LanTripTO> bestList() {

			ArrayList<LanTripTO> bestList = (ArrayList) sqlSession.selectList("best_lantrip_list");
			System.out.println(bestList);
			
			return bestList;
		}
		
	//마이페이지 favorite 목록
	public ArrayList<LanTripTO> favoriteList( LanTripTO to ) {
		
		ArrayList<LanTripTO> list = (ArrayList)sqlSession.selectList( "favoriteList", to ); 
		
		return list;
	}
}
