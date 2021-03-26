package com.exam.model1.accomHeart;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.accom.AccomTO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.shopping.ShoppingTO;



@Repository
public class AccomHeartDAO {

	@Autowired
	private SqlSession sqlSession;
	
	//숙소
	public int accomSaveHeart(AccomHeartTO to) {
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

	public int accomRemoveHeart(AccomHeartTO to) {
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
