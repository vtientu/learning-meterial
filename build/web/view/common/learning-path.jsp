<%-- 
    Document   : leaning-path
    Created on : Feb 6, 2023, 2:55:25 AM
    Author     : tient
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="gui/header.jsp" %>
    </head>
    <body>
        <div class="bg my-5 py-5">
            <div class="page-wraper">
                <div id="loading-icon-bx"></div>
                <div class="account-form">
                    <div class="account-form-inner">
                        <div class="account-container">
                            <div class="error-page">
                                <h3>Ooopps :(</h3>
                                <h2 class="error-title">404</h2>
                                <h5>The Page you were looking for, couldn't be found.</h5>
                                <p>The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
                                <a href="home" class="btn outline black">Back To Home</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="gui/footer.jsp" %>
    </body>
</html>
