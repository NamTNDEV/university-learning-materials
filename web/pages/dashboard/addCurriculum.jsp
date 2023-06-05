<%-- 
    Document   : CurriculumAdd
    Created on : Apr 13, 2023, 11:20:49 PM
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="config.AppConfig" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            <%@ include file="/css/style.css" %>
        </style>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
        <title>Add curriculum</title>
    </head>
    <%List subList = (List) request.getAttribute(AppConfig.SUBJECT_LIST);%>
    <body>
        <div class="dashboard-container">
            <%@include file="/components/dashboard/sidebar.jspx" %>
            <main>
                <%@include file="/components/dashboard/header.jspx" %>
                <div class="dashboard-content">
                    <div class="container ml-3" style="margin: 0 2%">
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


                        <legend>Add Curriculum</legend>
                        <form class="mt-4" action="<c:url value="/dashboard/curriculums/add" />" method="POST" enctype="multipart/form-data">

                            <!-- Basic Infomation -->
                            <span>Basic Infomation</span>
                            <div class="row g-3 align-items-center" style="margin-top: 23px;">
                                <div class="col-2">
                                    <label for="code" class="col-form-label" style="font-size: 16px;">Code</label>
                                </div>
                                <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                    <input type="text" name="code" id="code" class="form-control">
                                </div>
                            </div>

                            <div class="row g-3 align-items-center mt-1">
                                <div class="col-2">
                                    <label for="slug" class="col-form-label" style="font-size: 16px;">Slug</label>
                                </div>
                                <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                    <input type="text" name="splug" id="slug" class="form-control" readonly disabled>
                                </div>
                            </div>

                            <div class="row g-3 align-items-center mt-1">
                                <div class="col-2">
                                    <label for="englishName" class="col-form-label" style="font-size: 16px;">English
                                        name</label>
                                </div>
                                <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                    <input type="text" id="englishName" name="englishName" class="form-control"
                                           >
                                </div>
                            </div>

                            <div class="row g-3 align-items-center mt-1">
                                <div class="col-2">
                                    <label for="vietnameseName" class="col-form-label"
                                           style="font-size: 16px;">Vietnamese name</label>
                                </div>
                                <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                    <input type="text" id="vietnameseName" name="vietnameseName" class="form-control"
                                           >
                                </div>
                            </div>

                            <div class="row g-3 align-items-center mt-1">
                                <div class="col-2">
                                    <label for="description" class="col-form-label"
                                           style="font-size: 16px;">Description</label>
                                </div>
                                <div class="col-6" style="margin-left: -40px">
                                    <input type="hidden" name="description" id="description"/>
                                    <div  id="descriptionEditor" style="margin-top: 0; height: 70px;"></div>
                                </div>
                            </div>

                            <div class="row g-3 align-items-center mt-1">
                                <div class="col-2">
                                    <label for="decisionNo" class="col-form-label" style="font-size: 16px;">Decision
                                        No</label>
                                </div>
                                <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                    <input type="text" id="decisionNo" name="decisionNo" class="form-control"
                                           placeholder="BIT_SE_K16C">
                                </div>
                            </div>
                            <div class="alert alert-danger" id="basic-error" role="alert"
                                 style="margin-top: 20px; margin-right: 4px; display: none;">
                                <!--BASIC_INFO_ERROR_MESSAGE-->
                            </div>

                            <!-- Objectives -->
                            <span style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Objectives</span>
                            <label class="btn btn-outline-secondary">
                                <input type="file" id="file_obj_upload"/>
                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                            </label>
                            <br/>
                            <!-- Objectives / Program Objectives (PO) -->
                            <span style="font-size: 18px; margin-bottom: 32px; display: inline-block;">Program
                                Objectives (PO)</span>
                            <table id="poTbl" style="width: 96%; margin-bottom: 32px; display:none;">
                                <thead>
                                    <tr>
                                        <th style="width: 10%;">Name</th>
                                        <th style="width: 72%">Description</th>
                                        <th style="width: 20.4%;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div class="form-add row g-3 align-items-center mt-1">
                                <div class="row col-12" id="add-po-form">
                                    <div>
                                        <label for="poName" class="col-form-label" style="font-size: 16px;">Name</label>
                                        <input type="text" id="poName" name="poName" class="form-control">
                                    </div>
                                    <div class="">
                                        <label for="poDescription" class="col-form-label"
                                               style="font-size: 16px;">Description</label>
                                        <textarea id="poDescription" class="form-control" name="poDescription"
                                                  ></textarea>
                                    </div>
                                    <div style="margin-top: 16px;">
                                        <button type="button" class="btn btn-primary" id="btn-add-po" name="op"
                                                value="add_po">Add
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary" value="">Cancel</button>
                                    </div>
                                </div>
                            </div>

                            <div class="alert alert-danger" id="po-error" role="alert"
                                 style="margin-top: 20px; margin-right: 4px; display: none;">
                                <!--PO_ERROR_MESSAGE-->
                            </div>

                            <!-- Objectives / Program Learning Objectives (PLO) -->
                            <span
                                style="font-size: 18px; margin-bottom: 32px; margin-top: 55px; display: inline-block;">Program
                                Program Learning Objectives (PLO)</span>

                            <table id="ploTbl" style="width: 96%; margin-bottom: 32px; display:none;">
                                <thead>
                                    <tr>
                                        <th style="width: 7.6%;">Name</th>
                                        <th style="width: 65%">Description</th>
                                        <th style="width: 22%; text-align: right;">Map to PO</th>
                                        <th style="width: 5.4%;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!--TITLE-->
                                </tbody>
                            </table>

                            <div class="form-add row g-3 align-items-center mt-1">
                                <div class="row col-12" id="add-plo-form">
                                    <div class="row" style="padding-right: 0">
                                        <div class="col-6">
                                            <label for="ploName" class="col-form-label"
                                                   style="font-size: 16px;">Name</label>
                                            <input type="text" id="ploName" name="ploName" class="form-control">
                                        </div>
                                        <div class="col-6" style="padding-right: 0">
                                            <label for="mapToPO" class="col-form-label" style="font-size: 16px;">Map to
                                                PO</label>
                                            <select style="color: #495057;" name="mapToPO" id="mapToPO" class="form-select">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="">
                                        <label for="ploDescription" class="col-form-label"
                                               style="font-size: 16px;">Description</label>
                                        <textarea id="ploDescription" class="form-control" name="ploDescription"
                                                  ></textarea>
                                    </div>
                                    <div style="margin-top: 16px;">
                                        <button type="button" id="btn-add-plo" class="btn btn-primary" name="op"
                                                value="add_plo">Add
                                        </button>
                                        <button type="submit" class="btn btn-outline-secondary" value="">Cancel</button>
                                    </div>
                                </div>
                            </div>

                            <div class="alert alert-danger" id="plo-error" role="alert"
                                 style="margin-top: 20px; margin-right: 4px; display: none;">
                                PLO_ERROR_MESSAGE
                            </div>

                            <!-- Subject -->
                            <span style="font-size: 18px; margin-bottom: 32px; margin-top: 55px; display: inline-block;">Subject</span>
                            <span style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Objectives</span>
                            <label class="btn btn-outline-secondary">
                                <input type="file" id="file_sub_upload" accept=".xlsx,.xls"/>
                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                            </label>
                            <br/>

                            <table id="subTbl" style="width: 96%; margin-bottom: 60px;">
                                <thead>
                                    <tr>
                                        <th style="width: 12%;">ID</th>
                                        <th style="width: 12%;">Slug</th>
                                        <th style="width: 32%;">Name</th>
                                        <th style="width: 32%;">Vietnamese Name</th>
                                        <th style="width: 12%;">Semester</th>
                                        <th style="text-align: left; width: 12%;">Checked</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!--TITLE-->
                                    <c:forEach var="sub" items="<%=subList%>">
                                        <tr>
                                            <td>${sub.id}</td>
                                            <td>${sub.slug}</td>
                                            <td>${sub.name}</td>
                                            <td>${sub.viName}</td>
                                            <td>${sub.semester}</td>
                                            <td><input type="checkbox" name="subCheck" value="${sub.id}"></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <div class="fixed-footer">
                                <div class="" style="margin-left: auto">
                                    <button id="btn-submit" type="button" class="btn btn-primary" name="confirm">Publish
                                    </button>
                                    <button id="btn-save" type="button" class="btn btn-secondary" name="save">Save as
                                        Draft
                                    </button>
                                </div>
                            </div>
                            <div class="alert alert-danger" id="upload-error" role="alert"
                                 style="margin-top: 20px; margin-right: 4px; display: none;">
                                <!--UPLOAD_MESSAGE-->
                            </div>
                            <div class="alert alert-danger" id="upload-error-po" role="alert"
                                 style="margin-top: 20px; margin-right: 4px; display: none;">
                                <!--UPLOAD_PO_MESSAGE-->
                            </div>
                            <div class="alert alert-danger" id="upload-error-plo" role="alert"
                                 style="margin-top: 20px; margin-right: 4px; display: none;">
                                <!--UPLOAD_PLO_MESSAGE-->
                            </div>
                            <div class="alert alert-danger" id="submit-error" role="alert"
                                 style="margin-top: 20px; margin-right: 4px; display: none;">
                                <!--SUBMIT_MESSAGE-->
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/slugify@1.6.6/slugify.min.js"></script>
        <script src="https://unpkg.com/read-excel-file@5.x/bundle/read-excel-file.min.js"></script>
        <script>
            $(document).ready(function () {
                let oldName;
                let oldDescription;

                $("#btn-submit").click(function () {
                    handleSubmit();
                });

                $('[name="subCheck"]').change(function () {
                    let indexCheckRow = $(this).closest("tr");
                    let isChecked = $(this).prop('checked');
                    handleCheck(indexCheckRow, isChecked);
                });

                $('#file_obj_upload').click(function () {
                    $(this).val('');
                }).change(function () {
                    let file = $('#file_obj_upload')[0].files[0];
                    let errorShow = $('#upload-error');
                    const addPOForm = $('#add-po-form');
                    const addPLOForm = $('#add-plo-form');
                    $("#myModal").modal("show");
                    $('#modal-yes, #modal-no').off('click').on('click', function () {
                        if (this.id === 'modal-no') {
                            localStorage.removeItem('curiculum.list_po');
                            localStorage.removeItem('curiculum.list_plo');
                        }
                        $("#myModal").modal("hide");

                        let oldPOList = getListPOFromLocalStorage();
                        let poFileContent = readXlsxFile(file, {sheet: 'PO'});
                        let ploFileContent = readXlsxFile(file, {sheet: 'PLO'});
                        poFileContent.then(function (data) {
                            if (data.length > 0) {
                                handleAddFilePO(data);
                            }
                            errorShow.css('display', 'none');
                        }).then(function () {
                            ploFileContent.then(function (data) {
                                if (data.length > 0) {
                                    handleAddFilePLO(data, oldPOList);
                                }
                                errorShow.css('display', 'none');
                            }).catch(function (error) {
                                localStorage.setItem("curiculum.list_po", JSON.stringify(oldPOList));
                                renderListPO(oldPOList, addPOForm);
                                errorShow.css('display', 'block');
                                errorShow.text("Your upload file doesn't have PLO sheet, please try again!");
                            });
                        }).catch(function (error) {
                            errorShow.css('display', 'block');
                            errorShow.text("Your upload file doesn't have PO sheet, please try again!");
                        });
                    });
                });

                $('#file_sub_upload').click(function () {
                    $(this).val('');
                }).change(function () {
                    $("#myModal").modal("show");
                    $('#modal-yes, #modal-no').off('click').on('click', function () {
                        if (this.id === 'modal-no') {
                            localStorage.removeItem('curiculum.list_sub');
                        }
                        $("#myModal").modal("hide");
                        const inputFile = document.getElementById("file_sub_upload").files[0];
                        const formData = new FormData();
                        let errorShow = $('#upload-error');
                        
                        formData.append("file", inputFile);
                        fetch("${pageContext.request.servletContext.contextPath}/dashboard/curriculums/get-excel-datas", {
                            method: "POST",
                            body: formData
                        })
                                .then((response) => response.json())
                                .then(function (data) {
                                    let listSubStored = getListSubFromLocalStorage();
                                    let listSubExcel = data.subList;

                                    $.each(listSubExcel, function (index, value) {
                                        if (value.active) {
                                            let isExist = listSubStored.find(sub => sub.id == value.id);
                                            if (!isExist) {
                                                listSubStored.push({
                                                    id: value.id
                                                });
                                            }
                                        }
                                    });
                                    console.log(listSubStored);
                                    localStorage.setItem("curiculum.list_sub", JSON.stringify(listSubStored));
                                    renderListSub(listSubStored);
                                    errorShow.css('display', 'none');
                                })
                                .catch(function (error) {
                                    console.log(error);
                                    errorShow.css('display', 'block');
                                    errorShow.text("Your upload file is invalid, please try again!");
                                });
                    });
                });

                $("#poTbl").on("click", "[name='editBtn']", function () {
                    oldName = $(this).closest("tr").find("td").eq(0).text();
                    oldDescription = $(this).closest("tr").find("td").eq(1).text();
                    let row = $(this).closest('tr');
                    let form = $('<tr>');
                    let tdList = row.find('td');
                    let input;

                    tdList.each(function (index, element) {
                        if (index != tdList.length - 1) {
                            if (index == 0) {
                                input = $('<td><input class="form-control" type="text" /></td>')
                                input.find('input').attr('value', oldName);
                            } else {
                                input = $('<td><textarea class="form-control"></textarea></td>');
                                input.find('textarea').text(oldDescription);
                            }

                            form.append(input);
                        } else {
                            input = $('<td><button name="saveBtn" type="button" style="margin-left: 96%; border: none; background: none"><i class="fa-solid fa-check"></i></button>\n\
                                                        <button name="cancelBtn" type="button" style="margin-left: 96%; border: none; background: none; display: block;"><i class="fa-solid fa-x"></i></button>\n\
                                                        <button type="button" id="btn-delete-plo" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-trash"></i></button></td>');
                            form.append(input);
                        }
                    });
                    form.append('</tr>');
                    row.replaceWith(form);
                });

                $("#ploTbl").on("click", "[name='editBtn']", function () {
                    oldName = $(this).closest("tr").find("td").eq(0).text();
                    oldDescription = $(this).closest("tr").find("td").eq(1).text();

                    let row = $(this).closest('tr');
                    let form = $('<tr>');
                    let tdList = row.find('td');
                    let input;

                    tdList.each(function (index, element) {
                        if (index != tdList.length - 1) {
                            if (index == 0) {
                                input = $('<td><input class="form-control" type="text" /></td>');
                                input.find('input').attr('value', oldName);
                            } else if (index == 1) {
                                input = $('<td><textarea class="form-control"></textarea></td>');
                                input.find('textarea').text(oldDescription);
                            } else {
                                input = $('<td><select style="color: #495057;" name="mapToPO" id="" class="form-select"></select></td>');
                                let poList = getListPOFromLocalStorage();
                                poList.forEach(function (item) {
                                    input.find('select').append($('<option>', {value: item.name, text: item.name}));
                                })
                            }

                            form.append(input);
                        } else {
                            let input = $('<td><button name="saveBtn" type="button" style="margin-left: 96%; border: none; background: none"><i class="fa-solid fa-check"></i></button>\n\
                                                        <button name="cancelBtn" type="button" style="margin-left: 96%; border: none; background: none; display: block;"><i class="fa-solid fa-x"></i></button>\n\
                                                        <button type="button" id="btn-delete-plo" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-trash"></i></button></td>');
                            form.append(input);
                        }
                    });
                    form.append('</tr>');
                    row.replaceWith(form);
                });

                $("table").on("click", "[name='saveBtn']", function () {
                    let newName = $(this).closest("tr").find("td").find('input').val().toUpperCase();
                    let newDescription = $(this).closest("tr").find("td").find('textarea').val();
                    let newMapToPO;
                    let tblIDCheck = $(this).closest('table').attr('id');

                    if (newName.includes('PO')) {
                        handleEditPO(oldName, newName, newDescription);
                    } else if (newName.includes('PLO')) {
                        newMapToPO = $(this).closest("tr").find("td").find('select option:selected').text();
                        handleEditPLO(oldName, newName, newDescription, newMapToPO);
                    } else {
                        if (tblIDCheck.includes('plo')) {
                            let errorShow = $('#plo-error');
                            if (newName == '') {
                                errorShow.css('display', 'block');
                                errorShow.text("PLO name cannot be left blank, please try again!");
                            } else {
                                errorShow.css('display', 'block');
                                errorShow.text("PLO name must follow format PLOxx, please try again!");
                            }
                        } else {
                            let errorShow = $('#po-error');
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
                );
                $("table").on("click", "[name='cancelBtn']", function () {
                    let str = $(this).closest('tr').find('td').find('input').val();
                    let errorPOShow = $('#po-error');
                    let errorPLOShow = $('#plo-error');
                    let listPO = getListPOFromLocalStorage();
                    let listPLO = getListPLOFromLocalStorage();

                    if (str.includes('PO')) {
                        errorPOShow.css('display', 'none');
                        renderListPO(listPO);
                        updatePLOMapPOOptions(listPO);
                    } else if (str.includes('PLO')) {
                        errorPLOShow.css('display', 'none');
                        renderListPLO(listPLO);
                    } else {
                        errorPOShow.css('display', 'none');
                        errorPLOShow.css('display', 'none');
                        renderListPO(listPO);
                        renderListPLO(listPLO);
                    }

                });
                $('table').on("click", "#btn-delete-po", function () {
                    const addPOForm = $('#add-po-form');
                    const name = $(this).closest("tr").find("td").eq(0).text();
                    const indexDeleteRow = $(this).closest("tr").data('index');
                    console.log(indexDeleteRow);
                    let mappedCheck = 0;
                    let listPLO = getListPLOFromLocalStorage();
                    listPLO.forEach(function (item) {
                        let errorShow = $('#po-error');

                        if (name == item.mapToPO)
                            mappedCheck = 1;
                        errorShow.css('display', 'block');
                        errorShow.text("This PO is mapped to PLOs, please delete these PLO before!");
                    });
                    if (mappedCheck == 0) {
                        let errorShow = $('#po-error');
                        errorShow.css('display', 'none');
                        let listPO = getListPOFromLocalStorage();

                        listPO = listPO.filter((po, index) => index != indexDeleteRow);
                        renderListPO(listPO, addPOForm);
                        localStorage.setItem("curiculum.list_po", JSON.stringify(listPO));
                        updatePLOMapPOOptions(listPO);
                    }
                });
                $('table').on("click", "#btn-delete-plo", function () {
                    const addPLOForm = $('#add-po-form');
                    let listPLO = getListPLOFromLocalStorage();
                    let indexDeleteRow = $(this).closest("tr").data("index");

                    listPLO = listPLO.filter((plo, index) => index != indexDeleteRow);
                    renderListPLO(listPLO, addPLOForm);
                    localStorage.setItem("curiculum.list_plo", JSON.stringify(listPLO));
                });
            });

            window.addEventListener("load", () => {
                localStorage.clear();
                let listPO = getListPOFromLocalStorage();
                let listPLO = getListPLOFromLocalStorage();
                let listSub = getListSubFromLocalStorage();
                renderBasicInf();
                renderListPO(listPO);
                renderListPLO(listPLO);
                updatePLOMapPOOptions(listPO);
                renderListSub(listSub);
            });

            document.getElementById("btn-add-po").addEventListener("click", handleAddPO);
            document.getElementById("btn-add-plo").addEventListener("click", handleAddPLO);
            document.getElementById("code").addEventListener("change", handleCodeChange);

            const descriptionEditor = new Quill('#descriptionEditor', {
                theme: 'snow'
            });

            function handleCodeChange(e) {
                const code = e.target.value;
                const slugInput = document.getElementById("slug").value = slugify(code.toLowerCase().replaceAll('_', '- '));
            }

            function getListPOFromLocalStorage() {
                let listPO = JSON.parse(localStorage.getItem("curiculum.list_po"));
                if (listPO === null) {
                    listPO = [];
                }

                return listPO;
            }

            function getListPLOFromLocalStorage() {
                let listPLO = JSON.parse(localStorage.getItem("curiculum.list_plo"));
                if (listPLO === null) {
                    listPLO = [];
                }

                return listPLO;
            }

            function getListSubFromLocalStorage() {
                let listSub = JSON.parse(localStorage.getItem("curiculum.list_sub"));
                if (listSub === null) {
                    listSub = [];
                }

                return listSub;
            }

            function handleAddPO() {
                const addPOForm = document.getElementById('add-po-form');
                const namePONode = addPOForm.querySelector("#poName");
                const descriptionPONode = addPOForm.querySelector("#poDescription");
                const name = namePONode.value.toUpperCase();
                let listPO = getListPOFromLocalStorage();
                let errorShow = $('#po-error');
                if (!namePONode) {
                    throw new Error("Missing value");
                }

                if (name == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("PO name cannot be left blank, please try again!");
                } else if (!name.includes('PO')) {
                    errorShow.css('display', 'block');
                    errorShow.text("PO name must follow format POxx, please try again!");
                } else {
                    let isExist = listPO.find(po => po.name === name);
                    if (isExist) {
                        errorShow.css('display', 'block');
                        errorShow.text("This PO name was created, please try another!");
                    } else {
                        errorShow.css('display', 'none');
                        const description = descriptionPONode.value;
                        listPO.push({
                            name: name,
                            description: description
                        });
                        renderListPO(listPO, addPOForm);
                        localStorage.setItem("curiculum.list_po", JSON.stringify(listPO));
                        updatePLOMapPOOptions(listPO);
                        resetAddPOForm(addPOForm);
                    }
                }
            }

            function handleAddFilePO(poListAdd) {
                const addPOForm = document.getElementById('add-po-form');
                let listPO = getListPOFromLocalStorage();
                let errorShow = $('#upload-error-po');
                let formatErrorIndexStr = '';
                let repeatErrorIndexStr = '';
                poListAdd.forEach(function (element, index) {
                    if (index > 0) {
                        let nameE = element[0];
                        let descriptionE = element[1].toString();

                        if (nameE != null && descriptionE != null) {
                            nameE = nameE.toUpperCase();

                            if (nameE.includes('PO')) {
                                let isExistedName = listPO.find(po => po.name === nameE);

                                if (isExistedName) {
                                    repeatErrorIndexStr += (index + 1) + ', ';
                                } else {
                                    listPO.push({
                                        name: nameE,
                                        description: descriptionE
                                    });
                                }

                            } else {
                                formatErrorIndexStr += (index + 1) + ', ';
                            }
                        } else if (descriptionE != null) {
                            formatErrorIndexStr += (index + 1) + ', ';
                        }
                    }
                });
                if (formatErrorIndexStr.length != '' && repeatErrorIndexStr != '') {
                    formatErrorIndexStr = formatErrorIndexStr.substring(0, formatErrorIndexStr.length - 2);
                    repeatErrorIndexStr = repeatErrorIndexStr.substring(0, repeatErrorIndexStr.length - 2);
                    errorShow.css('display', 'block');
                    errorShow.text(" There are some invalid datas on rows " + formatErrorIndexStr + " at sheet 1. Make sure the PO name is not blank and in the format POxxx, please check again!\n\
                            - The PO names are existed on rows " + formatErrorIndexStr + ". Please check again!");
                } else if (formatErrorIndexStr.length != '') {
                    formatErrorIndexStr = formatErrorIndexStr.substring(0, formatErrorIndexStr.length - 2);
                    errorShow.css('display', 'block');
                    errorShow.text("- There are some invalid datas on rows " + formatErrorIndexStr + " at sheet 1. Make sure the PO name is not blank and in the format POxxx, please check again!");
                } else if (repeatErrorIndexStr != '') {
                    repeatErrorIndexStr = repeatErrorIndexStr.substring(0, repeatErrorIndexStr.length - 2);
                    errorShow.css('display', 'block');
                    errorShow.text("- The PO names are existed on rows " + formatErrorIndexStr + ". Please check again!");
                } else {
                    errorShow.css('display', 'none');
                    renderListPO(listPO, addPOForm);
                    localStorage.setItem("curiculum.list_po", JSON.stringify(listPO));
                    updatePLOMapPOOptions(listPO);
                }

            }

            function handleAddFilePLO(ploListAdd, oldPOList) {
                const addPLOForm = document.getElementById('add-plo-form');
                const addPOForm = document.getElementById('add-po-form');
                let listPLO = getListPLOFromLocalStorage();
                let listPO = getListPOFromLocalStorage();
                let errorShow = $('#upload-error-plo');
                let formatErrorIndexStr = '';
                let repeatErrorIndexStr = '';
                ploListAdd.forEach(function (element, index) {
                    if (index > 0) {
                        let nameE = element[0];
                        let descriptionE = element[1].toString();
                        let mapToPO = element[2];

                        if (nameE != null && descriptionE != null && mapToPO != null) {
                            nameE = nameE.toUpperCase();
                            mapToPO = mapToPO.toUpperCase();

                            if (nameE.includes('PLO')) {
                                let isExistedName = listPLO.find(plo => plo.name === nameE);

                                if (isExistedName) {
                                    repeatErrorIndexStr += (index + 1) + ', ';
                                } else {
                                    let isExisted = listPO.find(po => po.name === mapToPO);

                                    if (isExisted) {
                                        listPLO.push({
                                            name: nameE,
                                            description: descriptionE,
                                            mapToPO: mapToPO
                                        });
                                    } else {
                                        formatErrorIndexStr += (index + 1) + ', ';
                                    }
                                }

                            } else {
                                formatErrorIndexStr += (index + 1) + ', ';
                            }
                        } else if (descriptionE != null || mapToPO != null) {
                            formatErrorIndexStr += (index + 1) + ', ';
                        }

                    }
                });

                if (formatErrorIndexStr.length != '' && repeatErrorIndexStr != '') {
                    renderListPO(oldPOList, addPOForm);
                    localStorage.setItem("curiculum.list_po", JSON.stringify(oldPOList));
                    updatePLOMapPOOptions(oldPOList);
                    formatErrorIndexStr = formatErrorIndexStr.substring(0, formatErrorIndexStr.length - 2);
                    repeatErrorIndexStr = repeatErrorIndexStr.substring(0, repeatErrorIndexStr.length - 2);
                    errorShow.css('display', 'block');
                    errorShow.text("- There are some invalid datas on rows " + formatErrorIndexStr + " at sheet 2. Make sure that datas of MapToPO colunms was created, the PLO name is not blank and in the format PLOxxx, please check again!\n\
                            - The PLO names are existed on rows " + formatErrorIndexStr + ". Please check again!");
                } else if (formatErrorIndexStr.length != '') {
                    renderListPO(oldPOList, addPOForm);
                    localStorage.setItem("curiculum.list_po", JSON.stringify(oldPOList));
                    updatePLOMapPOOptions(oldPOList);
                    formatErrorIndexStr = formatErrorIndexStr.substring(0, formatErrorIndexStr.length - 2);
                    errorShow.css('display', 'block');
                    errorShow.text("- There are some invalid datas on rows " + formatErrorIndexStr + " at sheet 2. Make sure that datas of MapToPO colunms was created, the PLO name is not blank and in the format PLOxxx, please check again!");
                } else if (repeatErrorIndexStr != '') {
                    renderListPO(oldPOList, addPOForm);
                    localStorage.setItem("curiculum.list_po", JSON.stringify(oldPOList));
                    updatePLOMapPOOptions(oldPOList);
                    repeatErrorIndexStr = repeatErrorIndexStr.substring(0, repeatErrorIndexStr.length - 2);
                    errorShow.css('display', 'block');
                    errorShow.text("- The PLO names are existed on rows " + formatErrorIndexStr + ". Please check again!");
                } else {
                    errorShow.css('display', 'none');
                    renderListPLO(listPLO, addPLOForm);
                    localStorage.setItem("curiculum.list_plo", JSON.stringify(listPLO));
                }

            }

            function handleAddPLO() {
                const addPLOForm = document.getElementById('add-plo-form');
                const namePLONode = addPLOForm.querySelector("#ploName");
                const descriptionPLONode = addPLOForm.querySelector("#ploDescription");
                const mapToPONode = $("#mapToPO option:selected");
                const name = namePLONode.value.toUpperCase();
                const description = descriptionPLONode.value;
                const mapToPO = mapToPONode.text();
                let listPLO = getListPLOFromLocalStorage();
                let errorShow = $('#plo-error');
                if (!namePLONode || !descriptionPLONode || !mapToPONode) {
                    throw new Error("Missing value");
                }

                if (name == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("PLO name cannot be left blank, please try again!");
                } else if (!name.includes('PLO')) {
                    errorShow.css('display', 'block');
                    errorShow.text("PLO name must follow format PLOxx, please try again!");
                } else if (mapToPO == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("Please create a new PO before!");
                } else {
                    let isExist = listPLO.find(plo => plo.name === name);
                    if (isExist) {
                        errorShow.css('display', 'block');
                        errorShow.text("This PLO name was created, please try another!");
                    } else {
                        errorShow.css('display', 'none');
                        let listPLO = getListPLOFromLocalStorage();
                        listPLO.push({
                            name: name,
                            description: description,
                            mapToPO: mapToPO
                        })
                        renderListPLO(listPLO, addPLOForm);
                        localStorage.setItem("curiculum.list_plo", JSON.stringify(listPLO));
                        resetAddPLOForm(addPLOForm);
                    }
                }
            }

            function handleEditPO(oldName, newName, newDescription) {
                const addPOForm = document.getElementById('add-po-form');
                let listPO = getListPOFromLocalStorage();
                let errorShow = $('#po-error');
                let isExist = listPO.find(po => po.name == newName && po.name != oldName);

                if (isExist) {
                    errorShow.css('display', 'block');
                    errorShow.text("This PO name was created, please try another!");
                    return;
                } else {
                    let mappedCheck = 0;
                    let listPLO = getListPLOFromLocalStorage();
                    listPLO.forEach(function (item) {
                        if (oldName == item.mapToPO)
                            mappedCheck = 1;
                        let errorShow = $('#po-error');
                        errorShow.css('display', 'block');
                        errorShow.text("This PO is mapped to PLOs, please delete these PLO before!");
                    });
                    if (mappedCheck == 0) {
                        errorShow.css('display', 'none');
                        let poElement = listPO.find(po => po.name === oldName);
                        poElement.name = newName;
                        poElement.description = newDescription;
                        renderListPO(listPO, addPOForm);
                        localStorage.setItem("curiculum.list_po", JSON.stringify(listPO));
                        updatePLOMapPOOptions(listPO)
                    }
                }
            }

            function handleEditPLO(oldName, newName, newDescription, newMapToPO) {
                const addPLOForm = document.getElementById('add-plo-form');
                let errorShow = $('#plo-error');
                let listPLO = getListPLOFromLocalStorage();
                let isExist = listPLO.find(plo => plo.name == newName && plo.name != oldName);

                if (isExist) {
                    errorShow.css('display', 'block');
                    errorShow.text("This PLO name was created, please try another!");
                    return;
                } else {
                    errorShow.css('display', 'none');
                    let ploElement = listPLO.find(plo => plo.name === oldName);
                    ploElement.name = newName;
                    ploElement.description = newDescription;
                    ploElement.mapToPO = newMapToPO;
                    renderListPLO(listPLO, addPLOForm);
                    localStorage.setItem("curiculum.list_plo", JSON.stringify(listPLO));
                }
            }

            function updatePLOMapPOOptions(listPO) {
                const selectNode = document.getElementById("mapToPO");
                if (!selectNode || !listPO)
                    return console.error("Cannot update list PO options");
                const htmls = listPO.map((po, index) => `
                             <option value="\${po.name}">\${po.name}</option>
                        `).join("");
                selectNode.innerHTML = htmls;
            }

            function renderListPO(listPO, POFormNode) {
                if (!listPO)
                    throw new Error("Cannot render list PO");
                const POTableBody = document.querySelector("#poTbl tbody");
                const htmls = listPO.map((po, index) => `
                             <tr data-index="\${index}">
                                <td style="color: #495057;">\${po?.name}</td>
                                <td>\${po?.description}</td>
                                <td>
                                    <button name="editBtn" type="button" style="margin-left: 96%; border: none; background: none"><i class="fa-solid fa-pencil"></i></button>
                                    <button name="cancelBtn" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-x"></i></button>
                                    <button type="button" id="btn-delete-po" type="button" style="margin-left: 96%; border: none; background: none; display: block;"><i class="fa-solid fa-trash"></i></button>
                                </td>
                            </tr>
                        `).join("");
                POTableBody.parentNode.style.display = 'block';
                POTableBody.innerHTML = htmls;
            }

            function renderListPLO(listPLO, PLOFormNode) {
                if (!listPLO)
                    throw new Error("Cannot render list PLO");
                const PLOTableBody = document.querySelector("#ploTbl tbody");
                const htmls = listPLO.map((plo, index) => `
                             <tr data-index="\${index}">
                                <td style="color: #495057;">\${plo?.name}</td>
                                <td>\${plo?.description}</td>
                                <td style="text-align: right;">\${plo?.mapToPO}</td>
                                <td>
                                    <button name="editBtn" type="button" style="margin-left: 96%; border: none; background: none"><i class="fa-solid fa-pencil"></i></button>
                                    <button name="cancelBtn" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-x"></i></button>
                                    <button type="button" id="btn-delete-plo" type="button" style="margin-left: 96%; border: none; background: none; display: block;"><i class="fa-solid fa-trash"></i></button>
                                </td>
                            </tr>
                        `).join("");
                PLOTableBody.parentNode.style.display = 'block';
                PLOTableBody.innerHTML = htmls;
            }

            function renderListSub(listSub) {
                $('[name="subCheck"]').each(function () {
                    let thisVal = $(this).val();
                    let isChecked = listSub.find(sub => sub.id.trim() === thisVal.trim());
                    if (isChecked) {
                        $(this).prop("checked", true);
                    } else {
                        $(this).prop("checked", false);
                    }
                });
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
                    descriptionEditor.root.querySelector('p').innerHTML = '';
                    $('#decision').val('');
                } else {
                    descriptionEditor.root.querySelector('p').innerHTML = JSON.parse(basicDescription);
                    $('#description').val(JSON.parse(basicDescription));
                }
                if (basicDecisionNo == null) {
                    $('#decisionNo').val('');
                } else {
                    $('#decisionNo').val(JSON.parse(basicDecisionNo));
                }
            }

            function resetAddPOForm(POFormNode) {
                const nameNode = POFormNode.querySelector("#poName");
                const descriptionNode = POFormNode.querySelector("#poDescription");
                nameNode.value = "";
                descriptionNode.value = "";
            }

            function resetAddPLOForm(PLOFormNode) {
                const nameNode = PLOFormNode.querySelector("#ploName");
                const descriptionNode = PLOFormNode.querySelector("#ploDescription");
                nameNode.value = "";
                descriptionNode.value = "";
            }

            function resetBasicInfo(basicCode, basicSlug, basicEnglishName, basicVietnameseName, basicDescription, basicDecisionNo) {
                localStorage.setItem("curiculum.basicCode", JSON.stringify(basicCode));
                localStorage.setItem("curiculum.basicEnglishName", JSON.stringify(basicEnglishName));
                localStorage.setItem("curiculum.basicVietnameseName", JSON.stringify(basicVietnameseName));
                localStorage.setItem("curiculum.basicDescription", JSON.stringify(basicDescription));
                localStorage.setItem("curiculum.basicDecisionNo", JSON.stringify(basicDecisionNo));
                localStorage.setItem("curiculum.basicSlug", JSON.stringify(basicSlug));
            }

            function handleCheck(indexCheckRow, isChecked) {
                let listSub = getListSubFromLocalStorage();
                let id = indexCheckRow.find("td").eq(0).text().trim();

                if (isChecked) {
                    listSub.push({
                        id: id
                    });
                } else {
                    listSub = listSub.filter((sub, index) => sub.id != id);
                }

                localStorage.setItem("curiculum.list_sub", JSON.stringify(listSub));

            }

            async function handleSubmit() {
                let basicCode = $('#code').val();
                let basicSlug = $('#slug').val();
                let basicEnglishName = $('#englishName').val();
                let basicVietnameseName = $('#vietnameseName').val();
                let basicDescription;
                let basicDecisionNo = $('#decisionNo').val();
                let listPO = getListPOFromLocalStorage();
                let listPLO = getListPLOFromLocalStorage();
                let listSub = getListSubFromLocalStorage();
                let errorShow = $('#basic-error');
                let errorShowSubmit = $('#submit-error');
                let invalid = 0;
                let pTags = descriptionEditor.root.querySelectorAll('p');
                let descriptionEditorContent = '';
                for (let i = 0; i < pTags.length; i++) {
                    descriptionEditorContent += pTags[i].innerHTML;
                }
                if (descriptionEditorContent == '<br>') {
                    basicDescription = '';
                } else {
                    basicDescription = descriptionEditorContent;
                }
                const pattern = /^([[A-Z0-9]{3}-[[A-Z0-9]{2}-[A-Z0-9-]{4,5})$/;

                resetBasicInfo(basicCode, basicSlug, basicEnglishName, basicVietnameseName, basicDescription, basicDecisionNo);

                if (basicCode == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("Code cannot be left blank, please try again!");
                    invalid++;
                } else if (!pattern.test(basicCode)) {
                    errorShow.css('display', 'block');
                    errorShow.text("The Curriculum code must be followed format XXX-XX-XXXX, please try again!");
                    invalid++;
                } else {
                    basicCode = basicCode.toUpperCase();
                    errorShow.css('display', 'none');
                }

                if (listPO.length == 0 || listPLO.length == 0) {
                    errorShowSubmit.css('display', 'block');
                    errorShowSubmit.text("Please create a new PO and PLO before!");
                    invalid++;
                } else {
                    errorShowSubmit.css('display', 'none');
                }

                if (invalid == 0) {
                    const jsonSubmit = JSON.stringify({
                        code: basicCode,
                        name: basicEnglishName,
                        description: basicDescription,
                        decisionNo: basicDecisionNo,
                        viName: basicVietnameseName,
                        poList: listPO,
                        ploList: listPLO,
                        subList: listSub
                    });

                    let currAPI = '${pageContext.request.servletContext.contextPath}/dashboard/curriculums/add';

                    let options = {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json;charset=UTF-8"
                        },
                        body: jsonSubmit
                    }
                    ;

                    try {
                        const res = await fetch(currAPI, options);
                        if (res.ok) {
                            errorShowSubmit.css('display', 'none');
                            localStorage.clear();
                            window.location.href = '${pageContext.request.servletContext.contextPath}/dashboard/curriculums';
                        } else {
                            const json = await res.json();
                            errorShowSubmit.css('display', 'block');
                            errorShowSubmit.text(json?.message);
                        }
                    } catch (error) {
                        console.log('error when add new cur', error);
                    }
                }
            }

        </script>
    </body>

</html>