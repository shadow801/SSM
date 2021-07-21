package com.ewen.crud.test;

import com.ewen.crud.dao.DepartmentMapper;
import com.ewen.crud.dao.EmployeeMapper;
import com.ewen.crud.pojo.Department;
import com.ewen.crud.pojo.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试Dao层的工作
 * 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 1、导入Spring模块
 * 2、@ContextConfiguration：指定spring配置文件的位置
 * 3、直接autowired要使用的组件即可
 * @author ShadowStart
 * @create 2021-04-17 13:26
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class MapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private SqlSession sqlSession;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD() {
        // 插入几个部门
//        departmentMapper.insertSelective(new Department(null, "外向力部"));
        departmentMapper.insertSelective(new Department(null, "科技部"));

        //  生成员工数据，测试员工插入
//        employeeMapper.insertSelective(new Employee(null, "ruby", "F", "ruby@ruby.com", 3));

        // 批量插入多个员工，使用可以执行批量操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 1; i <= 1000; i++) {
            mapper.insertSelective(new Employee(null, "御坂" + i, "F", "misaka@misaka.com", 1));
        }
        System.out.println("批量完成");
    }



}
