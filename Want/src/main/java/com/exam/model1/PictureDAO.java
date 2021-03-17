package com.exam.model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.PictureListTO;
import com.exam.model1.PictureTO;

@Repository
public class PictureDAO {

	@Autowired
	private SqlSession sqlSession;

	// writer - dao 통과 안해도됨
	public void boardWrite() {
	}

	// writer_ok - flag 값 있어야함
	public int pictureWriteOk(PictureTO to) {
		int flag = 1;

		int result = sqlSession.insert("picture_write_ok", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}

	// list
	public PictureListTO boardList(PictureListTO listTO) {

		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();

		ArrayList<PictureTO> lists = (ArrayList)sqlSession.selectList("list");

		listTO.setTotalRecord(lists.size());
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);

		int skip = (cpage - 1) * recordPerPage;
		
		ArrayList<PictureTO> boardLists = new ArrayList();
		
		int cnt = 0;
		for (int i = skip; i < lists.size(); i++) {
			if(cnt == recordPerPage) {
				break;
			}
			if (lists.get(i) != null) {
				PictureTO to = lists.get(i);
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
	public PictureTO boardView(PictureTO to) {
		sqlSession.update("view_hit", to);
		to = sqlSession.selectOne("view", to);

		return to;
	}

	// delete
	public PictureTO boardDelete(PictureTO to) {
		PictureTO board = sqlSession.selectOne("delete", to);

		return board;
	}

	// delete_ok
	public int boardDeleteOk(PictureTO to) {
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
	public PictureTO boardModify(PictureTO to) {
		PictureTO board = sqlSession.selectOne("modify", to);

		return board;
	}

	// modify_ok
	public int boardModifyOk(PictureTO to) {
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
