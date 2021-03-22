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
	

	// list
	public LanTripListTO lanTripList(LanTripListTO listTO) {

		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();

		ArrayList<LanTripTO> lists = (ArrayList)sqlSession.selectList("lanTripList");

		listTO.setTotalRecord(lists.size());
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);

		int skip = (cpage - 1) * recordPerPage;

		ArrayList<LanTripTO> boardLists = new ArrayList();

		int cnt = 0;
		for (int i = skip; i < lists.size(); i++) {
			if (cnt == recordPerPage) {
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
}
