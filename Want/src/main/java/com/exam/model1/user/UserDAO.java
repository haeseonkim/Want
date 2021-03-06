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
import com.exam.model1.lantripApply.LanTripApplyTO;

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

	//회원있는지 여부 확인
	public Integer pwFind_Lookup( UserTO userTo ) {
		int result = sqlSession.selectOne( "pwFind_lookup", userTo );
		return result;
	}
	
	//회원 메일 있는지 확인
	public int pwFind_ok( UserTO userTo ) {
		int result = sqlSession.selectOne( "pwFind_ok", userTo );
		return result;
	}
	
	//회원 비번 가져오기
	public UserTO pwFind_select( UserTO userTo ) {
		UserTO to = sqlSession.selectOne("pwFind_select", userTo);
		return to;
	}
	//회원 비밀번호 디코딩해서 비번비교하기
	public UserTO pwFindDecry( UserTO userTo ) {
		userTo = sqlSession.selectOne( "pwFind_decry", userTo );
		return userTo;
	}
	
// -------------------------- 프로필 정보 -----------------------------
	// 내 프로필 
	public UserTO myProfile( UserTO uto ) {
		
		//컨트롤러에서 받은 uto를 sql매퍼를 호출한 뒤 그 결과를 return_uto에 저장
		//그리고 리턴값으로 return_uto를 넘겨줌
		UserTO return_uto = sqlSession.selectOne( "myProfile", uto );
		
		return return_uto;
	}
	
	// 다른 사람 프로필 정보 가져오기
	public UserTO OtherProfile(UserTO to) {
		
		UserTO pto = sqlSession.selectOne("otherProfile",to);
		
		return pto;
	}
	
	// 프로필 수정
	public int edit_profile_ok(UserTO to) {
		int result = sqlSession.update("edit_profile", to);
		
		return result;
	}
	
	// 프로필 사진 수정
	public int edit_img_ok(UserTO to) {
		int flag = 2;
		int result = sqlSession.update("edit_img", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}
		return flag;
	}
	// 프로필 사진 삭제
	public int delete_img_ok(UserTO to) {
		int flag = 2;
		int result = sqlSession.update("delete_img", to);
		if (result == 1) {
			flag = 0;
		} else if (result == 0) {
			flag = 1;
		}
		return flag;
	}
		
}