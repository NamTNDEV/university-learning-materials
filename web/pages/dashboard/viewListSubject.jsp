<%-- 
    Document   : viewSyllabus
    Created on : Apr 16, 2023, 6:46:29 PM
    Author     : admin
--%>
<%@page import="config.AppConfig" %>
<%@page import="java.util.ArrayList" %>
<%@page import="entities.Syllabus" %>
<%@ page import="entities.Subject" %>
<%@ page import="entities.User" %>
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
    ArrayList<Subject> lsSubject = (ArrayList<Subject>) request.getAttribute(AppConfig.DASHBOARD_SUBJECT_LIST);
    User user = (User) request.getSession().getAttribute(AppConfig.AUTH_USER);
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
                            <th scope="col">ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Semester</th>
                            <th scope="col">Status</th>
                            <th scope="col">CreatedAt</th>
                            <th scope="col">UpdatedAt</th>
                            <th scope="col">Edit</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="sub" items="<%= lsSubject%>">
                            <td>${sub.id}</td>
                            <td>${sub.name}</td>
                            <td>${sub.semester}</td>
                            <td>
                                <c:choose>
                                    <c:when test='<%=user.getRoleID().equals("ADM")%>'>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input subject-status" type="checkbox" role="switch"
                                                   data-subject-id="${sub.id.trim()}"
                                                ${sub.active ? "checked" : ""}>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${sub.active}">
                                                <span class="badge rounded-pill text-bg-success">active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge rounded-pill text-bg-secondary">in-active</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>

                            </td>
                            <td>${sub.createdAt}</td>
                            <td>${sub.updatedAt}</td>
                            <td>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-outline-primary btn-sm"
                                            onclick="window.location.href='${pageContext.servletContext.contextPath}/dashboard/subjects/edit?id=${sub.id.trim()}'">
                                        Edit
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
    <%@ include file="/js/main.js" %>
</script>
<script>
    $(document).ready(() => {
        const checkboxes = document.querySelectorAll('.form-check input');
        console.log({checkboxes})
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', async (event) => {
                const subjectId = event.target.dataset.subjectId;
                const active = event.target.checked

                const isConfirm = confirm(`Are you sure to \${active ? "active" : "in active"} \${subjectId}?`);

                if (!isConfirm) return;
                const url = "${pageContext.servletContext.contextPath}/dashboard/subjects/update-status";
                const data = {
                    subject_id: subjectId,
                    active: active
                }
                const options = {
                    method: "POST",
                    body: JSON.stringify(data)
                }

                try {
                    startLoading();
                    const res = await fetch(url, options);
                    const result = await res.json();
                    if (!res.ok) {
                        throw new Error(result.message);
                    }
                    alert(result.message)
                } catch (e) {
                    console.error(e)
                    alert("Cannot update status of " + subjectId);
                }
                stopLoading();
            });
        });
    })

</script>
</body>
</html>
