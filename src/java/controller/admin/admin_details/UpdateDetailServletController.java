/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.admin_details;

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
import module.Role;
import module.Subject;

/**
 *
 * @author tient
 */
public class UpdateDetailServletController extends HttpServlet {

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
            out.println("<title>Servlet UpdateUserServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUserServletController at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        AccountDAO adao = new AccountDAO();
        SyllabusDAO sdao = new SyllabusDAO();
        switch (action) {
            case "user":
                int aid = Integer.parseInt(request.getParameter("aid"));
                Account a = adao.getAccount(aid);
                ArrayList<Role> listRole = adao.getRoleList();
                request.setAttribute("user", a);
                request.setAttribute("listRole", listRole);
                request.getRequestDispatcher("../view/admin/user/update-user.jsp").forward(request, response);
                break;
            case "subject":
                int sid = Integer.parseInt(request.getParameter("sid"));
                Subject s = sdao.getSubject(sid);
                request.setAttribute("subject", s);
                request.getRequestDispatcher("../view/admin/subject/update-subject.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        AccountDAO adao = new AccountDAO();
        SyllabusDAO sdao = new SyllabusDAO();
        switch (action) {
            case "user":
                int aid = Integer.parseInt(request.getParameter("aid"));
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                int roleId = Integer.parseInt(request.getParameter("role"));
                Account a = new Account();
                a.setAccountID(aid);
                a.setRoleID(roleId);
                a.setFirstName(firstName);
                a.setLastName(lastName);
                adao.updateUser(a);
                response.sendRedirect("update-details?action=user&aid=" + aid);
                break;
            case "subject":
                int sid = Integer.parseInt(request.getParameter("sid"));
                String subjectCode = request.getParameter("subjectCode");
                String subjectName = request.getParameter("subjectName");
                int semester = Integer.parseInt(request.getParameter("semester"));
                int noCredit = Integer.parseInt(request.getParameter("noCredit"));
                boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
                Subject scheck = sdao.getSubject(sid);

                if (!scheck.getSubjectCode().equals(subjectCode)) {
                    if (sdao.checkSubjectCode(subjectCode)) {
                        request.setAttribute("message", "Subject Code already exists! Re-enter Subject Code");
                        request.getRequestDispatcher("update-details?action=subject&sid=" + sid).forward(request, response);
                    }
                }

                if (!scheck.getSubjectName().equals(subjectName)) {
                    if (sdao.checkSubjectName(subjectName)) {
                        request.setAttribute("message", "Subject Name already exists! Re-enter Subject Name");
                        request.getRequestDispatcher("update-details?action=subject&sid=" + sid).forward(request, response);
                    }
                }

                Subject s = new Subject();
                s.setSubjectCode(subjectCode);
                s.setSubjectName(subjectName);
                s.setSemester(semester);
                s.setNoCredit(noCredit);
                s.setIsActive(isActive);
                sdao.updateSubject(s);
                request.setAttribute("message", "Add Subject successful!");
                request.getRequestDispatcher("update-details?action=subject&sid=" + sid).forward(request, response);
                break;
        }
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
