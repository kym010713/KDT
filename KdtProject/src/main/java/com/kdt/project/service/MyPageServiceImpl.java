package com.kdt.project.service;

import org.springframework.stereotype.Service;

import com.kdt.project.dto.MyPageDto;
import com.kdt.project.entity.User;
import com.kdt.project.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService {

    private final UserRepository userRepository;

    @Override
    public MyPageDto getMyPage(String userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        return MyPageDto.builder()
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .address(user.getAddress())
                .build();
    }
}
