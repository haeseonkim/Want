package com.exam.model1.heart;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.accom.AccomTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.shopping.ShoppingTO;



@Repository
public class HeartDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int pictureSaveHeart(HeartTO to) {
		// p_board 테이블에 해당 게시물의 heart수를 +1 하기위한 to세팅
		PictureTO pto = new PictureTO();
		pto.setNo(to.getBno());
		sqlSession.update("picture_heart_up", pto);
		
		// p_heart 테이블에 추가
		int flag = 1;

		int result = sqlSession.insert("picture_heart_save", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}

	public int pictureRemoveHeart(HeartTO to) {
		// p_board 테이블에 해당 게시물의 heart수를 -1 하기위한 to세팅
		PictureTO pto = new PictureTO();
		pto.setNo(to.getBno());
		sqlSession.update("picture_heart_down", pto);
		
		// p_heart 테이블에서 삭제
		int flag = 1;

		int result = sqlSession.delete("picture_heart_remove", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}
	
	
	//========== 여행지관련 ==========
	//쇼핑
	public int shopSaveHeart(HeartTO to) {
		// s_board 테이블에 해당 게시물의 heart수를 +1 하기위한 to세팅
		ShoppingTO sto = new ShoppingTO();
		sto.setNo(to.getBno());
		sqlSession.update("shop_heart_up", sto);
		
		// s_heart 테이블에 추가
		int flag = 1;

		int result = sqlSession.insert("shop_heart_save", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}

	public int shopRemoveHeart(HeartTO to) {
		// s_board 테이블에 해당 게시물의 heart수를 -1 하기위한 to세팅
		PictureTO sto = new PictureTO();
		sto.setNo(to.getBno());
		sqlSession.update("shop_heart_down", sto);
		
		// s_heart 테이블에서 삭제
		int flag = 1;

		int result = sqlSession.delete("shop_heart_remove", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}
	
	//숙소
	public int accomSaveHeart(HeartTO to) {
		// a_board 테이블에 해당 게시물의 heart수를 +1 하기위한 to세팅
		AccomTO ato = new AccomTO();
		ato.setNo(to.getBno());
		sqlSession.update("accom_heart_up", ato);
		
		// a_heart 테이블에 추가
		int flag = 1;

		int result = sqlSession.insert("accom_heart_save", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}

	public int accomRemoveHeart(HeartTO to) {
		// a_board 테이블에 해당 게시물의 heart수를 -1 하기위한 to세팅
		AccomTO ato = new AccomTO();
		ato.setNo(to.getBno());
		sqlSession.update("accom_heart_down", ato);
		
		// a_heart 테이블에서 삭제
		int flag = 1;

		int result = sqlSession.delete("accom_heart_remove", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}
}