<%-- 
    Document   : login_step_1
    Created on : Apr 3, 2023, 11:12:22 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%@include file="/components/common/head.jspf" %>
    <title>Login</title>
</head>
<body>
<div class="container h-100 d-flex justify-content-center align-items-center w-100">
    <div class="d-flex w-100 justify-content-center align-items-center">
        <form action="./login" method="POST" id="login-form">
            <div class="head-section col-md-12 col-12 text-center">
                <h2 class="title">Sign in</h2>
                <p class="description">Continue with your student ID or employee ID</p>
            </div>
            <div class="col-md-12" id="username-input">
                <div class="form-group">
                    <input type="text" name="studentID" id="studentID" class="form-control" placeholder="Student ID">
                </div>
            </div>
            <div class="col-md-12" id="password-input"></div>
            <div class="row options-section">
                <div class="col-md-6 text-center">
                    <input class="form-check-input" type="checkbox" name="" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember me</label>
                </div>
                <div class="col-md-6 text-center" style="white-space: nowrap">
                    <a href="#">Forgot password?</a>
                </div>
            </div>
            <button class="btn-primary btn btn-block col-md-12 col-12 d-flex align-items-center gap-2 justify-content-center"
                    id="btn-continue" type="button" onclick="handleSubmit()">Continue
            </button>
            <div class="alert alert-danger mt-3" id="login-fail-mess" role="alert"
                 style="padding: 6px 12px; display: none;">
                LOGIN_FAIL_MESSAGE
            </div>
        </form>

    </div>
</div>
</body>
<script>
    window.addEventListener("keydown", function (e) {
        if (e.code === "Enter") {  //checks whether the pressed key is "Enter"
            if (e.target.form == document.getElementById("login-form")) {
                event.preventDefault();
                handleSubmit();
            }
        }
    });

    function showLoadingOnButton() {
        const buttonNode = document.getElementById("btn-continue");
        buttonNode.disabled = true;
        buttonNode.innerHTML = `
                <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                Loading...`
    }

    function resetSubmitButton() {
        const buttonNode = document.getElementById("btn-continue");
        buttonNode.disabled = false;
        buttonNode.innerHTML = `
                Continue<i class="fa-solid fa-arrow-right-long"></i>`
    }

    function changeSubmitButtonState(state) {
        switch (state) {
            case "loading": {
                showLoadingOnButton()
                break;
            }
            default: {
                resetSubmitButton();
            }
        }
    }

    async function handleSubmit() {
        const usernameNode = document.getElementById("studentID");
        const passwordNode = document.getElementById("password");
        const hasPasswordInput = passwordNode !== null;
        let apiUrl = "${pageContext.request.servletContext.contextPath}/login";
        let params = {
            studentID: usernameNode?.value?.trim(),
            step: 1
        }

        if (hasPasswordInput) {
            params.password = passwordNode?.value
            params.step = 2;
        }
        changeSubmitButtonState("loading");
        const res = await fetch(apiUrl, {
            method: "POST",
            body: JSON.stringify(params)
        })

        const json = await res.json()

        if (json.step == 2) {
            changeSubmitButtonState("reset")
            renderPasswordInput();
            usernameNode.disabled = true;
        }

        if (json?.redirectUrl) {
            document.location.pathname = json?.redirectUrl
        } else if (json?.message) {
            showError(json?.message);
            changeSubmitButtonState("reset");
        }
    }

    function renderPasswordInput() {
        const node = document.getElementById("password-input");
        node.innerHTML = `<div class="form-group">
                    <label class="mb-2" for="paSsword">Pasword</label>
                    <input type="password" name="paSsword" id="password" class="form-control">
                        </div>`;

        node.querySelector("input[type='password']").focus();
    }

    function showError(message) {
        $('#login-fail-mess').css('display', 'block');
        $('#login-fail-mess').text(message);
    }
</script>
</body>
</html>
