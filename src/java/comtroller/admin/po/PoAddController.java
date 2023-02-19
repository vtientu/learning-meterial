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
import java.sql.Date;
import java.time.LocalDate;
import module.Decision;
import module.PO;

/**
 *
 * @author phanh
 */
@WebServlet(name="PoAddController", urlPatterns={"/poAdd"})
public class PoAddController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PoAddController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PoAddController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("view/admin/po/add.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        PODAO dao = new PODAO();
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String active = request.getParameter("isActive");
        boolean isActive = active.equalsIgnoreCase("true");
        
        String messsage = "";
        
        for (PO item : dao.getAllPO()) {
            if (item.getPoName().equalsIgnoreCase(name)) {
                messsage = "PO Name was EXISTS !";
                request.setAttribute("message", messsage);
            }
        }

        if (messsage.isEmpty()) {


            int id = dao.getLastID() + 1;

            PO po = new PO(id, name, description, isActive);

            dao.add(po);
            response.sendRedirect("poDetail?id=" + id);
        } else {
            request.setAttribute("name", name);
            request.setAttribute("isActive", isActive);
            request.setAttribute("description", description);

            request.getRequestDispatcher("view/admin/po/add.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
