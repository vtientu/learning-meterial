/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.account;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import module.Account;

/**
 *
 * @author tient
 */
@MultipartConfig
public class ProfileServletController extends HttpServlet {

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
            out.println("<title>Servlet ProfileServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServletController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("view/common/account/profile.jsp").forward(request, response);
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
        if (action.equalsIgnoreCase("profile")) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            int gender = Integer.parseInt(request.getParameter("gender"));
            String birthday_raw = request.getParameter("birthday");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            HttpSession session = request.getSession();
            Account a = (Account) session.getAttribute("account");

            Part filePart = request.getPart("avatar");
            String fileName = filePart.getSubmittedFileName();
            String realPart = request.getServletContext().getRealPath("/images");
            if (!Files.exists(Paths.get(realPart))) {
                Files.createDirectories(Paths.get(realPart));
            }
            filePart.write(realPart + "/" + fileName);
            a.setAvatar(fileName);

            if (!a.getFirstName().equals(firstName) && firstName != null) {
                a.setFirstName(firstName);
            }

            if (!a.getLastName().equals(lastName) && lastName != null) {
                a.setLastName(lastName);
            }

            if (birthday_raw != null) {
                a.setBirthday(Date.valueOf(birthday_raw));
            }

            if (a.getGender() != gender) {
                a.setGender(gender);
            }

            if (phone != null) {
                a.setPhone(phone);
            }

            if (address != null) {
                a.setAddress(address);
            }

            AccountDAO adao = new AccountDAO();
            adao.editProfile(a);
            session.removeAttribute("account");
            session.setAttribute("account", a);
            request.getRequestDispatcher("view/common/account/profile.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("pw")) {
            String npswd = request.getParameter("nPassword");
            HttpSession session = request.getSession();
            Account a = (Account) session.getAttribute("account");
            a.setPassword(npswd);
            AccountDAO adao = new AccountDAO();
            adao.changePassword(a);
            session.removeAttribute("account");
            response.sendRedirect("home");
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
