package com.exam.model1.user;

import java.nio.ByteBuffer;
import java.security.AlgorithmParameters;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.BufferUnderflowException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.model1.lantrip.LanTripListTO;
import com.exam.model1.lantrip.LanTripTO;

@Repository
public class UserDAO {

	@Autowired
	private SqlSession sqlSession;
	

	//회원있는지 여부 확인
	public Integer loginLookup( UserTO userTo ) {
		int result = sqlSession.selectOne( "login_lookup", userTo );
		return result;
	}
	
	//회원 비번 맞는지 확인
	public int loginOk( UserTO userTo ) {
		int result = sqlSession.selectOne( "login_ok", userTo );
		return result;
	}
	
	//회원 비번 닉네임 가져오기
	public UserTO loginOkNick( UserTO userTo ) {
		UserTO to = sqlSession.selectOne( "login_ok_nick", userTo );
		return to;
	}

	
	//회원 비밀번호 디코딩해서 비번비교하기
	public UserTO loginDecry( UserTO userTo ) {
		userTo = sqlSession.selectOne( "login_decry", userTo );
		return userTo;
	}

	// ------------------- 회원가입관련 ----------------------
	// signup_ok - flag 값있어야함
	public int signup_ok(UserTO to) {
		int flag = 1;
		
		int result = sqlSession.insert("signup_ok", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}
		
	//signup의 닉네임 중복확인
	public Integer nickLookup( UserTO userTo ) {
		int result = sqlSession.selectOne( "nick_lookup", userTo );
		return result;
	}
	
	//비밀번호 암호화 (sha256방법 사용)
	public String encrypt( String text ) {
		try {
			//암호화할 때 필요한 MessageDigest클래스 
			MessageDigest md = MessageDigest.getInstance( "SHA-256" );
			md.update( text.getBytes() );
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer();
			for( int i=0; i<byteData.length; i++ ) {
				sb.append( Integer.toString( (byteData[i] & 0xff) + 0x100, 16 ).substring(1) );
			}
			StringBuffer hexString = new StringBuffer();
			for( int i=0; i<byteData.length; i++ ) {
				String hex = Integer.toHexString( 0xff & byteData[i] );
				if( hex.length() == 1 ) {
					hexString.append( '0' );
				}
				hexString.append( hex );
			}
			return hexString.toString();
			
		} catch( Exception e ) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}
	
	//비밀번호 암호화 (aes256방법 사용)
	public String encrytAES( String  msg, String key ) throws Exception {
		SecureRandom random = new SecureRandom();
		byte bytes[] = new byte[20];
		random.nextBytes(bytes);
		byte[] saltBytes = bytes;
		
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		PBEKeySpec spec = new PBEKeySpec( key.toCharArray(), saltBytes, 70000, 256 );
		
		SecretKey secretKey = factory.generateSecret(spec);
		SecretKeySpec secret = new SecretKeySpec( secretKey.getEncoded(), "AES" );
		
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	    cipher.init(Cipher.ENCRYPT_MODE, secret);
	    AlgorithmParameters params = cipher.getParameters();
	    // Initial Vector(1단계 암호화 블록용)
	    byte[] ivBytes = params.getParameterSpec(IvParameterSpec.class).getIV();

	    byte[] encryptedTextBytes = cipher.doFinal(msg.getBytes("UTF-8"));

	    byte[] buffer = new byte[saltBytes.length + ivBytes.length + encryptedTextBytes.length];
	    System.arraycopy(saltBytes, 0, buffer, 0, saltBytes.length);
	    System.arraycopy(ivBytes, 0, buffer, saltBytes.length, ivBytes.length);
	    System.arraycopy(encryptedTextBytes, 0, buffer, saltBytes.length + ivBytes.length, encryptedTextBytes.length);

	    return Base64.getEncoder().encodeToString(buffer);
	}
	
	public String decryptAES(String msg, String key) throws Exception {

	    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	    ByteBuffer buffer = ByteBuffer.wrap(Base64.getDecoder().decode(msg));

	    byte[] saltBytes = new byte[20];
	    buffer.get(saltBytes, 0, saltBytes.length);
	    byte[] ivBytes = new byte[cipher.getBlockSize()];
	    buffer.get(ivBytes, 0, ivBytes.length);
	    byte[] encryoptedTextBytes = new byte[buffer.capacity() - saltBytes.length - ivBytes.length];
	    buffer.get(encryoptedTextBytes);

	    SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
	    PBEKeySpec spec = new PBEKeySpec(key.toCharArray(), saltBytes, 70000, 256);
	    SecretKey secretKey = factory.generateSecret(spec);
	    SecretKeySpec secret = new SecretKeySpec(secretKey.getEncoded(), "AES");
	    cipher.init(Cipher.DECRYPT_MODE, secret, new IvParameterSpec(ivBytes));
	    byte[] decryptedTextBytes = cipher.doFinal(encryoptedTextBytes);
	    
	    return new String(decryptedTextBytes);
	}

	
	
	
	
	// writer - dao 통과 안해도됨
	public void boardWrite( UserTO userTo ) {
		
	}

	// writer_ok - flag 값있어야함
	public int boardWriteOk(LanTripTO to) {
		int flag = 1;

		int result = sqlSession.insert("write_ok", to);
		if (result == 1) {
			flag = 0;
		}
		return flag;
	}

	// list
	public LanTripListTO boardList(LanTripListTO listTO) {

		int cpage = listTO.getCpage();
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();

		ArrayList<LanTripTO> lists = (ArrayList)sqlSession.selectList("list");

		listTO.setTotalRecord(lists.size());
		listTO.setTotalPage(((listTO.getTotalRecord() - 1) / recordPerPage) + 1);

		int skip = (cpage - 1) * recordPerPage;
		
		ArrayList<LanTripTO> boardLists = new ArrayList();
		
		int cnt = 0;
		for (int i = skip; i < lists.size(); i++) {
			if(cnt == recordPerPage) {
				break;
			}
			if (lists.get(i) != null) {
				LanTripTO to = lists.get(i);
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
	public LanTripTO boardView(LanTripTO to) {
		sqlSession.update("view_hit", to);
		to = sqlSession.selectOne("view", to);

		return to;
	}

	// delete
	public LanTripTO boardDelete(LanTripTO to) {
		LanTripTO board = sqlSession.selectOne("delete", to);

		return board;
	}

	// delete_ok
	public int boardDeleteOk(LanTripTO to) {
		int flag = 2;

		int result = sqlSession.delete("delete_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}

		return flag;
	}

	// modify
	public LanTripTO boardModify(LanTripTO to) {
		LanTripTO board = sqlSession.selectOne("modify", to);

		return board;
	}

	// modify_ok
	public int boardModifyOk(LanTripTO to) {
		int flag = 2;
		int result = sqlSession.update("modify_ok", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}

		return flag;
	}
	
	
}
