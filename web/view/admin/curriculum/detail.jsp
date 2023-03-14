<%-- 
    Document   : curriadmin
    Created on : Feb 17, 2023, 12:28:26 AM
    Author     : inuya
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%@include file="../gui/header.jsp" %>

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <%@include file="../gui/sidebar.jsp" %>
        <!-- header end -->
        <!-- Left sidebar menu start -->

        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="">
                    <h4 class="">Curriculum managemant</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Curriculum managemant</li>
                    </ul>
                </div>	
                <div class="page-content bg-white">
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
                                            <div class="row">
                                                <div class="col-md-12 col-lg-4">

                                                    <h4>Overview</h4>
                                                    <ul class="course-features">
                                                        <li><i class="ti-book"></i> <span class="label">Curriculum Code</span> <span
                                                                class="value">${curriculum.curriculumCode}</span></li>
                                                        <li><i class="ti-smallcap"></i> <span class="label">Curriculum Name VN</span>
                                                            <span class="value">${curriculum.curriculumNameEN}</span>
                                                        </li>
                                                        <li><i class="ti-info-alt"></i> <span class="label">NoCredit</span>
                                                            <span class="value">${curriculum.curriculumNameVN}</    span>
                                                        </li>
                                                        <li><i class="ti-receipt"></i> <span class="label">DecisionNo </span> <a data-target="#decision" data-toggle="modal"><span
                                                                    class="value">${curriculum.decision.decisionNo != null ? curriculum.decision.decisionNo:'None'}${curriculum.decision.approvedDate != null ? ' dated ':''}${curriculum.decision.approvedDate != null ? curriculum.decision.approvedDate:''}</span></a></li>
                                                        <li>
                                                            <a href=""><input type="button" class="btn btn-warning" name="name" value="View PO"></a>
                                                            <a href="comboDetailcuradmin?curID=${curriculum.curID}"><input type="button" class="btn btn-warning" name="name" value="View Combo"></a>
                                                            <a href="viewelective?curID=${curriculum.curID}"><input type="button" class="btn btn-warning" name="name" value="View Elective"></a>
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
                                                    <th style="font-weight: bold; background: orange" class=" text-light"></th>
                                                    <th style="font-weight: bold; background: orange" class=" text-light">PLO Name</th>
                                                    <th style="font-weight: bold; background: orange" class=" text-light">PLO Description</th>
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
                                            <table border="1" class="table table-striped">
                                                <h4>Mapping subjects of the Curriculum ${curriculum.curriculumCode} to program learning outcomes</h4>
                                                <thead class="thead-orange">
                                                    <tr>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">Subject Code</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO1</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO2</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO3</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO4</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO5</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO6</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO7</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO8</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO9</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO10</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO11</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO12</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO13</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO14</th>
                                                        <th style="font-weight: bold; background: orange" class=" text-light">PLO15</th>
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
                                                            <th style="font-weight: bold; background: orange" class=" text-light">SubjectCode</th>
                                                            <th style="font-weight: bold; background: orange" class=" text-light">SubjectName</th>
                                                            <th style="font-weight: bold; background: orange" class=" text-light">Semester</th>
                                                            <th style="font-weight: bold; background: orange" class=" text-light">NoCredit</th>
                                                            <!--<th style="font-weight: bold; background: orange" class=" text-light">PreRequisite</th>-->
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${requestScope.subject}" var="s">
                                                            <tr>
                                                                <td>${s.subjectCode}</td>
                                                                <td><a href="syllabus-details?syID=${s.subjectCode}">${s.subjectName}</a></td>
                                                                <td>${s.semester}</td>
                                                                <td>${s.noCredit}</td>
                                                                

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
        <script src='../assets/assets-admin/vendors/switcher/switcher.js'></script>
        <script>
            // Pricing add
            function newMenuItem() {
                var newElem = $('tr.list-item').first().clone();
                newElem.find('input').val('');
                newElem.appendTo('table#item-add');
            }
            if ($("table#item-add").is('*')) {
                $('.add-item').on('click', function (e) {
                    e.preventDefault();
                    newMenuItem();
                });
                $(document).on("click", "#item-add .delete", function (e) {
                    e.preventDefault();
                    $(this).parent().parent().parent().parent().remove();
                });
            }
        </script>
    </body>
</html>