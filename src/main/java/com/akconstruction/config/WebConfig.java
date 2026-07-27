package com.akconstruction.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String baseDir = new File(".").getAbsolutePath();
        if (baseDir.endsWith(".")) {
            baseDir = baseDir.substring(0, baseDir.length() - 1);
        }

        registry.addResourceHandler("/images/**")
                .addResourceLocations(
                        "classpath:/static/images/",
                        "classpath:/META-INF/resources/images/",
                        "file:" + baseDir + "src/main/webapp/images/",
                        "file:" + baseDir + "WebContent/images/",
                        "file:" + baseDir + "src/main/resources/static/images/"
                );
    }
}
