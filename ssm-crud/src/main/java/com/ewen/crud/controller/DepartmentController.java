package com.ewen.crud.controller;

import com.ewen.crud.pojo.Department;
import com.ewen.crud.pojo.Msg;
import com.ewen.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求
 * @author ShadowStart
 * @create 2021-04-18 14:58
 */
@Controller
public class DepartmentController {

    private DepartmentService departmentService;

    @Autowired
    private void setDepartmentService(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    /**
     * 返回所有的部门信息
     * @return
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts() {
        // 查出的所有部门信息
        List<Department> depts =  departmentService.getDepts();
        return Msg.success().add("depts", depts);
    }

}
