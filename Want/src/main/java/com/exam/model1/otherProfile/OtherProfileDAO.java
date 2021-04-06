package com.exam.model1.otherProfile;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.accom.AccomTO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.lantripReply.LanTripReplyTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.pictureReply.ReplyTO;
import com.exam.model1.shopping.ShoppingTO;

@Repository
public class OtherProfileDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// ================================= 랜선여행 ================================ 
	
	// 랜선여행 리스트 
	public ArrayList<LanTripTO> lantripList (LanTripTO to){
		
		
		ArrayList<LanTripTO> lantripList = new ArrayList();
		
		System.out.println("dao nick: " + to.getNick());
		
		if(to.getNick().equals("")) {
			System.out.println("if");
			lantripList = (ArrayList)sqlSession.selectList("other_lanTrip_list_notlogin", to);
		}else {
			System.out.println("else");
			lantripList = (ArrayList)sqlSession.selectList("other_lanTrip_list", to);
		}
		
		return lantripList;
	}
	
	public LanTripTO lanTripWriteReply(ReplyTO to){
		// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
		LanTripTO lto = new LanTripTO();
		lto.setNo(to.getBno());

		// 해당 게시물의 reply를 +1 한다.
		sqlSession.update("lantrip_reply_up", lto);

		// 현재 p_reply 테이블의 가장 큰 no값을 가져온다.
		int grp = sqlSession.selectOne("l_reply_max_no");

		// grp 세팅
		to.setGrp(grp + 1);

		int result = sqlSession.insert("other_lantrip_reply_write", to);

		int check = sqlSession.selectOne("l_reply_max_no");
		// grp를 현재 가장 큰 no 즉 방금 넣은 데이터의 no값로 세팅함
		to.setGrp(check);

		// no 와 grp가 다르면 grp를 no로 없데이트
		int check_update = sqlSession.update("other_lantrip_reply_check", to);

		if (result == 1) { // p_reply 테이블에 새로운 댓글 추가가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			lto = sqlSession.selectOne("lantrip_reply_count", lto);
		}
		return lto;
	}
	
	// 댓글 리스트
	public ArrayList<ReplyTO> lanTripReplyList(ReplyTO to) {

		ArrayList<ReplyTO> replyList = new ArrayList();

		replyList = (ArrayList) sqlSession.selectList("other_lantrip_replyList", to);

		return replyList;
	}
	
	// 답글 작성
	public LanTripTO lantripWriteReReply(ReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
		LanTripTO lto = new LanTripTO();
		lto.setNo(to.getBno());

		// 해당 게시물의 reply를 +1 한다.
		sqlSession.update("lantrip_reply_up", lto);

		// l_reply 테이블에 추가 (댓글 작성과 동일)
		int result = sqlSession.insert("other_lantrip_rereply_write", to);

		if (result == 1) { // p_reply 테이블에 새로운 댓글 추가가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			lto = sqlSession.selectOne("lantrip_reply_count", lto);
		}
		return lto;
	}
	

	// 모댓글 삭제
	public LanTripTO lantripDeleteReply(ReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
		LanTripTO lto = new LanTripTO();
		lto.setNo(to.getBno());

		// grp가 reply의 no와 일치하는 댓글이 몇갠지 카운트한다. 모댓글에 딸린 답글이 몇갠지 카운트하기 위함
		int count_rereply = sqlSession.selectOne("other_lantrip_count_rereply", to);

		int result = 0;

		// 해당 게시물의 reply를 -1 한다.
		sqlSession.update("lantrip_reply_down", lto);

		if (count_rereply == 0) { // 답글이 없을 때 - 그냥 삭제
			// p_reply 테이블에서 삭제
			result = sqlSession.delete("other_lantrip_reply_delete", to);
		} else { // 답글이 있을 때 - content에 공백을 넣음 ("삭제된 게시물입니다" 라고 표기하기 위함)
			// p_reply 테이블에서 삭제하지 않고 content에 공백을 넣음
			result = sqlSession.update("other_lantrip_reply_not_delete", to);
		}

		if (result == 1) { // p_reply 테이블에서 댓글삭제가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			lto = sqlSession.selectOne("lantrip_reply_count", lto);
		}
		return lto;
	}

	// 답글 삭제
	public LanTripTO lantripDeleteReReply(ReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
		LanTripTO lto = new LanTripTO();
		lto.setNo(to.getBno());

		// 해당 게시물의 reply를 -1 한다.
		sqlSession.update("lantrip_reply_down", lto);

		// p_reply 테이블에서 삭제
		int result = sqlSession.delete("other_lantrip_reply_delete", to);

		// grp가 일치하는 답글이 몇갠지 카운트 한다. 없고 모댓글의 content가 ""이면 모댓글을 삭제하기 위함.
		int count_rereply = sqlSession.selectOne("other_lantrip_count_rereply_fromrereply", to);

		System.out.println("count_rereply = " + count_rereply);
		if (count_rereply == 0) {
			sqlSession.delete("other_lantrip_reply_delete_after_rereply_delete", to);
		}

		if (result == 1) { // p_reply 테이블에서 댓글삭제가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			lto = sqlSession.selectOne("lantrip_reply_count", lto);
		}
		return lto;
	}
	
	
	
	
	// ================================= 사진 자랑 ================================

	// 랜선여행 리스트
	public ArrayList<PictureTO> pictureList(PictureTO to) {

		ArrayList<PictureTO> pictureList = new ArrayList();

		System.out.println("dao nick: " + to.getNick());

		if (to.getNick().equals("")) {
			System.out.println("if");
			pictureList = (ArrayList) sqlSession.selectList("other_picture_list_notlogin", to);
		} else {
			System.out.println("else");
			pictureList = (ArrayList) sqlSession.selectList("other_picture_list", to);
		}

		return pictureList;
	}

	public PictureTO pictureWriteReply(ReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
		PictureTO pto = new PictureTO();
		pto.setNo(to.getBno());

		// 해당 게시물의 reply를 +1 한다.
		sqlSession.update("picture_reply_up", pto);

		// 현재 p_reply 테이블의 가장 큰 no값을 가져온다.
		int grp = sqlSession.selectOne("p_reply_max_no");

		// grp 세팅
		to.setGrp(grp + 1);

		int result = sqlSession.insert("other_picture_reply_write", to);

		int check = sqlSession.selectOne("p_reply_max_no");
		// grp를 현재 가장 큰 no 즉 방금 넣은 데이터의 no값로 세팅함
		to.setGrp(check);

		// no 와 grp가 다르면 grp를 no로 없데이트
		int check_update = sqlSession.update("other_picture_reply_check", to);

		if (result == 1) { // p_reply 테이블에 새로운 댓글 추가가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			pto = sqlSession.selectOne("picture_reply_count", pto);
		}
		return pto;
	}

	// 댓글 리스트
	public ArrayList<ReplyTO> pictureReplyList(ReplyTO to) {

		ArrayList<ReplyTO> replyList = new ArrayList();

		replyList = (ArrayList) sqlSession.selectList("other_picture_replyList", to);

		return replyList;
	}

	// 답글 작성
	public PictureTO pictureWriteReReply(ReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
		PictureTO pto = new PictureTO();
		pto.setNo(to.getBno());

		// 해당 게시물의 reply를 +1 한다.
		sqlSession.update("picture_reply_up", pto);

		// l_reply 테이블에 추가 (댓글 작성과 동일)
		int result = sqlSession.insert("other_picture_rereply_write", to);

		if (result == 1) { // p_reply 테이블에 새로운 댓글 추가가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			pto = sqlSession.selectOne("picture_reply_count", pto);
		}
		return pto;
	}

	// 모댓글 삭제
	public PictureTO pictureDeleteReply(ReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
		PictureTO pto = new PictureTO();
		pto.setNo(to.getBno());

		// grp가 reply의 no와 일치하는 댓글이 몇갠지 카운트한다. 모댓글에 딸린 답글이 몇갠지 카운트하기 위함
		int count_rereply = sqlSession.selectOne("other_picture_count_rereply", to);

		int result = 0;

		// 해당 게시물의 reply를 -1 한다.
		sqlSession.update("picture_reply_down", pto);

		if (count_rereply == 0) { // 답글이 없을 때 - 그냥 삭제
			// p_reply 테이블에서 삭제
			result = sqlSession.delete("other_picture_reply_delete", to);
		} else { // 답글이 있을 때 - content에 공백을 넣음 ("삭제된 게시물입니다" 라고 표기하기 위함)
			// p_reply 테이블에서 삭제하지 않고 content에 공백을 넣음
			result = sqlSession.update("other_picture_reply_not_delete", to);
		}

		if (result == 1) { // p_reply 테이블에서 댓글삭제가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			pto = sqlSession.selectOne("picture_reply_count", pto);
		}
		return pto;
	}

	// 답글 삭제
	public PictureTO pictureDeleteReReply(ReplyTO to) {
		// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
		PictureTO pto = new PictureTO();
		pto.setNo(to.getBno());

		// 해당 게시물의 reply를 -1 한다.
		sqlSession.update("picture_reply_down", pto);

		// p_reply 테이블에서 삭제
		int result = sqlSession.delete("other_picture_reply_delete", to);

		// grp가 일치하는 답글이 몇갠지 카운트 한다. 없고 모댓글의 content가 ""이면 모댓글을 삭제하기 위함.
		int count_rereply = sqlSession.selectOne("other_picture_count_rereply_fromrereply", to);

		System.out.println("count_rereply = " + count_rereply);
		if (count_rereply == 0) {
			sqlSession.delete("other_picture_reply_delete_after_rereply_delete", to);
		}

		if (result == 1) { // p_reply 테이블에서 댓글삭제가 성공한다면..
			// 갱신된 댓글 갯수를 가져옴
			pto = sqlSession.selectOne("picture_reply_count", pto);
		}
		return pto;
	}
	
	
	// ================================= 쇼핑정보 ================================ 
	
		// 랜선여행 리스트 
		public ArrayList<ShoppingTO> shoppingList (ShoppingTO to){
			
			
			ArrayList<ShoppingTO> shoppingList = new ArrayList();
			
			System.out.println("dao nick: " + to.getNick());
			
			if(to.getNick().equals("")) {
				System.out.println("if");
				shoppingList = (ArrayList)sqlSession.selectList("other_shopping_list_notlogin", to);
			}else {
				System.out.println("else");
				shoppingList = (ArrayList)sqlSession.selectList("other_shopping_list", to);
			}
			
			return shoppingList;
		}
		
		public ShoppingTO shoppingWriteReply(ReplyTO to){
			// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
			ShoppingTO sto = new ShoppingTO();
			sto.setNo(to.getBno());

			// 해당 게시물의 reply를 +1 한다.
			sqlSession.update("shopping_reply_up", sto);

			// 현재 p_reply 테이블의 가장 큰 no값을 가져온다.
			int grp = sqlSession.selectOne("s_reply_max_no");

			// grp 세팅
			to.setGrp(grp + 1);

			int result = sqlSession.insert("other_shopping_reply_write", to);

			int check = sqlSession.selectOne("s_reply_max_no");
			// grp를 현재 가장 큰 no 즉 방금 넣은 데이터의 no값로 세팅함
			to.setGrp(check);

			// no 와 grp가 다르면 grp를 no로 없데이트
			int check_update = sqlSession.update("other_shopping_reply_check", to);

			if (result == 1) { // p_reply 테이블에 새로운 댓글 추가가 성공한다면..
				// 갱신된 댓글 갯수를 가져옴
				sto = sqlSession.selectOne("shopping_reply_count", sto);
			}
			return sto;
		}
		
		// 댓글 리스트
		public ArrayList<ReplyTO> shoppingReplyList(ReplyTO to) {

			ArrayList<ReplyTO> replyList = new ArrayList();

			replyList = (ArrayList) sqlSession.selectList("other_shopping_replyList", to);

			return replyList;
		}
		
		// 답글 작성
		public ShoppingTO shoppingWriteReReply(ReplyTO to) {
			// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
			ShoppingTO sto = new ShoppingTO();
			sto.setNo(to.getBno());

			// 해당 게시물의 reply를 +1 한다.
			sqlSession.update("shopping_reply_up", sto);

			// l_reply 테이블에 추가 (댓글 작성과 동일)
			int result = sqlSession.insert("other_shopping_rereply_write", to);

			if (result == 1) { // p_reply 테이블에 새로운 댓글 추가가 성공한다면..
				// 갱신된 댓글 갯수를 가져옴
				sto = sqlSession.selectOne("shopping_reply_count", sto);
			}
			return sto;
		}
		

		// 모댓글 삭제
		public ShoppingTO shoppingDeleteReply(ReplyTO to) {
			// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
			ShoppingTO sto = new ShoppingTO();
			sto.setNo(to.getBno());

			// grp가 reply의 no와 일치하는 댓글이 몇갠지 카운트한다. 모댓글에 딸린 답글이 몇갠지 카운트하기 위함
			int count_rereply = sqlSession.selectOne("other_shopping_count_rereply", to);

			int result = 0;

			// 해당 게시물의 reply를 -1 한다.
			sqlSession.update("shopping_reply_down", sto);

			if (count_rereply == 0) { // 답글이 없을 때 - 그냥 삭제
				// p_reply 테이블에서 삭제
				result = sqlSession.delete("other_shopping_reply_delete", to);
			} else { // 답글이 있을 때 - content에 공백을 넣음 ("삭제된 게시물입니다" 라고 표기하기 위함)
				// p_reply 테이블에서 삭제하지 않고 content에 공백을 넣음
				result = sqlSession.update("other_shopping_reply_not_delete", to);
			}

			if (result == 1) { // p_reply 테이블에서 댓글삭제가 성공한다면..
				// 갱신된 댓글 갯수를 가져옴
				sto = sqlSession.selectOne("shopping_reply_count", sto);
			}
			return sto;
		}

		// 답글 삭제
		public ShoppingTO shoppingDeleteReReply(ReplyTO to) {
			// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
			ShoppingTO sto = new ShoppingTO();
			sto.setNo(to.getBno());

			// 해당 게시물의 reply를 -1 한다.
			sqlSession.update("shopping_reply_down", sto);

			// p_reply 테이블에서 삭제
			int result = sqlSession.delete("other_shopping_reply_delete", to);

			// grp가 일치하는 답글이 몇갠지 카운트 한다. 없고 모댓글의 content가 ""이면 모댓글을 삭제하기 위함.
			int count_rereply = sqlSession.selectOne("other_shopping_count_rereply_fromrereply", to);

			System.out.println("count_rereply = " + count_rereply);
			if (count_rereply == 0) {
				sqlSession.delete("other_shopping_reply_delete_after_rereply_delete", to);
			}

			if (result == 1) { // p_reply 테이블에서 댓글삭제가 성공한다면..
				// 갱신된 댓글 갯수를 가져옴
				sto = sqlSession.selectOne("shopping_reply_count", sto);
			}
			return sto;
		}
		
		
		
		// ================================= 숙소정보 ================================ 
		
			// 랜선여행 리스트 
			public ArrayList<AccomTO> accomList (AccomTO to){
				
				
				ArrayList<AccomTO> accomList = new ArrayList();
				
				System.out.println("dao nick: " + to.getNick());
				
				if(to.getNick().equals("")) {
					System.out.println("if");
					accomList = (ArrayList)sqlSession.selectList("other_accom_list_notlogin", to);
				}else {
					System.out.println("else");
					accomList = (ArrayList)sqlSession.selectList("other_accom_list", to);
				}
				
				return accomList;
			}
			
			public AccomTO accomWriteReply(ReplyTO to){
				// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
				AccomTO sto = new AccomTO();
				sto.setNo(to.getBno());

				// 해당 게시물의 reply를 +1 한다.
				sqlSession.update("accom_reply_up", sto);

				// 현재 p_reply 테이블의 가장 큰 no값을 가져온다.
				int grp = sqlSession.selectOne("a_reply_max_no");

				// grp 세팅
				to.setGrp(grp + 1);

				int result = sqlSession.insert("other_accom_reply_write", to);

				int check = sqlSession.selectOne("a_reply_max_no");
				// grp를 현재 가장 큰 no 즉 방금 넣은 데이터의 no값로 세팅함
				to.setGrp(check);

				// no 와 grp가 다르면 grp를 no로 없데이트
				int check_update = sqlSession.update("other_accom_reply_check", to);

				if (result == 1) { // p_reply 테이블에 새로운 댓글 추가가 성공한다면..
					// 갱신된 댓글 갯수를 가져옴
					sto = sqlSession.selectOne("accom_reply_count", sto);
				}
				return sto;
			}
			
			// 댓글 리스트
			public ArrayList<ReplyTO> accomReplyList(ReplyTO to) {

				ArrayList<ReplyTO> replyList = new ArrayList();

				replyList = (ArrayList) sqlSession.selectList("other_accom_replyList", to);

				return replyList;
			}
			
			// 답글 작성
			public AccomTO accomWriteReReply(ReplyTO to) {
				// p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
				AccomTO sto = new AccomTO();
				sto.setNo(to.getBno());

				// 해당 게시물의 reply를 +1 한다.
				sqlSession.update("accom_reply_up", sto);

				// l_reply 테이블에 추가 (댓글 작성과 동일)
				int result = sqlSession.insert("other_accom_rereply_write", to);

				if (result == 1) { // p_reply 테이블에 새로운 댓글 추가가 성공한다면..
					// 갱신된 댓글 갯수를 가져옴
					sto = sqlSession.selectOne("accom_reply_count", sto);
				}
				return sto;
			}
			

			// 모댓글 삭제
			public AccomTO accomDeleteReply(ReplyTO to) {
				// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
				AccomTO sto = new AccomTO();
				sto.setNo(to.getBno());

				// grp가 reply의 no와 일치하는 댓글이 몇갠지 카운트한다. 모댓글에 딸린 답글이 몇갠지 카운트하기 위함
				int count_rereply = sqlSession.selectOne("other_accom_count_rereply", to);

				int result = 0;

				// 해당 게시물의 reply를 -1 한다.
				sqlSession.update("accom_reply_down", sto);

				if (count_rereply == 0) { // 답글이 없을 때 - 그냥 삭제
					// p_reply 테이블에서 삭제
					result = sqlSession.delete("other_accom_reply_delete", to);
				} else { // 답글이 있을 때 - content에 공백을 넣음 ("삭제된 게시물입니다" 라고 표기하기 위함)
					// p_reply 테이블에서 삭제하지 않고 content에 공백을 넣음
					result = sqlSession.update("other_accom_reply_not_delete", to);
				}

				if (result == 1) { // p_reply 테이블에서 댓글삭제가 성공한다면..
					// 갱신된 댓글 갯수를 가져옴
					sto = sqlSession.selectOne("accom_reply_count", sto);
				}
				return sto;
			}

			// 답글 삭제
			public AccomTO accomDeleteReReply(ReplyTO to) {
				// p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
				AccomTO sto = new AccomTO();
				sto.setNo(to.getBno());

				// 해당 게시물의 reply를 -1 한다.
				sqlSession.update("accom_reply_down", sto);

				// p_reply 테이블에서 삭제
				int result = sqlSession.delete("other_accom_reply_delete", to);

				// grp가 일치하는 답글이 몇갠지 카운트 한다. 없고 모댓글의 content가 ""이면 모댓글을 삭제하기 위함.
				int count_rereply = sqlSession.selectOne("other_accom_count_rereply_fromrereply", to);

				System.out.println("count_rereply = " + count_rereply);
				if (count_rereply == 0) {
					sqlSession.delete("other_accom_reply_delete_after_rereply_delete", to);
				}

				if (result == 1) { // p_reply 테이블에서 댓글삭제가 성공한다면..
					// 갱신된 댓글 갯수를 가져옴
					sto = sqlSession.selectOne("accom_reply_count", sto);
				}
				return sto;
			}

}
