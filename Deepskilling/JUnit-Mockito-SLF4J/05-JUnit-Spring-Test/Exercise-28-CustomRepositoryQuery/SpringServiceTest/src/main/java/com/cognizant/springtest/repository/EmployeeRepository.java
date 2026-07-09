package com.cognizant.springtest.repository;

import com.cognizant.springtest.entity.Employee;

public interface EmployeeRepository {

    Employee findEmployee(int id);

}