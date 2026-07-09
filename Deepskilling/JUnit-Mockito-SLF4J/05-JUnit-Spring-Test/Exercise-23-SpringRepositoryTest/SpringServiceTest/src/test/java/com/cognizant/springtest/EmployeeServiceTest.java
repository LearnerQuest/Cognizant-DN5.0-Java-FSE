package com.cognizant.springtest;


import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.beans.factory.annotation.Autowired;


import com.cognizant.springtest.entity.Employee;
import com.cognizant.springtest.repository.EmployeeRepository;
import com.cognizant.springtest.service.EmployeeService;


@SpringBootTest
public class EmployeeServiceTest {


    @Autowired
    EmployeeService service;


    @MockBean
    EmployeeRepository repository;


    @Test
    void testGetEmployee(){

        Employee emp=new Employee(1,"Aashi");

        when(repository.findEmployee(1))
        .thenReturn(emp);


        Employee result=service.getEmployee(1);


        assertEquals("Aashi", result.getName());

        System.out.println("Spring Service Test Passed");

    }

}