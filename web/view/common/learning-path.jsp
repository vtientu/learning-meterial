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
        <div class="page-content bg-white">
            <div class="content-block">
                <!-- About Us -->
                <div class="section-area section-sp1">
                    <div class="container" style="min-height: 500px">
                        <div class="input-group input-group-sm align-items-center mb-4">
                            <h3 style="border-bottom:10px solid #f7b205">Learning Path</h3>
                            <form class="input-group" action="learningpath" method="post">
                                <input type="text" class="form-control" id="search-input" name="keysearch" placeholder="Enter Subject Code">
                                <div class="input-group-append">
                                    <button type="submit" name="submit" class="btn btn-secondary btn-number">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                        <c:if test="${listLearning != null}">
                            <div  id="list-items">
                                <table class="table  table-bordered" style="min-height: 300px">
                                    <thead class="thead-orange">
                                    <th>Syllabus ID</th>
                                    <th>Subject Code</th>
                                    <th>Syllabus Name</th>
                                    <th>DecisionNo MM/dd/yyyy</th>
                                    <th>All subject need to learn before</th>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listLearning}" var="listl">
                                            <tr>
                                                <td>${listl.subject.subjectID}</td>
                                                <td>${listl.subject.subjectCode}</td>
                                                <td><a style="color: blue;" href="syllabus-details?syID=${listl.subject.subjectCode}">${listl.syllabusNameEN}</a></td>
                                                <td>${listl.decisionNo}</td>
                                                <td>
                                                    <c:if test="${listl.subject.prerequisite.isEmpty()}"><br/>(None)
                                                    </c:if>
                                                    <c:if test="${!listl.subject.prerequisite.isEmpty()}">
                                                        <c:forEach items="${listl.subject.prerequisite}" var="c">
                                                            ${c.subjectPre == null || list.subject.prerequisite.isEmpty() ?'(No pre-requisite)':c.subjectPre}
                                                        </c:forEach>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>


                                <div class="col-lg-12 m-b20">
                                    <div class="pagination-bx rounded-sm gray clearfix">
                                        <ul class="pagination">
                                            <c:if test="${page == 1}">
                                                <li class="previous"><a style="pointer-events: none"><i class="ti-arrow-left"></i> Prev</a></li>
                                                </c:if>
                                                <c:if test="${page != 1}">
                                                <li class="previous"><a onclick="searchLearningPath(${page - 1})"><i class="ti-arrow-left"></i> Prev</a></li>
                                                </c:if>

                                            <li class="active"><a id="page">${page}</a></li>

                                            <c:if test="${page == totalPage}">
                                                <li class="next"><a style="pointer-events: none">Next<i class="ti-arrow-right"></i></a></li>
                                                    </c:if>
                                                    <c:if test="${page < totalPage}">
                                                <li class="next"><a onclick="searchLearningPath(${page + 1})">Next<i class="ti-arrow-right"></i></a></li>
                                                    </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

        </div>
        <script>


            let request;
            function searchLearningPath(page) {
                let url = './learningpath?page=' + page;


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
        <%@include file="gui/footer.jsp" %>
    </body>
</html>
