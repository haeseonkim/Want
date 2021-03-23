package com.exam.model1.picture;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.picture.PictureListTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.user.UserTO;

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

	// 로그인 전 게시판 list
	public PictureListTO boardList(PictureListTO listTO) {

		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();

		// 현재 사용자 id가 담긴 uto 사용
		ArrayList<PictureTO> lists = (ArrayList) sqlSession.selectList("picture_list");

		listTO.setTotalRecord(lists.size());
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);

		int skip = (cpage - 1) * recordPerPage;

		ArrayList<PictureTO> boardLists = new ArrayList();
		
		int cnt = 0;
		for (int i = skip; i < lists.size(); i++) {
			if (cnt == recordPerPage) {
				break;
			}
			if (lists.get(i) != null) {
				PictureTO pto = lists.get(i);
				boardLists.add(pto);
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

	// 로그인 후 게시판 list
	public PictureListTO boardListLogin(PictureListTO listTO, PictureTO to) {

		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();

		// 현재 사용자 id가 담긴 uto 사용
		ArrayList<PictureTO> lists = (ArrayList)sqlSession.selectList("picture_list_login", to);

		listTO.setTotalRecord(lists.size());
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);

		int skip = (cpage - 1) * recordPerPage;

		ArrayList<PictureTO> boardLists = new ArrayList();

		int cnt = 0;
		for (int i = skip; i < lists.size(); i++) {
			if (cnt == recordPerPage) {
				break;
			}
			if (lists.get(i) != null) {
				PictureTO pto = lists.get(i);
				boardLists.add(pto);
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

	// 베스트5 list
	public ArrayList<PictureTO> bestList() {

		ArrayList<PictureTO> bestList = (ArrayList) sqlSession.selectList("best_picture_list");
		System.out.println(bestList);
		return bestList;
	}

	// view
	public PictureTO boardView(PictureTO to) {
		// hit 수 증가
		sqlSession.update("picture_view_hit", to);
		
		// 해당 게시물 정보가져오기 - list에서 다 가져오게 해서 사실상 필요없어졌지만 그냥 놔둠
		to = sqlSession.selectOne("picture_view", to);

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
