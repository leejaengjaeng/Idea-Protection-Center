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
	
	@Autowired
	private CustomAuthProvider customAuthProvider;
	
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
			.antMatchers("/IPC_admin/**","/qna/regularQnaAdd").hasRole("ADMIN")
			.antMatchers("/qna/addOneQna","/copyRight/**").authenticated()
			.antMatchers("/","/**","/notice/**","/signup/**","/signup/inputsignup").permitAll()
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
				.accessDeniedPage("/authError")
				.and()
			.sessionManagement()
				.maximumSessions(1)
				.expiredUrl("/authError");
	}
	
	//authenticate with custom Service
	/*
	 *  login.do로 접근한 id ,pw로 
	 *  Spring Security User를 만들고  Custom으로 인증 처리함
	 */
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception
	{
		//UserDetailService를 내가 만든 서비스로 사용 : in-memory대신 DB사용
		auth.userDetailsService(UserAuthService);	
		
		//인증을 내가 만들 서비스로함
		auth.authenticationProvider(customAuthProvider);
	}
}
