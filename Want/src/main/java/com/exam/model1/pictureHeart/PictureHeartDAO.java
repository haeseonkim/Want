package com.exam.model1.pictureHeart;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.picture.PictureTO;



@Repository
public class PictureHeartDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public PictureTO pictureSaveHeart(PictureHeartTO to) {
		// p_board 테이블에 해당 게시물의 heart수를 +1 하기위한 to세팅
		PictureTO pto = new PictureTO();
		pto.setNo(to.getBno());
		
		// 해당 게시물의 heart를 +1 한다.
		sqlSession.update("picture_heart_up", pto);
		
		// p_heart 테이블에 추가 
		int result = sqlSession.insert("picture_heart_save", to);
		
		if (result == 1) {	// p_heart 테이블에 새로운 좋아요 추가가 성공한다면..
			// 갱신된 하트 갯수를 가져옴
			pto = sqlSession.selectOne("picture_heart_count", pto);
		}
		return pto;
	}

	public PictureTO pictureRemoveHeart(PictureHeartTO to) {
		// p_board 테이블에 해당 게시물의 heart수를 -1 하기위한 to세팅
		PictureTO pto = new PictureTO();
		pto.setNo(to.getBno());
		
		// 해당 게시물의 heart를 -1 한다.
		sqlSession.update("picture_heart_down", pto);
		
		// p_heart 테이블에서 삭제
		int result = sqlSession.delete("picture_heart_remove", to);
		
		if (result == 1) {	// p_heart 테이블에 좋아요 삭제가 성공한다면..
			// 갱신된 하트 갯수를 가져옴
			pto = sqlSession.selectOne("picture_heart_count", pto);
		}
		return pto;
	}
}
