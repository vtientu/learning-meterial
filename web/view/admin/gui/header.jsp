<%-- 
    Document   : header
    Created on : Feb 22, 2023, 1:53:28 PM
    Author     : tient
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">


    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="../assets/assets-admin/css/style.css">
        <link rel="stylesheet" type="text/css" href="../assets/assets-admin/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="../assets/assets-admin/css/color/color-1.css">

    </head>
    <body>
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
                            <img alt="" class="ttr-logo-desktop" src="../assets/assets-admin/images/logo-white.png" width="110" height="27">
                        </a>
                    </div>
                </div>
                <!--logo end -->
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img
                                        alt="" src="${account.typeAccount == -1?'../assets/images/':''}${account.avatar == null?'profile/pic1.png': account.avatar}" width="32" height="32"></span></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a>My profile</a></li>
                                    <li><a>Change Password</a></li>
                                    <li><a href="../home?action=logout">Logout</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- header right menu end -->
                </div>
                <div aria-live="polite" aria-atomic="true" style="position: relative;">
                    <div style="position: absolute; right: 2.5rem; top:  5rem;">
                        <div id="toasts" class="toast fade" data-delay="5000">
                            <div class="toast-body" style="background-color: ${sessionScope.color}; color: white">
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                                    <span aria-hidden="true" style="color: white">&times;</span>
                                </button>
                                ${message}
                            </div>
                        </div>
                    </div>
                </div>

                <div id="message" hidden="">${message}</div>
                <%
                    session.removeAttribute("message");
                    session.removeAttribute("color");
                %>
            </div>
        </header>
    </body>
</html>
