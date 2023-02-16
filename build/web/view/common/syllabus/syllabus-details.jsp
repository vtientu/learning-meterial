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
                    <div class="section-area" >
                        <div class="container p-5" style="box-shadow: 0px 4px 20px 4px rgb(0 0 0 / 15%)">
                            <div class="row d-flex flex-row-reverse">


                                <div class="tab-content">

                                    <div class="courese-overview" id="overview">

                                        <div class="ttr-post-title ">
                                            <h2 class="post-title">${syllabus.syllabusNameEN}</h2>
                                        </div>
                                        <div class="row mt-5 border-top pt-5">
                                            <div class="col-md-12 col-lg-4">

                                                <h4>Overview</h4>
                                                <ul class="course-features">
                                                    <li><i class="ti-book"></i> <span class="label">Subject Code</span> <span
                                                            class="value">${syllabus.subjectCode}</span></li>
                                                    <li><i class="ti-smallcap"></i> <span class="label">Syllabus Name</span>
                                                        <span class="value">${syllabus.syllabusNameEN}</span>
                                                    </li>
                                                    <li><i class="ti-info-alt"></i> <span class="label">NoCredit</span>
                                                        <span class="value">${syllabus.noCredit != null?syllabus.noCredit:'None'}</span>
                                                    </li>
                                                    <li><i class="ti-receipt"></i> <span class="label">DecisionNo </span> <a data-target="#decision" data-toggle="modal"><span
                                                                class="value">${syllabus.decisionNo != null ? syllabus.decisionNo:'None'}</span></a></li>

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
                                            <div class="col-md-12 col-lg-8">
                                                <h5 class="m-b5">Description</h5>
                                                <p>${syllabus.description}</p>
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
                                    <ul class="nav nav-fill nav-tabs mt-5 border-top pt-5" id="other">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-toggle="tab" href="#material">Material(s)</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-toggle="tab" href="#lo">LO(s)</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-toggle="tab" href="#session">Session(s)</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-toggle="tab" href="#question">Question(s)</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-toggle="tab" href="#assessment">Assessment(s)</a>
                                        </li>
                                    </ul>

                                    <div id="material" class="tab-pane fade show active">
                                        <h3 class="mb-3 mt-5">Material</h3>
                                        <div class="table-responsive mt-5">
                                            <table class="table table-hover table-bordered">
                                                <thead class="thead-orange">
                                                <th style="font-weight: bold" class=" text-light">MaterialDescription</th>
                                                <th style="font-weight: bold" class=" text-light">Author</th>
                                                <th style="font-weight: bold" class=" text-light">Publisher</th>
                                                <th style="font-weight: bold" class=" text-light">PublishedDate</th>
                                                <th style="font-weight: bold" class=" text-light">Edition</th>
                                                <th style="font-weight: bold" class=" text-light">ISBN</th>
                                                <th style="font-weight: bold" class=" text-light">IsMainMaterial</th>
                                                <th style="font-weight: bold" class=" text-light">IsHardCopy</th>
                                                <th style="font-weight: bold" class=" text-light">IsOnline</th>
                                                <th style="font-weight: bold" class=" text-light">Note</th>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Introductory documents aout FPT Group and FPT University</td>
                                                        <td>a</td>
                                                        <td>a</td>
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
                                    </div>
                                    <div id="question" class="tab-pane fade">
                                        <h5 class="mb-3">Questions</h5>
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
                                    <div id="session" class="tab-pane fade">
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
                                    </div>
                                    <div id="assessment" class="tab-pane fade">
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
                                    </div>
                                    <div id="lo" class="tab-pane fade">
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- contact area END -->

            <div id="decision" class=" mt-5 modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg" >
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        </div>
                        <div class="modal-body">
                            <table border="1">
                                <tbody><tr>
                                        <td style="width:12%;text-align:right;"> DecisionNo</td>
                                        <td>${syllabus.decisionNo}</td>
                                    </tr>
                                    <tr>
                                        <td style="width:12%;text-align:right;">DecisionName</td>
                                        <td>
                                            ${syllabus.decision.decisionName}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:12%;text-align:right;"> ApprovedDate (MM/dd/yyyy)</td>
                                        <td>${syllabus.decision.approvedDate}</td>
                                    </tr>
                                    <tr>
                                        <td style="width:12%;text-align:right;">Note</td>
                                        <td>${syllabus.decision.note}</td>
                                    </tr>
                                    <tr>
                                        <td style="width:12%;text-align:right;">CreateDate (MM/dd/yyyy)</td>
                                        <td>${syllabus.decision.createDate}</td>
                                    </tr>
                                    <tr>
                                        <td style="width:12%;text-align:right;"> FileName</td>
                                        <td>
                                            ${syllabus.decision.fileName}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <div class="col-md-12">
                                <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
                            </div>	
                        </div>
                    </div>
                </div>
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