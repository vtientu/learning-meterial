<%-- 
    Document   : create-user
    Created on : Mar 4, 2023, 1:24:32 PM
    Author     : tient
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include file="../gui/header.jsp" %>
        <script src="https://cdn.ckeditor.com/4.20.2/standard/ckeditor.js"></script>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <%@include file="../gui/sidebar.jsp" %>
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Update User</h4>
                </div>	
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="widget-inner">
                                <form class="edit-profile m-b30" action="update-details" method="post">
                                    <input type="text" name="action" value="syllabus" hidden="">
                                    <input type="text" name="syllabusID" value="${syllabus.syllabusID}">
                                    <div class="row">
                                        <div class="col-12 mb-3">
                                            <div class="ml-auto">
                                                <h3>Syllabus Details</h3>
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Subject Code<i class="text-red">*</i></label>
                                            <div>
                                                <select class="form-control" name="subjectCode">
                                                    <c:forEach items="${listSubject}" var="lists">
                                                        <option ${syllabus.subjectCode == lists.subjectCode?'selected':''} value="${lists.subjectCode}">${lists.subjectCode}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Decision<i class="text-red">*</i></label>
                                            <div>
                                                <select class="form-control" name="decision">
                                                    <c:forEach items="${listDecision}" var="listd">
                                                        <option ${syllabus.decisionNo == listd.decisionNo?'selected':''} value="${listd.decisionNo}">${listd.decisionNo}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Syllabus Name EN<i class="text-red">*</i></label>
                                            <div>
                                                <input class="form-control" type="text" value="${syllabus.syllabusNameEN}" required="" name="nameEN">
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Syllabus Name VN</label>
                                            <div>
                                                <input class="form-control" type="text" value="${syllabus.syllabusNameVN}" required="" name="nameVN">
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Degree Level</label>
                                            <div>
                                                <select name="degreeLevel" class="form-control">
                                                    <option ${syllabus.degreeLevel == null || syllabus.degreeLevel == ''?'selected':''} value="None">Select</option>
                                                    <option ${syllabus.degreeLevel == 'Bachelor'?'selected':''} value="Bachelor">Bachelor</option>
                                                    <option ${syllabus.degreeLevel == 'Bachelor'?'selected':''} value="Bachelor in Hotel Management">Bachelor in Hotel Management</option>
                                                    <option ${syllabus.degreeLevel == 'Bachelor'?'selected':''} value="Bachelor in English Language">Bachelor in English Language</option>
                                                    <option ${syllabus.degreeLevel == 'Bachelor'?'selected':''} value="Bachelor in Business Administration">Bachelor in Business Administration</option>
                                                    <option ${syllabus.degreeLevel == 'Bachelor'?'selected':''} value="Undergraduate">Undergraduate</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group col-6">
                                            <label class="col-form-label">Tool</label>
                                            <div>
                                                <input class="form-control" type="text" value="${syllabus.tools}" required="" name="tool">
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Scoring Scale</label>
                                            <div>
                                                <input class="form-control" type="number" value="${syllabus.scoringScale}" required="" name="scoringScale">
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Min Avg Mark To Pass</label>
                                            <div>
                                                <input class="form-control" type="number" value="${syllabus.minAvgMarkToPass}" required="" name="MinAvgMarkToPass">
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Time Allocation</label>
                                            <div>
                                                <textarea class="form-control" name="timeAllocation" rows="5" cols="10">${syllabus.timeAllocation}</textarea>
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Description</label>
                                            <div>
                                                <textarea class="form-control" name="description" rows="5" cols="10">${syllabus.description}</textarea>
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Student Task</label>
                                            <div>
                                                <textarea class="form-control" name="studentTask" rows="5" cols="10">${syllabus.studentTasks}</textarea>
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Note</label>
                                            <div>
                                                <textarea class="form-control" id="editorck" name="note" required="">${syllabus.note}</textarea><br/>
                                                <script>
                                                    CKEDITOR.replace('editorck');
                                                </script>
                                            </div>
                                        </div>
                                        <label class="text-red font-weight-bold ml-3">${message}</label>
                                        <div class="col-12 mt-3">
                                            <button type="submit" class="btn float-right">Update Syllabus</button>
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
