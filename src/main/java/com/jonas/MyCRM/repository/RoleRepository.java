package com.jonas.MyCRM.repository;

import com.jonas.MyCRM.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long>{
    Role findById(Long id);
}
