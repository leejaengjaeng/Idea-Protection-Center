package com.ipc.security;

import org.springframework.stereotype.Service;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.spec.PBEKeySpec;
import javax.crypto.SecretKeyFactory;

import java.math.BigInteger;

//PBKDF2 알고리즘 사용
@Service
public class SecAlgorithm{

//상수
	private static final String PBKDF2_ALGORITHM = "PBKDF2WithHmacSHA1";
	
	private static final int SALT_BYTES = 24;
	private static final int HASH_BYTES = 24;
	private static final int PBKDF2_ITERATIONS = 1000;
	
	// 호출 편하게 하기 위해서 선언
	private static final int ITERATIONS_INDEX = 0;
	private static final int SALT_INDEX = 1;
	private static final int PBKDF2_INDEX = 2;
	
	
//public
	public static String createHash(String pwd) throws NoSuchAlgorithmException, InvalidKeySpecException
	{
		return createHash(pwd.toCharArray());
	}
	public static boolean validatePassword(String pwdToCheck, String validHashCode) throws NoSuchAlgorithmException, InvalidKeySpecException
	{
	    return validatePassword(pwdToCheck.toCharArray(), validHashCode);
	}
	
//접근 불가능한 함수들
	private static byte[] pbkdf2(char[] password, byte[] salt, int iter, int bytes) throws NoSuchAlgorithmException, InvalidKeySpecException
	{
		//byte*8 저 부분이 무슨 길이였던거 같은데 정확히는 모르겠음
		PBEKeySpec keySpec = new PBEKeySpec(password, salt, iter, bytes * 8);
		SecretKeyFactory keyFac = SecretKeyFactory.getInstance(PBKDF2_ALGORITHM);
		return keyFac.generateSecret(keySpec).getEncoded();
	}
	// TODO: 이거 안쓰면 빨리 비교되나..?
    private static boolean slowEquals(byte[] a, byte[] b)
    {
    	int diff = a.length ^ b.length;
	    for(int i = 0; i < a.length && i < b.length; i++)
	    	diff |= a[i] ^ b[i];
	    return diff == 0;
	}
    // TODO: HEX 공부하자
 	private static String toHex(byte[] array)
     {
         BigInteger bi = new BigInteger(1, array);
         String hex = bi.toString(16);
         int paddingLength = (array.length * 2) - hex.length();
         if(paddingLength > 0) 
             return String.format("%0" + paddingLength + "d", 0) + hex;
         else
             return hex;
     }
 	private static byte[] fromHex(String hex)
 	{
 		byte[] binary = new byte[hex.length() / 2];
 	    for(int i = 0; i < binary.length; i++)
 	    {
 	    	binary[i] = (byte)Integer.parseInt(hex.substring(2*i, 2*i+2), 16);
 	    }
 	    return binary;
 	}
	private static boolean validatePassword(char[] pwdToCheck, String validHashCode) throws NoSuchAlgorithmException, InvalidKeySpecException
	{
		//패스워드를 복호화 
		String params[] = validHashCode.split(":");
		int iter = Integer.parseInt(params[ITERATIONS_INDEX]);
		byte salt[] = fromHex(params[SALT_INDEX]);
		byte validHash[] = fromHex(params[PBKDF2_INDEX]);
		byte checkHash[] = pbkdf2(pwdToCheck,salt,iter,validHash.length);
		
		//validHash와 입력된 pwd의 Hash를 비교
		return slowEquals(validHash,checkHash);
	}
	private static String createHash(char[] pwd) throws NoSuchAlgorithmException, InvalidKeySpecException
	{
		//랜덤 salt 값 생성
		SecureRandom random = new SecureRandom();
		byte salt[] = new byte[SALT_BYTES];
		random.nextBytes(salt);
		
		//pwd 해시
		byte hash[] = pbkdf2(pwd,salt,PBKDF2_ITERATIONS,HASH_BYTES);
		
		//암호화된 문자열 반환 -> 제일앞에 반복횟수는 왜 붙이징
		return PBKDF2_ITERATIONS+":"+toHex(salt)+":"+toHex(hash);
	}
}
