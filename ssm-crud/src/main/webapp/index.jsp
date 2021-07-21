<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%-- 员工修改的模态框 --%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">NAME</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="xxx@xxx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-6">
                            <%-- 部门提交ID即可 --%>
                            <select class="form-control" name="deptId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">NAME</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="Name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="xxx@xxx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-6">
                            <%-- 部门提交ID即可 --%>
                            <select class="form-control" name="deptId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%-- 标题 --%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%-- 按钮 --%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%-- 显示表格数据 --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>NAME</th>
                        <th>GENDER</th>
                        <th>EMAIL</th>
                        <th>DEPARTMENT</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%-- 显示分页信息 --%>
    <div class="row">
        <%-- 分页文字信息 --%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%-- 分页条信息 --%>
        <div class="col-md-6" id="page_navigate_area">

        </div>
    </div>
</div>
<script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    // 1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        let totalRecord,flag,currentPage;
        // 去首页
        to_page(1);

        function to_page(pageNo) {
            $("#check_all").prop("checked", false);
            $.ajax({
                url : "${APP_PATH}/emps",
                data : "pageNo=" + pageNo,
                type : "GET",
                success : function (result) {
                    // console.log(result);
                    // 1、解析并显示员工数据
                    build_emp_table(result);
                    // 2、解析并显示分页信息
                    build_page_info(result);
                    // 3、解析显示分页条
                    build_page_navigate(result);
                }
            });
        }

        function build_emp_table(result) {
            // 清空table表格
            $("#emps_table tbody").empty();
            let emps = result.extend.pageInfo.list;
            $.each(emps, function (index, item) {
                let checkbox = $("<td></td>").append("<input type='checkbox' class='check_item'/>");
                let empIdTd =  $("<td></td>").append(item.empId);
                let empNameTd =  $("<td></td>").append(item.empName);
                let genderTd =  $("<td></td>").append(item.gender=="M"? "M":"F");
                let emailTd =  $("<td></td>").append(item.email);
                let deptNameTd =  $("<td></td>").append(item.department.deptName);
                /*
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                    编辑
                </button>
                 */
                let editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                    .append(" 编辑");
                // 为编辑按钮添加自定义属性，来表示当前员工的id
                editBtn.attr("edit_id", item.empId);
                let delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append(" 删除");
                // 为删除按钮添加一个自定义属性，来表示当前员工的id
                delBtn.attr("del_id", item.empId);
                let btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                $("<tr></tr>").append(checkbox)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }

        // 解析显示分页信息
        /*
            当前<span class="label label-info">?</span>页,
            共<span class="label label-info">?</span>条记录,
            总共<span class="label label-info">?</span>页
         */
        function build_page_info(result) {
            let pageInfo = result.extend.pageInfo;
            totalRecord = pageInfo.pages + 1;
            $("#page_info_area").empty();
            let currentPage = $("<span></span>").addClass("label label-info").append(pageInfo.pageNum);
            let totalNum = $("<span></span>").addClass("label label-info").append(pageInfo.total);
            let pages = $("<span></span>").addClass("label label-info").append(pageInfo.pages);
            $("#page_info_area").append("当前").append(currentPage).append("页,共").append(totalNum).append("条记录,总共")
            .append(pages).append("页");
        }
        
        // 解析显示分页条
        function build_page_navigate(result) {
            $("#page_navigate_area").empty();
            let pageInfo = result.extend.pageInfo;
            currentPage = pageInfo.pageNum;
            let ul = $("<ul></ul>").addClass("pagination");

            let firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            let prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
            if (pageInfo.hasPreviousPage == false) {
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            } else {
                firstPageLi.click(function () {
                    to_page(1)
                });
                prePageLi.click(function() {
                    to_page(pageInfo.pageNum - 1);
                });
            }

            let nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
            let lastPageLi = $("<li></li>").append($("<a></a>").append("末尾").attr("href", "#"));
            if (pageInfo.hasNextPage == false) {
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            } else {
                nextPageLi.click(function() {
                    to_page(pageInfo.pageNum + 1);
                });
                lastPageLi.click(function() {
                    to_page(pageInfo.pages);
                });
            }
            // 添加首页和前一页
            ul.append(firstPageLi).append(prePageLi);
            // 遍历给ul添加页码
            $.each(pageInfo.navigatepageNums, function (index, item) {
                let numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
                if(pageInfo.pageNum == item) {
                    numLi.addClass("active");
                } else {
                    numLi.click(function() {
                        to_page(item);
                    });
                }
                ul.append(numLi);
            });
            // 添加下一页和末页
            ul.append(nextPageLi).append(lastPageLi);

            // 把ul添加到nav标签中
            let navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_navigate_area");
        }

        // 清空表单样式及内容
        function reset_form(ele) {
            $(ele)[0].reset(); // 因为jquery没有reset方法，所以要取出dom对象调用
            // 清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        // 点击新增按钮弹出模态框
        $("#emp_add_modal_btn").click(function () {
            // 清除表单数据
            reset_form("#empAddModal form");
            // 发送ajax请求，查出部门信息，显示在下拉列表
            getDepts("#dept_add_select");
            // 弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });

        // 查出所有的部门信息并显示在下拉列表中
        function getDepts(ele) {
            $(ele).empty();
            $.ajax({
                url : "${APP_PATH}/depts",
                type : "GET",
                success : function (result) {
                    // 显示部门信息在下拉列表中
                    $.each(result.extend.depts, function () {
                        let optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }

        // 校验表单数据
        function validate_add_form() {
            // 1、拿到要校验的数据，使用正则表达式进行校验
            let empName = $("#empName_add_input").val();
            let regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{3,10})/;
            if(!regName.test(empName)) {
                show_validate_msg("#empName_add_input", "error", "名字由6-16个字母或3到10个汉字构成");
                return false;
            } else {
                show_validate_msg("#empName_add_input", "success", "");
            }

            let email = $("#email_add_input").val();
            let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)) {
                show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
                return false;
            } else {
                show_validate_msg("#email_add_input", "success", "");
            }
            return true;
        }

        $("#empName_add_input").blur(function () {
            let empName = $("#empName_add_input").val();
            let regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{3,10})/;
            if(!regName.test(empName)) {
                show_validate_msg("#empName_add_input", "error", "名字由6-16个字母或3到10个汉字构成");
            } else {
                show_validate_msg("#empName_add_input", "success", "");
            }
        });

        $("#email_add_input").blur(function () {
            let email = $("#email_add_input").val();
            let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)) {
                show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            } else {
                show_validate_msg("#email_add_input", "success", "");
            }
        });

        function show_validate_msg(ele, status, msg) {
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if ("success" == status) {
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            } else if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        // 检验用户名是否可用
        $("#empName_add_input").change(function () {
            // 发送ajax请求校验用户名是否可用
            var empName = this.value;
            $.ajax({
                url : "${APP_PATH}/checkUser",
                data : "empName=" + empName,
                type : "POST",
                success : function (result) {
                    if (result.code == 100) {
                        show_validate_msg("#empName_add_input", "success", "用户名可用");
                        $("#emp_save_btn").attr("ajax-validate", "success");
                    } else {
                        show_validate_msg("#empName_add_input", "error", result.extend.vali_msg);
                        $("#emp_save_btn").attr("ajax-validate", "error");
                    }
                }
            });
        });

        // 点击保存员工
        $("#emp_save_btn").click(function () {
            // 1、模态框中填写的表单数据提交给服务器进行保存
            // 先对要提交给服务器的数据进行校验
            if (!validate_add_form()) {
                return;
            }
            // 1、判断之前的ajax用户名效验是否成功
            if ("error" == $(this).attr("ajax-validate")) {
                show_validate_msg("#empName_add_input", "error", "用户名不可用");
                return;
            }
            // 2、发送ajax请求保存员工
            $.ajax({
                url : "${APP_PATH}/emp",
                type : "POST",
                data : $("#empAddModal form").serialize(),
                success : function(result) {
                    if (result.code == 100) {
                        // 员工保存成功
                        // 1、关闭模态框
                        $("#empAddModal").modal('hide');
                        // 2、来到最后一页，显示刚刚保存的数据
                        // 发送ajax请求显示最后一页数据
                        to_page(totalRecord);
                    } else {
                        // 显示失败信息
                        // 有哪个字段的错误信息就显示哪个字段的
                        if (undefined != result.extend.errorFields.email) {
                            // 显示邮箱的错误信息
                            show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                        }
                        if (undefined != result.extend.errorFields.empName) {
                            // 显示员工名字的错误信息
                            show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                        }
                    }
                }
            });
        });

        // 1、我们是按钮创建之前就绑定了，所以是绑定不上
        // 我们可以在创建按钮的时候绑定
        $(document).on("click", ".edit_btn", function () {
            // 1、查出部门信息，并显示部门列表
            getDepts("#dept_update_select");
            // 2、查出员工信息，显示员工信息
            getEmp($(this).attr("edit_id"));
            // 3、把员工的id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        }); 
        
        function getEmp(id) {
            $.ajax({
                url : "${APP_PATH}/emp/" + id,
                type : "GET",
                success : function (result) {
                    let empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#email_update_input").val(empData.email);
                    $("#dept_update_select").val([empData.deptId]);
                }
            });
        }

        // 点击更新，更新员工信息
        $("#emp_update_btn").click(function () {
            // 验证邮箱是否合法
            let email = $("#email_update_input").val();
            let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)) {
                show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
                return;
            } else {
                show_validate_msg("#email_update_input", "success", "");
            }

            // 发送ajax请求保存更新员工的数据
            $.ajax({
                url : "${APP_PATH}/emp/" + $(this).attr("edit_id"),
                method : "PUT",
                data : $("#empUpdateModal form").serialize(),
                success : function (result) {
                    if (result.code == 100) {
                        // 关闭对话框
                        $("#empUpdateModal").modal("hide");
                        // 回到本页面
                        to_page(currentPage);
                    }
                }
            });
        });

        // 单个删除
        $(document).on("click", ".delete_btn", function () {
            // 1、弹出是否确认删除对话框
            let empName = $(this).parents("tr").find("td:eq(2)").text();
            let empId = $(this).attr("del_id");
            if (confirm("确认删除【"+ empName + "】吗？")) {
                // 确认发送ajax请求删除即可
                $.ajax({
                    url : "${APP_PATH}/emp/" + empId,
                    type : "DELETE",
                    success : function(result) {
                        if (result.code == 100) {
                            to_page(currentPage);
                        }
                    }
                });
            }
        });

        // 完成全选、全不选功能
        $("#check_all").click(function () {
            // attr获取checked总是undefined
            // 我们这些dom原生的属性；推荐用prop；prop修改和读取dom原生属性的值
            // attr获取自定义属性的值
            $(".check_item").prop("checked", $(this).prop("checked"));
        });

        // check_item
        $(document).on("click", ".check_item", function () {
            // 判断当前选择中的元素是否选满
            let falg = $(".check_item:checked").length == $(".check_item").length;
                $("#check_all").prop("checked", falg);
        });

        let empNames = "";
        let del_ids = "";
        $("#emp_delete_all_btn").click(function () {
            empNames = "";
            del_ids = "";
            $.each($(".check_item:checked"), function () {
                empNames += $(this).parents("tr").find("td:eq(2)").text() + "，";
                // 组装员工id字符串
                del_ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });
            // 去除empNames多余的逗号
            empNames = empNames.substring(0, empNames.length - 1);
            // 去除del_ids多余的逗号
            del_ids = del_ids.substring(0, del_ids.length - 1);
            if (confirm("确认删除【"+ empNames +"】吗？")) {
                // 发送ajax请求删除
                $.ajax({
                    url : "${APP_PATH}/emp/" + del_ids,
                    type : "DELETE",
                    success : function (result) {
                        if (result.code == 100) {
                            to_page(currentPage);
                        }
                    }
                });
            }
        });
    })
</script>
</body>
</html>
