<%-- 
    Document   : login_step_2
    Created on : Apr 3, 2023, 11:12:31 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <%@include file="/components/common/head.jspf" %>
        <title>Login</title>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-around mt-5">
                <div class="col-md-3 col-10 my-5 un_1">
                    <div class="header col-md-12 col-12 text-center">
                        Sign in with Student ID
                    </div>
                    <form action="/login" class="col-md-12">
                        <div class="form-group mb-3">
                            <label class="mb-2" for="studentID">Student ID</label>
                            <input type="text" name="studentID" id="studentID" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="mb-2" for="paSsword">Pasword</label>
                            <input type="password" name="paSsword" id="password" class="form-control">
                            <i class="fa-regular fa-eye-slash show"></i>
                        </div>
                    </form>
                    <i style="color:red;">${errmessage}</i>
                    <div class="row mb-3">
                        <div class="col-md-6 col">
                            <input class="form-check-input" type="checkbox" name="" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <div class="col-md-6 text-center col">
                            <a href="#">Forgot password?</a>
                        </div>
                    </div>
                    <button class="btn-primary btn btn-block col-md-12 col-12" type="submit">Sign in</button>

                </div>
            </div>
        </div>

        <script>
        </script>
    </body>
</html>