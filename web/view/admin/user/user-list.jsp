<%-- 
    Document   : user-list
    Created on : Feb 19, 2023, 5:14:27 PM
    Author     : tient
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">


    <head>

        <%@include file="../gui/header.jsp" %>

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Left sidebar menu start -->
        <%@include file="../gui/sidebar.jsp" %>
        <!-- Left sidebar menu end -->

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title" style="border-right: none">User List</h4>
                </div>
                <div class="row">	
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="row justify-content-between align-items-center">
                                <div class="wc-title" style="border: none">
                                    <c:if test="${account.roleID == 8}">
                                        <a class="btn mt-3" href="add-details?action=user">ADD</a>
                                    </c:if>
                                </div>
                                <div class="col-sm-2">
                                    <div class="widget courses-search-bx placeani m-0">
                                        <div class="form-group m-0">
                                            <div class="input-"></div>
                                            <label>Role: </label>
                                            <div>
                                                <form action="admin-list" method="get">
                                                    <input type="text" name="adminpage" value="user" hidden="">
                                                    <select class="form-control" name="role" onchange="this.form.submit()">
                                                        <option ${listr.roleID == role?'selected':''} value="0">Select</option>
                                                        <c:forEach items="${listRole}" var="listr">
                                                            <option ${listr.roleID == role?'selected':''} value="${listr.roleID}">${listr.roleName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <div class="widget courses-search-bx placeani m-0">
                                        <div class="form-group m-0">
                                            <div class="input-"></div>
                                            <label>Status: </label>
                                            <div>
                                                <form action="admin-list" method="get">
                                                    <input type="text" name="adminpage" value="user" hidden="">
                                                    <select class="form-control" name="active" onchange="this.form.submit()">
                                                        <option ${active == 'default'?'selected':''} value="default">Select</option>
                                                        <option ${active == 'true'?'selected':''} value="true">Active</option>
                                                        <option ${active == 'false'?'selected':''} value="false">Inactive</option>
                                                    </select>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4 mt-3" style="float: right;">
                                    <div class="widget courses-search-bx placeani m-0">
                                        <div class="form-group m-0">
                                            <div class="input-group">
                                                <label><i class="fa fa-search"></i> Search</label>
                                                <input oninput="processUserList(${page}, false, '${sort}', false)" name="keysearch" id="keyseach" type="text" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${listUser != null}">
                                <div class="widget-inner">
                                    <div  id="list-items">
                                        <table class="table text-center">
                                            <thead class="thead-orange">
                                            <th onclick="processUserList(${page}, false, '${sort != null ? sort eq 'id_up' ? 'id_up' : 'id_down' : 'id_down'}', false)">ID${sort == 'id_up' ?'<i style="font-weight: bold" class="ti ti-arrow-down"></i>':(sort == 'id_down' ?'<i style="font-weight: bold" class="ti ti-arrow-up"></i>':'')}</th>
                                            <th onclick="processUserList(${page}, false, '${sort != null ? sort eq 'name_up' ? 'name_up' : 'name_down' : 'name_down'}', false)">Name${sort == 'name_up' ?'<i style="font-weight: bold" class="ti ti-arrow-down"></i>':(sort == 'name_down' ?'<i style="font-weight: bold" class="ti ti-arrow-up"></i>':'')}</th>
                                            <th onclick="processUserList(${page}, false, '${sort != null ? sort eq 'user_up' ? 'user_up' : 'user_down' : 'user_down'}', false)">User Name${sort == 'user_up' ?'<i style="font-weight: bold" class="ti ti-arrow-down"></i>':(sort == 'user_down' ?'<i style="font-weight: bold" class="ti ti-arrow-up"></i>':'')}</th>
                                            <th onclick="processUserList(${page}, false, '${sort != null ? sort eq 'email_up' ? 'email_up' : 'email_down' : 'email_down'}', false)">Email${sort == 'email_up' ?'<i style="font-weight: bold" class="ti ti-arrow-down"></i>':(sort == 'email_down' ?'<i style="font-weight: bold" class="ti ti-arrow-up"></i>':'')}</th>
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                            </thead>
                                            <tbody>

                                                <c:forEach items="${listUser}" var="list">
                                                    <tr>
                                                        <td>${list.accountID}</td>
                                                        <td>${list.fullName}</td>
                                                        <td>${list.userName}</td>
                                                        <td>${list.email}</td>
                                                        <td>${list.role.roleName}</td>
                                                        <td style="color: ${list.isActive == true?'green':'red'}">${list.isActive != false?'Active':'Block'}</td>
                                                        <c:if test="${account.accountID != list.accountID && account.roleID == 8 && list.roleID < 8}">
                                                            <td>
                                                                <button data-toggle="modal" data-target="#confirmU${list.accountID}" class="btn bg-white" >
                                                                    <i class="ti ${list.isActive == false?'ti-lock':'ti-unlock'} font-weight-bold" style="color: ${list.isActive == false?'red':'green'}"></i>
                                                                </button>
                                                                <button class="btn bg-white">
                                                                    <a href="update-details?action=user&aid=${list.accountID}"><i class="ti ti-pencil-alt" style="color: black"></i></a>
                                                                </button>
                                                            </td>
                                                        </c:if>

                                                        <c:if test="${account.accountID == list.accountID || account.roleID < 8}">
                                                            <td></td>
                                                        </c:if>
                                                    </tr>

                                                <div class="modal fade" id="confirmU${list.accountID}">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h4 class="modal-title text-center">Do you want to change status account ${list.fullName}?</h4>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <span>Account ID: <label>${list.accountID}</label></span><br>
                                                                <span>Email: <label>${list.email}</label></span><br>
                                                                <span>User Name: <label>${list.userName}</label></span>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button onclick="processUserList(${page}, ${list.accountID}, '${sort}', false)" data-dismiss="modal" type="button" class="btn btn-primary" style="background-color: #007bff; color: white">${list.isActive != true?'Active':'Block'}</button>
                                                                <button type="button" class="btn btn-secondary" style="background-color: #6c757d; color: white" data-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <div style="float: right">
                                            <ul class="pagination">
                                                <c:if test="${page == 1}">
                                                    <li class="page-item"><a style="pointer-events: none" class="page-link">Previous</a></li>
                                                    </c:if>
                                                    <c:if test="${page > 1}">
                                                    <li class="page-item"><a onclick="processUserList(${page - 1}, false, '${sort}', true) style ="pointer-events: none" class="page-link">Previous</a></li>
                                                    </c:if>


                                                <li class="page-item"><a id="page" class="page-link">${page}</a></li>

                                                <c:if test="${page == totalPage}">
                                                    <li class="page-item"><a style="pointer-events: none" class="page-link">Next</a></li>
                                                    </c:if>
                                                    <c:if test="${page < totalPage}">
                                                    <li class="page-item"><a onclick="processUserList(${page + 1}, false, '${sort}', true)" class="page-link">Next</a></li>
                                                    </c:if>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${listUser == null}">
                                <h2>Empty search list</h2>
                            </c:if>
                        </div>
                    </div>
                </div>
        </main>


        <script>
            let request;
            function processUserList(page, aid, sort, pageType) {
                let key = document.getElementById("keyseach").value;
                let url = './admin-list?adminpage=user&page=' + page + '&keysearch=' + key + '&pageType=' + pageType;
                if (aid != false) {
                    url += '&aid=' + aid;
                }
                if (sort != null) {
                    url += '&sort=' + sort;
                }
                if (window.XMLHttpRequest) {
                    request = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    request = new ActiveXObject("Microsoft.XMLHTTP");
                }

                try {
                    request.onreadystatechange = getInfo;
                    request.open("POST", url, true);
                    request.send("POST");
                } catch (e) {
                    alert("Unable to connect server");
                }
            }

            function getInfo() {
                if (request.readyState === 4) {
                    var val = request.responseText;
                    document.getElementById("list-items").innerHTML = val;
                }
            }



        </script>
        <%@include file="../gui/footer.jsp" %>

        <!-- External JavaScripts -->

    </body>


</html>