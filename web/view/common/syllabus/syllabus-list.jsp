<%-- 
    Document   : syllabus-list
    Created on : Jan 31, 2023, 1:31:19 AM
    Author     : tient
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">


    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="#" type="image/x-icon" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>G5 - Project SWP391</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">


        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    </head>

    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header Top ==== -->
            <%@include file="../gui/header.jsp" %>
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner.png);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Syllabus</h1>
                        </div>
                    </div>
                </div>
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row justify-content-between">
                                <div>
                                    <h3 style="border-bottom:10px solid #f7b205">Syllabus</h3>
                                </div>
                                <div class="col-sm-4 m-b30" style="float: right;">
                                    <div class="widget courses-search-bx placeani">
                                        <div class="form-group">
                                                <div class="input-group">
                                                    <label><i class="fa fa-search"></i> Search</label>
                                                    <input oninput="searchSyllabus(${page})" name="keysearch" id="keyseach" type="text" class="form-control">
                                                </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div  id="list-items">
                                <table class="table text-center">
                                    <thead class="thead-orange">
                                    <th>Syllabus ID</th>
                                    <th>Subject Code</th>
                                    <th>Subject Name</th>
                                    <th>Syllabus Name</th>
                                    <th>IsActive</th>
                                    <th>IsApproved</th>
                                    <th>DecisionNo<br/>MM/dd/yyyy</th>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listSyllabus}" var="list">
                                            <tr>
                                                <td>${list.syllabusID}</td>
                                                <td>${list.subject.subjectCode}</td>
                                                <td>${list.subject.subjectName}</td>
                                                <td><a style="color: blue;" href="syllabus-details?syID=${list.subject.subjectCode}">${list.syllabusNameEN}</a></td>
                                                <td><i  style="color: ${list.isActive == true ? 'green':'red'}" class="fa ${list.isActive == true ? 'fa-check':'fa-close'}"/></td>
                                                <td><i  style="color: ${list.isApproved == true ? 'green':'red'}" class="fa ${list.isApproved == true ? 'fa-check':'fa-close'}"/></td>
                                                <td><a style="cursor: pointer; color: blue" data-target="#decision${list.syllabusID}" data-toggle="modal" ">${list.decisionNo}</a></td>
                                        <div id="decision${list.syllabusID}" class=" mt-5 modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog modal-lg" >
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <label class="col-2">DecisionNo</label><p class="col-10">${list.decision.decisionNo}</p>
                                                        </div>
                                                        <div class="row">
                                                            <label class="col-2">DecisionName</label><p class="col-10">${list.decision.decisionName}</p>
                                                        </div>
                                                        <div class="row">
                                                            <label class="col-2">ApprovedDate (MM/dd/yyyy)</label><p class="col-10">${list.decision.approvedDate}</p>
                                                        </div>
                                                        <div class="row">
                                                            <label class="col-2">Note</label><p class="col-10">${list.decision.note}</p>
                                                        </div>
                                                        <div class="row">
                                                            <label class="col-2">CreateDate (MM/dd/yyyy)</label><p class="col-10">${list.decision.createDate}</p>
                                                        </div>
                                                        <div class="row">
                                                            <label class="col-2">FileName</label><p class="col-10">${list.decision.fileName}</p>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <div class="col-md-12">
                                                            <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
                                                        </div>	
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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
                                                <li class="previous"><a onclick="searchSyllabus(${page - 1})"><i class="ti-arrow-left"></i> Prev</a></li>
                                                </c:if>

                                            <li class="active"><a id="page">${page}</a></li>

                                            <c:if test="${page == totalPage}">
                                                <li class="next"><a style="pointer-events: none">Next<i class="ti-arrow-right"></i></a></li>
                                                    </c:if>
                                                    <c:if test="${page < totalPage}">
                                                <li class="next"><a onclick="searchSyllabus(${page + 1})">Next<i class="ti-arrow-right"></i></a></li>
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
                function searchSyllabus(page) {
                    let key = document.getElementById("keyseach").value;
                    let url = './syllabus?page=' + page + '&keysearch=' + key;


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
            <!-- Content END-->
            <!-- Footer ==== -->
            <%@include file="../gui/footer.jsp" %>
            <!-- Footer END ==== -->
            <button class="back-to-top fa fa-chevron-up"></button>
        </div>
    </body>

</html>
