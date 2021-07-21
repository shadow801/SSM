package com.ewen.crud.controller;

import com.ewen.crud.pojo.Employee;
import com.ewen.crud.pojo.Msg;
import com.ewen.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import sun.misc.Request;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ShadowStart
 * @create 2021-04-17 15:43
 */
@Controller
public class EmployeeController {

    private EmployeeService employeeService;

    @Autowired
    private void setEmployeeService(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    /**
     * 单个批量二合一
     * 批量删除
     * @param
     * @return
     */
    @ResponseBody
        @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            // 批量删除
            List<Integer> delIds = new ArrayList<>();
            String[] strIds = ids.split("-");
            for (String id : strIds) {
                delIds.add(Integer.valueOf(id));
            }
            employeeService.deleteBatch(delIds);
        } else {
            // 单个删除
            Integer id = Integer.valueOf(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    /**
     * 员工更新方法
     *
     * 问题：
     * 请求体中有数据
     * 当是Employee对象封装不上
     * update t_emp where emp_id = 1014
     *
     * 原因：
     * Tomcat：
     *  1、将请求体中的数据，封装一个map，
     *  2、request.getParameter("empName")就会从这个map中取值
     *  3、SpringMVC封装POJO对象的时候，
     *          会把POJO中每个属性的值，request.getParameter("email");
     *AJAX发送PUT请求引发的血案：
     *      PUT请求：请求体中的数据，request.getParameter("empName")拿不到
     *      Tomcat一看是PUT请求，不会分装请求体中的数据为map，只有POST形式的请求才封装请求体为map
     * 我们要能支持直接发送PUT之类的请求，还要能封装请求体中的数据
     * 1、配置上FormContentFilter：
     * 2、作用：将请求体中的数据解析包装成一个map。
     * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg updateSaveEmp(Employee employee, HttpServletRequest request) {
        System.out.println("请求体中的值：" + request.getParameter("gender"));
        System.out.println("将要更新的员工数据：" + employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName) {
        // 先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{3,10})";
        if (!empName.matches(regx)) {
            return Msg.failed().add("vali_msg", "名字由6-16个字母或3到10个汉字构成");
        }
        // 数据库用户名重复校验
        boolean flag = employeeService.checkUser(empName);
        if (flag) {
            return Msg.success();
        }

        return Msg.failed().add("vali_msg", "用户名不可用");
    }

    /**
     * 员工保存
     * 1、支持JSR303效验
     * 2、导入hibernate-Validator
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "emp", method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            // 校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.failed().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * @ResponseBody 正常工作需要导入jackson包
     * @param pageNo
     * @return
     */
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo) {
        // 这不是一个分页查询
        // 引入PageHelper分页插件
        PageHelper.startPage(pageNo, 8);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> employees = employeeService.getAll();
        //用PageInfo对结果进行包装，第二个参数可以传入连续显示的页数
        PageInfo pageInfo = new PageInfo(employees, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 查询员工数据（分页查询）
     * @return
     */
//    @RequestMapping("/emps")
    public String getEmployees(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo,
                               Model model) {
        // 这不是一个分页查询
        // 引入PageHelper分页插件
        PageHelper.startPage(pageNo, 8);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> employees = employeeService.getAll();
        //用PageInfo对结果进行包装，第二个参数可以传入连续显示的页数
        PageInfo pageInfo = new PageInfo(employees, 5);
        model.addAttribute("pageInfo", pageInfo);

        return "list";
    }
}
