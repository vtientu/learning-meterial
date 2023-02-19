/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package comtroller.admin.po;

import dal.PODAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import module.PO;

/**
 *
 * @author phanh
 */
@WebServlet(name = "poDetailControlelr", urlPatterns = {"/poDetail"})
public class poDetailControlelr extends HttpServlet {

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
            out.println("<title>Servlet poDetailControlelr</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet poDetailControlelr at " + request.getContextPath() + "</h1>");
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
        String id_raw = request.getParameter("id");

        PODAO dao = new PODAO();

        int id = 0;
        try {

            id = Integer.parseInt(id_raw);

        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        PO po = dao.getPOByID(id);

        request.setAttribute("po", po);

        request.getRequestDispatcher("view/admin/po/detail.jsp").forward(request, response);
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
        String id_raw = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String active = request.getParameter("isActive");
        boolean isActive = active.equalsIgnoreCase("true");
        int id = 0;
        try {
            id = Integer.parseInt(id_raw);

        } catch (NumberFormatException e) {
            System.out.println("podetail" + e);
        }

        String messsage = "";

        PODAO dao = new PODAO();

        for (PO item : dao.getAllPO()) {
            if (item.getId() != id) {
                if (item.getPoName().equalsIgnoreCase(name)) {
                    messsage = "PO Name was EXISTS !";
                    request.setAttribute("message", messsage);
                }
            }
        }

        PO po = dao.getPOByID(id);

        if (messsage.isEmpty()) {

            po.setIsActive(isActive);
            po.setPoDescription(description);
            po.setPoName(name);

            dao.update(po);
            response.sendRedirect("poDetail?id=" + id);
        } else {
            request.setAttribute("po", po);

            request.getRequestDispatcher("view/admin/po/detail.jsp").forward(request, response);
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
