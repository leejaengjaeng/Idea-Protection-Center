package com.ipc;

import java.nio.charset.Charset;

import javax.servlet.Filter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.filter.CharacterEncodingFilter;

@SpringBootApplication
public class IdeaProtectionCenterApplication {

	public static void main(String[] args) {
		SpringApplication.run(IdeaProtectionCenterApplication.class, args);
		System.out.println("fuck");
	}
}
