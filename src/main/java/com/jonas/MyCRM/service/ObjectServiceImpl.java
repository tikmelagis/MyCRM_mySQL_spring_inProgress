package com.jonas.MyCRM.service;

import com.jonas.MyCRM.labas.ObjectD;
import com.jonas.MyCRM.repository.ObjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ObjectServiceImpl implements ObjectService {

    @Autowired
    private ObjectRepository objectRepository;

    @Override
    public void save(ObjectD objectD) {
        objectRepository.save(objectD);
    }
}
