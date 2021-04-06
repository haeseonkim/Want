package com.exam.model1.lantripReply;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.pictureReply.ReplyTO;


@Repository
public class LanTripReplyDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 랜선여행 view에서 댓글 추가하기
	public int lanTripReplyOk(LanTripReplyTO to) {
		int flag = 1;
		
		// grp뺴고 나머지 컬럼값 저장
		int result = sqlSession.insert( "lanTripReplyOk", to );
		
		if( result == 1 ) {
			String no = sqlSession.selectOne( "lan_noSelect" );
			to.setNo(no);
			to.setGrp(no);
			
			// 위에서 가져온 최근에 no값을 해당 no댓글의 grp에 update시켜주는 문장
			int result_grp = sqlSession.update( "lan_grpUpdate", to );
			
			if( result_grp == 1 ) {
				flag = 0;
			}
		}
		return flag;
	}

	// 랜선여행 댓글 list
	public ArrayList<LanTripReplyTO> lantripReplyList(LanTripReplyTO to) {
		ArrayList<LanTripReplyTO> rLists = (ArrayList)sqlSession.selectList("lantripReplyList", to);
		return rLists;
	}
	
	// 부모글의 grp, grps, grpl 가져오는 메서드
	public LanTripReplyTO lanParentSelect(LanTripReplyTO to) {
		LanTripReplyTO replyTo = sqlSession.selectOne( "lanParentSelect", to);
		return replyTo;
	}
	
	//기존에 있던 댓글중에서 부모 댓글과 같은 grp이고 부모 grpl(0)보다 자식 grps가 큰 댓글들은 모두 grps를 1씩 늘려준다.
	public int lanUpdateGrps(LanTripReplyTO to) {
		int result = sqlSession.update( "lanUpdateGrps", to );
		return result;
		}
		
	//새로운 답글을 추가하는 메서드
	public int lanRereplyInsertOk(LanTripReplyTO to) {
		int result = sqlSession.insert( "lanRereplyInsertOk", to );
		return result;
		}
		
		// 댓글 삭제하는 메서드(부모댓글 지우기와 자식댓글 지우기)
	public int lanTrip_reply_deleteOk(LanTripReplyTO to) {
		int flag = 1;
		String no = to.getNo();
		String grp = to.getGrp();

		int result = 0;
		if (no.equals(grp)) { // 부모 댓글일 경우 댓글번호랑 grp가 같다.
			// 부모 댓글과 그 밑에 있는 자식댓글까지 모두 삭제
			result = sqlSession.delete("lanTrip_reply_deleteOk_parent", to);
		} else {
			result = sqlSession.delete("lanTrip_reply_deleteOk_child", to);
		}
		if (result != 0) {
			flag = 0;
		}
		return flag;
	}

	// 댓글 수정하는 메서드
	public int lanTrip_reply_modifyOk(LanTripReplyTO to) {
		int flag = 1;
		int result = sqlSession.update("lanTrip_reply_modifyOk", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}
	
	
	// ==========================내 프로필 랜선여행 부분 ===========================
	//내프로필 - 댓글 추가하기
	public LanTripTO lantripWriteReply(LanTripReplyTO to) {
		LanTripTO lto = new LanTripTO();
		lto.setNo( to.getBno() );
		
		// grp뺴고 나머지 컬럼값 저장
		int result = sqlSession.insert( "lanTripReplyOk", to );
		
		if( result == 1 ) {
			//현재 테이블에서 가장 높은 no값 가져오기
			String no = sqlSession.selectOne( "lan_noSelect" );
			to.setNo(no);
			to.setGrp(no);
			
			// 위에서 가져온 최근에 no값을 해당 no댓글의 grp에 update시켜주는 문장
			int result_grp = sqlSession.update( "lan_grpUpdate", to );
			
			if( result_grp == 1 ) {
				sqlSession.update( "lanViewReply", lto );
				lto = sqlSession.selectOne( "lantrip_reply_count", lto );
			}
		}
		return lto;
	}
	
	// 댓글 삭제하는 메서드(부모댓글 지우기)
	public LanTripTO lantripDeleteReply(LanTripReplyTO to) {
		
		LanTripTO lto = new LanTripTO();
		String no = to.getBno();
		String grp = to.getGrp();
		lto.setNo(no);
		
		int result = 0;
		// 부모 댓글과 그 밑에 있는 자식댓글까지 모두 삭제
		result = sqlSession.delete("lanTrip_reply_deleteOk_parent", to);

		System.out.println( "1. 댓글삭제 no확인중 : " + lto.getNo() );
		if (result != 0) {
			sqlSession.update( "lanViewReply", lto );
			lto = sqlSession.selectOne( "lantrip_reply_count", lto );
		}
		return lto;
	}
	
	// 댓글 삭제하는 메서드(자식댓글 지우기)
	public LanTripTO lantripDeleteRereply(LanTripReplyTO to) {
		
		LanTripTO lto = new LanTripTO();
		String no = to.getBno();
		String grp = to.getGrp();
		lto.setNo(no);
		
		int result = 0;
		// 부모 댓글과 그 밑에 있는 자식댓글까지 모두 삭제
		System.out.println( "자식 지우기" );
		result = sqlSession.delete("lanTrip_reply_deleteOk_child", to);

		
		if (result != 0) {
			sqlSession.update( "lanViewReply", lto );
			lto = sqlSession.selectOne( "lantrip_reply_count", lto );
		}
		return lto;
	}			
	
	
	// 답글 작성
	public LanTripTO lantripWriteReReply(LanTripReplyTO to) {
		LanTripTO lto = new LanTripTO();
		lto.setNo(to.getBno());
		
		// l_reply 테이블에 답글 내용 추가
		int result = sqlSession.insert("lanTripRereplyOk", to);
		
		if (result == 1) {	// l_reply 테이블에 새로운 댓글 추가가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			sqlSession.update( "lanViewReply", lto );
			lto = sqlSession.selectOne("lantrip_reply_count", lto);
		}
		return lto;
	}
	

	
	
}

