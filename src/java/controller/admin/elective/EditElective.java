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
import dal.SubjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import module.Combo;
import module.Curriculum;
import module.Decision;
import module.Elective;
import module.Major;
import module.Material;
import module.Subject;

/**
 *
 * @author inuya
 */
public class EditElective extends HttpServlet {

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
            out.println("<title>Servlet EditElective</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditElective at " + request.getContextPath() + "</h1>");
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
        String type = request.getParameter("type");
        int typeint;
        try {
            typeint = Integer.parseInt(type);
        } catch (NumberFormatException e) {
            System.out.println(e);
            typeint = 1;
        }
        if (typeint == 1) {
            String electiveID = request.getParameter("electiveID");
            ElectiveDAO dao = new ElectiveDAO();
            Elective elective = dao.getElectiveById(electiveID);
            SubjectDAO daos = new SubjectDAO();
            ArrayList<Subject> s = daos.getSubjectNeedToChooseInElective(electiveID);
            request.setAttribute("subjectlist", s);
            request.setAttribute("elective", elective);
            request.setAttribute("type", 1);
        } else if (typeint == 2) {
            String id = request.getParameter("comboID");
            ComboDAO dao = new ComboDAO();
            Combo combo = dao.getcomboById(id);
            request.setAttribute("list", combo);
            request.setAttribute("type", 2);
        } else if (typeint == 3) {
            String id = request.getParameter("curID");
            CurriculumDAO dao = new CurriculumDAO();
            Curriculum curriculum = dao.getCurriculum(id);
            request.setAttribute("curriculum", curriculum);
            MajorDAO majorDAO = new MajorDAO();
            ArrayList<Major> major = majorDAO.getMajorlist();
            request.setAttribute("major", major);
            DecisionDAO de = new DecisionDAO();
            List<Decision> decision = de.getAllDecision();
            request.setAttribute("decision", decision);
            request.setAttribute("type", 3);
            SubjectDAO sudao = new SubjectDAO();
            ArrayList<Subject> subject = sudao.getSubjectNeedToChoose(id);
            ElectiveDAO dao1 = new ElectiveDAO();
            ArrayList<Elective> elist = dao1.getCurriculumNeedToChooseInElective(id);
            request.setAttribute("elist", elist);
            request.setAttribute("sulist", subject);
        } else if (typeint == 4) {
            String id = request.getParameter("materialID");
            MaterialDAO dao = new MaterialDAO();
            Material mate = dao.getMaterial(id);
            request.setAttribute("mate", mate);
            request.setAttribute("type", 4);
        }
        request.getRequestDispatcher("../view/admin/elective/updateelective.jsp").forward(request, response);
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
        String type = request.getParameter("type");
        int typeint;
        try {
            typeint = Integer.parseInt(type);
        } catch (NumberFormatException e) {
            System.out.println(e + "12341234");
            typeint = 1;
        }
        if (typeint == 1) {
            String electiveID = request.getParameter("electiveID");
            String nameen = request.getParameter("nameen");
            String namevn = request.getParameter("namevn");
            String note = request.getParameter("note");
            String active = request.getParameter("active");
            int isActive;
            int electiveIDint;
            try {
                electiveIDint = Integer.parseInt(electiveID);
                isActive = Integer.parseInt(active);
            } catch (NumberFormatException e) {
                System.out.println(e);
                isActive = 1;
                electiveIDint = 0;
            }
            ElectiveDAO dao = new ElectiveDAO();
            dao.EditElective(nameen, namevn, note, electiveID, isActive);
            String[] subjectID = request.getParameterValues("subjectid");
            int[] subjectIDint = null;
            if (subjectID != null) {
                if (subjectID.length < 0) {
                    subjectIDint = new int[1];
                } else {
                    subjectIDint = new int[subjectID.length];
                }
            }
            ArrayList<Subject> list = new ArrayList<>();
            if (subjectID != null) {
                for (int i = 0; i < subjectID.length; i++) {
                    try {
                        subjectIDint[i] = Integer.parseInt(subjectID[i]);
                    } catch (NumberFormatException e) {
                        System.out.println(e + "11223344");
                        subjectIDint[i] = 0;
                    }
                    Subject s = new Subject(subjectIDint[i], 0, 0, "", "", null, true, 0, 0);
                    list.add(s);
                }
            }
            Elective elective = new Elective();
            elective.setElectiveID(electiveIDint);
            elective.setSubject(list);
            SubjectDAO sudao = new SubjectDAO();
            sudao.getInsertCurriculumSubject(elective);
            response.sendRedirect("electivelist");
        } else if (typeint == 2) {
            String name = request.getParameter("name");
            String active = request.getParameter("active");
            String note = request.getParameter("note");
            String id = request.getParameter("id");
            int active1;
            try {
                active1 = Integer.parseInt(active);
            } catch (NumberFormatException e) {
                active1 = 1;
            }
            ComboDAO dao = new ComboDAO();
            dao.editCombo(name, active1, note, id);
            response.sendRedirect("comboList");
        } else if (typeint == 3) {
            String major = request.getParameter("major");
            String de = request.getParameter("decision");
            String id = request.getParameter("curID");
            String code = request.getParameter("code");
            String nameen = request.getParameter("nameen");
            String namevn = request.getParameter("namevn");
            String description = request.getParameter("description");
            String approve = request.getParameter("approve");
            int approveint;
            int majorID;
            int curID;
            try {
                approveint = Integer.parseInt(approve);
                majorID = Integer.parseInt(major);
                curID = Integer.parseInt(id);
            } catch (NumberFormatException e) {
                System.out.println(e + "1");
                approveint = 0;
                majorID = 0;
                curID = 0;
            }
            CurriculumDAO dao = new CurriculumDAO();
            dao.getEditCurriculum(id, majorID, de, code, nameen, namevn, description, approveint);
            String[] subjectID = request.getParameterValues("sucode");
            int[] subjectIDint = null;
            if (subjectID != null) {
                if (subjectID.length < 0) {
                    subjectIDint = new int[1];
                } else {
                    subjectIDint = new int[subjectID.length];
                }
            }
            ArrayList<Subject> list = new ArrayList<>();
            if (subjectID != null) {
                for (int i = 0; i < subjectID.length; i++) {
                    try {
                        subjectIDint[i] = Integer.parseInt(subjectID[i]);
                    } catch (NumberFormatException e) {
                        System.out.println(e + "11223344");
                        subjectIDint[i] = 0;
                    }
                    Subject s = new Subject(subjectIDint[i], 0, 0, "", "", null, true, 0, 0);
                    list.add(s);
                }
            }
            
            Curriculum cur = new Curriculum();
            cur.setCurID(curID);
            cur.setSubject(list);
            dao.getInsertCurriculumSubject(cur);
            String[] subjectid = request.getParameterValues("subjectid");
            int[] eid = null;
            if (subjectid != null) {
                if (subjectid.length < 0) {
                    eid = new int[1];
                } else {
                    eid = new int[subjectid.length];
                }
            }
            ArrayList<Elective> elist = new ArrayList<>();
            if (subjectid != null) {
                for (int i = 0; i < subjectid.length; i++) {
                    try {
                        eid[i] = Integer.parseInt(subjectid[i]);
                    } catch (NumberFormatException e) {
                        System.out.println(e + "11223344");
                        eid[i] = 0;
                    }
                    Elective elective = new Elective(eid[i], nameen, namevn, i, code);
                    elist.add(elective);
                }
            }
            Curriculum cur1 = new Curriculum();
            cur1.setCurID(curID);
            cur1.setElective(elist);
            ElectiveDAO dao1 = new ElectiveDAO();
            dao1.getInsertCurriculumElective(cur1);
            response.sendRedirect("curriAdmin");
        } else if (typeint == 4) {
            String id = request.getParameter("materialID");
            String des = request.getParameter("materialDescription");
            String author = request.getParameter("author");
            String syID = request.getParameter("syID");
            String publisher = request.getParameter("publisher");
            String pudate = request.getParameter("publisheddate");
            String edit = request.getParameter("edition");
            String isbn = request.getParameter("isbn");
            String main = request.getParameter("IsMainMaterial");
            String copy = request.getParameter("IsHardCopy");
            String online = request.getParameter("IsOnline");
            String note = request.getParameter("note");
            String isactive = request.getParameter("active");
            int isactiveint, syIDint, intmain, intcopy, intonline;
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
            dao.getEditMaterial(des, author, publisher, pudate, edit, isbn, intmain, intcopy, intonline, note, isactiveint, id);
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
