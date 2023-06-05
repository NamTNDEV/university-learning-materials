<%-- 
    Document   : update-password
    Created on : Apr 7, 2023, 11:33:34 AM
    Author     : duyba
--%>

<%@page import="config.AppConfig"%>
<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/components/common/head.jspf" %>
        <title>JSP Page</title>
    </head>
    <body class="w-100">
        <%@include file="/components/common/header.jspf" %>
        <div class="container h-100">
            <div class="d-flex justify-content-center align-items-center h-100">
                <form class="mx-auto" action="./update-password" method="POST" id="update-password-form">
                    <div class="header col-md-12 col-12 text-center">
                        Update Password
                    </div>
                    <div class="col-md-12" id="student-id-input">
                        <div class="form-group">
                            <label class="mb-2" for="studentId"><strong>Student ID : </label>
                            <span id="studentId" class="form-control-static">${sessionScope.USER.id}</span>
                        </div>
                        <input type="hidden" name="userId" value="${sessionScope.USER.id}">
                    </div>
                    <div class="col-md-12" id="current-password-input">
                        <div class="form-group">
                            <label class="mb-2" for="currentPassword">Current Password</label>
                            <input type="password" name="current-password" id="currentPassword" class="form-control" required="">
                        </div>
                    </div>
                    <div class="col-md-12" id="new-password-input">
                        <div class="form-group">
                            <label class="mb-2" for="newPassword">New Password</label>
                            <input type="password" name="password" id="newPassword" class="form-control" required="">
                        </div>
                    </div>
                    <div class="col-md-12" id="confirm-password-input">
                        <div class="form-group">
                            <label class="mb-2" for="confirmPassword">Confirm Password</label>
                            <input type="password" name="confirm-password" id="confirmPassword" class="form-control" required="">
                        </div>
                    </div>
                    <div class="col-md-12" id="error-message"></div>
                    <br/>
                    <button class="btn-primary btn btn-block col-md-12 col-12 gap-2" id="btn-update">Update<i
                            class="fa-solid fa-arrow-right-long"></i>
                    </button>
                </form>
            </div>
        </div> 
    </body>
    <%
        User user = (User) request.getSession().getAttribute(AppConfig.AUTH_USER);
        String password = user.getPassword();
        System.out.println(password);
    %>
    <script>
        var currentPasswordLabel = document.querySelector('label[for="currentPassword"]');
        var currentPasswordInput = document.getElementById("currentPassword");
        var password = "<%= password%>";
        console.log("day la " + password);
        if (password === "null" || password === "") {
            currentPasswordLabel.remove();
            currentPasswordInput.remove();
        }
    </script>



</html>