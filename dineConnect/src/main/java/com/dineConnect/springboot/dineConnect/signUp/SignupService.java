package com.dineConnect.springboot.dineConnect.signUp;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;


import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class SignupService {
    private final SignupRepository signupRepository;
    private final PasswordEncoder passwordEncoder;

    public Signup create(String username, String password) {
        Signup user = new Signup();
        user.setUsername(username);

        // 암호화하여 비밀번호 저장
        user.setPassword(passwordEncoder.encode(password));
        this.signupRepository.save(user);
        return user;
    }
}
