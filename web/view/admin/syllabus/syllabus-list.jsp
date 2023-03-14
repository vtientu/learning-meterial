<%-- 
    Document   : user-list
    Created on : Feb 19, 2023, 5:14:27 PM
    Author     : tient
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">


    <head>

        <%@include file="../gui/header.jsp" %>

    </head>

    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->

        <!-- header end -->
        <!-- Left sidebar menu start -->
        <%@include file="../gui/sidebar.jsp" %>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title" style="border-right: none">Syllabus List</h4>
                </div>
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="row justify-content-between">
                                <div class="wc-title">
                                    <c:if test="${account.roleID >= 7}">
                                        <a class="btn" href="add-details?action=syllabus">Add Syllabus</a>
                                    </c:if>
                                </div>
                                <div class="col-sm-4 mt-3" style="float: right;">
                                    <div class="widget courses-search-bx placeani m-0">
                                        <div class="form-group m-0">
                                            <div class="input-group">
                                                <label><i class="fa fa-search"></i> Search</label>
                                                <input oninput="processSyllabusList(${page}, '${sort}', true)" name="keysearch" id="keyseach" type="text" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-inner">
                                <div  id="list-items">
                                    <table class="table">
                                        <thead class="thead-orange">
                                        <th width="5%" onclick="processSyllabusList(${page}, '${sort != null ? sort eq 'id_up' ? 'id_up' : 'id_down' : 'id_down'}', false)">ID<i style="font-weight: bold" class="ti ${sort == "" ? 'ti-arrow-up' :  sort eq 'id_up' ? 'ti-arrow-down' : 'ti-arrow-up' }"></i></th>
                                        <th width="15%" onclick="processSyllabusList(${page}, '${sort != null ? sort eq 'scode_up' ? 'scode_up' : 'scode_down' : 'scode_down'}', false)">Subject Code<i style="font-weight: bold" class="ti ${sort == "" ? 'ti-arrow-up' :  sort eq 'scode_up' ? 'ti-arrow-down' : 'ti-arrow-up'}"></i></th>
                                        <th onclick="processSyllabusList(${page}, '${sort != null ? sort eq 'name_up' ? 'name_up' : 'name_down' : 'name_down'}', false)">Subject Name<i style="font-weight: bold" class="ti ${sort == "" ? 'ti-arrow-up' :  sort eq 'name_up' ? 'ti-arrow-down' : 'ti-arrow-up'}"></i></th>
                                        <th onclick="processSyllabusList(${page}, '${sort != null ? sort eq 'syname_up' ? 'syname_up' : 'syname_down' : 'syname_down'}', false)">Syllabus Name<i style="font-weight: bold" class="ti ${sort == "" ? 'ti-arrow-up' :  sort eq 'syname_up' ? 'ti-arrow-down' : 'ti-arrow-up'}"></i></th>
                                        <th>IsActive</th>
                                        <th>IsApproved</th>
                                        <th width="10%" onclick="processSyllabusList(${page}, '${sort != null ? sort eq 'decision_up' ? 'decision_up' : 'decision_down' : 'decision_down'}', false)">DecisionNo<br/>MM/dd/yyyy<i style="font-weight: bold" class="ti ${sort == "" ? 'ti-arrow-up' :  sort eq 'decision_up' ? 'ti-arrow-down' : 'ti-arrow-up'}"></i></th>
                                        <th>Action</th>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listSyllabus}" var="list">
                                                <tr>
                                                    <td>${list.syllabusID}</td>
                                                    <td>${list.subject.subjectCode}</td>
                                                    <td>${list.subject.subjectName}</td>
                                                    <td>${list.syllabusNameEN}</td>
                                                    <td class="text-center"><i  style="color: ${list.isActive == true ? 'green':'red'}" class="fa ${list.isActive == true ? 'fa-check':'fa-close'}"/></td>
                                                    <td class="text-center"><i  style="color: ${list.isApproved == true ? 'green':'red'}" class="fa ${list.isApproved == true ? 'fa-check':'fa-close'}"/></td>
                                                    <td>${list.decisionNo == null?'':list.decisionNo}</td>
                                                    <c:if test="${account.roleID >= 7}">
                                                        <td>
                                                            <button class="btn bg-white">
                                                                <a href="update-details?action=syllabus&sid=${list.syllabusID}"><i class="ti ti-pencil-alt" style="color: black"></i></a>
                                                            </button>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${account.roleID < 7}">
                                                        <td></td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <label style="color: red">${message}</label>
                                    <div style="float: right">
                                        <ul class="pagination">
                                            <c:if test="${page == 1}">
                                                <li class="page-item"><a style="pointer-events: none" class="page-link">Previous</a></li>
                                                </c:if>
                                                <c:if test="${page > 1}">
                                                <li class="page-item"><a onclick="processSyllabusList(${page - 1}, '${requestScope.sort}', true) style ="pointer-events: none" class="page-link">Previous</a></li>
                                                </c:if>
                                            <li class="page-item"><a id="page" class="page-link">${page}</a></li>
                                                <c:if test="${page == totalPage}">
                                                <li class="page-item"><a style="pointer-events: none" class="page-link">Next</a></li>
                                                </c:if>
                                                <c:if test="${page < totalPage}">
                                                <li class="page-item"><a onclick="processSyllabusList(${page + 1}, '${sort}', true)" class="page-link">Next</a></li>
                                                </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Your Profile Views Chart END-->
                    </div>
                </div>
        </main>
        <script>
            let request;
            function processSyllabusList(page, sort, pageType) {
                let key = document.getElementById("keyseach").value;
                let url = './admin-list?adminpage=syllabus&pageType=' + pageType + '&page=' + page + '&keysearch=' + key + '&sort=' +sort;
                if (window.XMLHttpRequest) {
                    request = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    request = new ActiveXObject("Microsoft.XMLHTTP");
                }

                try {
                    request.onreadystatechange = getInfo;
                    request.open("POST", url, true);
                    request.send("POST");
                } catch (e) {
                    alert("Unable to connect server");
                }
            }

            function getInfo() {
                if (request.readyState === 4) {
                    var val = request.responseText;
                    document.getElementById("list-items").innerHTML = val;
                }
            }

        </script>
        <%@include file="../gui/footer.jsp" %>
    </body>


</html>