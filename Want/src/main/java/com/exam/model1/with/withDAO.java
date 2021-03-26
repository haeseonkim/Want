package com.exam.model1.with;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class withDAO {

	@Autowired
	private SqlSession sqlSession;

	// writer - dao 통과 안해도됨
	public void with_write() {
	}

	// writer_ok - flag 값있어야함
	public int with_write_ok(withTO to) {
		int flag = 1;

		int result = sqlSession.insert("with_write_ok", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}

	// list
	   public withListTO boardList(withListTO listTO) {

	      int cpage = listTO.getCpage();
	      int recordPerPage = listTO.getRecordPerPage();
	      int blockPerPage = listTO.getBlockPerPage();
	      
	      // withTO의 내용을 배열로 가져옴 										mapper의 id, SqlMapper 변수명(?)과 동일
	      ArrayList<withTO> lists = (ArrayList)sqlSession.selectList("withList");
	      
	      listTO.setTotalRecord(lists.size());
	      listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);

	      int skip = (cpage - 1) * recordPerPage;
	      
	      ArrayList<withTO> boardLists = new ArrayList();
	      
	      int cnt = 0;
	      for (int i = skip; i < lists.size(); i++) {
	         if(cnt == recordPerPage) {
	            break;
	         }
	         if (lists.get(i) != null) {
	        	 withTO to = lists.get(i);
	            boardLists.add(to);
	         }
	         cnt++;
	      }

	      listTO.setBoardList(boardLists);

	      listTO.setStartBlock(((cpage - 1) / blockPerPage) * blockPerPage + 1);
	      listTO.setEndBlock(((cpage - 1) / blockPerPage) * blockPerPage + blockPerPage);
	      if (listTO.getEndBlock() >= listTO.getTotalPage()) {
	         listTO.setEndBlock(listTO.getTotalPage());
	      }

	      return listTO;
	   }
	   
	// view
	public withTO with_View(withTO to) {
		sqlSession.update("with_view_hit", to);
		to = sqlSession.selectOne("with_view", to);

		return to;
	}

	// delete
	public withTO withDelete(withTO to) {
		to = sqlSession.selectOne("delete", to);

		return to;
	}

	// delete_ok
	public int with_delete_ok(withTO to) {
		int flag = 2;

		int result = sqlSession.delete("with_delete_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}

		return flag;
	}

	// modify
	public withTO with_modify(withTO to) {
		to = sqlSession.selectOne("with_modify", to);

		return to;
	}

	// modify_ok
	public int with_modify_ok(withTO to) {
		int flag = 2;
		int result = sqlSession.update("with_modify_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}

		return flag;
	}
}