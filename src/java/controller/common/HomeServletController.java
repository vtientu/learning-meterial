/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.xml.bind.DatatypeConverter;
import module.Account;
import module.Constants;
import module.GooglePojo;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

/**
 *
 * @author tient
 */
public class HomeServletController extends HttpServlet {

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
            out.println("<title>Servlet HomeServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServletController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        if (action == null) {
            action = "default";
        }

        switch (action) {
            case "login":
                request.getRequestDispatcher("view/common/account/login.jsp").forward(request, response);
                break;
            case "register":
                request.getRequestDispatcher("view/common/account/register.jsp").forward(request, response);
                break;
            case "logout":
                session.removeAttribute("account");
                response.sendRedirect("home");
                break;
            case "login-google":
                loginGoogle(request, response);
                break;
            case "forget-password":
                if (session.getAttribute("verifyCode") == null) {
                    request.setAttribute("messageLogin", "Please enter email forget-password again !");
                    request.getRequestDispatcher("view/common/account/login.jsp").forward(request, response);
                } else {
                    String verifyCode = request.getParameter("code");
                    String email = request.getParameter("email");
                    if (verifyCode.equals(session.getAttribute("verifyCode"))) {
                        request.setAttribute("email", email);
                        request.getRequestDispatcher("view/common/account/forget-password.jsp").forward(request, response);
                    } else {
                        request.setAttribute("messageLogin", "Please enter email forget-password again !");
                        request.getRequestDispatcher("view/common/account/login.jsp").forward(request, response);
                    }
                    break;
                }
            default:
                request.getRequestDispatcher("view/common/gui/home.jsp").forward(request, response);
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
            case "login":
                login(request, response);
                break;
            case "register":
                register(request, response);
                break;
            case "forget-password":
                forgetPassword(request, response);
                break;
            case "change-password":
                changePassword(request, response);
                break;
            default:
                request.getRequestDispatcher("view/common/gui/home.jsp").forward(request, response);
        }
    }
    
    
    public String convertPassToMD5(String password) {
        MessageDigest convert = null;

        try {
            convert = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
        }
        
        convert.update(password.getBytes());
        byte [] passwordByte = convert.digest();
        return DatatypeConverter.printHexBinary(passwordByte);
    }

    public void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = convertPassToMD5(request.getParameter("password"));
        AccountDAO ad = new AccountDAO();
        ad.forgetPassword(email, password);
        request.setAttribute("messageLogin", "Change password successful !");
        request.getRequestDispatcher("view/common/account/login.jsp").forward(request, response);
    }

    public void loginGoogle(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        AccountDAO ad = new AccountDAO();
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        GooglePojo customer = getUserInfo(accessToken);
        AccountDAO adao = new AccountDAO();
        adao.registerAccountGoogle(customer);
        Account acc = ad.loginAccountGoogle(customer);
        session.setAttribute("account", acc);
        response.sendRedirect("home");
    }

    public void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String user = request.getParameter("user");
        String password = convertPassToMD5(request.getParameter("password"));
        AccountDAO ad = new AccountDAO();
        Account a = ad.loginAccount(user, password);
        if (a != null) {
            HttpSession session = request.getSession();
            session.setAttribute("account", a);
            response.sendRedirect("home");
        } else {
            request.setAttribute("messageLogin", "User or password invalid !");
            request.getRequestDispatcher("view/common/account/login.jsp").forward(request, response);
        }
    }

    public void register(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userRegister = request.getParameter("userName");
        String passwordRegister = convertPassToMD5(request.getParameter("password"));
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        AccountDAO ad = new AccountDAO();
        if (ad.registerAccount(userRegister, passwordRegister, email, firstName)) {
            request.setAttribute("messageLogin", "Register Success !");
            request.getRequestDispatcher("view/common/account/login.jsp").forward(request, response);
        } else {
            request.setAttribute("messageRegister", "UserName or Email already exists");
            request.getRequestDispatcher("view/common/account/register.jsp").forward(request, response);
        }
    }

    public void forgetPassword(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String emailForget = request.getParameter("email");
        AccountDAO ad = new AccountDAO();
        if (emailForget != null) {
            if (ad.checkEmailForget(emailForget)) {
                String code = getVerifyCode();
                send(emailForget, code);
                Account a = new Account();
                a.setEmail(emailForget);
                a.setPassword(convertPassToMD5(code));
                ad.changePassword(a);
                request.setAttribute("messageLogin", "Check your new password in email!");
                request.getRequestDispatcher("view/common/account/login.jsp").forward(request, response);
            } else {
                request.setAttribute("messageRegister", "Email is not registered");
                request.getRequestDispatcher("view/common/account/register.jsp").forward(request, response);
            }
        }
    }

    public String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public GooglePojo getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        GooglePojo googlePojo = new Gson().fromJson(response, GooglePojo.class);

        return googlePojo;
    }

    public void send(String to, String code) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("killermid16@gmail.com", "ckpitlhcqecelhew");
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("killermid16@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));
            message.setSubject("Verification Mail");
            String htmlEmail = "Your new password: " + code;

            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            mimeBodyPart.setContent(htmlEmail, "text/html");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);

            message.setContent(multipart);

            Transport.send(message);

            System.out.println("Đã gửi email");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public String getVerifyCode() {
        String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*_";
        Random random = new Random();
        StringBuilder builder = new StringBuilder();

        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(str.length());
            builder.append(str.charAt(index));
        }

        return builder.toString();

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
