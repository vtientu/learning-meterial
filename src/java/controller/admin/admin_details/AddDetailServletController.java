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
import module.Subject;
import module.Syllabus;

/**
 *
 * @author tient
 */
public class AddDetailServletController extends HttpServlet {

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
            out.println("<title>Servlet AddUserServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddUserServletController at " + request.getContextPath() + "</h1>");
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
                request.setAttribute("listRole", adao.getRoleList());
                request.getRequestDispatcher("../view/admin/user/create-user.jsp").forward(request, response);
                break;
            case "subject":
                request.getRequestDispatcher("../view/admin/subject/create-subject.jsp").forward(request, response);
                break;
            case "syllabus":
                ArrayList<Subject> listSubject = sdao.getListSubjectAll();
                ArrayList<Decision> listDecision = (ArrayList<Decision>) ddao.getAllDecision();
                request.setAttribute("listSubject", listSubject);
                request.setAttribute("listDecision", listDecision);
                request.getRequestDispatcher("../view/admin/syllabus/create-syllabus.jsp").forward(request, response);
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
                addUser(request, response);
                break;
            case "subject":
                addSubject(request, response);
                break;
            case "syllabus":
                addSyllabus(request, response);
                break;
        }
    }

    public void addSyllabus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Account a = (Account) session.getAttribute("account");
            String subjectID_raw = request.getParameter("subjectCode");
            String nameEN = request.getParameter("nameEN");
            String nameVN = request.getParameter("nameVN");
            String active_raw = request.getParameter("active");
            String approve_raw = request.getParameter("approve");
            String degreeLevel = request.getParameter("degreeLevel");
            String tool = request.getParameter("tool");
            String scoringScale_raw = request.getParameter("scoringScale");
            String MinAvgMarkToPass_raw = request.getParameter("minAvgMarkToPass");
            String timeAllocation = request.getParameter("timeAllocation");
            String description = request.getParameter("description");
            String studentTask = request.getParameter("studentTask");
            String note = request.getParameter("note");
            String[] prerequisite = request.getParameterValues("preRequisite");
            int subjectID = Integer.parseInt(subjectID_raw);
            boolean active = false;
            boolean approve = false;

            if (active_raw == null || approve_raw == null || nameEN == null) {
                session.setAttribute("message", "The information has not been filled in completely!");
                session.setAttribute("color", "red");
                response.sendRedirect("admin-list?adminpage=syllabus");
            }

            if (a.getRoleID() >= 7) {
                active = Boolean.parseBoolean(active_raw);
                approve = Boolean.parseBoolean(approve_raw);
            }
            
            int scoringScale = 0;
            
            if (scoringScale_raw != null && scoringScale_raw.length() > 0) {
                scoringScale = Integer.parseInt(scoringScale_raw);
            }

            int MinAvgMarkToPass = 0;
            if (MinAvgMarkToPass_raw != null && MinAvgMarkToPass_raw.length() > 0) {
                MinAvgMarkToPass = Integer.parseInt(MinAvgMarkToPass_raw);
            }

            SyllabusDAO sdao = new SyllabusDAO();

            Syllabus s = new Syllabus();
            Subject subject = new Subject();
            subject.setSubjectID(subjectID);

            s.setAccount(a);
            s.setSubject(subject);

            if (nameEN != null) {
                s.setSyllabusNameEN(nameEN);
            }

            if (nameVN != null) {
                s.setSyllabusNameVN(nameVN);
            }

            if (degreeLevel != null) {
                s.setDegreeLevel(degreeLevel);
            }

            if (tool != null) {
                s.setTools(tool);
            }

            if (scoringScale_raw != null && scoringScale_raw.length() > 0) {
                s.setScoringScale(scoringScale);
            }

            if (MinAvgMarkToPass_raw != null && MinAvgMarkToPass_raw.length() > 0) {
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

            if (active_raw != null) {
                s.setIsActive(active);
            }

            if (approve_raw != null) {
                s.setIsApproved(approve);
            }

            if (note != null) {
                s.setNote(note);
            }

//            PrintWriter out = response.getWriter();
            if (sdao.createSyllabus(s, prerequisite)) {
                session.setAttribute("message", "Create syllabus successful!");
                session.setAttribute("color", "green");
            } else {
                session.setAttribute("message", "Create syllabus fail!");
                session.setAttribute("color", "red");
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        response.sendRedirect("admin-list?adminpage=syllabus");

    }

    public void addSubject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String subjectCode = request.getParameter("subjectCode");
        String subjectName = request.getParameter("subjectName");
        int semester = Integer.parseInt(request.getParameter("semester"));
        int noCredit = Integer.parseInt(request.getParameter("noCredit"));
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        SyllabusDAO sdao = new SyllabusDAO();
        if (sdao.checkSubjectCode(subjectCode) || sdao.checkSubjectName(subjectName)) {
            if (sdao.checkSubjectCode(subjectCode)) {
                session.setAttribute("message", "Subject Code already exists! Re-enter Subject Code");
                session.setAttribute("color", "red");
            } else if (sdao.checkSubjectName(subjectName)) {
                session.setAttribute("message", "Subject Name already exists! Re-enter Subject Name");
                session.setAttribute("color", "red");
            }
        } else {
            Subject s = new Subject();
            s.setAccount(a);
            s.setSubjectCode(subjectCode);
            s.setSubjectName(subjectName);
            s.setSemester(semester);
            s.setNoCredit(noCredit);
            sdao.createSubject(s);
            session.setAttribute("message", "Add Subject successful!");
            session.setAttribute("color", "green");
        }
        response.sendRedirect("admin-list?adminpage=subject");

    }

    public void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String user = request.getParameter("userName");
        int roleID = Integer.parseInt(request.getParameter("role"));
        AccountDAO adao = new AccountDAO();
        HttpSession session = request.getSession();
        if (adao.checkEmail(email) || adao.checkUser(user)) {
            if (adao.checkEmail(email)) {
                session.setAttribute("message", "Email already exists!");
                session.setAttribute("color", "red");
            } else if (adao.checkUser(user)) {
                session.setAttribute("message", "User Name already exists!");
                session.setAttribute("color", "red");
            }
        } else {
            String password = adao.getVerifyCode();
            adao.send(email, password);
            Account a = new Account();
            a.setUserName(user);
            a.setFullName(fullName);
            a.setPassword(adao.convertPassToMD5(password));
            a.setEmail(email);
            a.setRoleID(roleID);
            adao.addUser(a);
            session.setAttribute("message", "Add user successful!");
            session.setAttribute("color", "green");
        }
        response.sendRedirect("admin-list?adminpage=user");
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
