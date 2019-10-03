package com.jonas.MyCRM.repository;

import com.jonas.MyCRM.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);

    User findById(Long id);


}
