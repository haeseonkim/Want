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
public class UserDAO {

	@Autowired
	private SqlSession sqlSession;
	
	////login
	//회원있는지 여부 확인
	public Integer loginLookup( UserTO userTo ) {
		int result = sqlSession.selectOne( "login_lookup", userTo );
		return result;
	}
	
	//회원 비번 맞는지 확인
	public Integer loginOk( UserTO userTo ) {
		int result = sqlSession.selectOne( "login_ok", userTo );
		return result;
	}

	////pwFInd
	//회원있는지 여부 확인
	public Integer pwFindLookup( UserTO userTo ) {
		int result = sqlSession.selectOne( "pwFind_lookup", userTo );
		return result;
	}
	
	//회원 메일 맞는지 확인
	public Integer pwFindOk( UserTO userTo ) {
		int result = sqlSession.selectOne( "pwFind_ok", userTo );
		return result;
	}

	// writer - dao 통과 안해도됨
	public void boardWrite( UserTO userTo ) {
		
	}

	// writer_ok - flag 값있어야함
	public int boardWriteOk(LanTripTO to) {
		int flag = 1;

		int result = sqlSession.insert("write_ok", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}

	// list
	public LanTripListTO boardList(LanTripListTO listTO) {

		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();

		ArrayList<LanTripTO> lists = (ArrayList)sqlSession.selectList("list");

		listTO.setTotalRecord(lists.size());
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);

		int skip = (cpage - 1) * recordPerPage;
		
		ArrayList<LanTripTO> boardLists = new ArrayList();
		
		int cnt = 0;
		for (int i = skip; i < lists.size(); i++) {
			if(cnt == recordPerPage) {
				break;
			}
			if (lists.get(i) != null) {
				LanTripTO to = lists.get(i);
				boardLists.add(to);
			}
			cnt++;
		}

		listTO.setBoardList(boardLists);

		listTO.setStartBlock(((cpage - 1) / blockPerPage) * blockPerPage + 1);
		listTO.setEndBlock(((cpage - 1) / blockPerPage) * blockPerPage + blockPerPage);
		if (listTO.getEndBlock() >= listTO.getTotalPage()) {
			listTO.setEndBlock(listTO.getTotalPage());
		}

		return listTO;
	}

	// view
	public LanTripTO boardView(LanTripTO to) {
		sqlSession.update("view_hit", to);
		to = sqlSession.selectOne("view", to);

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

		int result = sqlSession.delete("delete_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}

		return flag;
	}

	// modify
	public LanTripTO boardModify(LanTripTO to) {
		LanTripTO board = sqlSession.selectOne("modify", to);

		return board;
	}

	// modify_ok
	public int boardModifyOk(LanTripTO to) {
		int flag = 2;
		int result = sqlSession.update("modify_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}

		return flag;
	}
	
	// 정현수 수정
	// signup_ok - flag 값있어야함
	public int signup_ok(UserTO to) {
		int flag = 1;

		int result = sqlSession.insert("signup_ok", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}
	// 정현수 수정 끝
}
