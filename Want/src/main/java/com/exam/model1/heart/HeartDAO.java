package com.exam.model1.heart;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.picture.PictureTO;



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
	
	// 랜선여행 좋아
	public int lanTripSaveHeart(HeartTO to) {
		// p_board 테이블에 해당 게시물의 heart수를 +1 하기위한 to세팅
		LanTripTO lto = new LanTripTO();
		lto.setNo(to.getBno());
		sqlSession.update("lanTrip_heart_up", lto);
		
		// p_heart 테이블에 추가
		int flag = 1;

		int result = sqlSession.insert("lanTrip_heart_save", to); // nick이 들어가있
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}

	public int lanTripRemoveHeart(HeartTO to) {
		// p_board 테이블에 해당 게시물의 heart수를 -1 하기위한 to세팅
		LanTripTO lto = new LanTripTO();
		lto.setNo(to.getBno());
		sqlSession.update("lanTrip_heart_down", lto);
		
		// p_heart 테이블에서 삭제
		int flag = 1;

		int result = sqlSession.delete("lanTrip_heart_remove", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}
	
}
