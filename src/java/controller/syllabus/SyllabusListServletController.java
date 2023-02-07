/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.syllabus;

import dal.SyllabusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
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
        ArrayList<Syllabus> list = ld.getAllSyllabus();
        int page, numberPerPage = 12;
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
        ArrayList<Syllabus> listByPage = ld.getListByPage(list, start, end);
        request.setAttribute("listSyllabus", listByPage);
        request.getRequestDispatcher("view/common/syllabus/syllabus-list.jsp").forward(request, response);
    }

    public static void main(String[] args) {
        SyllabusDAO ld = new SyllabusDAO();
        ArrayList<Syllabus> list = ld.getAllSyllabus();
        for (Syllabus l : list) {
            System.out.println(l);
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
        response.setContentType("text/html;charset=UTF-8");
        String key = request.getParameter("keysearch");
        SyllabusDAO sd = new SyllabusDAO();
        ArrayList<Syllabus> list = sd.getListSyllabusByKey(key);
        PrintWriter out = response.getWriter();

        for (Syllabus o : list) {
            out.println("<div class=\"col-md-4 col-lg-3 col-sm-6 m-b30\">\n"
                    + "                                                <div class=\"cours-bx\">\n"
                    + "                                                    <div class=\"action-box\">\n"
                    + "                                                        <img src=\"assets/images/banner.png\" alt=\"\" style=\"height: 10rem\">\n"
                    + "                                                        <a href=\"syllabus-details?syID=" + o.getSubjectCode() + "\" class=\"btn\">View</a>\n"
                    + "                                                    </div>\n"
                    + "                                                    <div class=\"info-bx text-center\">\n"
                    + "                                                        <h5  style=\"min-height: 50px\"><a href=\"syllabus-details?syID=" + o.getSubjectCode() + "\">" + o.getSubjectNameEN() + "</a></h5>\n"
                    + "                                                        <span>" + o.getSubjectCode() + "</span>\n"
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
