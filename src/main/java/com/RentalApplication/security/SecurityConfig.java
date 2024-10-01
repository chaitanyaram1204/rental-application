package com.RentalApplication.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;
import org.springframework.security.web.SecurityFilterChain;

//@SuppressWarnings("deprecation")
//@Configuration
//public class SecurityConfig {
//
//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http.csrf().disable()
//            .authorizeRequests()
//            // Allow access to /api/properties for roles ADMIN and GUEST
//            .requestMatchers("/api/properties/**").hasAnyRole("ADMIN", "GUEST")
//            // Allow access to /api/users for roles USER and GUEST
//            .requestMatchers("/api/users/**").hasAnyRole("USER", "GUEST")
//            // All other requests require authentication
//            .anyRequest().authenticated();
//        
//        return http.build();
//    }
//}


@SuppressWarnings("deprecation")
@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .authorizeRequests()
            .anyRequest().permitAll();  // Permit all requests without authentication
        return http.build();
    }
}
