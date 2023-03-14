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
                    <h4 class="breadcrumb-title">Material List</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Material List</li>
                    </ul>
                </div>
                <style>
                    .overflow{
                        max-width: 200px;
                        max-height: 80px;
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                    }
                </style>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="col-lg-12 m-b-20">
                                <a href="addelective?addtype=4"><input type="submit" class="btn" name="name" value="Add material"></a>
                            </div>
                            <form action="materiallist" method="get">
                                <div class="wc-title d-flex">
                                    <h4 style="line-height: 32px">Material List</h4>
                                    <input type="text" name="keysearch" id="keysearch" class="ml-auto" placeholder="Search">
                                    <button type="submit" style="background: orange">
                                        <i class="fa fa-search" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </form>

                            <table class="table table-hover table-bordered">
                                <thead style="background: orange" class="thead-orange">
                                <th style="font-weight: bold" class=" text-light col-lg-1">#</th>
                                <th style="font-weight: bold" class=" text-light col-lg-6">MaterialDescription</th>
                                <th style="font-weight: bold" class=" text-light col-lg-2">Author</th>
                                <th style="font-weight: bold" class=" text-light col-lg-1">Publisher</th>
                                <th style="font-weight: bold" class=" text-light col-lg-1">PublishedDate</th>
                                <th style="font-weight: bold" class=" text-light col-lg-1">Status</th>
                                </thead>
                                <tbody id="content">
                                    <c:forEach items="${list}" var="l">
                                        <tr>
                                            <td>${l.materialID}</td>
                                            <td><a href="materialdetail?materialID=${l.materialID}">${l.materialDescription}</a></td>
                                                <c:if test="${l.author==null}">
                                                <td>None</td>
                                            </c:if>
                                            <c:if test="${l.author!=null}">
                                                <td>${l.author}</td>
                                            </c:if>
                                            <c:if test="${l.publisher==null}">
                                                <td>None</td>
                                            </c:if>
                                            <c:if test="${l.publisher!=null}">
                                                <td>${l.publisher}</td>
                                            </c:if>
                                            <c:if test="${l.publishedDate==null}">
                                                <td>None</td>
                                            </c:if>
                                            <c:if test="${l.publishedDate!=null}">
                                                <td>${l.publishedDate}</td>
                                            </c:if>
                                            <td>
                                                <a href="editelective?type=4&materialID=${l.materialID}"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
                                                <a href="deletematerial?materialID=${l.materialID}"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>


                </div>

                <div class="col-lg-12 m-b20">
                    <div class="pagination-bx rounded-sm gray clearfix">
                        <ul class="pagination">
                            <li class="previous"><a href="materiallist?page=${page > 1 ? page-1 : page}${keysearch!=null?"&keysearch=":""}${keysearch}"><i class="ti-arrow-left"></i> Prev</a></li>
                                <c:set var="page" value="${page}"/>
                                <c:forEach begin="${1}" end="${num}" var="i">
                                <li class="${i==page?"active":""}"><a href="materiallist?page=${i}${keysearch!=null?"&keysearch=":""}${keysearch}">${i}</a></li>
                                </c:forEach>
                            <li class="next"><a href="materiallist?page=${page < num ? page+1 : page  }${keysearch!=null?"&keysearch=":""}${keysearch}">Next <i class="ti-arrow-right"></i></a></li>
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
