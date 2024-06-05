package com.dineConnect.springboot.dineConnect.signUp;

import jakarta.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.dao.DataIntegrityViolationException;

import lombok.RequiredArgsConstructor;
import org.springframework.web.servlet.ModelAndView;

@RequiredArgsConstructor
@Controller
@RequestMapping("/sign")
public class SignupController {

    private final SignupService signService;

    @GetMapping("/signup")
    public ModelAndView signup() {
        ModelAndView mav = new ModelAndView("signup_form");
        mav.addObject("signupForm", new SignupForm());
        return mav;
    }

    @PostMapping("/signup")
    public String signup(@ModelAttribute("signupForm") @Valid SignupForm signupForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "signup_form";
        }

        if (!signupForm.getPassword1().equals(signupForm.getPassword2())) {
            bindingResult.rejectValue("password2", "passwordInCorrect",
                    "2개의 패스워드가 일치하지 않습니다.");
            return "signup_form";
        }
        try {
            signService.create(signupForm.getUsername(),
                    signupForm.getPassword1());
        } catch (DataIntegrityViolationException e) {
            e.printStackTrace();
            bindingResult.reject("signupFailed", "이미 등록된 사용자입니다.");
            return "signup_form";
        } catch (Exception e) {
            e.printStackTrace();

            bindingResult.reject("signupFailed", e.getMessage());
            return "signup_form";
        }

        return "redirect:/login";
    }
}