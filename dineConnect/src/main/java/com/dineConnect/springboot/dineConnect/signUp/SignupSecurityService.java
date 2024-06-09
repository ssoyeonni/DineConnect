package com.dineConnect.springboot.dineConnect.signUp;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class SignupSecurityService implements UserDetailsService {

    private final SignupRepository signupRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<Signup> _singup = this.signupRepository.findByusername(username);
        if (_singup.isEmpty()) {
            if ("in28minutes".equals(username)) {
                return createNewUser("in28minutes", "dummy");
            }
            if ("ranga".equals(username)) {
                return createNewUser("ranga", "dummydummy");
            }
            if ("1234".equals(username)) {
                return createNewUser("1234", "1234");
            }
            throw new UsernameNotFoundException("사용자를 찾을수 없습니다.");
        }
        Signup signup = _singup.get();
        List<GrantedAuthority> authorities = new ArrayList<>();
        if ("admin".equals(username)) {
            authorities.add(new SimpleGrantedAuthority(UserRole.ADMIN.getValue()));
        } else {
            authorities.add(new SimpleGrantedAuthority(UserRole.USER.getValue()));
        }
        return new User(signup.getUsername(), signup.getPassword(), authorities);
    }
    public UserDetails createNewUser(String username, String password) {
        List<GrantedAuthority> authorities = new ArrayList<>();
        if ("in28minutes".equals(username)) {
            authorities.add(new SimpleGrantedAuthority(UserRole.ADMIN.getValue()));
        } else {
            authorities.add(new SimpleGrantedAuthority(UserRole.USER.getValue()));
        }
        return new User(username, password, authorities);
    }


}
