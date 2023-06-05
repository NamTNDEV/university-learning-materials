<%--
  Created by IntelliJ IDEA.
  User: quocb
  Date: 4/28/2023
  Time: 8:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/components/common/head.jspf" %>
    <title>ULM Dashboard</title>
</head>
<body>
<div class="dashboard-container">
    <%@include file="/components/dashboard/sidebar.jspx" %>
    <main>
        <%@include file="/components/dashboard/header.jspx" %>
        <div class="dashboard-content">
        </div>
    </main>
</div>
</body>
</html>
