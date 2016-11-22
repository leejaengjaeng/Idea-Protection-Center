package com.ipc.security;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import com.ipc.service.UserAuthService;

@Service
public class CustomAuthProvider implements AuthenticationProvider
{
	@Autowired
	SecAlgorithm secAlgo;
	@Autowired
	UserAuthService userAuthService;
	
	@Override
	public Authentication authenticate(Authentication auth) throws AuthenticationException {
		//auth에는 현재 로그인 시도한 정보가 담김
		String id  = auth.getName();
		String pwd = (String)auth.getCredentials();
		
		User validUser = userAuthService.loadUserByUsername(id);
		
		try{
			if(validUser == null) throw new BadCredentialsException("없는 아이디");
			if(secAlgo.validatePassword(pwd,validUser.getPassword()))
				return new UsernamePasswordAuthenticationToken(validUser,validUser.getPassword(),validUser.getAuthorities());
		}catch (Exception e){
			System.out.println("customProvider ] 뭐가 잘못된거지 (pw포맷이 다름?)");
		} 

		return null;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}
	
	
}

