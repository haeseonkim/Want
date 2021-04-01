package com.exam.model1.lantripHeart;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.accom.AccomTO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.shopping.ShoppingTO;

@Repository
public class LantripHeartDAO {

	@Autowired
	private SqlSession sqlSession;

	public LanTripTO lanTripSaveHeart(LantripHeartTO to) {
		// l_board 테이블에 해당 게시물의 heart수를 +1 하기위한 to세팅
		LanTripTO lto = new LanTripTO();
		lto.setNo(to.getBno());
		sqlSession.update("lanTrip_heart_up", lto);

		//l_heart에 로우 추가
		int result = sqlSession.insert("lanTrip_heart_save", to); // nick이 들어가있
		if (result == 1) {	//insert가 성공한다면 갱신된 하트수를 가져온다.
			lto = sqlSession.selectOne( "lanTripHeartCount", lto );
		}
		return lto;
	}

	public LanTripTO lanTripRemoveHeart(LantripHeartTO to) {
		// l_board 테이블에 해당 게시물의 heart수를 -1 하기위한 to세팅
		LanTripTO lto = new LanTripTO();
		lto.setNo(to.getBno());
		sqlSession.update("lanTrip_heart_down", lto);

		//l_heart에 로우 삭제
		int result = sqlSession.delete("lanTrip_heart_remove", to);
		if (result == 1) {	//delete가 성공한다면 갱신된 하트수를 가져온다.
			lto = sqlSession.selectOne( "lanTripHeartCount", lto );
		}
		return lto;
	}
	

}
