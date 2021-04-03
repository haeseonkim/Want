package com.exam.model1.picture;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.picture.PictureListTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.pictureReply.ReplyTO;
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
	public ArrayList<PictureTO> boardList(PictureTO to) {

		// 게시물 리스트 가져오기
		ArrayList<PictureTO> list = (ArrayList) sqlSession.selectList("picture_list", to);
		
		return list;
	}

	// 로그인 후 게시판 list
	public ArrayList<PictureTO> boardListLogin(PictureTO to) {

		
		System.out.println("location : " + to.getLocation());
		
		//게시물 리스트 가져오기 - 현재사용자의 nick이 nick에 세팅된 to를 넘긴다.
		ArrayList<PictureTO> list = (ArrayList) sqlSession.selectList("picture_list_login", to);
				
		return list;
	}
	
	// 게시물 갯수 가져오기
	public int PictureCount(PictureTO to) {
		
		// 게시물 갯수를 구한다.
		// 검색 키워드가 들어온 경우 검색결과의 게시물갯수가 된다.
		int result = sqlSession.selectOne("picture_count", to);
		
		return result;
	}

	// 베스트5 list
	public ArrayList<PictureTO> bestList(PictureTO to) {

		ArrayList<PictureTO> bestList = (ArrayList) sqlSession.selectList("best_picture_list", to);
		//System.out.println(bestList);
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
	public PictureTO pictureModify(PictureTO to) {
		PictureTO board = sqlSession.selectOne("picture_modify", to);

		return board;
	}

	// modify_ok
	public int pictureModifyOk(PictureTO to) {
		int flag = 2;
		int result = sqlSession.update("picture_modify_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}

		return flag;
	}
	
	// delete_ok
	public int pictureDeleteOk(String no) {
		int flag = 2;
		PictureTO to = new PictureTO();
		to.setNo(no);
		int result = sqlSession.delete("picture_delete_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}
		return flag;
	}
	
	// 마이페이지 - 즐겨찾기 목록 글목록 가져오는 함수
	public ArrayList<PictureTO> picture_favoriteList( PictureTO pto ) {
		
		ArrayList<PictureTO> list = (ArrayList)sqlSession.selectList( "picture_favoriteList", pto );
		
		return list;
	}
}
