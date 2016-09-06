package com.ipc.security;

import org.apache.tomcat.jdbc.pool.DataSource;
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
	
//	@Autowired
//	@Qualifier("UserAuthService")
//	private UserDetailsService UserAuthService;
	
	
	@Override
    public void configure(WebSecurity web) throws Exception {
       //statoc files
		web
            .ignoring()
            .antMatchers("/resources/**","/webjars/**");
    }
	
	@Override
	protected void configure(HttpSecurity http) throws Exception
	{
		http
			.authorizeRequests()
			.antMatchers("/","/**").permitAll()
			.antMatchers("/admin","/adminMenu/**").hasRole("ADMIN")
			.and()
			.formLogin()
				.loginPage("/login").permitAll() 
				.loginProcessingUrl("/login.do")
				.usernameParameter("id")
				.passwordParameter("password")	
				.successForwardUrl("/loginProcess.do")
				.and()
			.logout()
				.logoutSuccessUrl("/")
				.and()		
			.exceptionHandling()
				.accessDeniedPage("/authError");
	}
	
	
	
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception
	{
		//UserAuthService瑜� �궗�슜�빐�꽌 �씤利앺븯�뒗�벏
		//auth.userDetailsService(UserAuthService);	
		
		/*.jdbcAuthentication()
				.dataSource(dataSource)
				.usersByUsernameQuery(
						"select id,password from user where id=?"
				)
				.authoritiesByUsernameQuery(
						"select id,role from user where id=?"
				);
		*/		
	}
}
