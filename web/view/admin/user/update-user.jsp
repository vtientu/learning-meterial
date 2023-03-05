<%-- 
    Document   : create-user
    Created on : Mar 4, 2023, 1:24:32 PM
    Author     : tient
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/add-listing.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
    <head>

        <%@include file="../gui/header.jsp" %>

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Left sidebar menu start -->
        <%@include file="../gui/sidebar.jsp" %>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Update User</h4>
                </div>	
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="widget-inner">
                                <form class="edit-profile m-b30" action="update-details" method="post">
                                    <input type="text" name="action" value="user" hidden="">
                                    <input type="text" name="aid" value="${user.accountID}" hidden="">
                                    <div class="row">
                                        <div class="col-12 mb-3">
                                            <div class="ml-auto">
                                                <h3>Profile User</h3>
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">First Name <i class="text-red">*</i></label>
                                            <div>
                                                <input class="form-control" type="text" value="${user.firstName}" required="" name="firstName">
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Last Name <i class="text-red">*</i></label>
                                            <div>
                                                <input class="form-control" type="text" value="${user.lastName}" required="" name="lastName">
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Email <i class="text-red">*</i></label>
                                            <div>
                                                <input class="form-control" type="email" value="${user.email}" disabled="" name="email">
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">User Name <i class="text-red">*</i></label>
                                            <div>
                                                <input class="form-control" type="text" value="${user.userName}" disabled="" name="userName">
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Role <i class="text-red">*</i></label>
                                            <div>
                                                <select class="form-control" name="role">
                                                    <c:forEach items="${listRole}" var="listr">
                                                        <option ${user.roleID == listr.roleID?'selected':''} value="${listr.roleID}">${listr.roleName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <label class="text-red font-weight-bold ml-3">${message}</label>
                                        <div class="col-12 mt-3">
                                            <button type="submit" class="btn float-right">Update Account</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <%@include file="../gui/footer.jsp" %>
    </body>

</html>
