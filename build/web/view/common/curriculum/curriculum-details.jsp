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
                    <div class="section-area" >
                        <div class="container p-5" style="box-shadow: 0px 4px 20px 4px rgb(0 0 0 / 15%)">
                            <div class="row d-flex flex-row-reverse">


                                <div class="tab-content">

                                    <div class="courese-overview" id="overview">

                                        <div class="ttr-post-title ">
                                            <h2 class="post-title">${Curriculum.curriculumNameEN}</h2>
                                        </div>
                                        <div class="row mt-5 border-top pt-5">
                                            <div class="col-md-12 col-lg-4">

                                                <h4>Overview</h4>
                                                <ul class="course-features">
                                                    <li><i class="ti-book"></i> <span class="label">Curriculum Code</span> <span
                                                            class="value">${curriculum.curriculumCode}</span></li>
                                                    <li><i class="ti-smallcap"></i> <span class="label">Curriculum Name VN</span>
                                                        <span class="value">${curriculum.curriculumNameEN}</span>
                                                    </li>
                                                    <li><i class="ti-info-alt"></i> <span class="label">NoCredit</span>
                                                        <span class="value">${curriculum.curriculumNameVN}</span>
                                                    </li>
                                                    <li><i class="ti-receipt"></i> <span class="label">DecisionNo </span> <a data-target="#decision" data-toggle="modal"><span
                                                                class="value">${curriculum.decision.decisionNo != null ? curriculum.decision.decisionNo:'None'}${curriculum.decision.approvedDate != null ? ' dated ':''}${curriculum.decision.approvedDate != null ? curriculum.decision.approvedDate:''}</span></a></li>
                                                    <li>
                                                        <a href=""><input type="button" class="btn btn-warning" name="name" value="View PO"></a>
                                                        <a href="combolist?curID=${curriculum.curID}"><input type="button" class="btn btn-warning" name="name" value="View Combo"></a>
                                                        <a href="electiveview?curID=${curriculum.curID}"><input type="button" class="btn btn-warning" name="name" value="View Elective"></a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-8">
                                                <h5 class="m-b5">Description</h5>
                                                <p>${curriculum.description}</p>
                                                </ul>
                                            </div>

                                        </div>
                                    </div>
                                    <ul class="nav nav-fill nav-tabs mt-5 border-top pt-5" id="other">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-toggle="tab" href="#material">PLO(s)</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-toggle="tab" href="#lo">Mapping(s)</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-toggle="tab" href="#session">Subject(s)</a>
                                        </li>
                                    </ul>

                                    <div id="material" class="tab-pane fade show active">
                                        <h3 class="mb-3 mt-5">PLO</h3>
                                        <div class="table-responsive mt-5">
                                            <table class="table table-hover table-bordered">
                                                <thead class="thead-orange">
                                                <th style="font-weight: bold" class=" text-light"></th>
                                                <th style="font-weight: bold" class=" text-light">PLO Name</th>
                                                <th style="font-weight: bold" class=" text-light">PLO Description</th>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>1</td>
                                                        <td>PLO1</td>
                                                        <td>Demonstrate basic knowledge of social sciences, politics and law, national security and defense, contributing to the formation of worldview and scientific methodology</td>
                                                    </tr>
                                                    <tr>
                                                        <td>2</td>
                                                        <td>PLO2</td>
                                                        <td>Demonstrate an entrepreneurial, creative, critical, and problem-solving mindset</td>
                                                    </tr>
                                                    <tr>
                                                        <td>3</td>
                                                        <td>PLO3</td>
                                                        <td>Communicate and work in groups effectively in academic and practical environments</td>
                                                    </tr>
                                                    <tr>
                                                        <td>4</td>
                                                        <td>PLO4</td>
                                                        <td>Utilize English in communication and learning (equivalent to level 4 according to the 6-level Foreign Language Proficiency Framework for Vietnam, equivalent to IELTS 6.0 or TOEFL (paper) 575-600 or TOEFL (iBT) 90 -100); and be able to communicate simply in Chinese</td>
                                                    </tr>
                                                    <tr>
                                                        <td>5</td>
                                                        <td>PLO5</td>
                                                        <td>Demonstrate professional behaviors, morality, social responsibilities and a sense of dedication to community</td>
                                                    </tr>
                                                    <tr>
                                                        <td>6</td>
                                                        <td>PLO6</td>
                                                        <td>Be mentally and physically strong, be capable of expressing national identity and integrating confidently into the world</td>
                                                    </tr>
                                                    <tr>
                                                        <td>7</td>
                                                        <td>PLO7</td>
                                                        <td>Develop self-study and lifelong learning spirit and capabilities to adapt to the constant change of technology and society</td>
                                                    </tr>
                                                    <tr>
                                                        <td>8</td>
                                                        <td>PLO8</td>
                                                        <td>Utilize English in communication and learning (equivalent to level 4 according to the 6-level Foreign Language Proficiency Framework for Vietnam, equivalent to IELTS 6.0 or TOEFL (paper) 575-600 or TOEFL (iBT) 90 -100); and be able to communicate simply in Chinese</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div id="lo" class="tab-pane fade">
                                        <h5 class="mb-3">Mapping</h5>
                                        <table border="1" class="table table-striped">
                                            <h4>Mapping subjects of the Curriculum ${curriculum.curriculumCode} to program learning outcomes</h4>
                                            <thead class="thead-orange">
                                                <tr>
                                                    <th>Subject Code</th>
                                                    <th>PLO1</th>
                                                    <th>PLO2</th>
                                                    <th>PLO3</th>
                                                    <th>PLO4</th>
                                                    <th>PLO5</th>
                                                    <th>PLO6</th>
                                                    <th>PLO7</th>
                                                    <th>PLO8</th>
                                                    <th>PLO9</th>
                                                    <th>PLO10</th>
                                                    <th>PLO11</th>
                                                    <th>PLO12</th>
                                                    <th>PLO13</th>
                                                    <th>PLO14</th>
                                                    <th>PLO15</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                </tr>
                                                <tr>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                </tr>
                                                <tr>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                    <th>a</th>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div id="session" class="tab-pane fade">
                                        <h5 class="mb-3">Subject</h5>
                                        <table border="1" class="table table-striped">
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
                                                            <td>${s.noCredit}</td>
                                                            <td>${s.prerequisite}</td>

                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                    </div>
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
