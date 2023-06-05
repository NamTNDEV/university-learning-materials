<%-- 
    Document   : viewSyllabus
    Created on : Apr 16, 2023, 6:46:29 PM
    Author     : admin
--%>
<%@page import="config.AppConfig" %>
<%@page import="java.util.ArrayList" %>
<%@page import="entities.Syllabus" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/components/common/head.jspf" %>
    <title>List Syllabus</title>
</head>
<body>
<%
    ArrayList<Syllabus> lsSyllabus = (ArrayList<Syllabus>) request.getAttribute(AppConfig.DASHBOARD_SYLLABUS_LIST);
%>
<div class="dashboard-container">
    <%@include file="/components/dashboard/sidebar.jspx" %>
    <main>
        <%@include file="/components/dashboard/header.jspx" %>
        <div class="dashboard-content">
            <div class="container-xl" style="margin-top: 32px">
                <div class="ulm-table__container">
                    <table class="ulm-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Subject Code</th>
                            <th>Name</th>
                            <th>Status</th>
                            <th>CreatedAt</th>
                            <th>UpdatedAt</th>
                            <th>isApproved</th>
                            <th>Edit</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="syl" items="<%= lsSyllabus%>">
                            <td>${syl.id}</td>
                            <td>${syl.subjectID}</td>
                            <td>${syl.name}</td>
                            <td>${syl.status}</td>
                            <td>${syl.createdAt}</td>
                            <td>${syl.updatedAt}</td>
                            <td>${syl.isApproved}</td>
                            <td>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-outline-primary btn-sm">Edit</button>
                                    <button type="button" class="btn btn-outline-danger btn-sm">Delete</button>
                                </div>
                            </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>
