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
public class LanTripApplyDAO {

	@Autowired
	private SqlSession sqlSession;

	// writer - dao 통과 안해도됨
	public void boardWrite() {
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
	   public LanTripApplyListTO boardList(LanTripApplyListTO listTO) {

	      int cpage = listTO.getCpage();
	      int recordPerPage = listTO.getRecordPerPage();
	      int blockPerPage = listTO.getBlockPerPage();
	      
	      // LanTripApplyTO의 내용을 배열로 가져옴 										mapper의 id, SqlMapper 변수명(?)과 동일
	      ArrayList<LanTripApplyTO> lists = (ArrayList)sqlSession.selectList("LanTripApplyList");
	      
	      listTO.setTotalRecord(lists.size());
	      listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);

	      int skip = (cpage - 1) * recordPerPage;
	      
	      ArrayList<LanTripApplyTO> boardLists = new ArrayList();
	      
	      int cnt = 0;
	      for (int i = skip; i < lists.size(); i++) {
	         if(cnt == recordPerPage) {
	            break;
	         }
	         if (lists.get(i) != null) {
	        	 LanTripApplyTO to = lists.get(i);
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
}
