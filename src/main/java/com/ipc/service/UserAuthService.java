package com.ipc.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ipc.dao.UserDao;
import com.ipc.vo.userVo;



@Service("UserAuthService")
public class UserAuthService implements UserDetailsService{

	@Autowired
	UserDao userDao;
	
	//Return Spring Security User for authentication
	private User buildUserForAuth(userVo user, List<GrantedAuthority> auths)
	{
		return new User(user.getId(), user.getPw(), auths);
	}
	
	//Get authorities name and return spring security authorities type
	private List<GrantedAuthority> buildAuth(String userRole)
	{
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority(userRole));
		return authorities;
	}
	
	//return User for authentication at AuthenticationManagerBuilder
	@Override
	public User loadUserByUsername(String userid) throws UsernameNotFoundException 
	{
		userVo userVo = userDao.getUserById(userid);

		if(userVo == null)
		{
			throw new UsernameNotFoundException(userid);
		}
		
		List<GrantedAuthority> authorities = buildAuth(userVo.getRole());
		
		User user = buildUserForAuth(userVo,authorities);
		return user;
		
	}
	

}
