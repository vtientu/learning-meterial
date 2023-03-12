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
                    <h4 class="breadcrumb-title">Material Details</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="home"><i class="fa fa-home"></i>Home</a></li>
                        <li>Material Details</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <table class="table table-hover table-bordered">
                                <tr>
                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">#</th>
                                    <td>${material.materialID}</td>
                                </tr>
                                <tr><th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">MaterialDescription</th>
                                    <td>${material.materialDescription}</td>
                                </tr>
                                <tr>
                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">Author</th>
                                        <c:if test="${material.author==null}">
                                        <td>None</td>
                                    </c:if>
                                    <c:if test="${material.author!=null}">
                                        <td>${material.author}</td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">Publisher</th>
                                        <c:if test="${material.publisher==null}">
                                        <td>None</td>
                                    </c:if>
                                    <c:if test="${material.publisher!=null}">
                                        <td>${material.publisher}</td>
                                    </c:if>
                                </tr>
                                <tr>

                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">PublishedDate</th>
                                        <c:if test="${material.publishedDate==null}">
                                        <td>None</td>
                                    </c:if>
                                    <c:if test="${material.publishedDate!=null}">
                                        <td>${material.publishedDate}</td>
                                    </c:if>
                                </tr>
                                <tr>

                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">Edition</th>
                                        <c:if test="${material.edition==null}">
                                        <td>None</td>
                                    </c:if>
                                    <c:if test="${material.edition!=null}">
                                        <td>${material.edition}</td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">ISBN</th>
                                        <c:if test="${material.ISBN==null}">
                                        <td>None</td>
                                    </c:if>
                                    <c:if test="${material.ISBN!=null}">
                                        <td>${material.ISBN}</td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">IsMainMaterial</th>
                                    <c:if test="${material.isMainMaterial==null}">
                                        <td><i class="fa fa-times" aria-hidden="true"></i></td>
                                    </c:if>
                                    <c:if test="${material.isMainMaterial!=null}">
                                        <td><i class="fa fa-check" aria-hidden="true"></i></td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">IsHardCopy</th>
                                    <c:if test="${material.isHardCopy==null}">
                                        <td><i class="fa fa-times" aria-hidden="true"></i></td>
                                    </c:if>
                                    <c:if test="${material.isHardCopy!=null}">
                                        <td><i class="fa fa-check" aria-hidden="true"></i></td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">IsOnline</th>
                                    <c:if test="${material.isOnline==null}">
                                        <td><i class="fa fa-times" aria-hidden="true"></i></td>
                                    </c:if>
                                    <c:if test="${material.isOnline!=null}">
                                        <td><i class="fa fa-check" aria-hidden="true"></i></td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <th style="font-weight: bold; background-color: orange" class=" text-light col-lg-2">Note</th>
                                    <td>${material.note}</td>
                                </tr>
                            </table>
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
