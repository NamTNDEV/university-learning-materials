<%-- 
    Document   : editSyllabus
<<<<<<< Updated upstream
    Created on : Apr 18, 2023, 3:40:44 PM
    Author     : admin
--%>

<%@page import="entities.Syllabus"%>
<%@page import="config.AppConfig"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            <%@ include file="/css/style.css" %>
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
        <title>Edit Syllabus</title>
    </head>
    <%
        Syllabus syl = (Syllabus) request.getAttribute(AppConfig.DASHBOARD_SYLLABUS_TARGET);
    %>
    <body>
        <div class="container-fluid h-100">
            <div class="row h-100">
                <div class="left col-md-2" style="background-color: rgba(5, 44, 101, 1); width: 212px;">
                    <h2 style="color: #FFFFFF; font-family: 'Inter'; font-size: 20px;">
                        ULM Dashboard
                    </h2>
                </div>
                <div class="right col-md-10">
                    <header>
                        <div class="d-flex align-items-center justify-content-between container">
                            <a href="#">
                                <h3></h3>
                            </a>
                            <div class="d-flex align-items-center gap-3">
                                <div class="dropdown">
                                    <div class="dropdown-toggle" type="button" id="menu1" data-bs-toggle="dropdown"
                                         aria-expanded="false" style="margin: 0!important">
                                        <img class="rounded-circle" style="width:40px"
                                             src="https://mdbcdn.b-cdn.net/img/new/avatars/2.webp">
                                        <span class="caret"></span>
                                    </div>
                                    <ul class="dropdown-menu  dropdown-menu-end">
                                        <li><a class="dropdown-item" href="#">Setting</a></li>
                                        <li><a class="dropdown-item" href="#">Logout</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </header>
                    <hr />
                    <main class="col-form-label">
                        <div class="row ms-1">
                            <legend>Edit Syllabus</legend>
                            <form class="mt-4">
                                <input type="hidden" name="id" value="" />
                                <!--Basic information-->
                                <span>Basic Infomation</span>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" name="active" type="checkbox" role="switch"
                                           id="active-switch">
                                    <label class="form-check-label" for="active-switch">Active</label>
                                </div>
                                <div class="">
                                    <div>
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">
                                                Syllabus for
                                            </label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <select style="color: #495057;" name="" id="" class="form-select">
                                                <c:if test="">
                                                    <option selected>Select Subject</option>
                                                </c:if>
                                                <c:forEach var="" items="">
                                                    <option value=""></option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">Subject
                                                code</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="text" id="" name="" class="form-control"
                                                   placeholder="This one are auto generate">
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">
                                                Degree Level
                                            </label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <select style="color: #495057;" name="" id="" class="form-select">
                                                <c:if test="">
                                                    <option selected>Select Subject</option>
                                                </c:if>
                                                <c:forEach var="" items="">
                                                    <option value=""></option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">Time
                                                Allocation</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="text" id="" name="" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <div class="">
                                    <div>
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">Number of
                                                Credit</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="number" id="" name="" class="form-control">
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">Min
                                                Score</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="number" id="" name="" class="form-control" placeholder="0">
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">Max
                                                Score</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="number" id="" name="" class="form-control" placeholder="0">
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">
                                                Pre-requisite
                                            </label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <select style="color: #495057;" name="" id="" class="form-select">
                                                <c:if test="">
                                                    <option selected>Select Pre-requisite Subject</option>
                                                </c:if>
                                                <c:forEach var="" items="">
                                                    <option value=""></option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="" class="col-form-label" style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 751px; margin-left: -40px;">
                                        <textarea class="form-control" name="" required=""></textarea>
                                    </div>
                                </div>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="" class="col-form-label" style="font-size: 16px;">Student
                                            Tasks</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 751px; margin-left: -40px;">
                                        <textarea class="form-control" name="" required=""></textarea>
                                    </div>
                                </div>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="" class="col-form-label" style="font-size: 16px;">Tools</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 751px; margin-left: -40px;">
                                        <textarea class="form-control" name="" required=""></textarea>
                                    </div>
                                </div>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="" class="col-form-label" style="font-size: 16px;">Note</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 751px; margin-left: -40px;">
                                        <textarea class="form-control" name="" required=""></textarea>
                                    </div>
                                </div>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="" class="col-form-label" style="font-size: 16px;">
                                            Decision No
                                        </label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="decisionNo" value="" name="" class="form-control"
                                               required="">
                                    </div>
                                </div>
                                <!--Materials-->
                                <span
                                    style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Materials</span><br>
                                <form class="box" method="post" action="" enctype="multipart/form-data">
                                    <div class="box_input">
                                        <input class="box_file" type="file" name="files[]" id="file"
                                               data-multiple-caption="{count} files selected" multiple />
                                        <label for="file"><strong>Choose a file</strong>
                                            <span class="box_dragndrop" style="display: none;"> or drag it here</span>.</label>
                                        <button class="box_button" type="submit">Upload</button>
                                    </div>
                                    <div class="box_uploading" style="display: none;">Uploading…</div>
                                    <div class="box_success" style="display: none;">Done!</div>
                                    <div class="box_error" style="display: none;">Error! <span></span>.</div>
                                </form>
                                <!-- Objectives -->
                                <span
                                    style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Objectives</span><br>
                                <!-- Objectives / Course Learning Objectives (CLO)-->
                                <span style="font-size: 18px; margin-bottom: 32px; display: inline-block;">
                                    Course Learning Objectives (CLO)
                                </span>
                                <c:if test="">
                                    <table id="ploTbl" style="width: 96%; margin-bottom: 32px;">
                                        <thead>
                                            <tr>
                                                <th style="width: 7.6%;">Name</th>
                                                <th style="width: 65%">Description</th>
                                                <th style="width: 22%; text-align: right;">Map to PLO</th>
                                                <th style="width: 5.4%;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="" items="">
                                                <tr>
                                                    <td style="color: #495057;">${name}</td>
                                                    <td>${description}</td>
                                                    <td style="text-align: right;">${mapToPLO}</td>
                                                    <td>
                                                        <button name="editBtn" type="button"
                                                                style="margin-left: 96%; border: none; background: none"><i
                                                                class="fa-solid fa-pencil"></i></button>
                                                        <button name="cancelBtn" type="button"
                                                                style="margin-left: 96%; border: none; background: none; display: none;"><i
                                                                class="fa-solid fa-x"></i></button>
                                                        <a href=""><i class="fa-solid fa-trash"></i></a>
                                                    </td>
                                                </tr>
                                                <tr style="height: 66px;"></tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="row col-4">
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">Name</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="text" id="" name="" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row col-4">
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">Map to
                                                PLO</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <select style="color: #495057;" name="" id="" class="form-select">
                                                <c:if test="">
                                                    <option selected>Please select</option>
                                                </c:if>
                                                <c:forEach var="" items="">
                                                    <option value=""></option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row col-2">
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">List
                                                of CLO</label>
                                        </div>
                                        <div class="col-12">
                                            <label id="" class="btn btn-secondary">
                                                <input type="file" />
                                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-12">
                                        <label for="" class="col-form-label" style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-12" style="width: 751px; margin-top: 8px;">
                                        <textarea id="" class="form-control" name=""></textarea>
                                    </div>
                                </div>
                                <div style="margin-top: 16px;">
                                    <button type="submit" class="btn btn-primary" name="op" value=""> Add</button>
                                    <button type="submit" class="btn btn-secondary" value=""> Cancel</button>
                                </div>

                                <!--Sessions Table-->
                                <div>
                                    <span
                                        style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Sessions</span><br>
                                    <div style="margin-top: 16px;">
                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                            <i class="fa-regular fa-square-plus"></i> Add</button>
                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                            <input type="file" />
                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                        </label>
                                    </div>
                                </div>
                                <div class="dashboard-container">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <input type="checkbox" />
                                                </th>
                                                <th scope="col">No</th>
                                                <th scope="col">Topic</th>
                                                <th scope="col">Learning Type</th>
                                                <th scope="col">LO</th>
                                                <th scope="col">ITU</th>
                                                <th scope="col">Material</th>
                                                <th scope="col">Included</th>
                                                <th scope="col">Edit</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="sessions" items="" varStatus="loop">
                                                <tr>
                                                    <th scope="row">
                                                        <input type="checkbox" />
                                                    </th>
                                                    <td>${loop.count}</td>
                                                    <td>${sessions.topic}</td>
                                                    <td>${sessions.learningType}</td>
                                                    <td>${sessions.LO}</td>
                                                    <td>${sessions.ITU}</td>
                                                    <td>${sessions.material}</td>
                                                    <td>${sessions.included}</td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <button type="button" class="btn btn-outline-primary btn-sm">
                                                                Edit</button>
                                                            <button type="button" class="btn btn-outline-danger btn-sm">
                                                                Delete</button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!--Questions Table-->
                                <div>
                                    <span
                                        style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Questions</span><br>
                                    <div style="margin-top: 16px;">
                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                            <i class="fa-regular fa-square-plus"></i> Add</button>
                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                            <input type="file" />
                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                        </label>
                                    </div>
                                </div>
                                <div class="dashboard-container">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <input type="checkbox" />
                                                </th>
                                                <th scope="col">No</th>
                                                <th scope="col">Category</th>
                                                <th scope="col">Type</th>
                                                <th scope="col">Part</th>
                                                <th scope="col">Weight</th>
                                                <th scope="col">Completion Citerial</th>
                                                <th scope="col">Duration</th>
                                                <th scope="col">Edit</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="questions" items="" varStatus="loop">
                                                <tr>
                                                    <th scope="row">
                                                        <input type="checkbox" />
                                                    </th>
                                                    <td>${loop.count}</td>
                                                    <td>${questions.category}</td>
                                                    <td>${questions.type}</td>
                                                    <td>${questions.part}</td>
                                                    <td>${questions.weight}</td>
                                                    <td>${questions.completionCiterial}</td>
                                                    <td>${questions.duration}</td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <button type="button" class="btn btn-outline-primary btn-sm">
                                                                Edit</button>
                                                            <button type="button" class="btn btn-outline-danger btn-sm">
                                                                Delete</button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!--Assessents Table-->
                                <div>
                                    <span
                                        style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Assessents</span><br>
                                    <div style="margin-top: 16px;">
                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                            <i class="fa-regular fa-square-plus"></i> Add</button>
                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                            <input type="file" />
                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                        </label>
                                    </div>
                                </div>
                                <div class="dashboard-container">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <input type="checkbox" />
                                                </th>
                                                <th scope="col">No</th>
                                                <th scope="col">Category</th>
                                                <th scope="col">Type</th>
                                                <th scope="col">Part</th>
                                                <th scope="col">Weight</th>
                                                <th scope="col">Completion Citerial</th>
                                                <th scope="col">Duration</th>
                                                <th scope="col">Edit</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="assessent" items="" varStatus="loop">
                                                <tr>
                                                    <th scope="row">
                                                        <input type="checkbox" />
                                                    </th>
                                                    <td>${loop.count}</td>
                                                    <td>${assessent.category}</td>
                                                    <td>${assessent.type}</td>
                                                    <td>${assessent.part}</td>
                                                    <td>${assessent.weight}</td>
                                                    <td>${assessent.completionCiterial}</td>
                                                    <td>${assessent.duration}</td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <button type="button" class="btn btn-outline-primary btn-sm">
                                                                Edit</button>
                                                            <button type="button" class="btn btn-outline-danger btn-sm">
                                                                Delete</button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!--Send to preview-->
                                <div>
                                    <div class="btn-group">
                                        <div style="width: 356px;">
                                            <select style="color: #495057;" name="" id="" class="form-select">
                                                <c:if test="">
                                                    <option selected>Send to Preview</option>
                                                </c:if>
                                                <c:forEach var="" items="">
                                                    <option value=""></option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div>
                                            <button type="submit" class="btn btn-primary"> Save</button>
                                            <button type="submit" class="btn btn-secondary"> Draft</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </main>
                </div>
            </div>
>>>>>>> Stashed changes
    </body>
</html>
