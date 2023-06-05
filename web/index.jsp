<%-- 
    Document   : index
    Created on : Apr 4, 2023, 4:54:25 PM
    Author     : quocb
--%>

<%@page import="entities.ExploreList" %>
<%@page import="java.util.List" %>
<%@page import="entities.Explore" %>
<%@page import="entities.User" %>
<%@page import="config.AppConfig" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@include file="/components/common/head.jspf" %>
    <title>Universe Learning Material</title>
</head>
<body>
<%@include file="/components/common/header.jspf" %>
<%
    List<Explore> expList = (List) request.getAttribute(AppConfig.EXPLORE_LIST);
    Boolean isForceUpdate = (Boolean) request.getSession().getAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD);
    User user = (User) request.getSession().getAttribute(AppConfig.AUTH_USER);

    if (isForceUpdate != null && isForceUpdate && user != null) {
%>
<div class="modal fade show in" id="staticBackdropLive" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLiveLabel" aria-modal="true" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLiveLabel">Change Your Password</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.servletContext.contextPath}/auth/update-password" method="POST"
                      id="update-password-form">
                    <input name="userId" value="<%= user.getId()%>" hidden/>
                    <label for="inputPassword5" class="form-label">Password</label>
                    <input type="password" name="password" required id="inputPassword5" class="form-control"
                           aria-labelledby="passwordHelpBlock">
                    <label for="inputPassword5" class="form-label">Confirm Password</label>
                    <input type="password" name="confirm-password" required id="inputPassword5" class="form-control"
                           aria-labelledby="passwordHelpBlock">
                </form>
                <div class="alert alert-warning mt-4" role="alert">
                    For your security, please update your password on your first login.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">I'll do later</button>
                <button type="submit" form="update-password-form" class="btn btn-primary">Update password</button>
            </div>
        </div>
    </div>
</div>
<script>
    window.addEventListener("load", (event) => {
        const myModal = new bootstrap.Modal('#staticBackdropLive', {
            keyboard: false
        })
        myModal.show();
    });


</script>
<%
    }
%>

<main class="container" style="margin-top: 32px;">
    <section class="posts-section">
        <p class="posts-section_heading">Last viewed</h3>
        <div class="posts-grid">
            <article class="post-card">
                <div class="post-card__header">
                    <a href="${pageContext.request.servletContext.contextPath}/syllabus/2" class="post-card__title">
                        SWE291
                    </a>
                    <span class="badge text-bg-primary">Syllabus</span>
                </div>
                <div class="post-card__body">
                    <p class="post-card__description">Text line</p>
                </div>
                <div class="post-card_footer">
                    <time class="post-card_time">Updated at March 27, 2023</time>
                </div>
            </article>
            <article class="post-card">
                <div class="post-card__header">
                    <a class="post-card__title">
                        SWE291
                    </a>
                    <span class="badge text-bg-primary">Syllabus</span>
                </div>
                <div class="post-card__body">
                    <p class="post-card__description">Text line</p>
                </div>
                <div class="post-card_footer">
                    <time class="post-card_time">Updated at March 27, 2023</time>
                </div>
            </article>
            <article class="post-card">
                <div class="post-card__header">
                    <a class="post-card__title">
                        SWE291
                    </a>
                    <span class="badge text-bg-primary">Syllabus</span>
                </div>
                <div class="post-card__body">
                    <p class="post-card__description">Text line</p>
                </div>
                <div class="post-card_footer">
                    <time class="post-card_time">Updated at March 27, 2023</time>
                </div>
            </article>
            <article class="post-card">
                <div class="post-card__header">
                    <a class="post-card__title">
                        SWE291
                    </a>
                    <span class="badge text-bg-primary">Syllabus</span>
                </div>
                <div class="post-card__body">
                    <p class="post-card__description">Text line</p>
                </div>
                <div class="post-card_footer">
                    <time class="post-card_time">Updated at March 27, 2023</time>
                </div>
            </article>
            <article class="post-card">
                <div class="post-card__header">
                    <a class="post-card__title">
                        SWE291
                    </a>
                    <span class="badge text-bg-primary">Syllabus</span>
                </div>
                <div class="post-card__body">
                    <p class="post-card__description">Text line</p>
                </div>
                <div class="post-card_footer">
                    <time class="post-card_time">Updated at March 27, 2023</time>
                </div>
            </article>
        </div>
    </section>
    <br/>
    <section class="posts-section">
        <p class="posts-section_heading">Explore</h3>
        <div class="posts-grid">
            <c:forEach var="ex" items="<%= expList%>">
                <article class="post-card">
                    <div class="post-card__header">
                        <a href="${pageContext.request.servletContext.contextPath}/${ex.controller}/${ex.id}"
                           class="post-card__title">
                                ${ex.code}
                        </a>
                        <span class="badge text-bg-primary">${ex.type}</span>
                    </div>
                    <div class="post-card__body">
                            <%--                        <p class="post-card__description">Text line</p>--%>
                    </div>
                    <div class="post-card_footer">
                        <time class="post-card_time">Updated at <fmt:formatDate pattern="MMMM dd, yyyy"
                                                                                value="${ex.updatedAt!=null?ex.updatedAt:ex.createdAt}"/></time>
                    </div>
                </article>
            </c:forEach>
        </div>
    </section>
</main>
</body>
</html>
