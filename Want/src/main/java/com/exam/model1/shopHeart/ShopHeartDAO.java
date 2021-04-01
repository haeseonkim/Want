package com.exam.model1.shopHeart;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.accom.AccomTO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.shopping.ShoppingTO;



@Repository
public class ShopHeartDAO {

	@Autowired
	private SqlSession sqlSession;
	
	
	//========== 여행지관련 ==========
	//쇼핑
	public ShoppingTO shopSaveHeart(ShopHeartTO to) {
		// s_board 테이블에 해당 게시물의 heart수를 +1 하기위한 to세팅
		ShoppingTO sto = new ShoppingTO();
		sto.setNo(to.getBno());
		sqlSession.update("shop_heart_up", sto);
		
		// s_heart 테이블에 추가
		int result = sqlSession.insert("shop_heart_save", to);
		if (result == 1) {
			sto = sqlSession.selectOne( "shopHeartCount", sto );
		}
		return sto;
	}


	public ShoppingTO shopRemoveHeart(ShopHeartTO to) {
		// s_board 테이블에 해당 게시물의 heart수를 -1 하기위한 to세팅
		ShoppingTO sto = new ShoppingTO();
		sto.setNo(to.getBno());
		sqlSession.update("shop_heart_down", sto);
		
		// s_heart 테이블에서 삭제
		int result = sqlSession.delete("shop_heart_remove", to);
		if (result == 1) {
			sto = sqlSession.selectOne( "shopHeartCount", sto );
		}
		return sto;
	}
	

}
