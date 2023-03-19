<%-- 
    Document   : addelective
    Created on : Feb 20, 2023, 3:23:08 AM
    Author     : inuya
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%@include file="../gui/header.jsp" %>

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Left sidebar menu start -->
        <%@include file="../gui/sidebar.jsp" %>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <c:if test="${addtype==1}">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">Add elective</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>Add elective</li>
                        </ul>
                    </div>	
                    <div class="row">
                        <!-- Your Profile Views Chart -->
                        <div class="col-lg-12 m-b30">
                            <div class="widget-box">
                                <div class="wc-title">
                                    <h4>Add elective</h4>

                                </div>

                                <div class="widget-inner">
                                    <form class="edit-profile m-b30" action="addelective" method="post">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="ml-auto">
                                                    <h3>1. Basic info</h3>
                                                    <input type="text" name="addtype" value="1" hidden="">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Elective name EN</label>
                                                <div>
                                                    <input class="form-control" type="text" name="nameen">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Elective name VN</label>
                                                <div>
                                                    <input class="form-control" type="text" name="namevn">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Curriculum</label>
                                                <select class="form-control" name="curriid">
                                                    <c:forEach items="${currilist}" var="clist">
                                                        <option value="${clist.curID}">${clist.curriculumCode}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Active</label>
                                                <div>
                                                    <div class="form-check-inline">
                                                        <label class="form-check-label" for="radio1" style="color: red">
                                                            <input type="radio" class="form-check-input" name="active" value="1" checked>Active
                                                        </label>
                                                    </div>
                                                    <div class="form-check-inline">
                                                        <label class="form-check-label" for="radio2" style="color: red">
                                                            <input type="radio" class="form-check-input" name="active" value="0">unactive
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="seperator"></div>

                                            <div class="col-12 m-t20">
                                                <div class="ml-auto m-b5">
                                                    <h3>2. Note</h3>
                                                </div>
                                            </div>
                                            <div class="form-group col-12">
                                                <label class="col-form-label">Note</label>
                                                <div>
                                                    <textarea class="form-control" name="note"> </textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <button type="submit" class="btn-secondry add-item m-r5"><i class="fa fa-fw fa-plus-circle"></i>Add Item</button>
                                                <button type="reset" class="btn">Save changes</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                        <!-- Your Profile Views Chart END-->
                    </div>
                </div>
            </c:if>
            <c:if test="${addtype==2}">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">Add combo</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>Add combo</li>
                        </ul>
                    </div>	
                    <div class="row">
                        <!-- Your Profile Views Chart -->
                        <div class="col-lg-12 m-b30">
                            <div class="widget-box">
                                <div class="wc-title">
                                    <h4>Add combo</h4>
                                </div>

                                <div class="widget-inner">
                                    <form class="edit-profile m-b30" action="addelective" method="post">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="ml-auto">
                                                    <h3>1. Basic info</h3>
                                                    <input type="text" name="addtype" value="2" hidden="">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Combo name</label>
                                                <div>
                                                    <input class="form-control" type="text" name="name">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Active</label>
                                                <div>
                                                    <div class="form-check-inline">
                                                        <label class="form-check-label" for="radio1" style="color: red">
                                                            <input type="radio" class="form-check-input" name="active" value="1" checked>Active
                                                        </label>
                                                    </div>
                                                    <div class="form-check-inline">
                                                        <label class="form-check-label" for="radio2" style="color: red">
                                                            <input type="radio" class="form-check-input" name="active" value="0">unactive
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="seperator"></div>

                                            <div class="col-12 m-t20">
                                                <div class="ml-auto m-b5">
                                                    <h3>2. Note</h3>
                                                </div>
                                            </div>
                                            <div class="form-group col-12">
                                                <label class="col-form-label">Note</label>
                                                <div>
                                                    <input class="form-control" name="note" >
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <button type="submit" class="btn-secondry add-item m-r5"><i class="fa fa-fw fa-plus-circle"></i>Add Item</button>
                                                <button type="reset" class="btn">Save changes</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                        <!-- Your Profile Views Chart END-->
                    </div>
                </div>
            </c:if>
            <c:if test="${addtype==3}">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">Edit curriculum</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>Edit curriculum</li>
                        </ul>
                    </div>	
                    <div class="row">
                        <!-- Your Profile Views Chart -->
                        <div class="col-lg-12 m-b30">
                            <div class="widget-box">
                                <div class="wc-title">
                                    <h4>Add curriculum</h4>
                                </div>
                                <div class="widget-inner">
                                    <form class="edit-profile m-b30" action="addelective" method="post">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="ml-auto">
                                                    <h3>1. Basic info</h3>
                                                    <input type="text" name="addtype" value="3" hidden="">
                                                </div>
                                            </div>
                                            <div class="form-group col-4">
                                                <label class="col-form-label">Major</label>
                                                <select class="form-control" name="major">
                                                    <c:forEach items="${major}" var="m">
                                                        <option value="${m.majorID}">${m.majorNameEN}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group col-4">
                                                <label class="col-form-label">Decision</label>
                                                <select class="form-control" id="sel1" name="decision">
                                                    <c:forEach items="${decision}" var="de">
                                                        <option value="${de.decisionNo}">${de.decisionNo}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group col-4">
                                                <label class="col-form-label">Curriculum code</label>
                                                <div>
                                                    <input class="form-control" type="text" name="code" >
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Curriculum name EN</label>
                                                <div>
                                                    <input class="form-control" type="text" name="nameen">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Curriculum name VN</label>
                                                <div>
                                                    <input class="form-control" type="text" name="namevn">
                                                </div>
                                            </div>

                                            <div class="seperator"></div>

                                            <div class="col-12 m-t20">
                                                <div class="ml-auto m-b5">
                                                    <h3>2. Description</h3>
                                                </div>
                                            </div>
                                            <div class="form-group col-12">
                                                <label class="col-form-label">Description</label>
                                                <div>
                                                    <textarea class="form-control" name="description" rows="5" cols="10"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <button type="submit" class="btn-secondry add-item m-r5"><i class="fa fa-fw fa-plus-circle"></i>Update</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                        <!-- Your Profile Views Chart END-->
                    </div>
                </div>
            </c:if>
            <c:if test="${addtype==4}">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">Edit material</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>Edit material</li>
                        </ul>
                    </div>	
                    <div class="row">
                        <!-- Your Profile Views Chart -->
                        <div class="col-lg-12 m-b30">
                            <div class="widget-box">
                                <div class="wc-title">
                                    <h4>Edit material</h4>
                                </div>

                                <div class="widget-inner">
                                    <form class="edit-profile m-b30" action="addelective" method="post">
                                        <input type="text" name="addtype" value="4" hidden="">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="ml-auto">
                                                    <h3>1. Basic info</h3>
                                                </div>
                                            </div>
                                            <div class="form-group col-4">
                                                <label class="col-form-label">MaterialDescription</label>
                                                <div>
                                                    <input class="form-control" type="text" name="materialDescription">
                                                </div>
                                            </div>
                                            <div class="form-group col-4">
                                                <label class="col-form-label">Author</label>
                                                <div>
                                                    <input class="form-control" type="text" name="author">
                                                </div>
                                            </div>
                                            <div class="form-group col-4">
                                                <label class="col-form-label">Active</label>
                                                <div>
                                                    <div class="form-check-inline">
                                                        <label class="form-check-label" for="radio1" style="color: red">
                                                            <input type="radio" class="form-check-input" name="active" value="1" checked="">Active
                                                        </label>
                                                    </div>
                                                    <div class="form-check-inline">
                                                        <label class="form-check-label" for="radio2" style="color: red">
                                                            <input type="radio" class="form-check-input" name="active" value="0" >unactive
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Publisher</label>
                                                <div>
                                                    <input class="form-control" type="text" name="publisher">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">PublishedDate</label>
                                                <div>
                                                    <input class="form-control" type="text" name="publisheddate" ">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Edition</label>
                                                <div>
                                                    <input class="form-control" type="text" name="edition" >
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">ISBN</label>
                                                <div>
                                                    <input class="form-control" type="text" name="isbn" >
                                                </div>
                                            </div>
                                            <div class="form-group col-4">
                                                <label class="col-form-label">IsMainMaterial</label>
                                                <select class="form-control" name="IsMainMaterial">
                                                    <option value="0">unactive</option>
                                                    <option value="1">Active</option>
                                                </select>
                                            </div>
                                            <div class="form-group col-4">
                                                <label class="col-form-label">IsHardCopy</label>
                                                <select class="form-control" name="IsHardCopy">
                                                    <option value="0">unactive</option>
                                                    <option value="1">Active</option>
                                                </select>
                                            </div>

                                            <div class="form-group col-4">
                                                <label class="col-form-label">IsOnline</label>
                                                <select class="form-control" name="IsOnline">
                                                    <option value="0">unactive</option>
                                                    <option value="1">Active</option>
                                                </select>
                                            </div>
                                            <div class="col-12 m-t20">
                                                <div class="ml-auto m-b5">
                                                    <h3>2. Note</h3>
                                                </div>
                                            </div>
                                            <div class="form-group col-12">
                                                <label class="col-form-label">Note</label>
                                                <div>
                                                    <input class="form-control" type="text" name="note">
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <button type="submit" class="btn-secondry add-item m-r5"><i class="fa fa-fw fa-plus-circle"></i>Add</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                        <!-- Your Profile Views Chart END-->
                    </div>
                </div>
            </c:if>
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
