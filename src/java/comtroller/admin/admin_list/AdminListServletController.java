/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package comtroller.admin.admin_list;

import dal.AccountDAO;
import dal.SyllabusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import module.Account;
import module.Subject;

/**
 *
 * @author tient
 */
public class AdminListServletController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminListServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminListServletController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String adminPage = request.getParameter("adminpage");
        switch (adminPage) {
            case "user":
                getUserList(request, response, 2);
                break;
            case "subject":
                getSubjectList(request, response, 2);
                break;
        }
    }
    
    
    
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String adminPage = request.getParameter("adminpage");
        switch (adminPage) {
            case "user":
                getUserList(request, response, 1);
                break;
            case "subject":
                getSubjectList(request, response, 1);
                break;
        }
    }

    
    
//    PrintWriter out = response.getWriter();
//        String key = request.getParameter("keysearch");
//        String aid = request.getParameter("aid");
//
//        
//        String xpage = request.getParameter("page");
//        out.println("page" + xpage);
//        out.println("key" + key);
//        out.println("aid" + aid);
    
    
    

    public void getSubjectList(HttpServletRequest request, HttpServletResponse response, int type)
            throws ServletException, IOException {
        ArrayList<Subject> listSubject;
        SyllabusDAO sdao = new SyllabusDAO();
        String key = request.getParameter("keysearch");
        String sid = request.getParameter("sid");

        if (sid != null && sid.length() > 0) {
            sdao.changeStatus(Integer.parseInt(sid));
        }

        listSubject = sdao.getListSubject();

        if (key != null && key.length() > 0) {
            listSubject = sdao.getListSubjectByKey(key);
        }

        int page, numberPerPage = 6;
        String xpage = request.getParameter("page");
        int size;
        if (listSubject.isEmpty()) {
            size = 0;
        } else {
            size = listSubject.size();
        }

        int numberOfPage = ((size % numberPerPage == 0) ? (size / numberPerPage) : (size / numberPerPage + 1));
        if (xpage == null || xpage.length() == 0) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start, end;
        start = (page - 1) * numberPerPage;
        end = Math.min(page * numberPerPage, size);

        ArrayList<Subject> listByPage = sdao.getListByPageSubject(listSubject, start, end);
        if (type == 1) {
            showSubjectList(request, response, listByPage, page, numberOfPage);
        } else if (type == 2) {
            request.setAttribute("page", page);
            request.setAttribute("totalPage", numberOfPage);
            request.setAttribute("listSubject", listByPage);
            request.getRequestDispatcher("../view/admin/subject/subject-list.jsp").forward(request, response);
        }
    }

    public void getUserList(HttpServletRequest request, HttpServletResponse response, int type)
            throws ServletException, IOException {
        ArrayList<Account> listUser;
        AccountDAO adao = new AccountDAO();
        PrintWriter out = response.getWriter();
        String key = request.getParameter("keysearch");
        String aid = request.getParameter("aid");

        if (aid != null && aid.length() > 0) {
            adao.changeStatus(Integer.parseInt(aid));
        }

        listUser = adao.getAllAccount();

        if (key != null && key.length() > 0) {
            listUser = adao.getListAccountByKey(key);
        }

        int page, numberPerPage = 6;
        String xpage = request.getParameter("page");
        int size;
        if (listUser.isEmpty()) {
            size = 0;
        } else {
            size = listUser.size();
        }

        int numberOfPage = ((size % numberPerPage == 0) ? (size / numberPerPage) : (size / numberPerPage + 1));
        if (xpage == null || xpage.length() == 0) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start, end;
        start = (page - 1) * numberPerPage;
        end = Math.min(page * numberPerPage, size);

        ArrayList<Account> listByPage = adao.getListByPage(listUser, start, end);
        if (type == 1) {
            showUserList(request, response, listByPage, page, numberOfPage);
        } else if (type == 2) {
            request.setAttribute("page", page);
            request.setAttribute("totalPage", numberOfPage);
            request.setAttribute("listUser", listByPage);
            request.getRequestDispatcher("../view/admin/user/user-list.jsp").forward(request, response);
        }
    }

    public void showSubjectList(HttpServletRequest request, HttpServletResponse response, ArrayList<Subject> listSubject, int page, int totalPage)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("<table class=\"table text-center\">\n"
                + "                                        <thead class=\"thead-orange\">\n"
                + "                                        <th>#</th>\n"
                + "                                        <th>Subject Code</th>\n"
                + "                                        <th>Subject Name</th>\n"
                + "                                        <th>Semester</th>\n"
                + "                                        <th>NoCredit</th>\n"
                + "                                        <th>Status</th>\n"
                + "                                        <th>Action</th>\n"
                + "                                        </thead>\n"
                + "                                        <tbody>");
        for (Subject s : listSubject) {
            out.print("<tr>\n"
                    + "                                                    <td>" + s.getSubjectID() + "</td>\n"
                    + "                                                    <td>" + s.getSubjectCode() + "</td>\n"
                    + "                                                    <td>" + s.getSubjectName() + "</td>\n"
                    + "                                                    <td>" + s.getSemester() + "</td>\n"
                    + "                                                    <td>" + s.getNoCredit() + "</td>\n");
            if (s.isIsActive()) {
                out.print("<td>Active</td>\n");
            } else {
                out.print("<td>Inactive</td>\n");
            }
            out.print("<td>\n"
                    + "                                                        <button id=\"aid\" class=\"btn bg-white\" onclick=\"processSubjectList(" + page + ", this.value)\" value=\"" + s.getSubjectID() + "\">\n");
            if (s.isIsActive()) {
                out.print("<i class=\"ti ti-check font-weight-bold\" style=\"color: green\"></i>\n");
            } else {
                out.print("<i class=\"ti ti-close font-weight-bold\" style=\"color: red\"></i>\n");
            }
            out.print("</button>\n"
                    + "                                                    </td>\n"
                    + "                                                </tr>");

        }
        String str = "</tbody>\n"
                + "                                    </table>\n"
                + "                                    <div style=\"float: right\">\n"
                + "                                        <ul class=\"pagination\">\n";
        if (page == 1) {
            str += "<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Previous</a></li>";
        } else {
            str += "<li class=\"page-item\"><a onclick=\"processSubjectList(" + (page - 1) + ", false)\" class=\"page-link\">Previous</a></li>";
        }

        str += "<li class=\"page-item\"><a id=\"page\" class=\"page-link\">" + page + "</a></li>";

        if (page == totalPage) {
            str += "<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Next</a></li>";
        } else {
            str += "<li class=\"page-item\"><a onclick=\"processSubjectList(" + (page + 1) + ", false)\" class=\"page-link\">Next</a></li>";
        }
        str += "</ul>\n"
                + "                 </div>";
        out.print(str);
    }

    public void showUserList(HttpServletRequest request, HttpServletResponse response, ArrayList<Account> listUser, int page, int totalPage)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.print("<table class=\"table text-center\">\n"
                + "                                        <thead class=\"thead-orange\">\n"
                + "                                        <th>#</th>\n"
                + "                                        <th>Name</th>\n"
                + "                                        <th>User Name</th>\n"
                + "                                        <th>Email</th>\n"
                + "                                        <th>Role</th>\n"
                + "                                        <th>Status</th>\n"
                + "                                        <th>Action</th>\n"
                + "                                        </thead>\n"
                + "                                        <tbody>");
        for (Account a : listUser) {
            out.print("<tr>\n"
                    + "                                                    <td>" + a.getAccountID() + "</td>\n"
                    + "                                                    <td>" + a.getDisplayName() + "</td>\n"
                    + "                                                    <td>" + a.getUserName() + "</td>\n"
                    + "                                                    <td>" + a.getEmail() + "</td>\n"
                    + "                                                    <td>" + a.getRole().getRoleName() + "</td>\n");
            if (a.isIsActive()) {
                out.print("<td>Active</td>\n");
            } else {
                out.print("<td>Block</td>\n");
            }
            out.print("<td>\n"
                    + "                                                        <button id=\"aid\" class=\"btn bg-white\" onclick=\"processUserList(" + page + ", this.value)\" value=\"" + a.getAccountID() + "\">\n");
            if (a.isIsActive()) {
                out.print("<i class=\"ti ti-check font-weight-bold\" style=\"color: green\"></i>\n");
            } else {
                out.print("<i class=\"ti ti-close font-weight-bold\" style=\"color: red\"></i>\n");
            }
            out.print("</button>\n"
                    + "                                                    </td>\n"
                    + "                                                </tr>");

        }
        String str = "</tbody>\n"
                + "                                    </table>\n"
                + "                                    <div style=\"float: right\">\n"
                + "                                        <ul class=\"pagination\">\n";
        if (page == 1) {
            str += "<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Previous</a></li>";
        } else {
            str += "<li class=\"page-item\"><a onclick=\"processUserList(" + (page - 1) + ", false)\" class=\"page-link\">Previous</a></li>";
        }

        str += "<li class=\"page-item\"><a id=\"page\" class=\"page-link\">" + page + "</a></li>";

        if (page == totalPage) {
            str += "<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Next</a></li>";
        } else {
            str += "<li class=\"page-item\"><a onclick=\"processUserList(" + (page + 1) + ", false)\" class=\"page-link\">Next</a></li>";
        }
        str += "</ul>\n"
                + "                 </div>";
        out.print(str);
    }

    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
