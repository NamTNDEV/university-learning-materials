<%@page import="config.AppConfig" %>
<%@page import="java.util.ArrayList" %>
<%@page import="entities.Curriculum" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/components/common/head.jspf" %>
    <title>List Curriculum</title>
</head>
<body>
<%
    ArrayList<Curriculum> lsCur = (ArrayList<Curriculum>) request.getAttribute(AppConfig.DASHBOARD_CURRICULUM_LIST);
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
                            <th style="width:100px">
                                <input type="checkbox"/>
                            </th>
                            <th style="width:120px">ID</th>
                            <th>Name</th>
                            <th style="width: 150px">Status</th>
                            <th style="width: 150px">Edit</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="cur" items="<%= lsCur%>">
                            <tr onclick="((e) => {e.stopPropagation(); viewCurriculum(${cur.id});})()">
                                <td>
                                    <input type="checkbox"/>
                                </td>
                                <td>${cur.id}</td>
                                <td>${cur.name}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cur.active}">
                                            <span class="badge rounded-pill text-bg-success">active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge rounded-pill text-bg-secondary">in-active</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-outline-primary btn-sm"
                                                onclick="window.location.href='${pageContext.request.servletContext.contextPath}/dashboard/curriculums/edit?id=${cur.id}'"
                                                style="height: 100%;">Edit
                                        </button>
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

<script>
    function viewCurriculum(e, curriculumId) {
        const url = "${pageContext.servletContext.contextPath}/dashboard/curriculums/edit?id=" + curriculumId;
        window.location.href = url;
    }
</script>
</body>
</html>

