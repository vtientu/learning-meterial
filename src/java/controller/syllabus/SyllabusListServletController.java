/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.syllabus;

import dal.DecisionDAO;
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
import module.Decision;
import module.Syllabus;

/**
 *
 * @author tient
 */
public class SyllabusListServletController extends HttpServlet {

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
            out.println("<title>Servlet SyllabusListServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SyllabusListServletController at " + request.getContextPath() + "</h1>");
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
        SyllabusDAO ld = new SyllabusDAO();
        ArrayList<Syllabus> list = ld.getAllSyllabus(1);
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        if (a != null && a.getRoleID() != 1) {
            list = ld.getAllSyllabus(a.getRoleID());
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
        end = Math.min(page * numberPerPage, size - 1);
        ArrayList<Syllabus> listByPage = ld.getListByPage(list, start, end);
        request.setAttribute("totalPage", numberOfPage);
        request.setAttribute("page", page);
        request.setAttribute("listSyllabus", listByPage);
        request.getRequestDispatcher("view/common/syllabus/syllabus-list.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        String key = request.getParameter("keysearch");
        SyllabusDAO sd = new SyllabusDAO();
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        ArrayList<Syllabus> list = sd.getAllSyllabus(1);
        if (key != null) {
            list = sd.getListSyllabusByKey(key, 1);
        }
        if (acc != null && acc.getRoleID() != 1) {
            list = sd.getAllSyllabus(acc.getRoleID());
            if (key != null) {
                list = sd.getListSyllabusByKey(key, acc.getRoleID());
            }
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
        ArrayList<Syllabus> listByPage = sd.getListByPage(list, start, end);
        processSyllabus(request, response, listByPage, page, numberOfPage, key);
    }


    public void processSyllabus(HttpServletRequest request, HttpServletResponse response, ArrayList<Syllabus> listByPage, int page, int numberOfPage, String key)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("<table class=\"table text-center\">\n"
                + "                                    <thead class=\"thead-orange\">\n"
                + "                                    <th>Syllabus ID</th>\n"
                + "                                    <th>Subject Code</th>\n"
                + "                                    <th>Subject Name</th>\n"
                + "                                    <th>Syllabus Name</th>\n"
                + "                                    <th>IsActive</th>\n"
                + "                                    <th>IsApproved</th>\n"
                + "                                    <th>DecisionNo<br/>MM/dd/yyyy</th>\n"
                + "                                    </thead>\n"
                + "                                    <tbody>");
        for (Syllabus o : listByPage) {
            out.println("               <tr>\n"
                    + "                                            <td>" + o.getSyllabusID() + "</td>\n"
                    + "                                            <td>" + o.getSubjectCode() + "</td>\n"
                    + "                                            <td>" + o.getSubject().getSubjectName() + "</td>\n"
                    + "                                            <td><a style=\"color: blue;\" href=\"syllabus-details?syID=" + o.getSubjectCode() + "\">" + o.getSyllabusNameEN() + "</a></td>\n"
                    + "                                            <td><i  style=\"color: " + (o.isIsActive() == true ? "green" : "red") + "\" class=\"fa " + (o.isIsActive() == true ? "fa-check" : "fa-close") + "\"/></td>\n"
                    + "                                            <td><i  style=\"color: " + (o.isIsApproved() == true ? "green" : "red") + "\" class=\"fa " + (o.isIsApproved() == true ? "fa-check" : "fa-close") + "\"/></td>\n"
                    + "                                            <td><a style=\"cursor: pointer; color: blue\" data-target=\"#decision" + o.getSyllabusID() + "\" data-toggle=\"modal\" \">" + o.getDecisionNo() + "</a></td>\n"
                    + "                                    <div id=\"decision" + o.getSyllabusID() + "\" class=\" mt-5 modal fade\" tabindex=\"-1\" role=\"dialog\" aria-hidden=\"true\">\n"
                    + "                                        <div class=\"modal-dialog modal-lg\" >\n"
                    + "                                            <div class=\"modal-content\">\n"
                    + "                                                <div class=\"modal-header\">\n"
                    + "                                                    <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>\n"
                    + "                                                </div>\n"
                    + "                                                <div class=\"modal-body\">\n"
                    + "                                                    <div class=\"row\">\n"
                    + "                                                        <label class=\"col-2\">DecisionNo</label><p class=\"col-10\">" + o.getDecisionNo() + "</p>\n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"row\">\n"
                    + "                                                        <label class=\"col-2\">DecisionName</label><p class=\"col-10\">" + o.getDecision().getDecisionName() + "</p>\n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"row\">\n"
                    + "                                                        <label class=\"col-2\">ApprovedDate (MM/dd/yyyy)</label><p class=\"col-10\">" + o.getDecision().getApprovedDateFormat() + "</p>\n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"row\">\n"
                    + "                                                        <label class=\"col-2\">Note</label><p class=\"col-10\">" + o.getDecision().getNote() + "</p>\n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"row\">\n"
                    + "                                                        <label class=\"col-2\">CreateDate (MM/dd/yyyy)</label><p class=\"col-10\">" + o.getDecision().getCreateDateFormat() + "</p>\n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"row\">\n"
                    + "                                                        <label class=\"col-2\">FileName</label><p class=\"col-10\">" + o.getDecision().getFileName() + "</p>\n"
                    + "                                                    </div>\n"
                    + "                                                </div>\n"
                    + "                                                <div class=\"modal-footer\">\n"
                    + "                                                    <div class=\"col-md-12\">\n"
                    + "                                                        <button class=\"btn\" data-dismiss=\"modal\" aria-hidden=\"true\">Cancel</button>\n"
                    + "                                                    </div>	\n"
                    + "                                                </div>\n"
                    + "                                            </div>\n"
                    + "                                        </div>\n"
                    + "                                    </div>\n"
                    + "                                    </tr>");
        }
        String str = "</tbody>\n"
                + "                            </table>\n"
                + "\n"
                + "\n"
                + "                            <div class=\"col-lg-12 m-b20\">\n"
                + "                                <div class=\"pagination-bx rounded-sm gray clearfix\">\n"
                + "                                    <ul class=\"pagination\">\n";
        if (page == 1) {
            str += "<li class=\"previous\"><a style=\"pointer-events: none\"><i class=\"ti-arrow-left\"></i> Prev</a></li>\n";
        } else {
            str += "<li class=\"previous\"><a onclick=\"searchSyllabus(" + (page - 1) + ")\"><i class=\"ti-arrow-left\"></i> Prev</a></li>\n";
        }

        str += "<li class=\"active\"><a id=\"page\">" + page + "</a></li>\n";
        if (page == numberOfPage) {
            str += "<li class=\"next\"><a style=\"pointer-events: none\">Next<i class=\"ti-arrow-right\"></i></a></li>\n";
        } else if (page < numberOfPage) {
            str += "<li class=\"next\"><a onclick=\"searchSyllabus(" + (page + 1) + ")\">Next<i class=\"ti-arrow-right\"></i></a></li>\n";
        }
        str += "                                    </ul>\n"
                + "                                </div>\n"
                + "                            </div>\n"
                + "                        </div>";
        out.println(str);
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
