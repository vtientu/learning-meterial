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
import jakarta.servlet.http.HttpSession;
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
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc.getRoleID() < 7) {
            response.sendRedirect("home");
        }
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
                break;
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
            case "syllabus":
                updateSyllabus(request, response);
                break;
        }
    }

    public void updateSyllabus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String syllabusID_raw = request.getParameter("syllabusID");
            String subjectID_raw = request.getParameter("subjectCode");
            String nameEN = request.getParameter("nameEN");
            String nameVN = request.getParameter("nameVN");
            String active_raw = request.getParameter("active");
            String approve_raw = request.getParameter("approve");
            String degreeLevel = request.getParameter("degreeLevel");
            String tool = request.getParameter("tool");
            String scoringScale_raw = request.getParameter("scoringScale");
            String MinAvgMarkToPass_raw = request.getParameter("MinAvgMarkToPass");
            String timeAllocation = request.getParameter("timeAllocation");
            String description = request.getParameter("description");
            String studentTask = request.getParameter("studentTask");
            String note = request.getParameter("note");
            String[] prerequisite = request.getParameterValues("preRequisite");
            int syllabusID = Integer.parseInt(syllabusID_raw);
            boolean active = Boolean.parseBoolean(active_raw);
            boolean approve = Boolean.parseBoolean(approve_raw);
            int subjectID = Integer.parseInt(subjectID_raw);
            int scoringScale = Integer.parseInt(scoringScale_raw);
            int MinAvgMarkToPass = Integer.parseInt(MinAvgMarkToPass_raw);

            HttpSession session = request.getSession();
            SyllabusDAO sdao = new SyllabusDAO();

            Syllabus s = sdao.getSyllabusByID(syllabusID);
            s.setSyllabusID(syllabusID);
            s.getSubject().setSubjectID(subjectID);

            if (nameEN != null) {
                s.setSyllabusNameEN(nameEN);
            }

            if (nameVN != null) {
                s.setSyllabusNameVN(nameVN);
            }

            if (active_raw != null) {
                s.setIsActive(active);
            }

            if (approve_raw != null) {
                s.setIsApproved(approve);
            }

            if (degreeLevel != null) {
                s.setDegreeLevel(degreeLevel);
            }

            if (tool != null) {
                s.setTools(tool);
            }

            if (scoringScale_raw != null) {
                s.setScoringScale(scoringScale);
            }

            if (MinAvgMarkToPass_raw != null) {
                s.setMinAvgMarkToPass(MinAvgMarkToPass);
            }

            if (timeAllocation != null) {
                s.setTimeAllocation(timeAllocation);
            }

            if (description != null) {
                s.setDescription(description);
            }

            if (studentTask != null) {
                s.setStudentTasks(studentTask);
            }

            if (note != null) {
                s.setNote(note);
            }
            if (sdao.updateSyllabus(s, prerequisite)) {
                session.setAttribute("message", "Update syllabus successful!");
                session.setAttribute("color", "green");
            } else {
                session.setAttribute("message", "Update syllabus fail!");
                session.setAttribute("color", "red");
            }
            response.sendRedirect("admin-list?adminpage=syllabus");
        } catch (IOException | NumberFormatException e) {
            System.out.println(e);
        }
    }

    public void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO adao = new AccountDAO();
        String username = request.getParameter("username");
        int aid = Integer.parseInt(request.getParameter("aid"));
        String fullName = request.getParameter("fullName");
        int roleId = Integer.parseInt(request.getParameter("role"));
        Account a = new Account();
        a.setUserName(username);
        a.setAccountID(aid);
        a.setRoleID(roleId);
        a.setFullName(fullName);
        HttpSession session = request.getSession();
        if (adao.updateUser(a)) {
            session.setAttribute("message", "Update user successful!");
            session.setAttribute("color", "green");
        } else {
            session.setAttribute("message", "Update user fail!");
            session.setAttribute("color", "red");
        }
        response.sendRedirect("admin-list?adminpage=user");
    }

    public void updateSubject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SyllabusDAO sdao = new SyllabusDAO();
            String sid_raw = request.getParameter("sid");
            int id = 0;
            id = Integer.parseInt(sid_raw);
            String subjectCode = request.getParameter("subjectCode");
            String subjectName = request.getParameter("subjectName");
            int semester = Integer.parseInt(request.getParameter("semester"));
            int noCredit = Integer.parseInt(request.getParameter("noCredit"));
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
            Subject s = sdao.getSubject(id);

            HttpSession session = request.getSession();

            session.setAttribute("message", "Update Subject successful!");
            session.setAttribute("color", "green");

            if (!s.getSubjectCode().equals(subjectCode)) {
                if (sdao.checkSubjectCode(subjectCode)) {
                    session.setAttribute("message", "Update Fail! Subject Code already exist");
                    session.setAttribute("color", "red");
                    response.sendRedirect("admin-list?adminpage=subject");
                }
            }

            if (!s.getSubjectName().equals(subjectName)) {
                if (sdao.checkSubjectName(subjectName)) {
                    session.setAttribute("message", "Update Fail! Subject Name already exist");
                    session.setAttribute("color", "red");
                    response.sendRedirect("admin-list?adminpage=subject");
                }
            }

            if (!s.getSubjectCode().equals(subjectCode) && !s.getSubjectName().equals(subjectName)) {
                if (sdao.checkSubjectCode(subjectCode) && sdao.checkSubjectName(subjectName)) {
                    session.setAttribute("message", "Update Fail! Subject Code and Subject Name already exist");
                    session.setAttribute("color", "red");
                    response.sendRedirect("admin-list?adminpage=subject");
                }
            }

            s.setSubjectCode(subjectCode);
            s.setSubjectName(subjectName);
            s.setSemester(semester);
            s.setNoCredit(noCredit);
            s.setIsActive(isActive);
            sdao.updateSubject(s);

            response.sendRedirect("admin-list?adminpage=subject");

        } catch (IOException | NumberFormatException e) {
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
