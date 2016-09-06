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
			.antMatchers("/admin","/adminMenu/**").hasRole("ADMIN")
			.antMatchers("/","/**").permitAll()
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
	
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception
	{
		//authenticate with custom Service
		auth.userDetailsService(UserAuthService);	
	}
}
