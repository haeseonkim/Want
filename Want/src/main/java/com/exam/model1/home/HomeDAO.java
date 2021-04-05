package com.exam.model1.home;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.accom.AccomTO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.picture.PictureTO;
import com.exam.model1.shopping.ShoppingTO;

@Repository
public class HomeDAO {

	@Autowired
	private SqlSession sqlSession;

	public ArrayList<LanTripTO> l_best3(){
		ArrayList<LanTripTO> lanList = (ArrayList)sqlSession.selectList("l_best3");
		return lanList;
	}
	
	public ArrayList<PictureTO> p_best3(){
		ArrayList<PictureTO> pictureList = (ArrayList)sqlSession.selectList("p_best3");
		return pictureList;
	}
	
	public ArrayList<ShoppingTO> s_best3(){
		ArrayList<ShoppingTO> shoppingList = (ArrayList)sqlSession.selectList("s_best3");
		return shoppingList;
	}
	
	public ArrayList<AccomTO> a_best3(){
		ArrayList<AccomTO> accomList = (ArrayList)sqlSession.selectList("a_best3");
		return accomList;
	}
	
	public int visitCount() {
		int exist = sqlSession.selectOne("firstCount");
		
		System.out.println("exist : " + exist);
		int flag = 0;
		
		// 첫방문자인지 아닌지
		if(exist == 0) {
			flag = sqlSession.insert("firstVisit");
		}else {
			flag = sqlSession.update("plusVisit");
		}
		
		
		return flag;
	}
	
	public int getVisit() {
		int visit = sqlSession.selectOne("getVisit");
		return visit;
	}
	
	public int getMember() {
		int member = sqlSession.selectOne("getMember");
		return member;
	}
	
	public int getBoardsContents() {
		int contents = 0;
		
		String tableName = "lantrip";
		int lantrip = sqlSession.selectOne("getContents", tableName);
		tableName = "lantripApply";
		int lantripApply = sqlSession.selectOne("getContents", tableName);
		tableName = "picture";
		int picture = sqlSession.selectOne("getContents", tableName);
		tableName = "shopping";
		int shopping = sqlSession.selectOne("getContents", tableName);
		tableName = "accom";
		int accom = sqlSession.selectOne("getContents", tableName);
		tableName = "with";
		int with = sqlSession.selectOne("getContents", tableName);
		
		contents = lantrip + lantripApply + picture + shopping + accom + with;
		
		return contents;
	}
	
}
