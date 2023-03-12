/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.curriculum;

import dal.CurriculumDAO;
import dal.DecisionDAO;
import dal.MajorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import module.Decision;
import module.Major;

/**
 *
 * @author inuya
 */
public class Curriculumadminadd extends HttpServlet {

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
            out.println("<title>Servlet Curriculumadminadd</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Curriculumadminadd at " + request.getContextPath() + "</h1>");
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
        MajorDAO majorDAO = new MajorDAO();
        ArrayList<Major> major = majorDAO.getMajorlist();
        request.setAttribute("major", major);
        DecisionDAO de = new DecisionDAO();
        List<Decision> decision = de.getAllDecision();
        request.setAttribute("decision", decision);
        request.getRequestDispatcher("../view/admin/curriculum/add.jsp").forward(request, response);
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
        String major = request.getParameter("major");
        String decision = request.getParameter("decision");
        String code = request.getParameter("code");
        String nameen = request.getParameter("nameen");
        String namevn = request.getParameter("namevn");
        String description = request.getParameter("description");
        int majorID;
        try {
            majorID = Integer.parseInt(major);
        } catch (NumberFormatException e) {
            System.out.println(e);
            majorID = 0;
        }
        CurriculumDAO dao = new CurriculumDAO();
        dao.curriculumInsert(code, majorID, nameen, namevn, decision, description);
        response.sendRedirect("curriAdmin");
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
