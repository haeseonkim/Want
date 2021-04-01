package com.exam.model1.message;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MessageDAO {

	@Autowired
	private SqlSession sqlSession;

	// 메세지 리스트
	public ArrayList<MessageTO> messageList(MessageTO to) {

		String nick = to.getNick();
		
		// 메세지 리스트에 나타낼 것들 가져오기 - 가장 최근 메세지, 보낸사람 profile 사진, 보낸사람 nick
		ArrayList<MessageTO> list = (ArrayList) sqlSession.selectList("message_list", to);

		for (MessageTO mto : list) {
			mto.setNick(nick);
			// 현재 사용자가 해당 room에서 안읽은 메세지의 갯수를 가져온다.
			int unread = sqlSession.selectOne("count_unread", mto);
			// 현재 사용자가 메세지를 주고받는 상대 profile을 가져온다.
			String profile = sqlSession.selectOne("get_other_profile",mto);
			// 안읽은 메세지 갯수를 mto에 set한다.
			mto.setUnread(unread);
			// 메세지 상대의 프로필사진을 mto에 set한다.
			mto.setProfile(profile);
			// 메세지 상대 nick을 세팅한다. other_nick
			if (nick.equals(mto.getSend_nick())) {
				mto.setOther_nick(mto.getRecv_nick());
			} else {
				mto.setOther_nick(mto.getSend_nick());
			}
		}

		return list;
	}


	// room 별 메세지 내용을 가져온다.
	public ArrayList<MessageTO> roomContentList(MessageTO to) {
		// 메세지 내역을 가져온다
		ArrayList<MessageTO> clist = (ArrayList) sqlSession.selectList("room_content_list", to);

		// 해당 방의 메세지들 중 받는 사람이 현재사용자의 nick인 메세지를 모두 읽음 처리한다
		sqlSession.update("message_read_chk", to);

		return clist;
	}
	
	// 메세지 list에서 메세지를 보낸다.
	public int messageSendInlist(MessageTO to) {
		int flag = sqlSession.insert("messageSendInlist",to);
		return flag;
	}

}
