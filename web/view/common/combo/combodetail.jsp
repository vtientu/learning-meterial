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
                            <h1 class="text-white">Combo management</h1>
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
                                    <h3 style="border-bottom:10px solid #f7b205">Combo management</h3>
                                </div>

                            </div>
                            <div  id="list-items">
                                <table class="table table-hover table-bordered">

                                    <tr>
                                        <td class="col-md-4">Combo Name</td>
                                        <td class="col-md-8">${clist.comboName}</td>

                                    </tr>
                                    <tr>
                                        <td class="col-md-4">Note</td>
                                        <td class="col-md-8">${clist.note}</td>

                                    </tr>

                                </table>
                                <table class="table">
                                    <thead class="thead-orange">
                                    <th style="font-weight: bold" class=" text-light col-lg-2">ID</th>
                                    <th style="font-weight: bold" class=" text-light col-lg-2">Subject Code</th>
                                    <th style="font-weight: bold" class=" text-light col-lg-2">Subject Name</th>
                                    <th style="font-weight: bold" class=" text-light col-lg-2">Semester</th>
                                    <th style="font-weight: bold" class=" text-light col-lg-2">Note</th>
                                    <th style="font-weight: bold" class=" text-light col-lg-2"></th>
                                    </thead>
                                    <c:forEach items="${combolist}" var="list">
                                        <tbody>
                                        <td></td>
                                        <td>${list.subjectCode}</td>
                                        <td>${list.subjectName}</td>
                                        <td>${list.semester}</td>
                                        <td></td>
                                        <td></td>  
                                        </tbody>
                                    </c:forEach>
                                </table>


                                <div class="col-lg-12 m-b20">
                                    <div class="pagination-bx rounded-sm gray clearfix">
                                        <ul class="pagination"><li class="previous"><a onclick=""><i class="ti-arrow-left"></i> Prev</a></li>
                                            <li class=""><a id="page">1</a></li>
                                            <li class=""><a id="page">2</a></li>
                                            <li class="next"><a onclick="">Next<i class="ti-arrow-right"></i></a></li>
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
        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
    </body>

</html>
