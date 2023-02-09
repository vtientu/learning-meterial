<%-- 
    Document   : syllabus-details
    Created on : Jan 31, 2023, 1:37:50 AM
    Author     : tient
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
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
                            <h1 class="text-white">Syllabus ${syllabus.subjectCode}</h1>
                        </div>
                    </div>
                </div>
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row d-flex flex-row-reverse">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <div class="course-detail-bx">
                                        <c:if test="${account != null && account.role.roleName != 'GUEST'}">
                                            <div class="course-price border-bottom">
                                                <p>Download All Student Material</p>
                                                <button class="btn radius-xl text-uppercase"><a href="files/materials/material" download="">Download</a></button>
                                            </div>
                                            <div class="course-price border-bottom">
                                                <p>Download All Teacher Material</p>
                                                <button class="btn radius-xl text-uppercase"><a href="files/materials/material" download="">Download</a></button>
                                            </div>
                                        </c:if>
                                        <div class="teacher-bx" style="border-top: none; margin: 0">
                                            <div class="teacher-name text-center">
                                                <h5>${syllabus.subjectNameEN}</h5>
                                                <span>${syllabus.subjectCode}</span>
                                            </div>
                                        </div>
                                        <div class="cours-more-info align-items-center">
                                            <div class="review text-center">
                                                <span>Semester</span>
                                                <h5>${syllabus.subject.semester}</h5>
                                            </div>
                                            <div class="review categories text-center">
                                                <span>Pre-Requisite</span>
                                                <h5>${syllabus.subject.preRequisite == null ? syllabus.subject.preRequisite:'None'}</h5>
                                            </div>
                                        </div>
                                        <div class="course-info-list scroll-page">
                                            <ul class="navbar">
                                                <li><a class="nav-link" href="#overview"><i class="ti-zip"></i>Overview</a>
                                                </li>
                                                <li><a class="nav-link" href="#curriculum"><i
                                                            class="ti-bookmark-alt"></i>Details</a></li>
                                                <li><a class="nav-link" href="#instructor"><i
                                                            class="ti-user"></i>Skills</a></li>
                                                        <c:if test="${account.role.roleName == 'ADMIN' || account.role.roleName == 'REVIEWER'}">
                                                    <li><a class="nav-link" href="#reviews"><i
                                                                class="ti-comments"></i>Reviews</a></li>
                                                        </c:if>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="courses-post">
                                        <div class="ttr-post-info">
                                            <div class="ttr-post-title ">
                                                <h2 class="post-title">${syllabus.subjectNameEN}</h2>
                                                <h5 class="mb-3">Description</h5>
                                            </div>
                                            <div class="ttr-post-text">
                                                <p>${syllabus.description}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="courese-overview mt-5 border-top pt-5" id="overview">
                                        <h4>Overview</h4>
                                        <div class="row">
                                            <div class="col-md-12 col-lg-5">
                                                <ul class="course-features">
                                                    <li><i class="ti-book"></i> <span class="label">Subject Code</span> <span
                                                            class="value">${syllabus.subjectCode}</span></li>
                                                    <li><i class="ti-smallcap"></i> <span class="label">Syllabus Name</span>
                                                        <span class="value">${syllabus.subjectNameEN}</span>
                                                    </li>
                                                    <li><i class="ti-info-alt"></i> <span class="label">NoCredit</span>
                                                        <span class="value">${syllabus.noCredit != null?syllabus.noCredit:'None'}</span>
                                                    </li>
                                                    <li><i class="ti-receipt"></i> <span class="label">DecisionNo </span> <span
                                                            class="value">${syllabus.decisionNo ? syllabus.decisionNo:'None'}</span></li>

                                                    <li><i class="ti-bar-chart-alt"></i> <span class="label">MarkToPass</span>
                                                        <span class="value">${syllabus.minAvgMarkToPass}</span></li>
                                                    <li><i class="ti-bar-chart-alt"></i> <span class="label">Scoring Scale</span>
                                                        <span class="value">${syllabus.scoringScale}</span></li>
                                                    <li><i class="ti-check-box">
                                                        </i> <span class="label">IsApproved</span>
                                                        <span class="value"><i class="${syllabus.isApproved == true?'ti-check':'ti-close'}"></i></span>
                                                    </li>
                                                    <li><i class="ti-check-box"></i> <span class="label">IsActive</span> <span
                                                            class="value"><i class="${syllabus.isActive == true?'ti-check':'ti-close'}"></i></span></li>
                                                    <li><i class="ti-time"></i> <span class="label">ApprovedDate</span>
                                                        <span class="value">${syllabus.approvedDateFormat}</span>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-7">
                                                <h5 class="m-b5">Time Allocation</h5>
                                                <p>${syllabus.timeAllocation}</p>
                                                <h5 class="m-b5">Tools</h5>
                                                <p>${syllabus.tools}</p>
                                                <h5 class="m-b5">Student Tasks</h5>
                                                <p>${syllabus.studentTasks}</p>

                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="m-b30 mt-5 border-top pt-5" id="curriculum">
                                        <h4>Curriculum</h4>
                                        <ul class="curriculum-list">
                                            <li>
                                                <h5 class="mb-3">Material</h5>
                                                <table border="1" class="table table-striped">
                                                    <thead class="thead-orange">
                                                        <tr>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                        </tr>
                                                        <tr>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                        </tr>
                                                        <tr>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                        </tr>
                                                    </tbody>
                                                </table>

                                            </li>
                                            <li>
                                                <h5 class="mb-3">Sessions</h5>
                                                <table border="1" class="table table-striped">
                                                    <thead class="thead-orange">
                                                        <tr>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                        </tr>
                                                        <tr>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                        </tr>
                                                        <tr>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </li>
                                            <li>
                                                <h5 class="mb-3">Assessment</h5>
                                                <table border="1" class="table table-striped">
                                                    <thead class="thead-orange">
                                                        <tr>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                            <th>a</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                        </tr>
                                                        <tr>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                        </tr>
                                                        <tr>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                            <td>a</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="mt-5 border-top pt-5" id="instructor">
                                        <h4>LO(s)</h4>
                                        <table border="1" class="table table-striped">
                                            <thead class="thead-orange">
                                                <tr>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                </tr>
                                                <tr>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                </tr>
                                                <tr>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                    <td>a</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <c:if test="${account != null && account.role.roleName != 'GUEST' && account.role.roleName != 'STUDENT' && account.role.roleName != 'TEACHER'}">
                                        <div class="mt-5 border-top pt-5" id="reviews">
                                            <h4>Reviews</h4>
                                            <c:if test="${account.role.roleName == 'REVIEWER' || account.role.roleName == 'ADMIN'}">
                                                <form action="syllabus-details" method="post">
                                                    <input type="text" name="syID" value="${syllabus.syllabusID}" hidden="">
                                                    <div class="form-group">
                                                        <label for="titleReview">Title *</label>
                                                        <input name="title" type="text" class="form-control" id="titleReview" placeholder="Title">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="descriptionReview">Description *</label>
                                                        <textarea name="description" type="password" class="form-control" id="descriptionReview" placeholder="Description"></textarea>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">Submit</button>
                                                </form>
                                            </c:if>
                                            <div id="feedback">
                                                <c:forEach items="${feedback}" var="f">
                                                    <div class="instructor-bx mt-5">
                                                        <div class="instructor-author">
                                                            <img src="images/${f.account.avatar == null?'profile/pic1.png':f.account.avatar}" alt="avatar">
                                                        </div>
                                                        <div class="instructor-info">

                                                            <h5>${f.account.displayName}</h5>
                                                            <span style="font-weight: bold">${f.title}</span>
                                                            <p class="m-b0">${f.description}</p>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- contact area END -->
        </div>
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
    <script src="assets/js/jquery.scroller.js"></script>
    <script src="assets/js/functions.js"></script>
    <script src="assets/js/contact.js"></script>
</body>

</html>