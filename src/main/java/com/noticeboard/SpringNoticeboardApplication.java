package com.noticeboard;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
//@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
public class SpringNoticeboardApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringNoticeboardApplication.class, args);
	}

}
