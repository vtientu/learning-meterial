<%-- 
    Document   : profile
    Created on : Jan 28, 2023, 9:27:46 PM
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



        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <style>
            .avatar-edit {
                position: absolute;
                right: 12px;
                z-index: 1;
                top: 10px;
            }

            .avatar-edit input{
                display: none;
            }

            .avatar-edit label{
                display: inline-block;
                width: 34px;
                height: 34px;
                margin-bottom: 0;
                border-radius: 100%;
                background: #FFFFFF;
                border: 1px solid transparent;
                box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.12);
                cursor: pointer;
                font-weight: normal;
                transition: all .2s ease-in-out;
            }

            .avatar-edit label:hover{
                background: #f1f1f1;
                border-color: #d6d6d6;
            }


            .avatar-preview {
                width: 192px;
                height: 192px;
                position: relative;
                border-radius: 100%;
                border: 6px solid #F8F8F8;
                box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.1);
            }

            .avatar-edit label:after {
                content: "\f040";
                font-family: 'FontAwesome';
                color: #757575;
                position: absolute;
                top: 10px;
                left: 0;
                right: 0;
                text-align: center;
                margin: auto;
            }

            .avatar-preview > div {
                width: 100%;
                height: 100%;
                border-radius: 100%;
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
            }

            .avatar-upload {
                position: relative;
                max-width: 205px;
                margin: 50px auto;

            }
        </style>
    </head>
    <body id="bg">
        <div class="page-wraper">
            <%@include file="../gui/header.jsp" %>
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner.png);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Profile</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li>Profile</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <div class="profile-bx text-center">
                                        <form class="edit-profile" action="profile" method="post" enctype="multipart/form-data">
                                            <div class="avatar-upload">
                                                <div class="avatar-edit">
                                                    <input name="avatar" type='file' id="imageUpload" accept=".png, .jpg, .jpeg" />
                                                    <label for="imageUpload"></label>
                                                </div>
                                                <div class="avatar-preview">
                                                    <div id="imagePreview" style="background-image: url(${account.typeAccount == -1?'images/':''}${account.avatar == null?'profile/pic1.png': account.avatar});">
                                                    </div>
                                                </div>
                                            </div>
                                            <script>
                                                function readURL(input) {
                                                    if (input.files && input.files[0]) {
                                                        var reader = new FileReader();
                                                        reader.onload = function (e) {
                                                            $('#imagePreview').css('background-image', 'url(' + e.target.result + ')');
                                                            $('#imagePreview').hide();
                                                            $('#imagePreview').fadeIn(650);
                                                        }
                                                        reader.readAsDataURL(input.files[0]);
                                                    }
                                                }
                                                $("#imageUpload").change(function () {
                                                    readURL(this);
                                                });
                                            </script>
                                            <div class="profile-info">
                                                <h4>${account.displayName}</h4>
                                                <span>${account.email}</span>
                                            </div>
                                            <div class="profile-tabnav">
                                                <ul class="nav nav-tabs">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" data-toggle="tab" href="#edit-profile"><i class="ti-pencil-alt"></i>Edit Profile</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" data-toggle="tab" href="#change-password"><i class="ti-lock"></i>Change Password</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a href="logout" class="nav-link"><i class="ti-close"></i>Logout</a>
                                                    </li>
                                                </ul>
                                            </div>
                                    </div>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-12 m-b30">
                                    <div class="profile-content-bx">
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="edit-profile">
                                                <div class="profile-head">
                                                    <h3>Edit Profile</h3>
                                                </div>

                                                <div class="">
                                                    <div class="form-group row">
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-10 ml-auto">
                                                            <h3>1. Personal Details</h3>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Name *</label>
                                                        <div class="col-4">
                                                            <input class="form-control" type="text" placeholder="First Name" value="${account.firstName}" name="firstName">
                                                        </div>
                                                        <div class="col-4">
                                                            <input class="form-control" type="text" placeholder="Last Name" value="${account.lastName}" name="lastName">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Gender</label>
                                                        <select class="col-12 col-sm-10 col-md-10 col-lg-8" name="gender">
                                                            <option ${account.gender == -1?'selected':''} value="-1" class="form-control">Select</option>
                                                            <option ${account.gender == 0?'selected':''} value="0" class="form-control">Male</option>
                                                            <option ${account.gender == 1?'selected':''} value="1" class="form-control">Female</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Birth Date</label>
                                                        <div class="col-12 col-sm-10 col-md-10 col-lg-8">
                                                            <input class="form-control" type="date" value="${account.birthday}" name="birthday">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Email *</label>
                                                        <div class="col-12 col-sm-10 col-md-10 col-lg-8">
                                                            <input class="form-control" type="email" placeholder="Email" value="${account.email}" disabled="">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Phone No.</label>
                                                        <div class="col-12 col-sm-10 col-md-10 col-lg-8">
                                                            <input class="form-control" type="text" placeholder="Phone Number" value="${account.phone}" name="phone">
                                                        </div>
                                                    </div>

                                                    <div class="seperator"></div>

                                                    <div class="form-group row">
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-10 ml-auto">
                                                            <h3>2. Address</h3>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Address</label>
                                                        <div class="col-12 col-sm-10 col-md-10 col-lg-8">
                                                            <input class="form-control" type="text" placeholder="Address" value="${account.address}" name="address">
                                                        </div>
                                                    </div>

                                                    <div class="m-form__seperator m-form__seperator--dashed m-form__seperator--space-2x"></div>


                                                </div>
                                                <div class="">
                                                    <div class="">
                                                        <div class="row">
                                                            <div class="col-12 col-sm-3 col-md-3 col-lg-2">
                                                            </div>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <button type="submit" class="btn">Save changes</button>
                                                                <button type="reset" class="btn-secondry">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                </form>
                                            </div>
                                            <div class="tab-pane" id="change-password">
                                                <div class="profile-head">
                                                    <h3>Change Password</h3>
                                                </div>
                                                <form class="edit-profile" action="changepassword" method="post">
                                                    <div class="">
                                                        <div class="form-group row">
                                                            <div class="col-12 col-sm-8 col-md-8 col-lg-9 ml-auto">
                                                                <h3>Password</h3>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-4 col-md-4 col-lg-3 col-form-label">Current Password</label>
                                                            <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                                <input class="form-control" id = "pswd" type="password" name="cPassword"  onchange="verifyPassword()">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-4 col-md-4 col-lg-3 col-form-label">New Password</label>
                                                            <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                                <input class="form-control" type="password" id = "npswd" onchange="verifyPassword()" name="nPassword">
                                                                <small>Password must be between 8 and 15 characters!</small>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-4 col-md-4 col-lg-3 col-form-label">Re Type New Password</label>
                                                            <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                                <input class="form-control" type="password" id = "rpswd" onchange="verifyPassword()" name="rPassword">
                                                            </div>
                                                        </div>
                                                        <span id = "message" style="color:red"> </span> <br><br>  
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-12 col-sm-4 col-md-4 col-lg-3">
                                                        </div>
                                                        <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                            <button id="save" type="submit" class="btn" disabled="">Save changes</button>
                                                            <button type="reset" class="btn-secondry">Cancel</button>
                                                        </div>
                                                    </div>
                                                </form>
                                                <input type="text" id="apw" hidden="" value="${account.password}">
                                                <script>
                                                    function verifyPassword() {
                                                        var apw = document.getElementById("apw").value;
                                                        var pw = document.getElementById("pswd").value;
                                                        var npw = document.getElementById("npswd").value;
                                                        var rpw = document.getElementById("rpswd").value;
                                                        if (pw !== apw) {
                                                            document.getElementById("message").innerHTML = "Password incorrect!";
                                                            document.getElementById("save").disabled = true;
                                                        } else {
                                                            document.getElementById("message").innerHTML = "";
                                                            if (npw.length >= 8 && npw.length <= 15 && rpw.length >= 8 && rpw.length <= 15) {
                                                                if (npw === rpw) {
                                                                    document.getElementById("message").innerHTML = "";
                                                                    document.getElementById("save").disabled = false;
                                                                } else {
                                                                    document.getElementById("save").disabled = true;
                                                                    document.getElementById("message").innerHTML = "New Password and password confirm are not the same!";
                                                                }
                                                            }
                                                        }
                                                    }
                                                </script>  
                                            </div>
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
            <button class="back-to-top fa fa-chevron-up" ></button>
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
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
    </body>

</html>

