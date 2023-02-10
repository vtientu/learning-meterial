/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.curriculum;

import dal.CurriculumDAO;
import dal.SyllabusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import module.Curriculum;
import module.Syllabus;

/**
 *
 * @author tient
 */
public class CurriculumListServletController extends HttpServlet {

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
            out.println("<title>Servlet CurriculumListServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CurriculumListServletController at " + request.getContextPath() + "</h1>");
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
        CurriculumDAO dao = new CurriculumDAO();
        ArrayList<Curriculum> curriculum = dao.getListForCurriculum();
        int page, numberPerPage = 12;
        String xpage = request.getParameter("page");
        int size;
        if (curriculum.isEmpty()) {
            size = 0;
        } else {
            size = curriculum.size();
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
        ArrayList<Curriculum> listByPage = dao.getListByPage(curriculum, start, end);
        request.setAttribute("listcurriculum", listByPage);
        request.setAttribute("num", numberOfPage);
        request.setAttribute("listcurriculum", listByPage);
        request.getRequestDispatcher("view/common/curriculum/curriculum-list.jsp").forward(request, response);
        
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
        CurriculumDAO cd = new CurriculumDAO();
        ArrayList<Curriculum> list = cd.getListCurriculumByCode(key);
        PrintWriter out = response.getWriter();

        for (Curriculum o : list) {
            out.println("<div class=\"col-md-4 col-lg-3 col-sm-6 m-b30\">\n"
                    + "                                                <div class=\"cours-bx\">\n"
                    + "                                                    <div class=\"action-box\">\n"
                    + "                                                        <img src=\"assets/images/banner.png\" alt=\"\"  style=\"height: 10rem\">\n"
                    + "                                                        <a href=\"curriculum-details?curID=" + o.getCurriculumCode() + "\" class=\"btn\">View</a>\n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"info-bx text-center\">\n"
                    + "                                                        <h5  style=\"min-height: 50px\"><a>" + o.getCurriculumNameEN() + ", " + o.getMajor().getMajorNameEN() + "</a></h5>\n"
                    + "                                                        <h5>(" + o.getCurriculumCode() + ")</h5>\n"
                    + "                                                        \n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"review text-center\">\n"
                    + "\n"
                    + "                                                    </div>\n"
                    + "                                                </div>\n"
                    + "                                            </div>");
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
