/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.admin_list;

import dal.AccountDAO;
import dal.SyllabusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import module.Account;
import module.Question;
import module.Role;
import module.Subject;
import module.Syllabus;

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
            case "syllabus":
                getSyllabusList(request, response, 2);
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
            case "syllabus":
                getSyllabusList(request, response, 1);
                break;
        }
    }

    public void getSyllabusList(HttpServletRequest request, HttpServletResponse response, int type)
            throws ServletException, IOException {
        String key = request.getParameter("keysearch");
        SyllabusDAO ld = new SyllabusDAO();
        ArrayList<Syllabus> list = ld.getAllSyllabus(2);
        if (key != null) {
            list = ld.getListSyllabusByKey(key, 2);
        }
        int page, numberPerPage = 10;
        String xpage = request.getParameter("page");
        int size;
        if (list.isEmpty()) {
            size = 0;
        } else {
            size = list.size();
        }

        int numberOfPage = ((size % numberPerPage == 0) ? (size / numberPerPage) : (size / numberPerPage + 1));
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start, end;
        start = (page - 1) * numberPerPage;
        end = Math.min(page * numberPerPage, size);
        ArrayList<Syllabus> listByPage = ld.getListByPage(list, start, end);
        if (type == 2) {
            request.setAttribute("totalPage", numberOfPage);
            request.setAttribute("page", page);
            request.setAttribute("listSyllabus", listByPage);
            request.getRequestDispatcher("../view/admin/syllabus/syllabus-list.jsp").forward(request, response);
        } else {
            processSyllabus(request, response, listByPage, page, numberOfPage, key);
        }
    }

    public void processSyllabus(HttpServletRequest request, HttpServletResponse response, ArrayList<Syllabus> listByPage, int page, int numberOfPage, String key)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        PrintWriter out = response.getWriter();
        out.println("<table class=\"table\">\n"
                + "                                    <thead>\n"
                + "                                    <th>ID</th>\n"
                + "                                    <th width=\"15%\">Subject Code</th>\n"
                + "                                    <th>Subject Name</th>\n"
                + "                                    <th>Syllabus Name</th>\n"
                + "                                    <th>IsActive</th>\n"
                + "                                    <th>IsApproved</th>\n"
                + "                                    <th>DecisionNo<br/>MM/dd/yyyy</th>\n"
                + "                                    <th>Action</th>\n"
                + "                                    </thead>\n"
                + "                                    <tbody>");
        for (Syllabus o : listByPage) {
            out.println("               <tr>\n"
                    + "                                            <td>" + o.getSyllabusID() + "</td>\n"
                    + "                                            <td>" + o.getSubject().getSubjectCode() + "</td>\n"
                    + "                                            <td>" + o.getSubject().getSubjectName() + "</td>\n"
                    + "                                            <td>" + o.getSyllabusNameEN() + "</td>\n"
                    + "                                            <td class=\"text-center\"><i  style=\"color: " + (o.isIsActive() == true ? "green" : "red") + "\" class=\"fa " + (o.isIsActive() == true ? "fa-check" : "fa-close") + "\"/></td>\n"
                    + "                                            <td class=\"text-center\"><i  style=\"color: " + (o.isIsApproved() == true ? "green" : "red") + "\" class=\"fa " + (o.isIsApproved() == true ? "fa-check" : "fa-close") + "\"/></td>\n");
            if (o.getDecisionNo() == null) {
                out.print("                                            <td></td>\n");
            } else {
                out.print("                                            <td>" + o.getDecisionNo() + "</td>\n");
            }
            if (a.getRoleID() >= 7) {
                out.print("                                            <td>\n"
                        + "                                                 <button class=\"btn bg-white\">\n"
                        + "                                                    <a href=\"update-details?action=syllabus&sid=" + o.getSyllabusID() + "\"><i class=\"ti ti-pencil-alt\" style=\"color: black\"></i></a>\n"
                        + "                                                 </button>\n"
                        + "                                             </td>");
            } else {
                System.out.println("<td></td>");
            }
            out.print("                                    </tr>");
        }
        String str = "</tbody>\n"
                + "                            </table>\n"
                + "\n"
                + "\n"
                + "                            <div style=\"float: right\">\n"
                + "                                    <ul class=\"pagination\">\n";
        if (page == 1) {
            str += "<li class=\"page-item\"><a class=\"page-link\" style=\"pointer-events: none\">Previous</a></li>\n";
        } else {
            str += "<li class=\"page-item\"><a class=\"page-link\" onclick=\"processSyllabusList(" + (page - 1) + ")\">Previous</a></li>\n";
        }

        str += "<li class=\"page-item\"><a id=\"page\" class=\"page-link\">" + page + "</a></li>\n";
        if (page == numberOfPage) {
            str += "<li class=\"page-item\"><a class=\"page-link\" style=\"pointer-events: none\">Next</a></li>\n";
        } else if (page < numberOfPage) {
            str += "<li class=\"page-item\"><a class=\"page-link\" onclick=\"processSyllabusList(" + (page + 1) + ")\">Next</a></li>\n";
        }
        str += "                                    </ul>\n"
                + "                                </div>\n"
                + "                        </div>";
        out.println(str);
    }

    public void getSubjectList(HttpServletRequest request, HttpServletResponse response, int type)
            throws ServletException, IOException {
        ArrayList<Subject> listSubject;
        SyllabusDAO sdao = new SyllabusDAO();
        String key = request.getParameter("keysearch");
        listSubject = sdao.getListSubject();

        if (key != null && key.length() > 0) {
            listSubject = sdao.getListSubjectByKey(key);
        }

        int page, numberPerPage = 8;
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
        String key = request.getParameter("keysearch");
        listUser = adao.getAllAccount();
        if (key != null && key.length() > 0) {
            listUser = adao.getListAccountByKey(key);
        }

        int page, numberPerPage = 8;
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
            request.setAttribute("listRole", adao.getRoleList());
            request.getRequestDispatcher("../view/admin/user/user-list.jsp").forward(request, response);
        }
    }

    public void showSubjectList(HttpServletRequest request, HttpServletResponse response, ArrayList<Subject> listSubject, int page, int totalPage)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
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
                out.print("<td style=\"color: green\">Active</td>\n");
            } else {
                out.print("<td style=\"color: red\">Inactive</td>\n");
            }
            if (account.getRoleID() == 8) {
                out.print("<td>"
                        + "<button class=\"btn bg-white\">\n"
                        + "                                                                <a href=\"update-details?action=subject&sid=" + s.getSubjectID() + "\"><i class=\"ti ti ti-pencil-alt font-weight-bold\" style=\"color: black; background-color: gainsboro\"></i></a>\n"
                        + "                                                            </button>"
                        + "</td>\n");
            } else {
                out.print("<td></td>");
            }
            out.print("                                                </tr>");

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
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        AccountDAO adao = new AccountDAO();
        ArrayList<Role> listRole = adao.getRoleList();
        out.print("<table class=\"table text-center\">\n"
                + "  <thead class=\"thead-orange\">\n"
                + "    <th>#</th>\n"
                + "    <th>Name</th>\n"
                + "    <th>User Name</th>\n"
                + "    <th>Email</th>\n"
                + "    <th>Role</th>\n"
                + "    <th>Status</th>\n"
                + "    <th>Action</th>\n"
                + "  </thead>\n"
                + "  <tbody>");

        for (Account a : listUser) {
            out.print("<tr>\n"
                    + "  <td>" + a.getAccountID() + "</td>\n"
                    + "  <td>" + a.getDisplayName() + "</td>\n"
                    + "  <td>" + a.getUserName() + "</td>\n"
                    + "  <td>" + a.getEmail() + "</td>\n"
                    + "  <td>" + a.getRole().getRoleName() + "</td>\n");

            if (a.isIsActive()) {
                out.print("  <td>Active</td>\n");
            } else {
                out.print("  <td>Block</td>\n");
            }

            if (account.getAccountID() != a.getAccountID() && account.getRoleID() == 8 && a.getRoleID() < 8) {
                out.print("  <td>\n"
                        + "    <button data-toggle=\"modal\" data-target=\"#confirmU" + a.getAccountID() + "\" class=\"btn bg-white\">\n");

                if (a.isIsActive()) {
                    out.print("      <i class=\"ti ti-unlock font-weight-bold\" style=\"color: green\"></i>\n");
                } else {
                    out.print("      <i class=\"ti ti-lock font-weight-bold\" style=\"color: red\"></i>\n");
                }

                out.print("    </button>\n"
                        + "    <button class=\"btn bg-white\"\">\n"
                        + "      <a href=\"update-details?action=user&aid=" + a.getAccountID() + "\"><i class=\"ti ti-pencil-alt\" style=\"color: black\"></i></a>"
                        + "    </button>"
                        + "  </td>\n");
            } else {
                out.print("  <td></td>");
            }

            out.print("</tr>");

            out.print("<div class=\"modal page\" id=\"confirmU" + a.getAccountID() + "\">\n"
                    + "                                                <div class=\"modal-dialog\" role=\"document\">\n"
                    + "                                                    <div class=\"modal-content\">\n"
                    + "                                                        <div class=\"modal-header\">\n"
                    + "                                                            <h4 class=\"modal-title text-center\">Do you want to change status account " + a.getDisplayName() + "?</h4>\n"
                    + "                                                            <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\n"
                    + "                                                                <span aria-hidden=\"true\">&times;</span>\n"
                    + "                                                            </button>\n"
                    + "                                                        </div>\n"
                    + "                                                        <div class=\"modal-body\">\n"
                    + "                                                            <span>Account ID: <label>" + a.getAccountID() + "</label></span><br>\n"
                    + "                                                            <span>Email: <label>" + a.getEmail() + "</label></span><br>\n"
                    + "                                                            <span>User Name: <label>" + a.getUserName() + "</label></span>\n"
                    + "                                                        </div>\n"
                    + "                                                        <div class=\"modal-footer\">\n"
                    + "                                                            <button id=\"aid\" onclick=\"processUserList(" + page + ", this.value)\" value=\"" + a.getAccountID() + "\"  data-dismiss=\"modal\" type=\"button\" class=\"btn btn-primary\" style=\"background-color: #007bff; color: white\">");
            if (a.isIsActive()) {
                out.print("Block");
            } else {
                out.print("Active");
            }
            out.print("</button>\n"
                    + "                                                            <button type=\"button\" class=\"btn btn-secondary\" style=\"background-color: #6c757d; color: white\" data-dismiss=\"modal\">Close</button>\n"
                    + "                                                        </div>\n"
                    + "                                                    </div>\n"
                    + "                                                </div>\n"
                    + "                                            </div>");

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
