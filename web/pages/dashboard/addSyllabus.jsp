
<%@page import="config.AppConfig"%>
<%@page import="entities.Curriculum"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include file="/components/common/head.jspf" %>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
        <script src="https://unpkg.com/read-excel-file@5.x/bundle/read-excel-file.min.js"></script>
        <title>Add Syllabus</title>
    </head>
    <%
        ArrayList<Curriculum> lsCur = (ArrayList<Curriculum>) request.getAttribute(AppConfig.DASHBOARD_CURRICULUM_LIST);
    %>
    <body>
        <div class="dashboard-container">
            <%@include file="/components/dashboard/sidebar.jspx" %>
            <main>
                <%@include file="/components/dashboard/header.jspx" %>
                <div class="dashboard-content">
                    <div class="col-form-label" style="margin-bottom: 100px;">
                        <div class="container-lg" style="margin: 0 auto">
                            <legend>Add Syllabus</legend>
                            <form class="mt-3" id="addSyllabusForm" action="./add" method="POST" style="position: relative">
                                <div class="accordion" id="accordionExample">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#collapseOne" aria-expanded="true"
                                                    aria-controls="collapseOne">
                                                Basic Information
                                            </button>
                                        </h2>
                                        <div id="collapseOne" class="accordion-collapse collapse show"
                                             data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div id="basic-information-form">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group mb-3">
                                                                <label for="curriculum" class="col-form-label"
                                                                       style="font-size: 16px;">
                                                                    Curriculum
                                                                </label>
                                                                <select style="color: #495057;" name="curriculum"
                                                                        id="curriculum" class="form-select" required>
                                                                    <option value="null" selected>Select Curriculum</option>
                                                                    <c:forEach var="cur" items="<%= lsCur%>">
                                                                        <option value="${cur.id}">${cur.code}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group mb-3">
                                                                <label for="subject" class="col-form-label"
                                                                       style="font-size: 16px;">
                                                                    Subject
                                                                </label>
                                                                <select style="color: #495057;" name="subject" id="subject"
                                                                        class="form-select" disabled>
                                                                    <option selected>Select Subject</option>
                                                                </select>
                                                                <div id="mapToPLO" class="form-text">
                                                                    Please select Curriculum first.
                                                                </div>
                                                            </div>
                                                            <div class="form-group mb-3">
                                                                <label for="degreeLevel" class="col-form-label"
                                                                       style="font-size: 16px;">
                                                                    Degree Level
                                                                </label>
                                                                <select style="color: #495057;" name="degreeLevel"
                                                                        id="degreeLevel" class="form-select">
                                                                    <option selected>Bachelor</option>
                                                                    Bachelor
                                                                </select>
                                                            </div>
                                                            <div class="form-group mb-3">
                                                                <label for="timeAllocation" class="col-form-label" style="font-size: 16px;">
                                                                    Time allocation
                                                                </label>
                                                                <input type="text" id="timeAllocation" name="timeAllocation" class="form-control" required/>
                                                            </div>
                                                            <div class="form-group mb-3">
                                                                <label for="decisionNo" class="col-form-label" style="font-size: 16px;">
                                                                    Decision No
                                                                </label>
                                                                <input type="text" id="decisionNo" name="decisionNo" class="form-control" required/>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group mb-3">
                                                                <label for="credit" class="col-form-label" style="font-size: 16px;">
                                                                    Number of Credit
                                                                </label>
                                                                <input type="number" value="1" min="1" max="15" step="1" id="credit" name="credit" class="form-control" required/>
                                                            </div>
                                                            <div class="form-group mb-3">
                                                                <label for="minScore" class="col-form-label" style="font-size: 16px;">
                                                                    Min score
                                                                </label>
                                                                <input type="number" value="0" min="0" max="10" step="0.25" id="minScore" name="minScore" class="form-control"/>
                                                            </div>
                                                            <div class="form-group mb-3">
                                                                <label for="maxScore" class="col-form-label" style="font-size: 16px;">
                                                                    Max score
                                                                </label>
                                                                <input type="number" min="0" max="10" step="0.25" id="maxScore" name="maxScore" class="form-control" required/>
                                                            </div>
                                                            <!--                                                            <div class="form-group mb-3">
                                                                                                                            <label for="Active" class="col-form-label" style="font-size: 16px;">
                                                                                                                                Pret
                                                                                                                            </label>
                                                                                                                            <select style="color: #495057;" name="preRequisite" id="preRequisite" class="form-select">
                                                                                                                                <option value="none">None</option>
                                                                                                                            </select>
                                                                                                                        </div>-->
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="description" class="col-form-label" style="font-size: 16px;">Description</label>
                                                        <input type="hidden" name="description" id="description"/>
                                                        <div id="descriptionEditor"></div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-6">
                                                            <label for="tasks" class="col-form-label" style="font-size: 16px;">Student
                                                                Tasks</label>
                                                            <textarea class="form-control" name="tasks"></textarea>
                                                            <label for="note" class="col-form-label" style="font-size: 16px;">Note</label>
                                                            <textarea class="form-control" name="note"></textarea>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label for="tools" class="col-form-label" style="font-size: 16px;">Tools</label>
                                                            <textarea class="form-control" name="tools"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#collapseTwo" aria-expanded="false"
                                                    aria-controls="collapseTwo">
                                                Materials
                                            </button>
                                        </h2>
                                        <div id="collapseTwo" class="accordion-collapse collapse"
                                             data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <label class="input-group-text" for="inputGroupFile01">Upload</label>
                                                    <input type="file" style="display: block;" class="form-control"
                                                           id="material-input-file">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#collapseThree" aria-expanded="false"
                                                    aria-controls="collapseThree">
                                                Objectives
                                            </button>
                                        </h2>
                                        <div id="collapseThree" class="accordion-collapse collapse"
                                             data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <span style="font-size: 18px; margin-bottom: 32px; display: inline-block;">
                                                    Course Learning Objectives (CLO)
                                                </span>
                                                <table id="cloTbl" width="100%">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Name</th>
                                                            <th scope="col">Description</th>
                                                            <th scope="col">Map to PLO</th>
                                                            <th scope="col">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                                <div class="form-add row g-3 align-items-center mt-1">
                                                    <div class="row col-6" id="add-clo-form">
                                                        <div class="row" style="padding-right: 0">
                                                            <div class="col-6">
                                                                <label for="cloName" class="col-form-label"
                                                                       style="font-size: 16px;">Name</label>
                                                                <input type="text" id="cloName" name="cloName"
                                                                       class="form-control" placeholder="CLOxx...">
                                                            </div>
                                                            <div class="col-6" style="padding-right: 0">
                                                                <label for="mapToPLO" class="col-form-label"
                                                                       style="font-size: 16px;">Map to
                                                                    PLO</label>
                                                                <select style="color: #495057;" name="mapToPLO" id="mapToPLO"
                                                                        class="form-select" disabled>
                                                                    <option value="none">None</option>
                                                                </select>
                                                                <div id="mapToPLO" class="form-text">
                                                                    Please select Curriculum first.
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <label for="ploDescription" class="col-form-label"
                                                                   style="font-size: 16px;">Description</label>
                                                            <textarea id="cloDescription" class="form-control"
                                                                      name="cloDescription"
                                                                      ></textarea>
                                                        </div>
                                                        <div style="margin-top: 16px;">
                                                            <button type="button" id="btn-add-plo" class="btn btn-primary"
                                                                    name="op" value="add_plo">Add
                                                            </button>
                                                            <button type="submit" class="btn btn-outline-secondary" value="">
                                                                Cancel
                                                            </button>
                                                        </div>
                                                    </div>

                                                    <div class="row col-4">
                                                        <div class="col-12">
                                                            <label for="PLOList" class="col-form-label" style="font-size: 16px;">List
                                                                of CLO</label>
                                                        </div>
                                                        <!--                                                        <div class="col-12">
                                                                                                                    <label id="PLOList" class="btn btn-outline-secondary">
                                                                                                                        <input type="file" />
                                                                                                                        <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                                                                                                    </label>
                                                                                                                </div>-->
                                                    </div>
                                                </div>
                                                <div class="alert alert-danger" id="clo-error" role="alert"
                                                     style="margin-top: 20px; margin-right: 4px; display: none;">
                                                    CLO_ERROR_MESSAGE
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#collapseFour" aria-expanded="false"
                                                    aria-controls="collapseFour">
                                                Sessions, Questions & Assessments
                                            </button>
                                        </h2>
                                        <div id="collapseFour" class="accordion-collapse collapse"
                                             data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div>
                                                    <div style="margin-top: 16px;">
                                                        <!--                                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                                                                                                    <i class="fa-regular fa-square-plus"></i> Add</button>-->
                                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                                            <input type="file" id="file-input" accept=".xlsx">
                                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="container-x1">
                                                    <h3 class="table-heading">Sessions</h3>
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 30px;" scope="col">
                                                                    <input type="checkbox" id="allCheckSession" checked />
                                                                </th>
                                                                <th style="width: 50px;" scope="col">No</th>
                                                                <th scope="col">Topic</th>
                                                                <th scope="col">Learning Type</th>
                                                                <th scope="col">LO</th>
                                                                <th scope="col">ITU</th>
                                                                <th scope="col">Material</th>
                                                                <th scope="col">Active</th>
                                                                <th  class="text-right">Edit</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="excel-table-sessions">
                                                        </tbody>
                                                        <div id="session-table-error">

                                                        </div>
                                                        <button type="button" style="float: right;" class="btn btn-outline-danger" onclick="deleteSession()">Delete</button>
                                                    </table>
                                                    <h3 class="table-heading">Questions</h3>
                                                    <table class="table table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 30px;" scope="col">
                                                                    <input id="allCheckQuestion" type="checkbox" checked/>
                                                                </th>
                                                                <th style="width: 50px;" scope="col">No</th>
                                                                <th scope="col">SessionNo</th>
                                                                <th scope="col">Name</th>
                                                                <th colspan="3">Details</th>
                                                                <th scope="col">Active</th>
                                                                <th class="text-right">Edit</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="excel-table-questions">
                                                        </tbody>
                                                        <div id="question-table-error">
                                                        </div>
                                                        <div id="question-table-error2">
                                                        </div>
                                                        <button type="button"  style="float: right;" class="btn btn-outline-danger"  onclick="deleteQuestion()">Delete</button>
                                                    </table>
                                                    <h3 class="table-heading">Assessments</h3>
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 30px;" scope="col">
                                                                    <input id="allCheckAssessment" type="checkbox" checked/>
                                                                </th>
                                                                <th style="width: 50px;" scope="col">No</th>
                                                                <th scope="col">Category</th>
                                                                <th scope="col">Type</th>
                                                                <th scope="col">Part</th>
                                                                <th scope="col">Weight</th>
                                                                <th scope="col">Completion Citerial</th>
                                                                <th scope="col">Duration</th>
                                                                <th scope="col">CLO</th>
                                                                <th scope="col">Question Type</th>
                                                                <th scope="col">Total Quetions</th>
                                                                <th scope="col">Knowledge and Skills</th>
                                                                <th scope="col">Grading Guide</th>
                                                                <th scope="col">Active</th>
                                                                <th scope="col">Edit</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="excel-table-assessments">
                                                        </tbody>
                                                        <div id="assessment-table-error">
                                                        </div>
                                                        <button type="button"  style="float: right;" class="btn btn-outline-danger" onclick="deleteAssessment()">Delete</button>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--                                    <div class="accordion-item">
                                                                            <h2 class="accordion-header">
                                                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                                                                                    Questions
                                                                                </button>
                                                                            </h2>
                                                                            <div id="collapseFive" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                                                                                <div class="accordion-body">
                                                                                    <div>
                                                                                        <div style="margin-top: 16px;">
                                                                                                                                                    <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                                                                                                                                        <i class="fa-regular fa-square-plus"></i> Add</button>
                                                                                            <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                                                                                <input type="file" id="file-input2" accept=".xlsx"/>
                                                                                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                                                                            </label>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="container-x1">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="accordion-item">
                                                                            <h2 class="accordion-header">
                                                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                                                                                    Assessments
                                                                                </button>
                                                                            </h2>
                                                                            <div id="collapseSix" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                                                                                <div class="accordion-body">
                                                                                    <div>
                                                                                        <div style="margin-top: 16px;">
                                                                                                                                                    <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                                                                                                                                        <i class="fa-regular fa-square-plus"></i> Add</button>
                                                                                            <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                                                                                <input type="file" id="file-input3"/>
                                                                                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                                                                            </label>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="container-x1">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>-->
                                </div>
                                <div id="messageSyl"></div>
                                <!--Send to preview-->
                                <div class="fixed-footer">
                                    <div style="margin-left:auto;">
                                        <button type="submit" id="btn-publish" class="btn btn-primary"> Submit Syallbus</button>
                                        <!--                                        <button type="submit" id="btn-save" class="btn btn-secondary"> Save draft</button>-->
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
                            <div class="offcanvas-header">
                                <h5 class="offcanvas-title" id="offcanvasExampleLabel">Edit Course Learning Objectives</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                            </div>
                            <div class="offcanvas-body edit-clo-form" id="edit-clo-form">
                                <input type="hidden" id="cloID">
                                <label for="cloName" class="col-form-label" style="font-size: 16px;">Name</label>
                                <input type="text" id="cloName" name="cloName" class="form-control" placeholder="CLOxx...">
                                <label for="mapToPLO" class="col-form-label" style="font-size: 16px;">Map to
                                    PLO</label>
                                <select style="color: #495057;" name="mapToPLO" id="mapToPLO" class="form-select">
                                    <option value="none">None</option>
                                </select>
                                <label for="ploDescription" class="col-form-label"
                                       style="font-size: 16px;">Description</label>
                                <textarea id="cloDescription" class="form-control" name="cloDescription">
                                </textarea>
                                <div class="alert alert-danger" id="clo-update-error" role="alert" style="margin-top: 20px; margin-right: 4px; display: none;"> 
                                    CLO_ERROR_MESSAGE
                                </div>
                                <div class="mt-4">
                                    <button type="button" id="btn-update-clo" class="btn btn-primary">Save</button>
                                    <button type="button" id="btn-cancel-update" class="btn btn-outline-secondary" data-bs-dismiss="offcanvas" aria-label="Cancel">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>



                <!-- Modal Question -->
                <div id="edit-modal-question" class="modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Edit Question</h5>

                            </div>
                            <div class="modal-body">
                                <form>
                                    <!--                                    <div class="mb-3">
                                                                            <label for="edit-session-no" class="col-form-label">Session No:</label>
                                                                            <input type="text" class="form-control" id="edit-no">
                                                                        </div>-->

                                    <div class="mb-3">
                                        <label for="edit-session-no-select" class="col-form-label">Session No:</label>
                                        <select class="form-control" id="edit-no-select">

                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-name" class="col-form-label">Name:</label>
                                        <input type="text" class="form-control" id="edit-name">
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-details" class="col-form-label">Details:</label>
                                        <textarea class="form-control" id="edit-details"></textarea>
                                    </div>
                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="edit-active">
                                        <label class="form-check-label" for="edit-active">Active</label>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="edit-cancel">Cancel</button>
                                <button type="button" class="btn btn-primary" id="edit-save">Save</button>
                            </div>
                        </div>
                    </div>
                </div>



                <!-- Modal Assessment -->




                <div id="edit-modal-assessment" class="modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Edit Assessment</h5>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="mb-3">
                                        <label for="edit-category" class="col-form-label">Category:</label>
                                        <input type="text" class="form-control" id="edit-category-assessment">
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-type" class="col-form-label">Type:</label>
                                        <input type="text" class="form-control" id="edit-type-assessment">
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-part" class="col-form-label">Part:</label>
                                        <input type="text" class="form-control" id="edit-part-assessment">
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-weight" class="col-form-label">Weight:</label>
                                        <input type="text" class="form-control" id="edit-weight-assessment">
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-complement-citerial" class="col-form-label">Completion Citerial:</label>
                                        <textarea class="form-control" id="edit-complement-citerial-assessment"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-duration" class="col-form-label">Duration:</label>
                                        <input type="text" class="form-control" id="edit-duration-assessment">
                                    </div>
                                    <!--                                    <div class="mb-3">
                                                                            <label for="edit-clo" class="col-form-label">CLO:</label>
                                                                            <textarea class="form-control" id="edit-clo-assessment"></textarea>
                                                                        </div>-->
                                    <div class="mb-3">
                                        <label for="edit-session-no-select-multi-assessment" class="col-form-label">CLO:</label>
                                        <select  multiple class="form-control" id="edit-clo-select-multi-assessment">

                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-question-type" class="col-form-label">Question Type:</label>
                                        <input type="text" class="form-control" id="edit-question-type-assessment">
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-total-question" class="col-form-label">Total Questions:</label>
                                        <input type="text" class="form-control" id="edit-total-question-assessment">
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-kns" class="col-form-label">Knowledge and Skills:</label>
                                        <input class="form-control" id="edit-kns-assessment"></input>
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-grading-guide" class="col-form-label">Grading Guide:</label>
                                        <input class="form-control" id="edit-grading-guide-assessment"></input>
                                    </div>
                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="edit-active-assessment">
                                        <label class="form-check-label" id="edit-active-assessment">Active</label>
                                    </div>
                                </form>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="edit-cancel-assessment">Cancel</button>
                                    <button type="button" class="btn btn-primary" id="edit-save-assessment">Save</button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div id="edit-modal-session" class="modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Edit Session</h5>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="mb-3">
                                        <label for="edit-session-no" class="col-form-label">Session No:</label>
                                        <input type="number" class="form-control" id="edit-session-no">
                                    </div>

                                    <!--                                    <div class="mb-3">
                                                                            <label for="edit-session-no-select-multi" class="col-form-label">CLO:</label>
                                                                            <select  multiple class="form-control" id="edit-clo-select-multi">
                                    
                                                                            </select>
                                                                        </div>-->
                                    <div class="mb-3">
                                        <label for="edit-name" class="col-form-label">Topic:</label>
                                        <input type="text" class="form-control" id="edit-session-topic">
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-details" class="col-form-label">Learning Type:</label>
                                        <textarea class="form-control" id="edit-session-learningType"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="edit-details" class="col-form-label">ITU:</label>
                                        <textarea class="form-control" id="edit-session-itu"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="edit-session-no-select-multi" class="col-form-label">CLO:</label>
                                        <select  multiple class="form-control" id="edit-clo-select-multi">

                                        </select>
                                    </div>

                                    <!--                                    <div class="mb-3">
                                                                            <label for="edit-details" class="col-form-label">LO:</label>
                                                                            <textarea class="form-control" id="edit-session-clo"></textarea>
                                                                        </div>-->
                                    <div class="mb-3">
                                        <label for="edit-details" class="col-form-label">Material:</label>
                                        <textarea class="form-control" id="edit-session-material"></textarea>
                                    </div>
                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="edit-session-active">
                                        <label class="form-check-label" for="edit-active">Active</label>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="edit-session-cancel">Cancel</button>
                                <button type="button" class="btn btn-primary" id="edit-session-save">Save</button>
                            </div>
                        </div>
                    </div>
                </div>


                <!--                <div id="confirm-modal" class="modal">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Confirm Overwrite</h5>
                                            </div>
                                            <div class="modal-body">
                                                <p>"Your file is in an invalid format, so nothing has been changed"</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="confirm-no">No</button>
                                                <button type="button" class="btn btn-primary" id="confirm-yes">Yes</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>-->



                <script>



//                    const activeSwitch = document.getElementById("flexSwitchCheckChecked");
//                    activeSwitch.addEventListener("change", handleActiveSwitchChange);
//                    function handleActiveSwitchChange() {
//                    localStorage.setItem('activeTotal', activeSwitch.checked);
//                    const listSessions = JSON.parse(localStorage.getItem(app.localStorage.syllabus.sessions));
//                    const listQuestions = JSON.parse(localStorage.getItem(app.localStorage.syllabus.questions));
//                    const listAssessments = JSON.parse(localStorage.getItem(app.localStorage.syllabus.assessments));
//                    listSessions.forEach(item => {
//                    item.active = activeSwitch.checked;
//                    });
//                    listQuestions.forEach(item => {
//                    item.active = activeSwitch.checked;
//                    });
//                    listAssessments.forEach(item => {
//                    item.active = activeSwitch.checked;
//                    });
//                    renderList(listSessions, 'sessions');
//                    renderList(listQuestions, 'questions');
//                    renderList(listAssessments, 'assessments');
//                    };


                    const app = {
                    localStorage: {
                    syllabus: {
                    sessions: 'syllabus.sessions',
                            questions: 'syllabus.questions',
                            assessments: 'syllabus.assessments',
                            list_clo: 'syllabus.list_clo'
                    }
                    }
                    }


                    const descriptionEditor = new Quill('#descriptionEditor', {
                    theme: 'snow'
                    });
                    $(document).ready(() => {
                    startLoading();
                    const myForm = document.querySelector("#basic-information-form");
//                    const active = document.getElementById("flexSwitchCheckChecked");
//                    console.log("check activeTotal" + JSON.parse(localStorage.getItem('activeTotal')));
//                    active.checked = JSON.parse(localStorage.getItem('activeTotal'));
                    const curID = myForm.querySelector('select#curriculum')?.value
                            const loadedDataLocalStorage = JSON.parse(localStorage.getItem('syllabus.loaded_data'));
                    const listCLO = cloUtils.getListFromLocalStorage();
                    const listSessions = JSON.parse(localStorage.getItem(app.localStorage.syllabus.sessions));
                    const listQuestions = JSON.parse(localStorage.getItem(app.localStorage.syllabus.questions));
                    const listAssessments = JSON.parse(localStorage.getItem(app.localStorage.syllabus.assessments));
                    renderList(listSessions, 'sessions')
                            renderList(listQuestions, 'questions')
                            renderList(listAssessments, 'assessments')

                            renderListCLO(listCLO)
                            initForm(myForm);
                    handleLoadData(null, curID, loadedDataLocalStorage)
                            $('#btn-add-plo').on('click', handleAddCLO)
                            $("#cloTbl").on("click", "[name='editBtn']", renderUpdateCLOForm);
                    $("#cloTbl").on("click", "[name='saveBtn']", handleSaveEdit);
                    $("#btn-update-clo").on("click", handleUpdateCLO);
                    $("#cloTbl").on("click", "[name='deleteBtn']", handleDelete);
                    document.getElementById("curriculum").addEventListener("change", e => handleLoadData(e));
                    stopLoading();
                    })

                            document.getElementById("addSyllabusForm").addEventListener("submit", handleSubmitAddSyllabus);
                    function getListFromLocalStorage(key) {
                    return JSON.parse(localStorage.getItem(key)) || []
                    }

                    async function handleSubmitAddSyllabus(e) {
                    e.preventDefault();
                    const descriptionInput = document.getElementById("description");
                    const materialInput = document.getElementById("material-input-file");
                    const active = document.getElementById("flexSwitchCheckChecked");
                    descriptionInput.value = JSON.stringify(descriptionEditor.root.innerHTML);
                    const formData = new FormData(document.forms.addSyllabusForm);
                    const listCLO = getListFromLocalStorage(app.localStorage.syllabus.list_clo);
                    const sessions = getListFromLocalStorage(app.localStorage.syllabus.sessions);
                    const questions = getListFromLocalStorage(app.localStorage.syllabus.questions);
                    const assessments = getListFromLocalStorage(app.localStorage.syllabus.assessments);
                    const submitCLOs = listCLO.map((c) => {c.plo = c.plo.value; return c})
                            formData.append('material', materialInput.files[0]);
                    const submitData = {}
                    for (const [key, value] of formData) {
                    submitData[key] = value
                    }

                    submitData.list_clo = submitCLOs;
                    submitData.sessions = sessions;
                    submitData.questions = questions;
                    submitData.assessments = assessments;
                    console.log({
                    submitData,
                    });
                    try {


                    if (submitCLOs.length === 0) {
                    throw new Error("You should add CLO");
                    }
                    if (sessions.length === 0) {
                    throw new Error("You should add session");
                    }if (questions.length === 0) {
                    throw new Error("You should add question");
                    }
                    if (assessments.length === 0) {
                    throw new Error("You should add assessment");
                    }

                    if (materialInput.files.length){
                    const res2 = await fetch('${pageContext.servletContext.contextPath}/dashboard/syllabus/uploadMaterial', {
                    method: 'POST',
                            headers: {
                            'enctype': 'multipart/form-data'
                            },
                            body: formData
                    });
                    const responseData2 = await res2.json();
                    console.log({res2});
                    if (!res2.ok){
                    throw new Error(responseData2.message)
                    }
                    }


                    const res = await fetch('${pageContext.servletContext.contextPath}/dashboard/syllabus/add', {
                    method: 'POST',
                            body: JSON.stringify(submitData)
                    });
                    const responseData = await res.json();
                    console.log({res})
                            if (!res.ok) {
                    throw new Error(responseData.message)
                    }
                    console.log(responseData);
                    window.location.href = responseData.redirectUrl;
                    }
                    catch (e)  {
                    const message = document.getElementById("messageSyl");
                    message.innerHTML = `Error ` + e.message;
                    message.style.display = "block";
                    message.style.border = "1px solid red";
                    message.style.padding = "10px";
                    message.style.fontSize = "16px";
                    message.style.color = "red";
                    message.style.backgroundColor = "#ffe6e6";
                    console.error("Error is " + e)
                    }
                    }

                    function initForm(formNode) {
                    // Retrieve saved form data from localStorage
                    const formKey = 'syllabus.' + formNode.id
                            const formData = JSON.parse(localStorage.getItem(formKey));
                    // Loop through form input elements
                    const formInputs = formNode.querySelectorAll("input, select, textarea");
                    formInputs.forEach((input) => {
                    // Load saved value for input if available
                    if (formData && formData[input.name]) {
                    input.value = formData[input.name];
                    }

                    // Listen for changes to input and save to localStorage
                    input.addEventListener("change", () => {
                    const inputValues = {};
                    formInputs.forEach((input) => {
                    inputValues[input.name] = input?.value;
                    });
                    localStorage.setItem(formKey, JSON.stringify(inputValues));
                    });
                    });
                    }

                    function startLoading() {
                    const loadingClass = 'loading';
                    const loadingContainer = document.createElement('div');
                    loadingContainer.classList.add('loading')
                            loadingContainer.innerHTML = `
                                            <div class="spinner-border text-light" role="status">
                                                <span class="visually-hidden">Loading...</span>
                                            </div>`
                            document.body.appendChild(loadingContainer)
                    }

                    function stopLoading() {
                    return document.querySelector('.loading')?.remove();
                    }

                    async function handleLoadData(e, initialCurId, loadedData) {
                    try {
                    const curId = e != null ? e?.target?.value : initialCurId;
                    if (!curId) throw new Error('Invalid Curriculum ID.');
                    const data = loadedData ? loadedData : await getSubjects(curId);
                    if (!data) throw new Error('');
                    const subjectSelectNode = document.getElementById('subject');
                    const ploSelectNode = document.querySelector('select#mapToPLO');
//                    const preRequisiteSelectNode = document.getElementById('preRequisite');
                    const syllabus = JSON.parse(localStorage.getItem('syllabus.basic-information-form'));
                    const subject = syllabus.subject;
                    console.log("day la " + subject);
                    const htmls = data?.subjects?.map((s) => `
                                                                  <option value="\${s.id.trim()}">\${s.id.trim()} - \${s.name}</option>
                                                            `).join('');
                    const ploOptionHtmls = data?.list_plo?.map((p) => `
                                                                  <option value="\${p.id}"  title="\${p.description}">\${p.name}</option>
                                                            `).join('');
                    localStorage.setItem('syllabus.list_plo', JSON.stringify(data?.list_plo))
                            localStorage.setItem('syllabus.loaded_data', JSON.stringify(data))

                            subjectSelectNode.innerHTML = htmls
                            subjectSelectNode.disabled = false;
//                    ploSelectNode.innerHTML = '<option value="none">None</option>' + ploOptionHtmls;
                    ploSelectNode.innerHTML = ploOptionHtmls;
                    ploSelectNode.disabled = false;
//                    preRequisiteSelectNode.innerHTML = '<option value="none">None</option>' + htmls;
                    } catch (e) {
                    console.error(e);
                    alert('Cannot load subjects from this curriculum');
                    }
                    }

                    async function getSubjects(curId) {
                    const promise = fetch('${pageContext.servletContext.contextPath}/dashboard/syllabus/get-subjects?curId=' + curId);
                    return (await promise).json();
                    }

                    function getListPLOFromLocalSyllabus() {
                    return JSON.parse(localStorage.getItem('syllabus.list_plo')) || [];
                    }

                    const cloUtils = {
                    getListFromLocalStorage: () => {
                    return JSON.parse(localStorage.getItem("syllabus.list_clo")) || [];
                    },
                            saveToLocalStorage: (newList) => {
                    localStorage.setItem('syllabus.list_clo', JSON.stringify(newList));
                    }
                    }

                    function showError(message) {
                    const errorShowNode = $('#clo-error');
                    errorShowNode.css('display', 'block')
                            errorShowNode.text(message);
                    }

                    function hideError() {
                    const errorShowNode = $('#clo-error');
                    errorShowNode.css('display', 'none');
                    }

                    function handleUpdateCLO() {
                    const editForm = document.getElementById("edit-clo-form");
                    const index = editForm.querySelector("#cloID").value
                            const name = editForm.querySelector("#cloName").value
                            const description = editForm.querySelector("#cloDescription").value
                            const ploValue = editForm.querySelector("select#mapToPLO").value
                            const ploName = $("#edit-clo-form select#mapToPLO option:selected").text();
                    const listCLO = cloUtils.getListFromLocalStorage();
                    try {
                    validateCLO('edit', listCLO, {
                    currentIndex: index,
                            name,
                            description,
                            ploName
                    });
                    const newCLO = {
                    index,
                            name,
                            description,
                            plo: {
                            name: ploName,
                                    value: ploValue
                            }
                    }
                    listCLO[index] = newCLO
                            cloUtils.saveToLocalStorage(listCLO);
                    renderListCLO(listCLO)
                            $('#btn-cancel-update').click();
                    console.log("CLO update checked");
                    const sessions = getListFromLocalStorage(app.localStorage.syllabus.sessions);
                    const questions = getListFromLocalStorage(app.localStorage.syllabus.questions);
                    const assessments = getListFromLocalStorage(app.localStorage.syllabus.assessments);
                    validateExcelForSession(sessions);
                    validateExcelForAssessment(assessments);
                    checkAndMapingSessionNo(sessions, questions);
                    localStorage.setItem('syllabus.sessions', JSON.stringify(sessions));
                    localStorage.setItem('syllabus.questions', JSON.stringify(questions));
                    localStorage.setItem('syllabus.assessments', JSON.stringify(assessments));
                    renderList(sessions, 'sessions');
                    renderList(questions, 'questions');
                    renderList(assessments, 'assessments');
                    }
                    catch (e) {
                    showError(e.message);
                    }
                    }

                    function validateCLO(action = 'add', list, inputs) {
                    const {
                    name,
                            description,
                            ploName,
                            currentIndex
                    } = inputs;
                    if (!name || name.trim() === '') {
                    throw new Error("CLO name cannot be left blank, please try again!");
                    }
                    if (!name.startsWith('CLO')) {
                    throw new Error("CLO name must follow format CLOxx, please try again!");
                    }

                    if (ploName.trim() == '') {
                    throw new Error("You must select PLO. Remember to select Curriculum first.!");
                    }

                    let isExist = list.findIndex((c, index) => action === 'add' && c.name === name && index != Number.parseInt(currentIndex || - 1));
                    if (isExist != - 1) {
                    throw new Error(name + " is exist, please try another!");
                    }

                    return true;
                    }

                    function handleAddCLO() {
                    const addCLOForm = document.getElementById('add-clo-form');
                    const nameCLONode = addCLOForm.querySelector("#cloName");
                    const descriptionCLONode = addCLOForm.querySelector("#cloDescription");
                    const mapToPLONode = $("#add-clo-form select#mapToPLO option:selected");
                    const name = nameCLONode.value;
                    const description = descriptionCLONode.value;
                    const ploName = mapToPLONode.text();
                    console.log({
                    ploName
                    })
                            const ploValue = $("select#mapToPLO").val();
                    let listCLO = cloUtils.getListFromLocalStorage();
                    if (!nameCLONode || !descriptionCLONode || !mapToPLONode) {
                    showError("Missing value");
                    throw new Error("Missing value");
                    }

                    try {
                    validateCLO('add', listCLO, {
                    name,
                            description,
                            ploName
                    })
                            listCLO.push({
                            name: name,
                                    description: description,
                                    plo: {
                                    name: ploName,
                                            value: ploValue
                                    }
                            });
                    renderListCLO(listCLO);
                    localStorage.setItem("syllabus.list_clo", JSON.stringify(listCLO));
                    resetForm(addCLOForm);
                    } catch (e) {
                    showError(e.message);
                    }


                    }

                    function renderListCLO(listCLO) {
                    if (!listCLO) throw new Error("Cannot render list PLO");
                    const CLOTableBody = document.querySelector("#cloTbl tbody");
                    const htmls = listCLO.map((clo, index) => `
                                         <tr data-index="\${index}">
                                            <td scope="row" style="color: #495057;">\${clo?.name}</td>
                                            <td style="padding-bottom: 12px">\${clo?.description}</td>
                                            <td>\${clo?.plo?.name}</td>
                                            <td>
                                                <button name="editBtn" type="button" style="border: none; background: none" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample"><i class="fa-solid fa-pencil"></i></button>
                                                <button name="cancelBtn" type="button" style="border: none; background: none; display: none;"><i class="fa-solid fa-x"></i></button>
                                                <button name="deleteBtn" type="button" id="btn-delete-plo" type="button" style="border: none; background: none; display: block;" ><i class="fa-solid fa-trash"></i></button>
                                            </td>
                                        </tr>
                                    `).join("");
                    CLOTableBody.parentNode.style.display = 'table';
                    CLOTableBody.innerHTML = htmls;
                    }

                    function renderUpdateCLOForm() {

                    const oldName = $(this).closest("tr").find("td").eq(0).text();
                    const oldDescription = $(this).closest("tr").find("td").eq(1).text();
                    const oldMapToPLO = $(this).closest("tr").find("td").eq(2).text();
                    const index = $(this).closest("tr").data("index");
                    const editForm = document.getElementById('edit-clo-form');
                    console.log({
                    index,
                            editForm
                    })
                            const idInput = editForm.querySelector("#cloID")
                            const nameInput = editForm.querySelector("#cloName")
                            const selectPLOInput = editForm.querySelector("select#mapToPLO");
                    const cloDescriptionInput = editForm.querySelector("#cloDescription");
                    const lisPLO = getListPLOFromLocalSyllabus();
                    idInput.value = index;
                    nameInput.value = oldName;
                    cloDescriptionInput.value = oldDescription;
                    const optionsHtmls = lisPLO.map((p, i) => `
                                            <option value="\${p.id}"  title="\${p.description}" \${p.name === oldMapToPLO && 'selected'}>\${p.name}</option>
                                        `).join('')
                            selectPLOInput.innerHTML = optionsHtmls
                            //                        element.html('');
                            //                        element.append(input);
                    }

                    function handleEditCLO(index, newName, newDescription, newMapToPLO) {

                    }

                    function handleSaveEdit() {
                    const cloIndex = $(this).closest("tr").data("index");
                    console.log({
                    cloIndex
                    })
                            const newName = $(this).closest("tr").find("td").find('input').val();
                    const newDescription = $(this).closest("tr").find("td").find('textarea').val();
                    const newMapToPLO = $(this).closest("tr").find("td").find('select#mapToPLO option:selected').text();
                    const tblIDCheck = $(this).closest('table').attr('id');
                    if (newName.includes('CLO') && newDescription) {
                    handleEditCLO(cloIndex, newName, newDescription, newMapToPLO);
                    } else {
                    if (tblIDCheck.includes('plo')) {
                    var errorShow = $('#plo-error');
                    if (newName == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("PLO name cannot be left blank, please try again!");
                    } else {
                    errorShow.css('display', 'block');
                    errorShow.text("PLO name must follow format PLOxx, please try again!");
                    }
                    } else {
                    var errorShow = $('#po-error');
                    if (newName == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("PO name cannot be left blank, please try again!");
                    } else {
                    errorShow.css('display', 'block');
                    errorShow.text("PO name must follow format POxx, please try again!");
                    }
                    }
                    }
                    }

                    function handleDelete(event){
                    const index = $(this).closest("tr").data("index");
                    console.log("day la index " + index);
                    deleteCLO(index);
                    }

                    function deleteCLO(index) {
                    const listCLO = cloUtils.getListFromLocalStorage();
                    if (index < 0 || index >= listCLO.length) {
                    throw new Error("Invalid CLO index");
                    }

                    listCLO.splice(index, 1);
                    cloUtils.saveToLocalStorage(listCLO);
                    renderListCLO(listCLO);
                    const sessions = getListFromLocalStorage(app.localStorage.syllabus.sessions);
                    const questions = getListFromLocalStorage(app.localStorage.syllabus.questions);
                    const assessments = getListFromLocalStorage(app.localStorage.syllabus.assessments);
                    validateExcelForSession(sessions);
                    validateExcelForAssessment(assessments);
                    checkAndMapingSessionNo(sessions, questions);
                    localStorage.setItem('syllabus.sessions', JSON.stringify(sessions));
                    localStorage.setItem('syllabus.questions', JSON.stringify(questions));
                    localStorage.setItem('syllabus.assessments', JSON.stringify(assessments));
                    renderList(sessions, 'sessions');
                    renderList(questions, 'questions');
                    renderList(assessments, 'assessments');
//                    $('#btn-cancel-update').click();
                    }






                    const allCheckboxSession = document.getElementById("allCheckSession");
                    allCheckboxSession.addEventListener("change", function () {
                    const sessionCheckboxes = document.querySelectorAll('#excel-table-sessions input#sessionCheckbox');
                    if (allCheckboxSession.checked) {
                    for (let i = 0; i < sessionCheckboxes.length; i++) {
                    sessionCheckboxes[i].checked = false;
                    }
                    }
                    });
                    const allCheckboxQuestion = document.getElementById("allCheckQuestion");
                    allCheckboxQuestion.addEventListener("change", function () {
                    const questionCheckboxes = document.querySelectorAll('#excel-table-questions input#questionCheckbox');
                    if (allCheckboxQuestion.checked) {
                    for (let i = 0; i < questionCheckboxes.length; i++) {
                    questionCheckboxes[i].checked = false;
                    }
                    }
                    });
                    const allCheckboxAssessment = document.getElementById("allCheckAssessment");
                    allCheckboxAssessment.addEventListener("change", function () {
                    const assessmentCheckboxes = document.querySelectorAll('#excel-table-assessments input#assessmentCheckbox');
                    if (allCheckboxAssessment.checked) {
                    for (let i = 0; i < assessmentCheckboxes.length; i++) {
                    assessmentCheckboxes[i].checked = false;
                    }
                    }
                    });
                    function deleteSession() {
                    const sessions = getListFromLocalStorage(app.localStorage.syllabus.sessions);
                    const questions = getListFromLocalStorage(app.localStorage.syllabus.questions);
                    const sessionCheckboxes = document.querySelectorAll('#excel-table-sessions input#sessionCheckbox');
                    if (allCheckboxSession.checked) {
                    if (confirm("Deleting all sessions will also delete all questions. Do you still want to proceed?")) {
                    sessions.splice(0, sessions.length);
                    questions.splice(0, questions.length);
                    renderList(sessions, 'sessions');
                    renderList(questions, 'questions');
                    } else {
                    return;
                    }
                    } else {
                    for (let i = 0; i < sessionCheckboxes.length; i++) {
                    if (sessionCheckboxes[i].checked) {
                    const row = sessionCheckboxes[i].closest("tr");
                    const index = sessionCheckboxes[i].closest('tr').getAttribute('data-index');
                    sessions[index].deleted = true;
                    
                    }
                    }
                    checkAndMapingSessionNo(sessions.filter(session => !session.deleted), questions);
                    renderList(sessions.filter(session => !session.deleted), 'sessions');
                    renderList(questions, 'questions');
                    }
                    }

                    function deleteAssessment() {
                    const assessments = getListFromLocalStorage(app.localStorage.syllabus.assessments);
                    const assessmentCheckboxes = document.querySelectorAll('#excel-table-assessments input#assessmentCheckbox');
                    if (allCheckboxAssessment.checked) {
                    if (confirm("Do you want to delete all assessments?")) {
                    assessments.splice(0, assessments.length);
                    renderList(assessments, 'assessments');
                    } else {
                    return;
                    }
                    } else {
                    for (let i = 0; i < assessmentCheckboxes.length; i++) {
                    if (assessmentCheckboxes[i].checked) {
                    const index = assessmentCheckboxes[i].closest('tr').getAttribute('data-index');
                    assessments[index].deleted = true;
                    }
                    }
                    renderList(assessments.filter(assessment => !assessment.deleted), 'assessments');
                    }
                    }



                    function deleteQuestion(){
                    const questions = getListFromLocalStorage(app.localStorage.syllabus.questions);
                    const questionCheckboxes = document.querySelectorAll('#excel-table-questions input#questionCheckbox');
                    if (allCheckboxQuestion.checked) {
                    if (confirm("Do you want to delete all questions ?")) {
                    questions.splice(0, questions.length);
                    renderList(questions, 'questions');
                    } else {
                    return;
                    }
                    } else {
                    for (let i = 0; i < questionCheckboxes.length; i++) {
                    if (questionCheckboxes[i].checked) {
                    const index = questionCheckboxes[i].closest('tr').getAttribute('data-index');
                    questions[index].deleted = true;

                    }
                    }
                     renderList(questions.filter(question => !question.deleted), 'questions');
                    }
                    }






                    function resetForm(form) {
                    const formElements = form.querySelectorAll("input, select, textarea");
                    for (let i = 0; i < formElements.length; i++) {
                    const elementType = formElements[i].type.toLowerCase();
                    if (elementType === "text" || elementType === "password" || elementType === "textarea" || elementType === "select-one" || elementType === "select-multiple") {
                    formElements[i].value = "";
                    } else if (elementType === "checkbox" || elementType === "radio") {
                    formElements[i].checked = formElements[i].defaultChecked;
                    }
                    }
                    }


                    // handle sessions-questions-assessments
                    const input = document.getElementById("file-input");
                    input.addEventListener("change", event => {
                    const list = localStorage.getItem('syllabus.sessions');
                    const listAssess = localStorage.getItem('syllabus.assessments');
                    const listCLO = cloUtils.getListFromLocalStorage();
                    if (!listCLO || listCLO.length === 0){
                    alert("You should add CLO first!!!");
                    event.target.value = null;
                    return;
                    }
                    console.log("checked");
                    if (list || listAssess){
                    if (confirm("The file has been uploaded before, do you want to overwrite this file?")){
                    console.log("oke nha");
                    handleFileUpload(event);
                    event.target.value = null;
                    } else{
                    console.log("!oke nha");
                    event.target.value = null;
                    return;
                    } }
                    else{
                    handleFileUpload(event);
                    event.target.value = null;
                    }
                    });
                    async function handleFileUpload(event) {
                    const file = event.target.files[0];
                    const sessionsMap = {
                    'No': 'no',
                            'Topic': 'topic',
                            'Learning Type': 'learning_type',
                            'LO': 'lo',
                            'ITU': 'itu',
                            'Material': 'material',
                            'Active': 'active',
                    };
                    const questionsMap = {
                    'No': 'no',
                            'SessionNo': 'session_no',
                            'Name': 'name',
                            'Details': 'details',
                            'Active': 'active',
                    };
                    const assessmentsMap = {
                    'No': 'no',
                            'Category': 'category',
                            'Type': 'type',
                            'Part': 'part',
                            'Weight': 'weight',
                            'Complement citerial': 'complement_citerial',
                            'Duration': 'duration',
                            'CLO': 'clo',
                            'Question Type': 'question_type',
                            'Total Questions': 'total_question',
                            'Knowledge and Skill': 'kns',
                            'Grading Guide': 'grading_guide',
                            'Active': 'active',
                    };
                    try {
                    startLoading();
                    const sessionsData = await readXlsxFile(file, {
                    sheet: "Sessions",
                            map: sessionsMap
                    });
                    const assessmentsData = await readXlsxFile(file, {
                    sheet: "Assessments",
                            map: assessmentsMap
                    });
                    const questionsData = await readXlsxFile(file, {
                    sheet: "Questions",
                            map: questionsMap
                    });
                    validateExcelForSession(sessionsData?.rows);
                    validateExcelForQuestion(questionsData?.rows);
                    validateExcelForAssessment(assessmentsData?.rows);
                    checkAndMapingSessionNo(sessionsData?.rows, questionsData?.rows);
                    checkAndUpdateActiveValues(sessionsData?.rows);
                    checkAndUpdateActiveValues(questionsData?.rows);
                    checkAndUpdateActiveValues(assessmentsData?.rows);
                    renderList(sessionsData?.rows, 'sessions');
                    renderList(questionsData?.rows, 'questions')
                            renderList(assessmentsData?.rows, 'assessments')
                    } catch (e) {
                    console.error(e);
                    } finally {
                    stopLoading();
                    }

                    };
                    function validateExcelForSession(list){

                    const listCLO = cloUtils.getListFromLocalStorage();
                    const cloValues = listCLO.map(itemCLO => itemCLO.name);
                    const message = document.getElementById("session-table-error");
                    message.innerHTML = "";
                    message.style.display = "none";
                    let errorMessage = "";
                    let check = true;
                    if (!list || list.length === 0) return;
                    for (let i = 0; i < list.length; i++) {
                    let checkDelete = true;
                    const item = list[i];
                    if (isNaN(item.no)){

                    check = false;
                    checkDelete = false;
                    errorMessage = "Invalid format SessionNo ";
                    }


                    if (item.lo){
                    const cloArray = item.lo.split(",");
                    for (let j = 0; j < cloArray.length; j++){

                    if (!cloValues.includes(cloArray[j])){

                    check = false;
                    checkDelete = false;
                    errorMessage = "CLO Session does not match to list CLO ";
                    }
                    }
                    }

                    if (checkDelete == false){
                    list.splice(i, 1);
                    i--;
                    }
                    }
                    if (check === false){
                    message.innerHTML = errorMessage + "<br>Some rows have been removed";
                    message.style.display = "block";
                    message.style.border = "1px solid red";
                    message.style.padding = "10px";
                    message.style.fontSize = "16px";
                    message.style.color = "red";
                    message.style.backgroundColor = "#ffe6e6";
                    }

                    }


                    function validateExcelForQuestion(list){
                    const message = document.getElementById("question-table-error2");
                    message.innerHTML = "";
                    message.style.display = "none";
                    let errorMessage = "";
                    let check = true;
                    if (!list || list.length === 0) return;
                    for (let i = 0; i < list.length; i++) {
                    const item = list[i];
                    if (isNaN(item.no)){
                    check = false;
                    errorMessage = "Invalid format QuestionNo ";
                    list.splice(i, 1);
                    i--;
                    }

                    if (check === false){
                    message.innerHTML = errorMessage + "<br>Some rows have been removed";
                    message.style.display = "block";
                    message.style.border = "1px solid red";
                    message.style.padding = "10px";
                    message.style.fontSize = "16px";
                    message.style.color = "red";
                    message.style.backgroundColor = "#ffe6e6";
                    }

                    }}


                    function validateExcelForAssessment(list){
                    const listCLO = cloUtils.getListFromLocalStorage();
                    const cloValues = listCLO.map(itemCLO => itemCLO.name);
                    const message = document.getElementById("assessment-table-error");
                    message.innerHTML = "";
                    message.style.display = "none";
                    let errorMessage = "";
                    let check = true;
                    if (!list || list.length === 0) return;
                    for (let i = 0; i < list.length; i++) {
                    let checkDelete = true;
                    const item = list[i];
                    if (isNaN(item.no)){
                    check = false;
                    checkDelete = false;
                    errorMessage = "Invalid format AssessmentNo ";
                    }

                    if (isNaN(item.part)){
                    check = false;
                    checkDelete = false;
                    errorMessage = "Invalid format Assessment Part ";
                    }

                    if (item.clo){
                    const cloArray = item.clo.split(",");
                    for (let j = 0; j < cloArray.length; j++){

                    if (!cloValues.includes(cloArray[j])){
                    check = false;
                    checkDelete = false;
                    errorMessage = "CLO Assessment does not match to list CLO ";
                    }
                    }
                    }
                    if (checkDelete == false){
                    list.splice(i, 1);
                    i--;
                    }
                    }
                    if (check === false){
                    message.innerHTML = errorMessage + "<br>Some rows have been removed";
                    message.style.display = "block";
                    message.style.border = "1px solid red";
                    message.style.padding = "10px";
                    message.style.fontSize = "16px";
                    message.style.color = "red";
                    message.style.backgroundColor = "#ffe6e6";
                    }

                    }


                    function checkAndUpdateActiveValues(list) {
                    if (!list || list.length === 0) return;
                    list.forEach(item => {
                    item.active = false;
                    });
                    }

                    function checkAndMapingSessionNo(listSession, listQuestion){
                    const message = document.getElementById("question-table-error");
                    message.innerHTML = "";
                    message.style.display = "none";
                    if (!listSession || listSession.length === 0 || !listQuestion || listQuestion.length === 0) {
                    listQuestion.splice(0, listQuestion.length);
                    return;
                    }
                    const noValues = listSession.map(item => parseInt(item.no));
                    console.log("day la no" + noValues);
                    for (let i = 0; i < listQuestion.length; i++) {
                    const itemQuestion = listQuestion[i];
                    console.log("check maping no " + itemQuestion.session_no);
                    if (!noValues.includes(itemQuestion.session_no)) {
                    console.log("xoa");
                    const message = document.getElementById("question-table-error");
                    message.innerHTML = `Error : Some questions does not match to Session has been removed`;
                    message.style.display = "block";
                    message.style.border = "1px solid red";
                    message.style.padding = "10px";
                    message.style.fontSize = "16px";
                    message.style.color = "red";
                    message.style.backgroundColor = "#ffe6e6";
                    listQuestion.splice(i, 1);
                    i--;
                    }
                    }
//                    return listQuestion;
                    }



                    function renderList(list, type) {
                    if (!list || list.length === 0) {
                    if (type === "assessments"){
                    const assessmentsTable = document.getElementById("excel-table-assessments");
                    assessmentsTable.innerHTML = "";
                    localStorage.removeItem('syllabus.' + type);
                    }
                    if (type === "sessions"){
                    const questionsTable = document.getElementById("excel-table-sessions");
                    questionsTable.innerHTML = "";
                    localStorage.removeItem('syllabus.' + type);
                    }
                    if (type === "questions"){
                    const questionsTable = document.getElementById("excel-table-questions");
                    questionsTable.innerHTML = "";
                    localStorage.removeItem('syllabus.' + type);
                    }
                    return;
                    }

                    const action = {
                    sessions: renderListSessions,
                            assessments: renderListAssessments,
                            questions: renderListQuestions
                    }

                    const executeFn = action[type]

                            if (!executeFn) throw new Error('Invalid type of list. We\'ve supported sessions, questions and assessments. Try again');
                    executeFn(list);
                    localStorage.setItem('syllabus.' + type, JSON.stringify(list));
                    }
                    function renderListQuestions(rows) {
                    const questionsTable = document.getElementById("excel-table-questions");
                    questionsTable.innerHTML = "";
                    let count = 0;
                    rows.forEach((row) => {
                    const tr = document.createElement("tr");
                    const tdCheckbox = document.createElement("td");
                    const checkbox = document.createElement("input");
                    const tdNo = document.createElement("td");
                    const tdSessionNo = document.createElement("td");
                    const tdName = document.createElement("td");
                    const tdDetails = document.createElement("td");
                    const tdEdit = document.createElement("td");
                    const tdActive = document.createElement("td");
                    const activeCheckbox = document.createElement("input");
                    const editButton = document.createElement("button");
                    const allCheckQuestion = document.getElementById("allCheckQuestion");
                    checkbox.type = "checkbox";
                    checkbox.checked = false;
                    checkbox.id = "questionCheckbox";
                    checkbox.onclick = function() {
                    if (checkbox.checked){
                    allCheckQuestion.checked = false;
                    }
                    }
                    tdNo.textContent = row.no;
                    tdSessionNo.textContent = row?.session_no;
                    tdName.textContent = row?.name;
                    tdDetails.textContent = row.details;
                    tdDetails.setAttribute('colspan', 3);
                    editButton.textContent = "Edit";
                    editButton.classList.add("btn", "btn-sm", "btn-primary");
                    editButton.type = "button";
                    activeCheckbox.id = "tableCheckBoxID";
                    activeCheckbox.type = "checkbox";
                    activeCheckbox.checked = false;
                    if (row.active == "1"){
                    activeCheckbox.checked = true;
                    }

                    activeCheckbox.disabled = true;
                    tdCheckbox.appendChild(checkbox);
                    tr.appendChild(tdCheckbox);
                    tr.appendChild(tdNo);
                    tr.appendChild(tdSessionNo);
                    tr.appendChild(tdName);
                    tr.appendChild(tdDetails);
                    tdEdit.appendChild(editButton);
                    tdActive.appendChild(activeCheckbox);
                    tr.appendChild(tdActive);
                    tr.appendChild(tdEdit);
                    questionsTable.appendChild(tr);
                    tr.setAttribute('data-index', count);
                    count++;
                    editButton.addEventListener("click", (event) => {
                    event.preventDefault();
                    showModalQuestion(row, (updatedRow) => {
                    // Update the row data with the new values
                    row.session_no = updatedRow.session_no;
                    row.name = updatedRow.name;
                    row.details = updatedRow.details;
                    row.active = updatedRow.active;
                    localStorage.setItem('syllabus.questions', JSON.stringify(rows));
                    renderListQuestions(rows); // Render the updated rows after saving
                    });
                    });
                    });
                    }


                    function showModalQuestion(row, onSave) {
                    const modal = document.getElementById("edit-modal-question");
//                    const sessionNoInput = document.getElementById("edit-no");
                    const nameInput = document.getElementById("edit-name");
                    const detailsInput = document.getElementById("edit-details");
                    const activeCheckbox = document.getElementById("edit-active");
                    const sessionNoSelect = document.getElementById("edit-no-select");
                    sessionNoSelect.innerHTML = "";
                    const listSessions = JSON.parse(localStorage.getItem(app.localStorage.syllabus.sessions));
                    for (let i = 0; i < listSessions.length; i++) {
                    const option = document.createElement("option");
                    option.text = listSessions[i].no;
                    option.value = listSessions[i].no;
                    if (listSessions[i].no == row.session_no) {
                    option.selected = true;
                    }
                    sessionNoSelect.appendChild(option);
                    }
//                    sessionNoInput.value = row.session_no;
                    nameInput.value = row.name;
                    detailsInput.value = row.details;
                    activeCheckbox.disabled = true;
                    activeCheckbox.checked = row?.active == "1";
                    $('#edit-modal-question').modal('show');
                    const saveButton = document.getElementById("edit-save");
                    const cancelButton = document.getElementById("edit-cancel");
                    saveButton.addEventListener("click", onClickSave);
                    cancelButton.addEventListener("click", onClickCancel);
                    function onClickSave(event) {
                    event.preventDefault();
                    console.log("day roi");
                    const updatedRow = {
                    session_no: sessionNoSelect.value,
                            name: nameInput.value,
                            details: detailsInput.value,
                            active: activeCheckbox.checked ? "1" : "0",
                    };
                    onSave(updatedRow);
                    saveButton.removeEventListener("click", onClickSave);
                    cancelButton.removeEventListener("click", onClickCancel);
                    $('#edit-modal-question').modal('hide');
                    }

                    function onClickCancel(event) {
                    console.log("dong");
                    event.preventDefault();
                    saveButton.removeEventListener("click", onClickSave);
                    cancelButton.removeEventListener("click", onClickCancel);
                    $('#edit-modal-question').modal('hide');
                    }


                    $('#edit-modal-question').on('hidden.bs.modal', function () {
                    saveButton.removeEventListener("click", onClickSave);
                    cancelButton.removeEventListener("click", onClickCancel);
                    })
                    }


                    function renderListAssessments(rows) {
                    const assessmentsTable = document.getElementById("excel-table-assessments");
                    assessmentsTable.innerHTML = "";
                    let count = 0;
                    rows.forEach((row) => {
                    const tr = document.createElement("tr");
                    const tdCheckbox = document.createElement("td");
                    const checkbox = document.createElement("input");
                    const tdNo = document.createElement("td");
                    const tdCategory = document.createElement("td");
                    const tdType = document.createElement("td");
                    const tdPart = document.createElement("td");
                    const tdWeight = document.createElement("td");
                    const tdComplementCiterial = document.createElement("td");
                    const tdDuration = document.createElement("td");
                    const tdCLO = document.createElement("td");
                    const tdQuestionType = document.createElement("td");
                    const tdTotalQuestions = document.createElement("td");
                    const tdKnowledgeSkills = document.createElement("td");
                    const tdGradingGuide = document.createElement("td");
                    const tdActive = document.createElement("td");
                    const activeCheckbox = document.createElement("input");
                    const tdEdit = document.createElement("td");
                    const editButton = document.createElement("button");
                    const allCheckAssessment = document.getElementById("allCheckAssessment");
                    checkbox.type = "checkbox";
                    checkbox.checked = false;
                    checkbox.id = "assessmentCheckbox";
                    checkbox.onclick = function() {
                    if (checkbox.checked){
                    allCheckAssessment.checked = false;
                    }
                    }
                    tdNo.textContent = row?.no;
                    tdCategory.textContent = row?.category;
                    tdType.textContent = row?.type;
                    tdPart.textContent = row?.part;
                    tdWeight.textContent = row?.weight;
                    tdComplementCiterial.textContent = row?.complement_citerial;
                    tdDuration.textContent = row?.duration;
                    tdCLO.textContent = row?.clo;
                    tdCLO.style.wordBreak = "break-all";
                    tdQuestionType.textContent = row?.question_type;
                    tdTotalQuestions.textContent = row?.total_question;
                    tdKnowledgeSkills.textContent = row?.kns;
                    tdGradingGuide.textContent = row?.grading_guide;
                    editButton.textContent = "Edit";
                    editButton.classList.add("btn", "btn-sm", "btn-primary");
                    editButton.type = "button";
                    activeCheckbox.id = "tableCheckBoxID";
                    activeCheckbox.type = "checkbox";
                    activeCheckbox.checked = false;
                    activeCheckbox.disabled = true;
                    console.log(row.active);
                    if (row.active == "1"){
                    activeCheckbox.checked = true;
                    }


                    tdCheckbox.appendChild(checkbox);
                    tdEdit.appendChild(editButton);
                    tr.appendChild(tdCheckbox);
                    tr.appendChild(tdNo);
                    tr.appendChild(tdCategory);
                    tr.appendChild(tdType);
                    tr.appendChild(tdPart);
                    tr.appendChild(tdWeight);
                    tr.appendChild(tdComplementCiterial);
                    tr.appendChild(tdDuration);
                    tr.appendChild(tdCLO);
                    tr.appendChild(tdQuestionType);
                    tr.appendChild(tdTotalQuestions);
                    tr.appendChild(tdKnowledgeSkills);
                    tr.appendChild(tdGradingGuide);
                    tdActive.appendChild(activeCheckbox);
                    tr.appendChild(tdActive);
                    tr.appendChild(tdEdit);
                    tr.setAttribute('data-index', count);
                    count++;
                    assessmentsTable.appendChild(tr);
                    editButton.addEventListener("click", () => {
                    showModalAssessment(row, (updatedRow) => {
                    // Update the row data with the new values
                    row.category = updatedRow.category;
                    row.type = updatedRow.type;
                    row.part = updatedRow.part;
                    row.weight = updatedRow.weight;
                    row.complement_citerial = updatedRow.complement_citerial;
                    row.duration = updatedRow.duration;
                    row.clo = updatedRow.clo;
                    row.question_type = updatedRow.question_type;
                    row.total_question = updatedRow.total_question;
                    row.kns = updatedRow.kns;
                    row.grading_guide = updatedRow.grading_guide;
                    row.active = updatedRow.active;
                    console.log(updatedRow.active);
                    localStorage.setItem('syllabus.assessments', JSON.stringify(rows));
                    renderListAssessments(rows); // Render the updated rows after saving
                    });
                    });
                    });
                    }


                    function showModalAssessment(row, onSave) {
                    const modal = document.getElementById("edit-modal-assessment");
                    const saveButton = document.getElementById("edit-save-assessment");
                    const cancelButton = document.getElementById("edit-cancel-assessment");
                    const categoryInput = document.getElementById("edit-category-assessment");
                    const typeInput = document.getElementById("edit-type-assessment");
                    const partInput = document.getElementById("edit-part-assessment");
                    const weightInput = document.getElementById("edit-weight-assessment");
                    const complementCiterialInput = document.getElementById("edit-complement-citerial-assessment");
                    const durationInput = document.getElementById("edit-duration-assessment");
//                    const cloInput = document.getElementById("edit-clo-assessment");
                    const questionTypeInput = document.getElementById("edit-question-type-assessment");
                    const totalQuestionInput = document.getElementById("edit-total-question-assessment");
                    const knsInput = document.getElementById("edit-kns-assessment");
                    const gradingGuideInput = document.getElementById("edit-grading-guide-assessment");
                    const activeCheckbox = document.getElementById("edit-active-assessment");
                    const listCLO = cloUtils.getListFromLocalStorage();
                    const cloSelect = document.getElementById("edit-clo-select-multi-assessment");
                    cloSelect.innerHTML = "";
                    for (let i = 0; i < listCLO.length; i++){
                    const option = document.createElement("option");
                    option.text = listCLO[i].name;
                    option.value = listCLO[i].name;
                    if (row && row.clo && row?.clo.includes(listCLO[i].name)){
                    option.selected = true;
                    }
                    cloSelect.appendChild(option);
                    }
                    console.log("ass ne " + row.active);
                    categoryInput.value = row?.category;
                    typeInput.value = row?.type;
                    partInput.value = row?.part;
                    weightInput.value = row?.weight;
                    complementCiterialInput.value = row?.complement_citerial;
                    durationInput.value = row?.duration;
//                    cloInput.value = row?.clo;
                    questionTypeInput.value = row?.question_type;
                    totalQuestionInput.value = row?.total_question;
                    knsInput.value = row?.kns;
                    gradingGuideInput.value = row?.grading_guide;
                    activeCheckbox.disabled = true;
                    activeCheckbox.checked = row?.active == "1";
                    $('#edit-modal-assessment').modal('show');
                    saveButton.addEventListener("click", onClickSave);
                    cancelButton.addEventListener("click", onClickCancel);
                    function onClickSave(event) {
                    event.preventDefault();
                    console.log("day roi");
                    const selectedOptions = Array.from(cloSelect.selectedOptions).map(option => option.value).join(',');
                    const updatedRow = {
                    category: categoryInput.value,
                            type: typeInput.value,
                            part: partInput.value,
                            weight: weightInput.value,
                            complement_citerial: complementCiterialInput.value,
                            duration: durationInput.value,
                            clo: selectedOptions,
                            question_type: questionTypeInput.value,
                            total_question: totalQuestionInput.value,
                            kns: knsInput.value,
                            grading_guide: gradingGuideInput.value,
                            active: activeCheckbox.checked ? "1" : "0",
                    };
                    onSave(updatedRow);
                    saveButton.removeEventListener("click", onClickSave);
                    cancelButton.removeEventListener("click", onClickCancel);
                    $('#edit-modal-assessment').modal('hide');
                    }

                    function onClickCancel(event) {
                    console.log("dong");
                    event.preventDefault();
                    saveButton.removeEventListener("click", onClickSave);
                    cancelButton.removeEventListener("click", onClickCancel);
                    $('#edit-modal-assessment').modal('hide');
                    }

                    $('#edit-modal-assessment').on('hidden.bs.modal', function () {
                    saveButton.removeEventListener("click", onClickSave);
                    cancelButton.removeEventListener("click", onClickCancel);
                    })
                    }


                    function renderListSessions(rows) {
                    const activeSwitch = document.getElementById("flexSwitchCheckChecked");
                    const sessionsTable = document.getElementById("excel-table-sessions");
                    let count = 0;
                    sessionsTable.innerHTML = "";
                    rows.forEach((row) => {
                    //Create elements
                    const tr = document.createElement("tr");
                    const tdCheckbox = document.createElement("td");
                    const checkbox = document.createElement("input");
                    const tdNo = document.createElement("td");
                    const tdTopic = document.createElement("td");
                    const tdLearningType = document.createElement("td");
                    const tdLO = document.createElement("td");
                    const tdITU = document.createElement("td");
                    const tdMaterial = document.createElement("td");
                    const tdActive = document.createElement("td");
                    const activeCheckbox = document.createElement("input");
                    const tdEdit = document.createElement("td");
                    const editButton = document.createElement("button");
                    const allCheckboxSession = document.getElementById("allCheckSession");
                    // Set essentials data
                    checkbox.type = "checkbox";
                    checkbox.id = "sessionCheckbox";
                    checkbox.checked = false;
                    checkbox.onclick = function() {

                    if (checkbox.checked){
                    allCheckboxSession.checked = false;
                    }
                    };
                    tdCheckbox.appendChild(checkbox);
                    tdNo.textContent = row?.no;
                    tdTopic.textContent = row?.topic;
                    tdLearningType.textContent = row?.learning_type;
                    tdLO.textContent = row?.lo;
                    tdLO.style.wordBreak = "break-all";
                    tdITU.textContent = row?.itu;
                    tdMaterial.textContent = row?.material;
                    editButton.textContent = "Edit";
                    editButton.classList.add("btn", "btn-sm", "btn-primary");
                    editButton.type = "button";
                    activeCheckbox.id = "tableCheckBoxID";
                    activeCheckbox.type = "checkbox";
                    activeCheckbox.checked = false;
                    activeCheckbox.disabled = true;
                    if (row.active == "1"){
                    activeCheckbox.checked = true;
                    }


                    // Append them.
                    tdEdit.appendChild(editButton);
                    editButton.addEventListener("click", (event) => {
                    event.preventDefault();
                    showModalSession(row, (updatedRow) => {
                    // Update the row data with the new values
                    row.no = updatedRow.no;
                    row.topic = updatedRow.topic;
                    row.learning_type = updatedRow.learning_type;
                    row.lo = updatedRow.lo;
                    row.itu = updatedRow.itu;
                    row.material = updatedRow.material;
                    row.active = updatedRow.active;
                    localStorage.setItem('syllabus.sessions', JSON.stringify(rows));
                    let questions = getListFromLocalStorage(app.localStorage.syllabus.questions);
                    renderListSessions(rows);
                    console.log(rows);
                    console.log("Day la question" + JSON.stringify(questions));
                    checkAndMapingSessionNo(rows, questions);
                    console.log(JSON.stringify(questions));
                    renderListQuestions(questions);
                    localStorage.setItem('syllabus.questions', JSON.stringify(questions));
                    // Render the updated rows after saving
                    });
                    });
                    tr.appendChild(tdCheckbox);
                    tr.appendChild(tdNo);
                    tr.appendChild(tdTopic);
                    tr.appendChild(tdLearningType);
                    tr.appendChild(tdLO);
                    tr.appendChild(tdITU);
                    tr.appendChild(tdMaterial);
                    tdActive.appendChild(activeCheckbox);
                    tr.appendChild(tdActive);
                    tr.appendChild(tdEdit);
                    tr.setAttribute('data-index', count);
                    sessionsTable.appendChild(tr);
                    count++;
                    });
                    }

                    function showModalSession(row, onSave, onCancel) {
                    console.log(row);
                    const modal = document.getElementById("edit-modal-session");
                    const saveButton = document.getElementById("edit-session-save");
                    const cancelButton = document.getElementById("edit-session-cancel");
                    const inputNo = document.getElementById("edit-session-no");
                    const topicInput = document.getElementById("edit-session-topic");
                    const learningTypeInput = document.getElementById("edit-session-learningType");
                    const ituInput = document.getElementById("edit-session-itu");
//                    const cloInput = document.getElementById("edit-session-clo");
                    const materialInput = document.getElementById("edit-session-material");
                    const activeCheckbox = document.getElementById("edit-session-active");
                    const listCLO = cloUtils.getListFromLocalStorage();
                    const cloSelect = document.getElementById("edit-clo-select-multi");
                    cloSelect.innerHTML = "";
                    for (let i = 0; i < listCLO.length; i++){
                    const option = document.createElement("option");
                    option.text = listCLO[i].name;
                    option.value = listCLO[i].name;
                    if (row && row.lo && row?.lo.includes(listCLO[i].name)){
                    option.selected = true;
                    }
                    cloSelect.appendChild(option);
                    }

                    console.log("ass ne " + row.active);
                    inputNo.value = row?.no;
                    topicInput.value = row?.topic;
                    learningTypeInput.value = row?.learning_type;
                    ituInput.value = row?.itu;
//                    cloInput.value = row?.lo;
                    materialInput.value = row?.material;
                    activeCheckbox.disabled = true;
                    activeCheckbox.checked = row?.active == "1";
                    $('#edit-modal-session').modal('show');
                    saveButton.addEventListener("click", onClickSave);
                    cancelButton.addEventListener("click", onClickCancel);
                    function onClickSave(event) {
                    event.preventDefault();
                    console.log("day roi");
                    const selectedOptions = Array.from(cloSelect.selectedOptions).map(option => option.value);
                    const updatedRow = {
                    no: inputNo.value,
                            topic: topicInput.value,
                            learning_type: learningTypeInput.value,
                            lo: selectedOptions,
                            itu: ituInput.value,
                            material: materialInput.value,
                            active: activeCheckbox.checked ? "1" : "0",
                    };
                    console.log("CLO modal " + selectedOptions);
                    onSave(updatedRow);
                    saveButton.removeEventListener("click", onClickSave);
                    cancelButton.removeEventListener("click", onClickCancel);
                    $('#edit-modal-session').modal('hide');
                    }

                    function onClickCancel(event) {
                    console.log("dong");
                    event.preventDefault();
                    saveButton.removeEventListener("click", onClickSave);
                    cancelButton.removeEventListener("click", onClickCancel);
                    $('#edit-modal-session').modal('hide');
                    }
                    $('#edit-modal-session').on('hidden.bs.modal', function () {
                    saveButton.removeEventListener("click", onClickSave);
                    cancelButton.removeEventListener("click", onClickCancel);
                    })
                    };


                </script>
                </body>
                </html>