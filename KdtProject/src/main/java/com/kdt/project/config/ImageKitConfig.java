package com.kdt.project.config;

import io.imagekit.sdk.ImageKit;
import io.imagekit.sdk.config.Configuration; // ImageKit SDK의 Configuration 임포트 유지
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;

@org.springframework.context.annotation.Configuration 
public class ImageKitConfig {

    @Value("${imagekit.publicKey}")
    private String publicKey;

    @Value("${imagekit.privateKey}")
    private String privateKey;

    @Value("${imagekit.urlEndpoint}")
    private String urlEndpoint;

    @Bean
    public ImageKit imageKit() {
        Configuration config = new Configuration(publicKey, privateKey, urlEndpoint);

        ImageKit imageKit = ImageKit.getInstance();
        imageKit.setConfig(config);
        return imageKit;
    }
}