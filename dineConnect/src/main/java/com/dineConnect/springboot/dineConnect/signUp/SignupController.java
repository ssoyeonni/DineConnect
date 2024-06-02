package com.dineConnect.springboot.dineConnect.signUp;

import jakarta.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/sign")
public class SignupController {

    private final SignupService signService;

    @GetMapping("/signup")
    public String signup(SignupForm signupForm) {
        return "signup_form";
    }

    @PostMapping("/signup")
    public String signup(@Valid SignupForm signupForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "signup_form";
        }

        if (!signupForm.getPassword1().equals(signupForm.getPassword2())) {
            bindingResult.rejectValue("password2", "passwordInCorrect",
                    "2개의 패스워드가 일치하지 않습니다.");
            return "signup_form";
        }

        signService.create(signupForm.getUsername(),
                signupForm.getPassword1());

        return "redirect:/";
    }
}