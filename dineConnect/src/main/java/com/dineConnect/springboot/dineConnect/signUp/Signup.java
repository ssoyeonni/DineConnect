package com.dineConnect.springboot.dineConnect.signUp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import lombok.Getter;
import lombok.Setter;

// https://wikidocs.net/162141
//
//SiteUser = Signup
//UserRepository = SignupRepository
//UserService = SignupService
//UserController = SignupController
//UserCreateForm = SignupForm

@Getter
@Setter
@Entity
public class Signup {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String username;

    private String password;

}