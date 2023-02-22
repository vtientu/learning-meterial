<%-- 
    Document   : sidebar
    Created on : Feb 22, 2023, 1:55:55 PM
    Author     : tient
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="ttr-sidebar">
    <div class="ttr-sidebar-wrapper content-scroll">
        <!-- side menu logo start -->
        <div class="ttr-sidebar-logo text-center">
            <a href="#"><img alt="" src="../assets/assets-admin/images/logo.png" width="110" height="22"></a>
        </div>
        <!-- side menu logo end -->
        <!-- sidebar menu start -->
        <nav class="ttr-sidebar-navi">
            <ul>
                <li>
                    <a href="home" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-home"></i></span>
                        <span class="ttr-label">Home</span>
                    </a>
                </li>
                <li>
                    <a href="admin-list?adminpage=user" class="ttr-material-button">
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
                    <a href="admin-list?adminpage=subject" class="ttr-material-button">
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
