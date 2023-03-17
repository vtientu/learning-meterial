/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.elective;

import dal.ComboDAO;
import dal.CurriculumDAO;
import dal.DecisionDAO;
import dal.ElectiveDAO;
import dal.MajorDAO;
import dal.MaterialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import module.Curriculum;
import module.Decision;
import module.Major;

/**
 *
 * @author inuya
 */
public class AddElective extends HttpServlet {

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
            out.println("<title>Servlet AddElective</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddElective at " + request.getContextPath() + "</h1>");
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
        String addtype = request.getParameter("addtype");
        int addtypeint;
        try {
            addtypeint = Integer.parseInt(addtype);
        } catch (NumberFormatException e) {
            System.out.println(e);
            addtypeint = 0;
        }
        if (addtypeint == 1) {
            CurriculumDAO dao = new CurriculumDAO();
            ArrayList<Curriculum> list = dao.getListForCurriculum();
            request.setAttribute("currilist", list);
            request.setAttribute("addtype", 1);
        } else if (addtypeint == 2) {
            request.setAttribute("addtype", 2);
        } else if (addtypeint == 3) {
            MajorDAO majorDAO = new MajorDAO();
            ArrayList<Major> major = majorDAO.getMajorlist();
            request.setAttribute("major", major);
            DecisionDAO de = new DecisionDAO();
            List<Decision> decision = de.getAllDecision();
            request.setAttribute("decision", decision);
            request.setAttribute("addtype", 3);
        } else if (addtypeint == 4) {
            request.setAttribute("addtype", 4);
        }
        request.getRequestDispatcher("../view/admin/elective/addelective.jsp").forward(request, response);
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
        String type = request.getParameter("addtype");
        int addtype;
        try {
            addtype = Integer.parseInt(type);
        } catch (NumberFormatException e) {
            System.out.println(e + "a");
            addtype = 0;
        }
        if (addtype == 1) {
            String nameen = request.getParameter("nameen");
            String namevn = request.getParameter("namevn");
            String note = request.getParameter("note");
            String active = request.getParameter("active");
            String curriid = request.getParameter("curriid");
            int intactive;
            int intcurriid;
            try {
                intactive = Integer.parseInt(active);
                intcurriid = Integer.parseInt(curriid);
            } catch (NumberFormatException e) {
                System.out.println(e);
                intactive = 0;
                intcurriid = 0;
            }
            ElectiveDAO dao = new ElectiveDAO();
            dao.addElective(nameen, namevn, note, intactive);
            dao.addElective2(intcurriid);
            response.sendRedirect("electivelist");
        } else if (addtype == 2) {
            String name = request.getParameter("name");
            String active = request.getParameter("active");
            String note = request.getParameter("note");
            ComboDAO dao = new ComboDAO();
            int active1;
            try {
                active1 = Integer.parseInt(active);
            } catch (NumberFormatException e) {
                System.out.println(e);
                active1 = 1;
            }
            dao.addCombo(name, active1, note);
            response.sendRedirect("comboList");
        } else if (addtype == 3) {
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
        } else if (addtype == 4) {
            String des = request.getParameter("materialDescription");
            String author = request.getParameter("author");
            String publisher = request.getParameter("publisher");
            String pudate = request.getParameter("publisheddate");
            String edit = request.getParameter("edition");
            String isbn = request.getParameter("isbn");
            String main = request.getParameter("IsMainMaterial");
            String copy = request.getParameter("IsHardCopy");
            String online = request.getParameter("IsOnline");
            String note = request.getParameter("note");
            String isactive = request.getParameter("active");
            int isactiveint, intmain, intcopy, intonline;
            try {
                isactiveint = Integer.parseInt(isactive);
                intmain = Integer.parseInt(main);
                intcopy = Integer.parseInt(copy);
                intonline = Integer.parseInt(online);
            } catch (NumberFormatException e) {
                System.out.println(e + "1234");
                isactiveint = 0;
                intmain = 0;
                intcopy = 0;
                intonline = 0;
            }
            MaterialDAO dao = new MaterialDAO();
            dao.getInsertMaterial(des, author, publisher, pudate, edit, isbn, intmain, intcopy, intonline, note, isactiveint);
            response.sendRedirect("materiallist");
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
