package com.lib;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.lib.controller.LoginIntercepter;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	@Override
    public void addInterceptors(InterceptorRegistry registry) {

        LoginIntercepter loginIntercepter = new LoginIntercepter();
        registry.addInterceptor(loginIntercepter)
                .addPathPatterns(loginIntercepter.loginEssential)
                .excludePathPatterns(loginIntercepter.loginInessential); // 해당 패턴의 경로는 인터셉트하지 않겠다
    }
}
