<%-- 
    Document   : footer
    Created on : Feb 22, 2023, 1:54:27 PM
    Author     : tient
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <div class="ttr-overlay"></div>
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
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                if (document.getElementById('message').innerHTML !== '') {
                    $('.toast').toast('show');
                }
            });
        </script>
    </body>
</html>
