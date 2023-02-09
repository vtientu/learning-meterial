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
                            <h1 class="text-white">Curriculum ${curriculum.curriculumCode}</h1>
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
                                        
                                        <div class="teacher-bx" style="border-top: none; margin: 0">
                                            <div class="teacher-name text-center">
                                                <h5>${curriculum.curriculumNameEN}</h5>
                                                <span>${curriculum.curriculumNameVN}</span>
                                            </div>
                                        </div>
                                        <div class="cours-more-info align-items-center">
                                            <div class="review text-center">
                                                <span>Curriculum code</span>
                                                <h6>${curriculum.curriculumCode}</h6>
                                            </div>
                                            <div class="review categories text-center">
                                                <span>Major</span>
                                                <h5>${curriculum.major.keyword}</h5>
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
                                                <h2 class="post-title">${curriculum.curriculumNameEN}</h2>
                                                <h2 class="post-title">${curriculum.major.majorNameEN}</h2>
                                                <h5 class="mb-3">Description</h5>
                                            </div>
                                            <div class="ttr-post-text">
                                                <p>${curriculum.description}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="courese-overview mt-5 border-top pt-5" id="overview">
                                        <h4>Overview</h4>
                                        <div class="row">
                                            <div class="col-md-12 col-lg-5">
                                                <ul class="course-features">
                                                    <li><i class="fa fa-eye"></i> <input type="button" value="View PO" class="btn btn-success">
                                                    </li>
                                                    <li><i class="fa fa-eye"></i> <input type="button" value="View Combo" class="btn btn-success">
                                                    </li>
                                                    <li><i class="fa fa-eye"></i> <input type="button" value="View Elective" class="btn btn-success">
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-7">
                                                <h5 class="m-b5">Decision no</h5>
                                                <p>${curriculum.getDecisionNo()}</p>
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
                                    <div class="mt-5 border-top pt-5" id="instructor">
                                        <h6 style="color: green">Subject</h6>
                                        <table border="1" class="table table-striped">
                                            <thead class="thead-orange">
                                                <tr>
                                                    <th>SubjectCode</th>
                                                    <th>SubjectName</th>
                                                    <th>Semester</th>
                                                    <th>NoCredit</th>
                                                    <th>PreRequisite</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${requestScope.subject}" var="s">
                                                    <tr>
                                                        <td>${s.subjectCode}</td>
                                                        <td><a href="syllabus-details?syID=${s.subjectCode}">${s.subjectName}</a></td>
                                                        <td>${s.semester}</td>
                                                        <td>${s.subjectCode}</td>
                                                        <td>${s.subjectCode}</td>

                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <c:if test="${account != null && account.role.roleName != 'GUEST' && account.role.roleName != 'STUDENT' && account.role.roleName != 'TEACHER'}">
                                        <div class="mt-5 border-top pt-5" id="reviews">
                                            <h4>Reviews</h4>
                                            <c:if test="${account.role.roleName == 'REVIEWER' || account.role.roleName == 'ADMIN'}">
                                                <form action="list-details" method="post">
                                                    <input type="text" name="syID" value="${syllabus.subjectCode}" hidden="">
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-12 col-md-6">
                                                                <label for="nameReview">Full name *</label>
                                                                <input name="displayName" type="text" class="form-control" id="nameReview" placeholder="Enter your name" required="">
                                                            </div>
                                                            <div class="col-12 col-md-6">
                                                                <label for="emailReview">Email address *</label>
                                                                <input name="email" type="email" class="form-control" id="emailReview" placeholder="Enter your name">
                                                            </div>
                                                        </div>
                                                    </div>
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
                                            <div class="instructor-bx mt-5">
                                                <div class="instructor-author">
                                                    <img src="assets/images/testimonials/pic1.jpg" alt="">
                                                </div>
                                                <div class="instructor-info">
                                                    <h6>Keny White </h6>
                                                    <span>Professor</span>
                                                    <ul class="list-inline m-tb10">
                                                        <li><a href="#" class="btn sharp-sm facebook"><i class="fa fa-facebook"></i></a></li>
                                                        <li><a href="#" class="btn sharp-sm twitter"><i class="fa fa-twitter"></i></a></li>
                                                        <li><a href="#" class="btn sharp-sm linkedin"><i class="fa fa-linkedin"></i></a></li>
                                                        <li><a href="#" class="btn sharp-sm google-plus"><i class="fa fa-google-plus"></i></a></li>
                                                    </ul>
                                                    <p class="m-b0">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries</p>
                                                </div>
                                            </div>
                                            <div class="instructor-bx">
                                                <div class="instructor-author">
                                                    <img src="assets/images/testimonials/pic2.jpg" alt="">
                                                </div>
                                                <div class="instructor-info">
                                                    <h6>Keny White </h6>
                                                    <span>Professor</span>
                                                    <p class="m-b0">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries</p>
                                                </div>
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
