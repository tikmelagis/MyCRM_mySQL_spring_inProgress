package com.jonas.MyCRM.service;

import com.jonas.MyCRM.model.User;


public interface UserService {
    void save(User user);

    void delete(Long id);


    User findByUsername(String username);

}
