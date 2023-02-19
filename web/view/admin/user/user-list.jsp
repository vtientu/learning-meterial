<%-- 
    Document   : user-list
    Created on : Feb 19, 2023, 5:14:27 PM
    Author     : tient
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/bookmark.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->

    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />



        <!-- PAGE TITLE HERE ============================================= -->
        <title>Q5 - SWP391</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="../assets/assets-admin/css/assets.css">
        <link rel="stylesheet" type="text/css" href="../assets/assets-admin/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="../assets/assets-admin/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="../assets/assets-admin/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="../assets/assets-admin/css/style.css">
        <link rel="stylesheet" type="text/css" href="../assets/assets-admin/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="../assets/assets-admin/css/color/color-1.css">

    </head>

    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <!--sidebar menu toggler start -->
                <div class="ttr-toggle-sidebar">
                    <i class="ti-menu ttr-open-icon"></i>
                    <i class="ti-menu ttr-close-icon"></i>
                </div>
                <!--sidebar menu toggler end -->
                <!--logo start -->
                <div class="ttr-logo-box">
                    <div>
                        <a href="#" class="ttr-logo">
                            <img alt="" class="ttr-logo-desktop" src="../assets/assets-admin/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!--logo end -->
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img
                                        alt="" src="../assets/assets-admin/images/testimonials/pic3.jpg" width="32" height="32"></span></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="user-profile.html">My profile</a></li>
                                    <li><a href="list-view-calendar.html">Activity</a></li>
                                    <li><a href="mailbox.html">Messages</a></li>
                                    <li><a href="../login.html">Logout</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- header right menu end -->
                </div>
                <!--header search panel start -->
                <div class="ttr-search-bar">
                    <form class="ttr-search-form">
                        <div class="ttr-search-input-wrapper">
                            <input type="text" name="qq" placeholder="search something..." class="ttr-search-input">
                            <button type="submit" name="search" class="ttr-search-submit"><i
                                    class="ti-arrow-right"></i></button>
                        </div>
                        <span class="ttr-search-close ttr-search-toggle">
                            <i class="ti-close"></i>
                        </span>
                    </form>
                </div>
                <!--header search panel end -->
            </div>
        </header>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a href="#"><img alt="" src="../assets/assets-admin/images/logo.png" width="122" height="27"></a>
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
                <!-- side menu logo end -->
                <!-- sidebar menu start -->
                <nav class="ttr-sidebar-navi">
                    <ul>
                        <li>
                            <a href="adhome" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Home</span>
                            </a>
                        </li>
                        <li>
                            <a href="user-list" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-user"></i></span>
                                <span class="ttr-label">User List</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                                <span class="ttr-label">Syllabus List</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                                <span class="ttr-label">Curriculum List</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                                <span class="ttr-label">Subject List</span>
                            </a>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                    <!-- sidebar menu end -->
                </nav>
                <!-- sidebar menu end -->
            </div>
        </div>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>User List</h4>
                            </div>
                            <div class="widget-inner">
                                <div  id="list-items">
                                    <table class="table text-center">
                                        <thead class="thead-orange">
                                        <th>#</th>
                                        <th>Name</th>
                                        <th>User Name</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th></th>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listUser}" var="list">
                                                <tr>
                                                    <td>${list.accountID}</td>
                                                    <td>${list.displayName}</td>
                                                    <td>${list.userName}</td>
                                                    <td>${list.email}</td>
                                                    <td>${list.role.roleName}</td>
                                                    <td>
                                                        <form action="user-list" method="post">
                                                            <input value="${list.accountID}" hidden="" name="aid"/>
                                                            <input type="radio" onclick="this.form.submit()" name="active" value="Active" ${list.isActive == true?'checked':''}/>
                                                            <label>Activated</label>
                                                            <input type="radio" onclick="this.form.submit()" name="active" value="Disable" ${list.isActive != true?'checked':''}/>
                                                            <label>Not Activated</label>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- Your Profile Views Chart END-->
                    </div>
                </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="../assets/assets-admin/js/jquery.min.js"></script>
        <script src="../assets/assets-admin/vendors/bootstrap/js/popper.min.js"></script>
        <script src="../assets/assets-admin/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="../assets/assets-admin/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="../assets/assets-admin/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="../assets/assets-admin/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="../assets/assets-admin/vendors/counter/waypoints-min.js"></script>
        <script src="../assets/assets-admin/vendors/counter/counterup.min.js"></script>
        <script src="../assets/assets-admin/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="../assets/assets-admin/vendors/masonry/masonry.js"></script>
        <script src="../assets/assets-admin/vendors/masonry/filter.js"></script>
        <script src="../assets/assets-admin/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='../assets/assets-admin/vendors/scroll/scrollbar.min.js'></script>
        <script src="../assets/assets-admin/js/functions.js"></script>
        <script src="../assets/assets-admin/vendors/chart/chart.min.js"></script>
        <script src="../assets/assets-admin/js/admin.js"></script>
    </body>


</html>