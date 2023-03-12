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
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Elective List</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Elective List</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Elective List</h4>
                            </div>
                            <table class="table table-hover table-bordered">
                                <thead style="background: orange" class="thead-orange">
                                <th style="font-weight: bold" class=" text-light col-lg-1">ElectiveID</th>
                                <th style="font-weight: bold" class=" text-light col-lg-4">ElectiveNameEN</th>
                                <th style="font-weight: bold" class=" text-light col-lg-3">ElectiveNameVN</th>
                                <th style="font-weight: bold" class=" text-light col-lg-1">isActive</th>
                                <th style="font-weight: bold" class=" text-light col-lg-2">Note</th>
                                <th style="font-weight: bold" class=" text-light col-lg-1">Status</th>
                                </thead>
                                <tbody>
                                    <c:forEach items="${list}" var="liste">
                                        <tr>
                                            <td>${liste.electiveID}</td>
                                            <td>${liste.electiveNameEN}</td>
                                            <td><a href="viewelectivedetail?electiveID=${liste.electiveID}" style="color: blue">${liste.electiveNameVN}</a></td>
                                            <td style="${liste.isActive==1?"color: green":"color: red"}">${liste.isActive==1?"Active":"Unactive"}</td>
                                            <td><a>${liste.note}
                                                </a></td>
                                            <td><a href="editelective?type=1&electiveID=${liste.electiveID}"><i class="fa fa-pencil-square-o" aria-hidden="true" style='font-size:26px;color:red'></i></a>
                                                <a href="#" onclick="showMess(${liste.electiveID})"><i class="fa fa-trash-o" aria-hidden="true" style='font-size:26px;color:red'></i></a></td>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                            <a href="addelective?addtype=1"><button class="btn" type="submit">Add elective</button></a>
                        </div>
                    </div>


                </div>  
                <div class="col-lg-12 m-b20">
                    <div class="pagination-bx rounded-sm gray clearfix">
                        <ul class="pagination">
                            <li class="previous"><a href="#"><i class="ti-arrow-left"></i> Prev</a></li>
                                <c:forEach begin="1" end="6" var="i">
                                <li class="${i==1?"active":""}"><a href="#">${i}</a></li>
                                </c:forEach>
                            <li class="next"><a href="#">Next <i class="ti-arrow-right"></i></a></li>
                        </ul>
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
                                                    function  showMess(id) {
                                                        var option = confirm('Are you sure to delete');
                                                        if (option === true) {
                                                            window.location.href = "deleteelective?electiveID=" + id;
                                                        }
                                                    }
        </script>
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