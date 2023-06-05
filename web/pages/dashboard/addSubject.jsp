<%-- 
    Document   : CurriculumAdd
    Created on : Apr 13, 2023, 11:20:49 PM
    Author     : Admin
--%>

<%@page import="config.AppConfig" %>
<%@ page import="entities.Subject" %>
<%@ page import="config.Label" %>
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
        Subject subject = (Subject) request.getAttribute(AppConfig.DASHBOARD_SUBJECT);
        Boolean isEdit = subject != null;
    %>
    <title><%= isEdit ? Label.DASHBOARD_SUBJECT_EDIT_TITLE : Label.DASHBOARD_SUBJECT_ADD_TITLE %>
    </title>
</head>
<body>

<div class="dashboard-container">
    <%@include file="/components/dashboard/sidebar.jspx" %>
    <main>
        <%@include file="/components/dashboard/header.jspx" %>
        <div class="dashboard-content">
            <div class="container" style="margin: 0 auto">
                <!--Modal-->
                <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Note</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Uploading will be able to delete all existing datas, do you want to keep
                                    them?</p>
                            </div>
                            <div class="modal-footer">
                                <button id="modal-no" type="button" class="btn btn-secondary">No</button>
                                <button id="modal-yes" type="button" class="btn btn-primary">Yes</button>
                            </div>
                        </div>
                    </div>
                </div>


                <legend><%= isEdit ? Label.DASHBOARD_SUBJECT_EDIT_TITLE : Label.DASHBOARD_SUBJECT_ADD_TITLE %>
                </legend>
                <form class="mt-4" method="POST"
                      id="add-subject-form">
                    <c:choose>
                        <c:when test="${ subject != null}">
                            <div class="row g-3 align-items-center" style="margin-top: 23px;">
                                <div class="col-2">
                                    <label for="subject.status" class="col-form-label"
                                           style="font-size: 16px;">Active</label>
                                </div>
                                <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" role="switch"
                                               id="subject.status"
                                               name="subject.status" <%=subject.getActive() ? "checked" : "" %>>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                    <div class="row g-3 align-items-center" style="margin-top: 23px;">
                        <div class="col-2">
                            <label for="subject.code" class="col-form-label" style="font-size: 16px;">Code</label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <input type="text" name="subject.code" id="subject.code" class="form-control"
                                   value="<%= isEdit ? subject.getId() : "" %>" <%= isEdit ? "disabled" : "" %>
                            >
                        </div>
                    </div>

                    <div class="row g-3 align-items-center mt-1">
                        <div class="col-2">
                            <label for="subject.slug" class="col-form-label" style="font-size: 16px;">Slug</label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <input type="text" name="subject.slug" id="subject.slug" class="form-control" readonly
                                   value="<%= isEdit && subject.getSlug() != null ? subject.getSlug(): "" %>"
                                   disabled>
                        </div>
                    </div>

                    <div class="row g-3 align-items-center mt-1">
                        <div class="col-2">
                            <label for="subject.name" class="col-form-label" style="font-size: 16px;">English
                                name</label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <input type="text" id="subject.name" name="subject.name" class="form-control"
                                   value="<%= isEdit &&  subject.getName() != null ? subject.getName() : "" %>"
                            >
                        </div>
                    </div>

                    <div class="row g-3 align-items-center mt-1">
                        <div class="col-2">
                            <label for="subject.viName" class="col-form-label"
                                   style="font-size: 16px;">Vietnamese name</label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <input type="text" id="subject.viName" name="subject.viName" class="form-control"
                                   value="<%= isEdit && subject.getViName() != null ? subject.getViName() : "" %>"
                            >
                        </div>
                    </div>

                    <div class="row g-3 align-items-center mt-1">
                        <div class="col-2">
                            <label for="subject.semester" class="col-form-label" style="font-size: 16px;">
                                Semester
                            </label>
                        </div>
                        <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                            <input type="number" min="0" max="10" step="0.25" id="subject.semester"
                                   name="subject.semester"
                                   value="<%= isEdit && subject.getSemester() != null  ? subject.getSemester(): "0" %>"
                                   class="form-control"/>
                        </div>
                    </div>
                    <div style="margin-left: auto; margin-top: 32px;">
                        <button id="btn-submit" type="submit"
                                class="btn btn-primary"><%= isEdit ? Label.DASHBOARD_SUBJECT_EDIT_SUBMIT_BTN : Label.DASHBOARD_SUBJECT_ADD_SUBMIT_BTN %>
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
            $("#add-subject-form").submit(function (e) {
                $(':disabled').each(function (e) {
                    $(this).removeAttr('disabled');
                })
            });
        }
    );

    document.getElementById("subject.code").addEventListener("change", handleCodeChange);

    function handleSubmit(e) {
        e.preventDefault();
        document.getElementById("subject.slug").disabled = false;
        e.submit();
    }

    function handleCodeChange(e) {
        const code = e.target.value;
        document.getElementById("subject.slug").value = slugify(code.toLowerCase().replaceAll('_', '- '));
    }

    function renderBasicInf() {
        let basicCode = localStorage.getItem("curiculum.basicCode");
        let basicSlug = localStorage.getItem("curiculum.basicSlug");
        let basicEnglishName = localStorage.getItem("curiculum.basicEnglishName");
        let basicVietnameseName = localStorage.getItem("curiculum.basicVietnameseName");
        let basicDescription = localStorage.getItem("curiculum.basicDescription");
        let basicDecisionNo = localStorage.getItem("curiculum.basicDecisionNo");
        if (basicCode == null) {
            $('#code').val('');
        } else {
            $('#code').val(JSON.parse(basicCode));
        }
        if (basicSlug == null) {
            $('#slug').val('');
        } else {
            $('#slug').val(JSON.parse(basicSlug));
        }
        if (basicEnglishName == null) {
            $('#englishName').val('');
        } else {
            $('#englishName').val(JSON.parse(basicEnglishName));
        }
        if (basicVietnameseName == null) {
            $('#vietnameseName').val('');
        } else {
            $('#vietnameseName').val(JSON.parse(basicVietnameseName));
        }
        if (basicDescription == null) {
            $('#description').val('');
        } else {
            $('#description').val(JSON.parse(basicDescription));
        }
        if (basicDecisionNo == null) {
            $('#decisionNo').val('');
        } else {
            $('#decisionNo').val(JSON.parse(basicDecisionNo));
        }
    }

    function resetBasicInfo(basicCode, basicSlug, basicEnglishName, basicVietnameseName, basicDescription, basicDecisionNo) {
        localStorage.setItem("curiculum.basicCode", JSON.stringify(basicCode));
        localStorage.setItem("curiculum.basicEnglishName", JSON.stringify(basicEnglishName));
        localStorage.setItem("curiculum.basicVietnameseName", JSON.stringify(basicVietnameseName));
        localStorage.setItem("curiculum.basicDescription", JSON.stringify(basicDescription));
        localStorage.setItem("curiculum.basicDecisionNo", JSON.stringify(basicDecisionNo));
        localStorage.setItem("curiculum.basicSlug", JSON.stringify(basicSlug));
    }

</script>
</body>

</html>