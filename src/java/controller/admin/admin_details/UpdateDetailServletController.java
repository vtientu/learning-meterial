/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.admin_details;

import dal.AccountDAO;
import dal.DecisionDAO;
import dal.SyllabusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import module.Account;
import module.Decision;
import module.Role;
import module.Subject;
import module.Syllabus;

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
        DecisionDAO ddao = new DecisionDAO();
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
            case "syllabus":
                int syllabusID = Integer.parseInt(request.getParameter("sid"));
                Syllabus syllabus = sdao.getSyllabusByID(syllabusID);
                ArrayList<Subject> listSubject = sdao.getListSubject();
                ArrayList<Decision> listDecision = (ArrayList<Decision>) ddao.getAllDecision();
                request.setAttribute("listSubject", listSubject);
                request.setAttribute("listDecision", listDecision);
                request.setAttribute("syllabus", syllabus);
                request.getRequestDispatcher("../view/admin/syllabus/update-syllabus.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        switch (action) {
            case "user":
                updateUser(request, response);
                break;
            case "subject":
                updateSubject(request, response);
                break;
        }
    }

    public void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO adao = new AccountDAO();
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
    }

    public void updateSubject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SyllabusDAO sdao = new SyllabusDAO();
            int sid = Integer.parseInt(request.getParameter("sid"));
            String subjectCode = request.getParameter("subjectCode");
            String subjectName = request.getParameter("subjectName");
            int semester = Integer.parseInt(request.getParameter("semester"));
            int noCredit = Integer.parseInt(request.getParameter("noCredit"));
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

            Subject s = new Subject();
            s.setSubjectCode(subjectCode);
            s.setSubjectName(subjectName);
            s.setSemester(semester);
            s.setNoCredit(noCredit);
            s.setIsActive(isActive);
            if (!sdao.updateSubject(s)) {
                request.setAttribute("message", "Update Fail! Subject Code or Subject Name already exist");
                request.getRequestDispatcher("update-details?action=subject&sid=" + sid).forward(request, response);
            } else {
                request.setAttribute("message", "Add Subject successful!");
                request.getRequestDispatcher("update-details?action=subject&sid=" + sid).forward(request, response);
            }
        } catch (ServletException | IOException | NumberFormatException e) {
            System.out.println(e);
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
