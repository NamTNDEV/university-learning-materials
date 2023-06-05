<%-- 
    Document   : detail
    Created on : Apr 6, 2023, 2:06:43 PM
    Author     : quocb
--%>

<%@page import="entities.Subject"%>
<%@page import="java.util.List"%>
<%@page import="com.sun.org.glassfish.external.probe.provider.annotations.Probe"%>
<%@page import="entities.ProgramObjective"%>
<%@page import="config.AppConfig"%>
<%@page import="entities.Syllabus"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <%
            Syllabus syl = (Syllabus) request.getAttribute(AppConfig.SYLLABUS_ITEM);
            String preRequisite = (String) request.getAttribute(AppConfig.REQUISITE_ITEM);
            List cloList = (List) request.getAttribute(AppConfig.CLO_LIST);
            List ssList = (List) request.getAttribute(AppConfig.SESSION_LIST);
            List mtList = (List) request.getAttribute(AppConfig.MATERIALS_LIST);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/components/common/head.jspf" %>
        <title><%= syl.getName()%></title>
    </head>
    <body>
        <%@include file="/components/common/header.jspf" %>
        <main class="container mt-5" id="main-content">
            <div class="row" style="column-gap: 32px;">
                <div class=" over-hamburger d-md-none flex-column d-flex align-items-center justify-content-between">
                    <div class="hamburger flex-column d-flex align-items-center justify-content-between">
                        <div class="bar"></div>
                    </div>
                </div>
                <div class="nav_mobile d-md-none">
                    <nav class="nav nav-pills flex-column">
                        <a class="nav-link" href="#item-1">Description</a>
                        <a id="nav-pa-mobile" class="nav-link" href="#item-2">Objectives</a>
                        <a class="nav-link ms-3 my-1 nav-chi-mobile" href="#item-2-1">Course Learning Objectives</a>
                        <a class="nav-link" href="#item-3">Materials & Tools</a>
                        <a class="nav-link" href="#item-3">Sessions</a>
                        <a class="nav-link" href="#item-3">Student Tasks</a>
                    </nav>
                </div>
                <div class="col-3 sidebar" style="position:relative">
                    <nav id="navbar" class="h-100 flex-column align-items-stretch">
                        <nav class="nav nav-pills flex-column">
                            <a class="nav-link" href="#item-1">Description</a>
                            <a class="nav-link" href="#item-2">Objectives</a>
                            <nav class="nav nav-pills flex-column">
                                <a class="nav-link ms-3 my-1" href="#item-2-1">Course Learning Objectives</a>
                            </nav>
                            <a class="nav-link" href="#item-3">Materials & Tools</a>
                            <a class="nav-link" href="#item-3">Sessions</a>
                            <a class="nav-link" href="#item-3">Student Tasks</a>
                        </nav>
                    </nav>
                </div>
                <div class="col-8 text-content">
                    <div data-bs-spy="scroll" data-bs-target="#navbar" data-bs-smooth-scroll="true" class="scrollspy-example-2" tabindex="0"
                         >
                        <div id="item-1">
                            <span class="badge text-bg-primary">Syllabus</span>
                            <h4 class="page-title mt-4"><%= syl.getSubjectID() + " - " + syl.getName()%></h4>
                            <div class="d-flex align-items-center gap-5 mt-3">
                                <p style="font-size: 14px;">Approved at 12/22/2022</p>
                                <p style="font-size: 14px;">1341/QĐ-ĐHFPT</p>
                            </div>
                            <div class="">
                                <p>Number of Credit: <%= syl.getCredit()%></p>
                            </div>
                            <div class="">
                                <p class="mb-0">Scoring scale: <%= syl.getScoringScale()%></p>
                                <p>Min average score: <%= syl.getMinScore()%></p>
                            </div>
                            <div class="">
                                <p>Pre-Requisite: <%= preRequisite%></p>
                            </div>
                            <div class="">
                                <p>Time Allocation</p>
                            </div>
                            <h4 class="page-title">Description</h4>
                            <div class="d-flex align-items-center gap-5 mt-3">
                                <c:out value="<%=syl.getDescription().trim()%>" escapeXml="false"/>
                            </div>
                        </div>

                        <div id="item-2">
                            <h4 class="page-title">Objectives</h4>
                            <div id="item-2-1">
                                <h5>1. Course Learning Objectives</h5>
                                <table class="table table-striped table-bordered">
                                    <thead class="table-info">
                                        <tr>
                                            <th></th>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>SyllabusID</th>
                                            <th>CreatedAt</th>
                                            <th>UpdatedAt</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="clo" items="<%= cloList%>" varStatus="loop">
                                            <tr>
                                                <td>${loop.count}</td>
                                                <td>${clo.name}</td>
                                                <td>${clo.description}</td>
                                                <td>${clo.syllabusID}</td>
                                                <td>${clo.createdAt}</td>
                                                <td>${clo.updatedAt}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div id="item-3">
                            <h4 class="page-title">Materials & Tools</h4>
                            <table class="table table-striped table-bordered">
                                <thead class="table-info">
                                    <tr>
                                        <th></th>
                                        <th>Name</th>
                                        <th>MaterialUri</th>
                                        <th>SyllabusID</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="mt" items="<%= mtList%>" varStatus="loop">
                                        <tr>
                                            <td>${loop.count}</td>
                                            <td>${mt.name}</td>
                                            <td>${mt.materialUri}</td>
                                            <td>${mt.syllabusID}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div id="item-4">
                            <h4 class="page-title">Sessions</h4>
                            <table class="table table-striped table-bordered">
                                <thead class="table-info">
                                    <tr>
                                        <th></th>
                                        <th>Topic</th>
                                        <th>LearningType</th>
                                        <th>LO_ID</th>
                                        <th>Materials</th>
                                        <th>StudentTasks</th>
                                        <th>SyllabusID</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="ss" items="<%= ssList%>" varStatus="loop">
                                        <tr>
                                            <td>${loop.count}</td>
                                            <td>${ss.topic}</td>
                                            <td>${ss.learningType}</td>
                                            <td>${ss.LO_ID}</td>
                                            <td>${ss.materials}</td>
                                            <td>${ss.studentTasks}</td>
                                            <td>${ss.syllabusID}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div id="item-4">
                            <h4 class="page-title">Student Tasks</h4>
                            <div class="">
                                <p>Number of Credit: <%= syl.getTasks()%></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>       
        </main>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sticky-sidebar/3.3.1/sticky-sidebar.min.js" integrity="sha512-iVhJqV0j477IrAkkzsn/tVJWXYsEqAj4PSS7AG+z1F7eD6uLKQxYBg09x13viaJ1Z5yYhlpyx0zLAUUErdHM6A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script type="text/javascript">
            var sidebar = new StickySidebar('#navbar', {
                containerSelector: '#main-content',
                innerWrapperSelector: '.sidebar',
                topSpacing: 20,
                bottomSpacing: 20
            });
        </script>

        <!-- Hamburgur button and navbar animation ( open and close) -->
        <script>
            const menu_btn = document.querySelector('.hamburger');
            const nav_mobile = document.querySelector('.nav_mobile');

            menu_btn.addEventListener('click', function () {
                menu_btn.classList.toggle('is-active');
                nav_mobile.classList.toggle('is-active');
            });
        </script>

        <!-- Navbar_mobile click animation -->
        <script type="text/javascript">
            $(document).ready(function () {
                $('.nav_mobile a').on('click', function () {
                    if ($(this).context.className.indexOf('nav-chi-mobile') > 0) {
                        $(this).siblings().removeClass('is-active');
                        $(this).addClass('is-active');
                        const xxx = document.getElementById("nav-pa-mobile");
                        xxx.classList.add('is-active');
                    } else {
                        $(this).siblings().removeClass('is-active');
                        $(this).addClass('is-active');
                    }

                })
            });
        </script>
    </body>
</html>
