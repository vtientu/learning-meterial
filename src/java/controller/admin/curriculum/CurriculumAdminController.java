/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.curriculum;

import dal.CurriculumDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import module.Curriculum;

/**
 *
 * @author inuya
 */
public class CurriculumAdminController extends HttpServlet {

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
            out.println("<title>Servlet CurriculumAdminController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CurriculumAdminController at " + request.getContextPath() + "</h1>");
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
        String keysearch = request.getParameter("keysearch");
        CurriculumDAO dao = new CurriculumDAO();
        ArrayList<Curriculum> curlist = dao.getListCurriculumByCode(keysearch);
        int page, numberPerPage = 12;
        String xpage = request.getParameter("page");
        int size;
        if (curlist.isEmpty()) {
            size = 0;
        } else {
            size = curlist.size();
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
        
        ArrayList<Curriculum> listByPage = dao.getListByPage(curlist, start, end);
        request.setAttribute("keysearch", keysearch);
        request.setAttribute("page", page);
        request.setAttribute("num", numberOfPage);
        request.setAttribute("listcurriculum1", listByPage);
        request.setAttribute("listcurriculum2", curlist);
        request.getRequestDispatcher("../view/admin/curriculum/index.jsp").forward(request, response);
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
        for (Curriculum l : list) {
            out.println("<tr>\n"
                    + "                                        <td>" + l.getCurID() + "</td>\n"
                    + "                                        <td>" + l.getCurriculumCode() + "</td>\n"
                    + "                                        <td><a href=\"curriculumdetail?curID=" + l.getCurID() + "\">" + l.getCurriculumNameEN() + ", " + l.getMajor().getMajorNameEN() + "</a></td>\n"
                    + "                                        <td>a</td>\n"
                    + "                                        <td>a</td>\n"
                    + "                                                            </a></td>\n"
                    + "                                        <td>145</td>\n"
                    + "                                    </tr>");
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
