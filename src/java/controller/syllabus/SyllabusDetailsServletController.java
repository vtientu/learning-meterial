/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.syllabus;

import dal.ReviewDAO;
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
import module.Feedback;
import module.Syllabus;

/**
 *
 * @author tient
 */
public class SyllabusDetailsServletController extends HttpServlet {

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
            out.println("<title>Servlet SyllabusDetailsServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SyllabusDetailsServletController at " + request.getContextPath() + "</h1>");
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
        String code = request.getParameter("syID");
        SyllabusDAO sd = new SyllabusDAO();
        Syllabus s = sd.getSyllabus(code);
        ReviewDAO rdao = new ReviewDAO();
        ArrayList<Feedback> listReview = rdao.getFeedbackBySyID(s.getSyllabusID());
        request.setAttribute("feedback", listReview);
        request.setAttribute("syllabus", s);
        request.getRequestDispatcher("view/common/syllabus/syllabus-details.jsp").forward(request, response);
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
        try {
            int sid = Integer.parseInt(request.getParameter("syID"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            HttpSession session = request.getSession();
            Account a = (Account) session.getAttribute("account");
            ReviewDAO rd = new ReviewDAO();
            Feedback fb = new Feedback(0, 0, title, description, a);

            rd.createFeedbackSyllabus(sid, fb);

            SyllabusDAO sd = new SyllabusDAO();
            Syllabus s = sd.getSyllabus(request.getParameter("syCode"));
            ReviewDAO rdao = new ReviewDAO();
            ArrayList<Feedback> listReview = rdao.getFeedbackBySyID(sid);
            request.setAttribute("feedback", listReview);
            request.setAttribute("syllabus", s);
            response.sendRedirect("home");
        } catch (NumberFormatException e) {
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
