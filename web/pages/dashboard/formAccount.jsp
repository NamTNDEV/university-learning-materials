<%-- 
    Document   : CurriculumAdd
    Created on : Apr 13, 2023, 11:20:49 PM
    Author     : Admin
--%>

<%@page import="config.AppConfig" %>
<%@ page import="entities.Subject" %>
<%@ page import="config.Label" %>
<%@ page import="entities.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entities.Role" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        <%@ include file="/css/style.css" %>
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
    <%
        User account = (User) request.getAttribute(AppConfig.DASHBOARD_ACCOUNT);
        ArrayList<Role> lsRole = (ArrayList<Role>) request.getAttribute(AppConfig.DASHBOARD_ROLE_LIST);
        ArrayList<String> lsEducationLevel = (ArrayList<String>) request.getAttribute(AppConfig.DASHBOARD_EDUCATION_LEVEL_LIST);
        Boolean isEdit = account != null;
    %>
    <title><%= isEdit ? Label.DASHBOARD_ACCOUNT_EDIT_TITLE : Label.DASHBOARD_ACCOUNT_ADD_TITLE %>
    </title>
</head>
<body>

<div class="dashboard-container">
    <%@include file="/components/dashboard/sidebar.jspx" %>
    <main>
        <%@include file="/components/dashboard/header.jspx" %>
        <div class="dashboard-content">
            <div class="container" style="margin: 0 auto">
                <legend><%= isEdit ? Label.DASHBOARD_ACCOUNT_EDIT_TITLE : Label.DASHBOARD_ACCOUNT_ADD_TITLE %>
                </legend>
                <form class="mt-4" method="POST"
                      id="account-form" style="margin: 0 auto;">
                    <div class="row g-3 align-items-center mt-1">
                        <div class="col-2">
                            <label for="fullName" class="col-form-label" style="font-size: 16px;">Full
                                Name</label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <input type="text" name="fullName" id="fullName" class="form-control"
                                   value="<%= isEdit && account.getFullName()!= null ? account.getFullName(): "" %>"
                            >
                        </div>
                    </div>
                    <div class="row g-3 align-items-center mt-1">
                        <div class="col-2">
                            <label for="email" class="col-form-label" style="font-size: 16px;">Email</label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <input type="email" id="email" name="email" class="form-control"
                                   value="<%= isEdit && account.getEmail() != null ? account.getEmail() : "" %>"
                            >
                        </div>
                    </div>

                    <div class="row g-3 align-items-center" style="margin-top: 23px;">
                        <div class="col-2">
                            <label for="username" class="col-form-label" style="font-size: 16px;">Username</label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <input type="text" name="username" id="username" class="form-control"
                                   value="<%= isEdit ? account.getId() : "" %>" <%= isEdit ? "disabled" : "" %>
                            >
                        </div>
                    </div>

                    <div class="row g-3 align-items-center mt-1">
                        <div class="col-2">
                            <label for="password" class="col-form-label"
                                   style="font-size: 16px;">Password</label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <input type="password" id="password" name="password" class="form-control"
                                   value="<%= isEdit ? "******" : "" %>"
                                <%= isEdit ? "disabled" : "" %>
                            >
                        </div>
                    </div>


                    <div class="row g-3 align-items-center mt-1">
                        <div class="col-2">
                            <label for="roleID" class="col-form-label" style="font-size: 16px;">
                                Role
                            </label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <select style="color: #495057;" name="roleID" id="roleID"
                                    class="form-select">
                                <c:set var="roleID" value="<%=account.getRoleID()%>"/>
                                <c:forEach var="role" items="<%=lsRole%>">
                                    <option value="${role.id}" ${role.id.equals(roleID) ? "selected" : ""}>${role.roleName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center mt-1">
                        <div class="col-2">
                            <label for="educationLevel" class="col-form-label" style="font-size: 16px;">
                                Education Level
                            </label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <select name="educationLevel" id="educationLevel"
                                    class="form-select">
                                <c:set var="educationLevel" value="<%=account.getEducationLevel() %>"/>
                                <c:forEach var="edu" items="<%=lsEducationLevel%>">
                                    <option value="${edu}" ${edu.equals(educationLevel) ? "selected" : ""}>${edu}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div style="margin-left: auto; margin-top: 32px;">
                        <button id="btn-submit" type="submit"
                                class="btn btn-primary"><%= isEdit ? Label.DASHBOARD_ACCOUNT_EDIT_SUBMIT_BTN : Label.DASHBOARD_ACCOUNT_ADD_TITLE %>
                        </button>
                        <button onclick="history.back()" id="btn-save" type="button" class="btn btn-secondary"
                        >Cancel
                        </button>
                    </div>
                    <div class="alert alert-danger" id="submit-error" role="alert"
                         style="margin-top: 20px; margin-right: 4px; display: none;">
                        SUBMIT_MESSAGE
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/slugify@1.6.6/slugify.min.js"></script>
<script src="https://unpkg.com/read-excel-file@5.x/bundle/read-excel-file.min.js"></script>
<script>

    $(document).ready(function () {
            // renderBasicInf();
            $("#account-form").submit(function (e) {
                $(':disabled').each(function (e) {
                    $(this).removeAttr('disabled');
                })
            });
        }
    );
</script>
</body>

</html>