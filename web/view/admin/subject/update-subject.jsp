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

        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Update Subject</h4>
                </div>	
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="widget-inner">
                                <form class="edit-profile m-b30" action="update-details" method="post">
                                    <input type="text" name="sid" value="${subject.subjectID}" hidden="">
                                    <input type="text" name="action" value="subject" hidden="">
                                    <div class="row">
                                        <div class="col-12 mb-3">
                                            <div class="ml-auto">
                                                <h3 class="my-5">Information</h3>
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Subject Code <i class="text-red">*</i></label>
                                            <div>
                                                <input class="form-control" type="text" value="${subject.subjectCode}" required="" name="subjectCode">
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Subject Name <i class="text-red">*</i></label>
                                            <div>
                                                <input class="form-control" type="text" value="${subject.subjectName}" required="" name="subjectName">
                                            </div>
                                        </div>
                                        <div class="form-group col-6 my-3">
                                            <label class="col-form-label">Semester <i class="text-red">*</i></label>
                                            <div>
                                                <select name="semester" class="form-control">
                                                    <c:forEach begin="0" end="9" var="i">
                                                        <option ${subject.semester == i ? 'selected':''} value="${i}">${i}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group col-6 my-3">
                                            <label class="col-form-label">No Credit <i class="text-red">*</i></label>
                                            <div>
                                                <select name="noCredit" class="form-control">
                                                    <c:forEach begin="0" end="10" var="i">
                                                        <option ${subject.noCredit == i?'selected':''} value="${i}">${i}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group col-12 my-3">
                                            <label class="col-form-label">Approved</label>
                                            <div>
                                                <select name="isActive" class="form-control">
                                                    <option ${subject.isActive == true?'selected':''} value="true">Approved</option>
                                                    <option ${subject.isActive == false?'selected':''} value="false">Disable</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-12 mt-5">
                                            <button type="submit" class="btn float-right">Update Subject</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>
        

        <%@include file="../gui/footer.jsp" %>
    </body>


</html>
