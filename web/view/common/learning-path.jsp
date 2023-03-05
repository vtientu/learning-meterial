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
            <!-- inner page banner -->
            <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner.png);">
                <div class="container">
                    <div class="page-banner-entry">
                        <h1 class="text-white">Learning Path</h1>
                    </div>
                </div>
            </div>
            <!-- inner page banner END -->
            <div class="content-block">
                <!-- About Us -->
                <div class="section-area section-sp1">
                    <div class="container" style="min-height: 500px">
                        <div class="row justify-content-between">
                            <div>
                                <h3 style="border-bottom:10px solid #f7b205">Learning Path</h3>
                            </div>
                            <div class="col-sm-4 m-b30" style="float: right;">
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" placeholder="Search" aria-label="Recipient's username" aria-describedby="basic-addon2">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button">Button</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div  id="list-items">
                            <table class="table text-center">
                                <thead class="thead-orange">
                                <th>Syllabus ID</th>
                                <th>Subject Code</th>
                                <th>Syllabus Name</th>
                                <th>DecisionNo MM/dd/yyyy</th>
                                <th>All subject need to learn before</th>
                                </thead>
                                <tbody>

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
                    </div>
                </div>
            </div>
            <!-- contact area END -->

        </div>
        <script>


            let request;
            function searchLearningPath(page) {
                let key = document.getElementById("keyseach").value;
                let url = './learningpath?page=' + page + '&keysearch=' + key;


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
