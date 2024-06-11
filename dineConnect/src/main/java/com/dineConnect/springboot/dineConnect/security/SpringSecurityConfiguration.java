package com.dineConnect.springboot.dineConnect.security;
import static org.springframework.security.config.Customizer.withDefaults;
import java.util.function.Function;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.header.writers.frameoptions.XFrameOptionsHeaderWriter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;


@Configuration  //spring bean을 만들고 리턴
public class SpringSecurityConfiguration {
	//LDAP or Database
	//In Memory
	
	//InMemoryUserDetailsManager
	//InMemoryUserDetailsManager(UserDetails... users)

	// 데이터베이스에 있는 아이디로 로그인 가능하게 하려면 아래 주석처리 해야함
//	@Bean
//	public InMemoryUserDetailsManager createUserDetailsManager() {
//
//
//		 UserDetails userDetails1 = createNewUser("in28minutes", "dummy");
//		 UserDetails userDetails2 = createNewUser("ranga", "dummydummy");
//		 UserDetails managerDetails1 = createNewManager("soyeon", "1234");
//
//		return new InMemoryUserDetailsManager(userDetails1, userDetails2, managerDetails1);
//	}
//
//
//
//	private UserDetails createNewUser(String username, String password) {
//		Function<String, String> passwordEncoder
//		 	= input -> passwordEncoder().encode(input);
//
//		UserDetails userDetails = User.builder()
//				 		.passwordEncoder(passwordEncoder)
//						 .username(username)
//						 .password(password)
//						 .roles("USER", "ADMIN")
//						 .build();
//		return userDetails;
//	}
//
//	private UserDetails createNewManager(String managername, String password) {
//		Function<String, String> passwordEncoder
//				= input -> passwordEncoder().encode(input);
//
//		UserDetails managerDetails = User.builder()
//				.passwordEncoder(passwordEncoder)
//				.username(managername)
//				.password(password)
//				.roles("MANAGER", "ADMIN")
//				.build();
//		return managerDetails;
//	}


	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	//All URLs are proteted
	//A login form is shown for unauthorized requests
	//CSRF disable, Frames

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.authorizeHttpRequests(
				auth -> auth
//						.requestMatchers("/", "/login", "/sign/signup", "/login/**").permitAll()
						.anyRequest()
						.authenticated());
		http.formLogin(withDefaults());
//		http.formLogin(form -> form
//				.loginPage("/login")
//				.defaultSuccessUrl("/", true)
//				.failureUrl("/login")
//				.permitAll()
//		);

//
		http.csrf(csrf -> csrf.disable());
		http.headers(headers -> headers.frameOptions(frameOptions -> frameOptions.disable()));
//		http
//				.authorizeHttpRequests((authorizeRequests) ->
//				authorizeRequests
//						.requestMatchers("/", "/login/**","/login", "/sign/signup").permitAll()
//						.anyRequest().authenticated()
//		)
//
//				.formLogin((formLogin) ->
//						formLogin
//								.loginPage("/login")
//								.usernameParameter("username")
//								.passwordParameter("password")
//								.defaultSuccessUrl("/", true)
//				);

		return http.build();
//		return http
//				.authorizeHttpRequests(auth -> auth.requestMatchers("/login/**", "/sign/signup").permitAll().
//						anyRequest().authenticated())
//				.formLogin(form -> form
//				.loginPage("/login")
//				.defaultSuccessUrl("/")
//				.permitAll())
////				.csrf(csrf -> csrf.disable())
////				.headers(headers -> headers.frameOptions(frameOptions -> frameOptions.disable()))
//				.build();
//	}

	}
	@Bean
	AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
		return authenticationConfiguration.getAuthenticationManager();
	}
}