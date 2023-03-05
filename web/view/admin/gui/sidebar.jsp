<%-- 
    Document   : sidebar
    Created on : Feb 22, 2023, 1:55:55 PM
    Author     : tient
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="ttr-sidebar">
    <div class="ttr-sidebar-wrapper content-scroll">
        <nav class="ttr-sidebar-navi">
            <ul>
                <li>
                    <a href="home" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-home"></i></span>
                        <span class="ttr-label">Home</span>
                    </a>
                </li>
                <li>
                    <a class="ttr-material-button" href="#">
                        <span class="ttr-icon"><i class="ti-user"></i></span>
                        <span class="ttr-label">User Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="admin-list?adminpage=user" class="ttr-material-button">
                                <span class="ttr-label">User List</span>
                            </a>
                        </li>
                        <li>
                            <a href="add-details?action=user" class="ttr-material-button"><span class="ttr-label">Add User</span></a>
                        </li>
                    </ul>
                </li>
                
                <li>
                    <a class="ttr-material-button" href="#">
                        <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                        <span class="ttr-label">Subject Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="admin-list?adminpage=subject" class="ttr-material-button">
                                <span class="ttr-label">Subject List</span>
                            </a>
                        </li>
                        <li>
                            <a class="ttr-material-button" href="add-details?action=subject"><span class="ttr-label">Create Subject</span></a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a class="ttr-material-button" href="#">
                        <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                        <span class="ttr-label">Syllabus Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="admin-list?adminpage=syllabus" class="ttr-material-button">
                                <span class="ttr-label">Syllabus List</span>
                            </a>
                        </li>
                        <li>
                            <a class="ttr-material-button" href="add-details?action=syllabus"><span class="ttr-label">Create Syllabus</span></a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a class="ttr-material-button" href="#">
                        <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                        <span class="ttr-label">Curriculum List</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a class="ttr-material-button">
                                <span class="ttr-label">Curriculum List</span>
                            </a>
                        </li>
                        <li>
                            <a class="ttr-material-button"><span class="ttr-label">Curriculum Subject</span></a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a class="ttr-material-button" href="#">
                        <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                        <span class="ttr-label">PO/PLO Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="admin-list?adminpage=subject" class="ttr-material-button">
                                <span class="ttr-label">Subject List</span>
                            </a>
                        </li>
                        <li>
                            <a class="ttr-material-button"><span class="ttr-label">Create Subject</span></a>
                        </li>
                    </ul>
                </li>


            </ul>
            <!-- sidebar menu end -->
        </nav>
        <!-- sidebar menu end -->
    </div>
</div>
