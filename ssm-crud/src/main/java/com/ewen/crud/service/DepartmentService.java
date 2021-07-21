package com.ewen.crud.service;

import com.ewen.crud.dao.DepartmentMapper;
import com.ewen.crud.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ShadowStart
 * @create 2021-04-18 14:59
 */
@Service
public class DepartmentService {

    private DepartmentMapper departmentMapper;

    @Autowired
    private void setDepartmentMapper(DepartmentMapper departmentMapper) {
        this.departmentMapper = departmentMapper;
    }

    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
