package com.jonas.MyCRM.service;

import com.jonas.MyCRM.model.Role;
import com.jonas.MyCRM.model.User;
import com.jonas.MyCRM.repository.RoleRepository;
import com.jonas.MyCRM.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.HashSet;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void save(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(new HashSet<Role>(Collections.singleton(roleRepository.findById(1L))));
        userRepository.save(user);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public void delete(Long id) {
        userRepository.delete(id);


    }


}
