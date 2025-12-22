package com.aivle.spring.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;

@RestController
public class VersionController {
    
    @GetMapping("/version")
    public Map<String, String> getVersion() {
        Map<String, String> version = new HashMap<>();
        version.put("version", "3.0.0-green");  // Green 버전 표시
        version.put("environment", "production");
        version.put("timestamp", String.valueOf(System.currentTimeMillis()));
        return version;
    }
}