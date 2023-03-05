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
import module.Account;
import module.Subject;

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
        switch (action) {
            case "user":
                request.setAttribute("listRole", adao.getRoleList());
                request.getRequestDispatcher("../view/admin/user/create-user.jsp").forward(request, response);
                break;
            case "subject":
                request.getRequestDispatcher("../view/admin/subject/create-subject.jsp").forward(request, response);
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
        }
    }

    public void addSubject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String subjectCode = request.getParameter("subjectCode");
        String subjectName = request.getParameter("subjectName");
        int semester = Integer.parseInt(request.getParameter("semester"));
        int noCredit = Integer.parseInt(request.getParameter("noCredit"));

        SyllabusDAO sdao = new SyllabusDAO();
        if (sdao.checkSubjectCode(subjectCode) || sdao.checkSubjectName(subjectName)) {
            if (sdao.checkSubjectCode(subjectCode)) {
                request.setAttribute("message", "Subject Code already exists! Re-enter Subject Code");
                request.getRequestDispatcher("../view/admin/subject/create-subject.jsp").forward(request, response);
            } else if (sdao.checkSubjectName(subjectName)) {
                request.setAttribute("message", "Subject Name already exists! Re-enter Subject Name");
                request.getRequestDispatcher("../view/admin/subject/create-subject.jsp").forward(request, response);
            }
        } else {
            Subject s = new Subject();
            s.setSubjectCode(subjectCode);
            s.setSubjectName(subjectName);
            s.setSemester(semester);
            s.setNoCredit(noCredit);
            sdao.createSubject(s);
            request.setAttribute("message", "Add Subject successful!");
            request.getRequestDispatcher("../view/admin/subject/create-subject.jsp").forward(request, response);
        }

    }

    public void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String user = request.getParameter("userName");
        String password = request.getParameter("password");
        int roleID = Integer.parseInt(request.getParameter("role"));
        AccountDAO adao = new AccountDAO();
        if (adao.checkEmail(email) || adao.checkUser(user)) {
            if (adao.checkEmail(email)) {
                request.setAttribute("message", "Email already exists!");
                request.getRequestDispatcher("../view/admin/user/create-user.jsp").forward(request, response);
            } else if (adao.checkUser(user)) {
                request.setAttribute("message", "User Name already exists!");
                request.getRequestDispatcher("../view/admin/user/create-user.jsp").forward(request, response);
            }
        } else {
            Account a = new Account();
            a.setUserName(user);
            a.setFirstName(firstName);
            a.setLastName(lastName);
            a.setEmail(email);
            a.setPassword(password);
            a.setRoleID(roleID);
            adao.addUser(a);
            request.setAttribute("message", "Add user successful!");
            request.getRequestDispatcher("../view/admin/user/create-user.jsp").forward(request, response);
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
