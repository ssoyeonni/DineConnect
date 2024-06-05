package com.dineConnect.springboot.dineConnect.signUp;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface SignupRepository extends JpaRepository<Signup, Long>
{
}
