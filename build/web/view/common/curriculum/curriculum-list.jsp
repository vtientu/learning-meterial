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
                            <h1 class="text-white">Curriculum</h1>
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
                                    <h3 style="border-bottom:10px solid #f7b205">Curriculum</h3>
                                </div>
                                <div class="col-sm-4 m-b30" style="float: right;">
                                    <div class="widget courses-search-bx placeani">
                                        <div class="form-group">
                                            <form action="curriculum" method="post">
                                                <div class="input-group">
                                                    <label><i class="fa fa-search"></i> Search</label>
                                                    <input oninput="searchCurriculum()" name="keysearch" id="keyseach" type="text" class="form-control">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div id="list-curriculum" class="row">
                                    <c:forEach items="${listcurriculum}" var="list">
                                        <c:if test="${list.approve==1}">
                                            <div class="col-md-4 col-lg-3 col-sm-6 m-b30">
                                            <div class="cours-bx">
                                                <div class="action-box">
                                                    <img src="assets/images/banner.png" alt=""  style="height: 10rem">
                                                    <a href="curriculum-details?curID=${list.getCurID()}" class="btn">View</a>
                                                </div>
                                                <div class="info-bx text-center">
                                                    <h5  style="min-height: 50px"><a href="curriculum-details?curID=${list.getCurID()}">${list.getCurriculumNameEN()}, ${list.major.majorNameEN}</a></h5>
                                                    <h5>(${list.getCurriculumCode()})</h5>
                                                    <h5>(${list.decision.decisionNo})</h5>
                                                </div>
                                                    
                                                <div class="review text-center">

                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                        
                                    </c:forEach>
                                </div>
                                <div class="col-lg-12 m-b20">
                                    <div class="pagination-bx rounded-sm gray clearfix">
                                        <ul class="pagination">
                                            <li class="previous"><a href="curriculum?page=${page > 1 ? page-1 : page}"><i class="ti-arrow-left"></i> Prev</a></li>
                                                <c:set var="page" value="${requestScope.page}"/>

                                            <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                                                <li class="${i==page?"active":""}"><a href="curriculum?page=${i}">${i}</a></li>
                                                </c:forEach>
                                            <li class="next"><a href="curriculum?page=${page < num ? page+1 : page  }">Next <i class="ti-arrow-right"></i></a></li>
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
                function searchCurriculum() {
                    let key = document.getElementById("keyseach").value;
                    let url = './curriculum?keysearch=' + key;
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
                        alert("Unable to connect server")
                    }
                }

                function getInfo() {
                    if (request.readyState === 4) {
                        var val = request.responseText;
                        document.getElementById("list-curriculum").innerHTML = val;
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
