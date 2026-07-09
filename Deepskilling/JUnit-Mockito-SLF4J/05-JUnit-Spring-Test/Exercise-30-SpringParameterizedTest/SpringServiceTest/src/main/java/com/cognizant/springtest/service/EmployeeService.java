package com.cognizant.springtest.service;

import org.springframework.stereotype.Service;

import com.cognizant.springtest.entity.Employee;
import com.cognizant.springtest.repository.EmployeeRepository;


@Service
public class EmployeeService {

    private EmployeeRepository repository;


    public EmployeeService(EmployeeRepository repository){
        this.repository=repository;
    }


    public Employee getEmployee(int id){

        return repository.findEmployee(id);

    }

}