<%-- 
    Document   : header
    Created on : Jan 18, 2023, 10:15:14 PM
    Author     : tient
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
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

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
        <!-- REVOLUTION SLIDER END -->	
        <style>
            .dropbtn {
                color: black;
                font-size: 16px;
                border: none;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f1f1f1;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

            .dropdown-content a:hover {
                background-color: #ddd;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

        </style>
    </head>
    <body>
        <header class="header rs-nav" style="height: 300px">
            <div class="top-bar">
                <div class="container">
                    <div class="row d-flex justify-content-between">
                        <div class="topbar-left">
                            <ul>
                                <li><a href="#"><i class="fa fa-envelope-o"></i>G5 - Project SWP391</a></li>
                            </ul>
                        </div>
                        <div class="topbar-right">
                            <ul>
                                <c:if test="${account == null}">
                                    <li><a href="home?action=login">Login</a></li>
                                    <li><a href="home?action=register">Register</a></li>
                                    </c:if>
                                    <c:if test="${account != null}">
                                    <li>
                                        <div class="dropdown">
                                            <div class="dropbtn p-0">
                                                <img class="rounded-circle shadow-4" style="width: 50px" src="${account.typeAccount == -1?'./assets/images/':''}${account.avatar == null?'profile/pic1.png': account.avatar}" alt="alt"/>
                                                <label>${account.fullName == null ? '':account.fullName}</label>
                                            </div>
                                            <div class="dropdown-content">
                                                <c:if test="${account.role.roleID > 3}"><a href="admin/home">Manager System</a></c:if>
                                                <a href="profile">Profile</a>
                                                <a href="home?action=logout">Logout</a>
                                            </div>
                                        </div>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sticky-header navbar-expand-lg">
                <div class="menu-bar clearfix">
                    <div class="container clearfix">
                        <!-- Header Logo ==== -->
                        <div class="menu-logo">
                            <a href="home"><img src="assets/images/logo.png" alt=""></a>
                        </div>
                        <!-- Mobile Nav Button ==== -->
                        <button class="navbar-toggler collapsed menuicon justify-content-end" type="button" data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown" aria-expanded="false" aria-label="Toggle navigation">
                            <span></span>
                            <span></span>
                            <span></span>
                        </button>
                        <!-- Navigation Menu ==== -->
                        <div class="menu-links navbar-collapse collapse justify-content-start" id="menuDropdown">
                            <div class="menu-logo">
                                <a href="home.html"><img src="assets/images/logo.png" alt=""></a>
                            </div>
                            <ul class="nav navbar-nav m-auto justify-content-between">	
                                <li><a href="home">Home</a></li>
                                <li><a href="syllabus">Syllabus</a></li>
                                <li><a href="curriculum">Curriculum</a>
                                </li>
                                <li><a href="learningpath">Learning Path</a>
                                </li>
                                <li><a href="prequisite">the pre-requisite</a>
                                </li>
                            </ul>
                        </div>
                        <!-- Navigation Menu END ==== -->
                    </div>
                </div>
            </div>
        </header>
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
