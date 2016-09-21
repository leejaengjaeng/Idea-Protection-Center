package com.ipc.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;

@EnableWebSecurity
public class SecConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	@Qualifier("UserAuthService")
	private UserDetailsService UserAuthService;
	
	
	@Override
    public void configure(WebSecurity web) throws Exception {
		//static files
		web
            .ignoring()
            .antMatchers("/resources/**","/webjars/**");
    }
	
	@Override
	protected void configure(HttpSecurity http) throws Exception
	{
		http
			.authorizeRequests()
			.antMatchers("/IPC_adminPage").hasRole("ADMIN")
			.antMatchers("/","/**","/signup/**","/signup/inputsignup").permitAll()
			.and()
			.formLogin()
				.loginPage("/login").permitAll() 
				.loginProcessingUrl("/login.do")
				.usernameParameter("id")
				.passwordParameter("pw")	
				.successForwardUrl("/loginProcess.do")
				.and()
			.logout()
				.and()		
			.exceptionHandling()
				.accessDeniedPage("/authError");
	}
	
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception
	{
		//authenticate with custom Service
		/*
		 *  login.do로 접근한 id ,pw로 만든 security의 User 객체와 
		 *  UserAuthService로 만든 DB에서 가지고온 User 객체를 비교해서 로그인
		 */
		auth.userDetailsService(UserAuthService);	
	}
}
