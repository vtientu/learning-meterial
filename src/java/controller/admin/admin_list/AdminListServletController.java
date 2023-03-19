/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.admin_list;

import dal.AccountDAO;
import dal.SyllabusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import module.Account;
import module.Question;
import module.Role;
import module.Subject;
import module.Syllabus;

/**
 *
 * @author tient
 */
public class AdminListServletController extends HttpServlet {

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
            out.println("<title>Servlet AdminListServletController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminListServletController at " + request.getContextPath() + "</h1>");
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
        String adminPage = request.getParameter("adminpage");
        switch (adminPage) {
            case "user":
                getUserList(request, response, 2);
                break;
            case "subject":
                getSubjectList(request, response, 2);
                break;
            case "syllabus":
                getSyllabusList(request, response, 2);
                break;
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
        String adminPage = request.getParameter("adminpage");
        switch (adminPage) {
            case "user":
                getUserList(request, response, 1);
                break;
            case "subject":
                getSubjectList(request, response, 1);
                break;
            case "syllabus":
                getSyllabusList(request, response, 1);
                break;
        }
    }

    public void getSyllabusList(HttpServletRequest request, HttpServletResponse response, int type)
            throws ServletException, IOException {
        String key = request.getParameter("keysearch");
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        SyllabusDAO ld = new SyllabusDAO();
        ArrayList<Syllabus> list = ld.getAllSyllabusAdmin(a);

        String approve_raw = request.getParameter("approve");
        String approve = "default";
        String active_raw = request.getParameter("active");
        String active = "default";

        if (active_raw != null) {
            if (active_raw.equals("default")) {
                list = ld.getAllSyllabusAdmin(a);
            } else {
                boolean active_select = Boolean.parseBoolean(active_raw);
                active = active_raw;
                list = ld.getListSyllabusByActive(active_select, a);
            }
        }

        if (approve_raw != null) {
            if (approve_raw.equals("default")) {
                list = ld.getAllSyllabusAdmin(a);
            } else {
                boolean approve_select = Boolean.parseBoolean(approve_raw);
                approve = approve_raw;
                list = ld.getListSyllabusByApprove(approve_select, a);
            }
        }

        if (key != null) {
            list = ld.getListSyllabusAdminByKey(key, a);
        }
        int page, numberPerPage = 10;
        String xpage = request.getParameter("page");

        String sort = request.getParameter("sort");

        String sortType = "";
        if (sort != null) {
            String pageType = request.getParameter("pageType");
            switch (sort) {
                case "id_down":
                    Collections.sort(list, (Syllabus o1, Syllabus o2) -> {
                        if (o1.getSyllabusID() < o2.getSyllabusID()) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "id_up");
                    break;
                case "id_up":
                    Collections.sort(list, (Syllabus o1, Syllabus o2) -> {
                        if (o1.getSyllabusID() > o2.getSyllabusID()) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "id_down");
                    break;
                case "scode_down":
                    Collections.sort(list, (Syllabus o1, Syllabus o2) -> {
                        if (o1.getSubject().getSubjectCode().compareTo(o2.getSubject().getSubjectCode()) > 0) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "scode_up");
                    break;
                case "scode_up":
                    Collections.sort(list, (Syllabus o1, Syllabus o2) -> {
                        if (o1.getSubject().getSubjectCode().compareTo(o2.getSubject().getSubjectCode()) < 0) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "scode_down");
                    break;
                case "syname_down":
                    Collections.sort(list, (Syllabus o1, Syllabus o2) -> {
                        if (o1.getSyllabusNameEN().compareTo(o2.getSyllabusNameEN()) > 0) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "syname_up");
                    break;
                case "syname_up":
                    Collections.sort(list, (Syllabus o1, Syllabus o2) -> {
                        if (o1.getSyllabusNameEN().compareTo(o2.getSyllabusNameEN()) < 0) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "syname_down");
                    break;
                case "decision_down":
                    Collections.sort(list, (Syllabus o1, Syllabus o2) -> {
                        if (o1.getDecisionNo() != null && o2.getDecisionNo() != null) {
                            if (o1.getDecisionNo().compareTo(o2.getDecisionNo()) > 0) {
                                return 1;
                            }
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "decision_up");
                    break;
                case "decision_up":
                    Collections.sort(list, (Syllabus o1, Syllabus o2) -> {
                        if (o1.getDecisionNo() != null && o2.getDecisionNo() != null) {
                            if (o1.getDecisionNo().compareTo(o2.getDecisionNo()) < 0) {
                                return 1;
                            }
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "decision_down");
                    break;
            }
        }
        request.setAttribute("sort", sortType);
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
        if (type == 2) {
            request.setAttribute("totalPage", numberOfPage);
            request.setAttribute("page", page);
            request.setAttribute("listSyllabus", listByPage);
            request.setAttribute("active", active);
            request.setAttribute("approve", approve);
            request.getRequestDispatcher("../view/admin/syllabus/syllabus-list.jsp").forward(request, response);
        } else {
            processSyllabus(request, response, listByPage, page, numberOfPage, key, sortType);
        }
    }

    public void processSyllabus(HttpServletRequest request, HttpServletResponse response, ArrayList<Syllabus> listByPage, int page, int numberOfPage, String key, String sort)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("<table class=\"table\">\n");
        out.print("<thead class=\"thead-orange\">");
        out.print("<th width=\"5%\" onclick=\"processSyllabusList(" + page + ", '" + (sort != null ? sort.equals("id_up") ? "id_up" : "id_down" : "id_down") + "', false)\">ID" + (sort.equals("id_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : (sort.equals("id_down") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>" : "")) + "</th>");
        out.print("<th width=\"15%\" onclick=\"processSyllabusList(" + page + ", '" + (sort != null ? sort.equals("scode_up") ? "scode_up" : "scode_down" : "scode_down") + "', false)\">Subject Code" + (sort.equals("scode_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : (sort.equals("scode_down") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>" : "")) + "</th>");
        out.print("<th onclick=\"processSyllabusList(" + page + ", '" + (sort != null ? sort.equals("syname_up") ? "syname_up" : "syname_down" : "syname_down") + "', false)\">Syllabus Name" + (sort.equals("syname_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : (sort.equals("syname_down") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>" : "")) + "</th>");
        out.print("<th class=\"text-center\">Author</th>");
        out.print("<th class=\"text-center\">IsActive</th>");
        out.print("<th class=\"text-center\">IsApproved</th>");
        out.print("<th width=\"10%\" onclick=\"processSyllabusList(" + page + ", '" + (sort != null ? sort.equals("decision_up") ? "decision_up" : "decision_down" : "decision_down") + "', false)\">DecisionNo<br/>MM/dd/yyyy" + (sort.equals("decision_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : (sort.equals("decision_down") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>" : "")) + "</th>");
        out.print("<th>Action</th>");
        out.print("</thead>");
        out.print("                                    <tbody>");
        for (Syllabus o : listByPage) {
            out.println("               <tr>\n"
                    + "                                            <td>" + o.getSyllabusID() + "</td>\n"
                    + "                                            <td>" + o.getSubject().getSubjectCode() + "</td>\n"
                    + "                                            <td>" + o.getSyllabusNameEN() + "</td>\n"
                    + "                                            <td class=\"text-center\">" + o.getAccount().getFullName() + "</td>\n"
                    + "                                            <td class=\"text-center\"><i  style=\"color: " + (o.isIsActive() == true ? "green" : "red") + "\" class=\"fa " + (o.isIsActive() == true ? "fa-check" : "fa-close") + "\"/></td>\n"
                    + "                                            <td class=\"text-center\"><i  style=\"color: " + (o.isIsApproved() == true ? "green" : "red") + "\" class=\"fa " + (o.isIsApproved() == true ? "fa-check" : "fa-close") + "\"/></td>\n");
            if (o.getDecisionNo() == null) {
                out.print("                                            <td></td>\n");
            } else {
                out.print("                                            <td>" + o.getDecisionNo() + "</td>\n");
            }

            out.print("                                            <td>\n"
                    + "                                                 <button class=\"btn bg-white\">\n"
                    + "                                                    <a href=\"update-details?action=syllabus&sid=" + o.getSyllabusID() + "\"><i class=\"ti ti-pencil-alt\" style=\"color: black\"></i></a>\n"
                    + "                                                 </button>\n"
                    + "                                             </td>");

            out.print("                                    </tr>");
        }
        out.print("</tbody>\n"
                + "                            </table>\n");
        out.print("<div style=\"float: right\">");
        out.print("<ul class=\"pagination\">");

        if (page == 1) {
            out.print("<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Previous</a></li>");
        } else {
            out.print("<li class=\"page-item\"><a onclick=\"processSyllabusList(" + (page - 1) + ", '" + request.getAttribute("sort") + "', true)\" class=\"page-link\">Previous</a></li>");
        }

        out.print("<li class=\"page-item\"><a id=\"page\" class=\"page-link\">" + page + "</a></li>");

        if (page == numberOfPage) {
            out.print("<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Next</a></li>");
        } else {
            out.print("<li class=\"page-item\"><a onclick=\"processSyllabusList(" + (page + 1) + ", '" + sort + "', true)\" class=\"page-link\">Next</a></li>");
        }

        out.print("</ul>");
        out.print("</div>");

    }

    public void getSubjectList(HttpServletRequest request, HttpServletResponse response, int type)
            throws ServletException, IOException {
        ArrayList<Subject> listSubject;
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");

        SyllabusDAO sdao = new SyllabusDAO();
        String key = request.getParameter("keysearch");
        listSubject = sdao.getListSubject(a);
        String active_raw = request.getParameter("active");
        String active = "default";

        if (active_raw != null) {
            if (active_raw.equals("default")) {
                listSubject = sdao.getListSubject(a);
            } else {
                boolean active_select = Boolean.parseBoolean(active_raw);
                active = active_raw;
                listSubject = sdao.getListSubjectByStatus(active_select, a);
            }
        }

        if (key != null && key.length() > 0) {
            listSubject = sdao.getListSubjectByKey(key, a);
        }

        String sort = request.getParameter("sort");

        String sortType = "";
        if (sort != null) {
            String pageType = request.getParameter("pageType");
            switch (sort) {
                case "id_down":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getSubjectID() < o2.getSubjectID()) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "id_up");
                    break;
                case "id_up":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getSubjectID() > o2.getSubjectID()) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "id_down");
                    break;
                case "scode_down":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getSubjectCode().compareTo(o2.getSubjectCode()) > 0) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "scode_up");
                    break;
                case "scode_up":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getSubjectCode().compareTo(o2.getSubjectCode()) < 0) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "scode_down");
                    break;
                case "name_down":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getSubjectName().compareTo(o2.getSubjectName()) > 0) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "name_up");
                    break;
                case "name_up":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getSubjectName().compareTo(o2.getSubjectName()) < 0) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "name_down");
                    break;
                case "semester_down":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getSemester() < o2.getSemester()) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "semester_up");
                    break;
                case "semester_up":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getSemester() > o2.getSemester()) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "semester_down");
                    break;
                case "credit_down":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getNoCredit() < o2.getNoCredit()) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "credit_up");
                    break;
                case "credit_up":
                    Collections.sort(listSubject, (Subject o1, Subject o2) -> {
                        if (o1.getNoCredit() > o2.getNoCredit()) {
                            return 1;
                        }
                        return -1;
                    });
                    sortType = (pageType.equals("true") ? sort : "credit_down");
                    break;
            }
        }
        request.setAttribute("sort", sortType);

        int page, numberPerPage = 8;
        String xpage = request.getParameter("page");
        int size;
        if (listSubject.isEmpty()) {
            size = 0;
        } else {
            size = listSubject.size();
        }

        int numberOfPage = ((size % numberPerPage == 0) ? (size / numberPerPage) : (size / numberPerPage + 1));
        if (xpage == null || xpage.length() == 0) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start, end;
        start = (page - 1) * numberPerPage;
        end = Math.min(page * numberPerPage, size);

        ArrayList<Subject> listByPage = sdao.getListByPageSubject(listSubject, start, end);
        if (type == 1) {
            showSubjectList(request, response, listByPage, page, numberOfPage, sortType);
        } else if (type == 2) {
            request.setAttribute("page", page);
            request.setAttribute("totalPage", numberOfPage);
            request.setAttribute("listSubject", listByPage);
            request.setAttribute("active", active);
            request.getRequestDispatcher("../view/admin/subject/subject-list.jsp").forward(request, response);
        }
    }

    public void getUserList(HttpServletRequest request, HttpServletResponse response, int type)
            throws ServletException, IOException {
        try {
            AccountDAO adao = new AccountDAO();
            String aid = request.getParameter("aid");
            String key = request.getParameter("keysearch");
            String role_raw = request.getParameter("role");
            String active_raw = request.getParameter("active");
            int role = 0;
            String active = "default";
            if (aid != null) {
                adao.changeStatus(Integer.parseInt(aid));
            }

            ArrayList<Account> listUser = adao.getAllAccount();
            if (key != null && key.length() > 0) {
                listUser = adao.getListAccountByKey(key);
            }

            if (role_raw != null) {
                role = Integer.parseInt(role_raw);
                if (role == 0) {
                    listUser = adao.getAllAccount();
                } else {
                    listUser = adao.getListAccountByRole(role);
                }
            }

            if (active_raw != null) {
                if (active_raw.equals("default")) {
                    listUser = adao.getAllAccount();
                } else {
                    boolean active_select = Boolean.parseBoolean(active_raw);
                    active = active_raw;
                    listUser = adao.getListAccountByActive(active_select);
                }
            }

            String sort = request.getParameter("sort");

            String sortType = "";
            if (sort != null) {
                String pageType = request.getParameter("pageType");
                switch (sort) {
                    case "id_down":
                        Collections.sort(listUser, (Account o1, Account o2) -> {
                            if (o1.getAccountID() < o2.getAccountID()) {
                                return 1;
                            }
                            return -1;
                        });
                        sortType = (pageType.equals("true") ? sort : "id_up");
                        break;
                    case "id_up":
                        Collections.sort(listUser, (Account o1, Account o2) -> {
                            if (o1.getAccountID() > o2.getAccountID()) {
                                return 1;
                            }
                            return -1;
                        });
                        sortType = (pageType.equals("true") ? sort : "id_down");
                        break;
                    case "name_down":
                        Collections.sort(listUser, (Account o1, Account o2) -> {
                            if (o1.getFullName().compareTo(o2.getFullName()) > 0) {
                                return 1;
                            }
                            return -1;
                        });
                        sortType = (pageType.equals("true") ? sort : "name_up");
                        break;
                    case "name_up":
                        Collections.sort(listUser, (Account o1, Account o2) -> {
                            if (o1.getFullName().compareTo(o2.getFullName()) < 0) {
                                return 1;
                            }
                            return -1;
                        });
                        sortType = (pageType.equals("true") ? sort : "name_down");
                        break;
                    case "user_down":
                        Collections.sort(listUser, (Account o1, Account o2) -> {
                            if (o1.getUserName().compareTo(o2.getUserName()) > 0) {
                                return 1;
                            }
                            return -1;
                        });
                        sortType = (pageType.equals("true") ? sort : "user_up");
                        break;
                    case "user_up":
                        Collections.sort(listUser, (Account o1, Account o2) -> {
                            if (o1.getUserName().compareTo(o2.getUserName()) < 0) {
                                return 1;
                            }
                            return -1;
                        });
                        sortType = (pageType.equals("true") ? sort : "user_down");
                        break;
                    case "email_down":
                        Collections.sort(listUser, (Account o1, Account o2) -> {
                            if (o1.getEmail().compareTo(o2.getEmail()) > 0) {
                                return 1;
                            }
                            return -1;
                        });
                        sortType = (pageType.equals("true") ? sort : "email_up");
                        break;
                    case "email_up":
                        Collections.sort(listUser, (Account o1, Account o2) -> {
                            if (o1.getEmail().compareTo(o2.getEmail()) < 0) {
                                return 1;
                            }
                            return -1;
                        });
                        sortType = (pageType.equals("true") ? sort : "email_down");
                        break;
                }
            }
            request.setAttribute("sort", sortType);

            int page, numberPerPage = 8;
            String xpage = request.getParameter("page");
            int size;
            if (listUser.isEmpty()) {
                size = 0;
            } else {
                size = listUser.size();
            }

            int numberOfPage = ((size % numberPerPage == 0) ? (size / numberPerPage) : (size / numberPerPage + 1));
            if (xpage == null || xpage.length() == 0) {
                page = 1;
            } else {
                page = Integer.parseInt(xpage);
            }
            int start, end;
            start = (page - 1) * numberPerPage;
            end = Math.min(page * numberPerPage, size);

            ArrayList<Account> listByPage = adao.getListByPage(listUser, start, end);
            if (type == 1) {
                showUserList(request, response, listByPage, page, numberOfPage, sort);
            } else if (type == 2) {
                request.setAttribute("listRole", adao.getRoleList());
                request.setAttribute("page", page);
                request.setAttribute("totalPage", numberOfPage);
                request.setAttribute("listUser", listByPage);
                request.setAttribute("listRole", adao.getRoleList());
                request.setAttribute("active", active);
                request.setAttribute("role", role);
                request.getRequestDispatcher("../view/admin/user/user-list.jsp").forward(request, response);
            }
        } catch (ServletException | IOException | NumberFormatException e) {
            System.out.println(e);
        }
    }

    public void showSubjectList(HttpServletRequest request, HttpServletResponse response, ArrayList<Subject> listSubject, int page, int totalPage, String sort)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("<table class=\"table\">\n");
        out.print("<thead class=\"thead-orange\">");
        out.print("<th onclick=\"processSubjectList(" + page + ", '" + (sort != null && sort.equals("id_up") ? "id_up" : "id_down") + "', false)\">ID" + (sort != null && sort.startsWith("id") ? (sort.equals("id_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>") : "") + "</th>");
        out.print("<th width=\"15%\" onclick=\"processSubjectList(" + page + ", '" + (sort != null && sort.equals("scode_up") ? "scode_up" : "scode_down") + "', false)\">Subject Code" + (sort != null && sort.startsWith("scode") ? (sort.equals("scode_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>") : "") + "</th>");
        out.print("<th onclick=\"processSubjectList(" + page + ", '" + (sort != null && sort.equals("name_up") ? "name_up" : "name_down") + "', false)\">Subject Name" + (sort != null && sort.startsWith("name") ? (sort.equals("name_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>") : "") + "</th>");
        out.print("<th onclick=\"processSubjectList(" + page + ", '" + (sort != null && sort.equals("semester_up") ? "semester_up" : "semester_down") + "', false)\">Semester" + (sort != null && sort.startsWith("semester") ? (sort.equals("semester_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>") : "") + "</th>");
        out.print("<th width=\"10%\" onclick=\"processSubjectList(" + page + ", '" + (sort != null && sort.equals("credit_up") ? "credit_up" : "credit_down") + "', false)\">No Credit" + (sort != null && sort.startsWith("semester") ? (sort.equals("credit_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>") : "") + "</th>");
        out.print("<th>Status</th>");
        out.print("<th>Author</th>");
        out.print("<th>Action</th>");
        out.print("</thead>");
        out.print("                                    <tbody>");
        for (Subject s : listSubject) {
            out.print("<tr>\n"
                    + "                                                    <td>" + s.getSubjectID() + "</td>\n"
                    + "                                                    <td>" + s.getSubjectCode() + "</td>\n"
                    + "                                                    <td>" + s.getSubjectName() + "</td>\n"
                    + "                                                    <td class=\"text-center\">" + s.getSemester() + "</td>\n"
                    + "                                                    <td class=\"text-center\">" + s.getNoCredit() + "</td>\n");
            if (s.isIsActive()) {
                out.print("<td style=\"color: green\">Active</td>\n");
            } else {
                out.print("<td style=\"color: red\">Inactive</td>\n");
            }
            out.print("<td>"+s.getAccount().getFullName()+"</td>");
            out.print("<td>"
                    + "<button class=\"btn bg-white\">\n"
                    + "                                                                <a href=\"update-details?action=subject&sid=" + s.getSubjectID() + "\"><i class=\"ti ti ti-pencil-alt font-weight-bold\" style=\"color: black; background-color: gainsboro\"></i></a>\n"
                    + "                                                            </button>"
                    + "</td>\n");
            out.print("                                                </tr>");

        }
        String str = "</tbody>\n"
                + "                                    </table>\n"
                + "                                    <div style=\"float: right\">\n"
                + "                                        <ul class=\"pagination\">\n";
        if (page == 1) {
            str += "<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Previous</a></li>";
        } else {
            str += "<li class=\"page-item\"><a onclick=\"processSubjectList(" + (page - 1) + ",'" + sort + "', true)\" class=\"page-link\">Previous</a></li>";
        }

        str += "<li class=\"page-item\"><a id=\"page\" class=\"page-link\">" + page + "</a></li>";

        if (page == totalPage) {
            str += "<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Next</a></li>";
        } else {
            str += "<li class=\"page-item\"><a onclick=\"processSubjectList(" + (page + 1) + ",'" + sort + "', true)\" class=\"page-link\">Next</a></li>";
        }
        str += "</ul>\n"
                + "                 </div>";
        out.print(str);
    }

    public void showUserList(HttpServletRequest request, HttpServletResponse response, ArrayList<Account> listUser, int page, int totalPage, String sort)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        for (Account a : listUser) {
            System.out.println(a.getAccountID());
        }
        Account account = (Account) session.getAttribute("account");

        out.println("<table class=\"table text-center\">");
        out.println("<thead class=\"thead-orange\">");
        out.println("<th onclick=\"processUserList(" + page + ", false, '" + (sort != null && sort.equals("id_up") ? "id_down" : "id_up") + "', false)\">ID" + (sort != null && sort.startsWith("id") ? (sort.equals("id_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>") : "") + "</th>");
        out.println("<th onclick=\"processUserList(" + page + ", false, '" + (sort != null && sort.equals("name_up") ? "name_down" : "name_up") + "', false)\">Name" + (sort != null && sort.startsWith("name") ? (sort.equals("name_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>") : "") + "</th>");
        out.println("<th onclick=\"processUserList(" + page + ", false, '" + (sort != null && sort.equals("user_up") ? "user_down" : "user_up") + "', false)\">User Name" + (sort != null && sort.startsWith("user") ? (sort.equals("user_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>") : "") + "</th>");
        out.println("<th onclick=\"processUserList(" + page + ", false, '" + (sort != null && sort.equals("email_up") ? "email_down" : "email_up") + "', false)\">Email" + (sort != null && sort.startsWith("email") ? (sort.equals("email_up") ? "<i style=\"font-weight: bold\" class=\"ti ti-arrow-down\"></i>" : "<i style=\"font-weight: bold\" class=\"ti ti-arrow-up\"></i>") : "") + "</th>");
        out.println("<th>Role</th>");
        out.println("<th>Status</th>");
        out.println("<th>Action</th>");
        out.println("</thead>");
        out.println("<body>");

        for (Account list : listUser) {
            out.print("<tr>");
            out.print("<td>" + list.getAccountID() + "</td>");
            out.print("<td>" + list.getFullName() + "</td>");
            out.print("<td>" + list.getUserName() + "</td>");
            out.print("<td>" + list.getEmail() + "</td>");
            out.print("<td>" + list.getRole().getRoleName() + "</td>");
            out.print("<td style=\"color: " + (list.isIsActive() == true ? "green" : "red") + "\">" + (list.isIsActive() != false ? "Active" : "Block") + "</td>");

            if (account.getAccountID() != list.getAccountID() && account.getRoleID() == 8 && list.getRoleID() < 8) {
                out.print("<td>");
                out.print("<button data-toggle=\"modal\" data-target=\"#confirmU" + list.getAccountID() + "\" class=\"btn bg-white\">");
                out.print("<i class=\"ti " + (list.isIsActive() == false ? "ti-lock" : "ti-unlock") + " font-weight-bold\" style=\"color: " + (list.isIsActive() == false ? "red" : "green") + "\"></i>");
                out.print("</button>");
                out.print("<button class=\"btn bg-white\">");
                out.print("<a href=\"update-details?action=user&aid=" + list.getAccountID() + "\"><i class=\"ti ti-pencil-alt\" style=\"color: black\"></i></a>");
                out.print("</button>");
                out.print("</td>");
            } else if (account.getAccountID() == list.getAccountID() || account.getRoleID() < 8) {
                out.print("<td></td>");
            }

            out.print("</tr>");

            out.print("<div class=\"modal fade\" id=\"confirmU" + list.getAccountID() + "\">");
            out.print("<div class=\"modal-dialog\" role=\"document\">");
            out.print("<div class=\"modal-content\">");
            out.print("<div class=\"modal-header\">");
            out.print("<h4 class=\"modal-title text-center\">Do you want to change status account " + list.getFullName() + "?</h4>");
            out.print("<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">");
            out.print("<span aria-hidden=\"true\">&times;</span>");
            out.print("</button>");
            out.print("</div>");
            out.print("<div class=\"modal-body\">");
            out.print("<span>Account ID: <label>" + list.getAccountID() + "</label></span><br>");
            out.print("<span>Email: <label>" + list.getEmail() + "</label></span><br>");
            out.print("<span>User Name: <label>" + list.getUserName() + "</label></span>");
            out.print("</div>");
            out.print("<div class=\"modal-footer\">");
            out.print("<button onclick=\"processUserList(" + page + ", " + list.getAccountID() + ")\" data-dismiss=\"modal\" type=\"button\" class=\"btn btn-primary\" style=\"background-color: #007bff; color: white\">" + (list.isIsActive() != true ? "Active" : "Block") + "</button>");
            out.print("<button type=\"button\" class=\"btn btn-secondary\" style=\"background-color: #6c757d; color: white\" data-dismiss=\"modal\">Close</button>");
            out.print("</div>");
            out.print("</div>");
            out.print("</div>");

        }
        String str = "</tbody>\n"
                + "                                    </table>\n"
                + "                                    <div style=\"float: right\">\n"
                + "                                        <ul class=\"pagination\">\n";
        if (page == 1) {
            str += "<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Previous</a></li>";
        } else {
            str += "<li class=\"page-item\"><a onclick=\"processUserList(" + (page - 1) + ", false)\" class=\"page-link\">Previous</a></li>";
        }

        str += "<li class=\"page-item\"><a id=\"page\" class=\"page-link\">" + page + "</a></li>";

        if (page == totalPage) {
            str += "<li class=\"page-item\"><a style=\"pointer-events: none\" class=\"page-link\">Next</a></li>";
        } else {
            str += "<li class=\"page-item\"><a onclick=\"processUserList(" + (page + 1) + ", false)\" class=\"page-link\">Next</a></li>";
        }

        str += "</ul>\n"
                + "                 </div>";
        out.print(str);
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
