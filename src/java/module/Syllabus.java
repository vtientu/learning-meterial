/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 *
 * @author tient
 */
public class Syllabus {
    private String subjectCode;
    private String subjectNameEN;
    private String subjectNameVN;
    private boolean isActive;
    private boolean isApproved;
    private String decisionNo;
    private int noCredit;
    private String degreeLevel;
    private String timeAllocation;
    private String description;
    private String studentTasks;
    private String tools;
    private int scoringScale;
    private String note;
    private int MinAvgMarkToPass;
    private Date approvedDate;
    private Subject subject;

    public Syllabus() {
    }

    public Syllabus(String subjectCode, String subjectNameEN, String subjectNameVN, boolean isActive, boolean isApproved, String decisionNo, int noCredit, String degreeLevel, String timeAllocation, String description, String studentTasks, String tools, int scoringScale, String note, int MinAvgMarkToPass, Date approvedDate, Subject subject) {
        this.subjectCode = subjectCode;
        this.subjectNameEN = subjectNameEN;
        this.subjectNameVN = subjectNameVN;
        this.isActive = isActive;
        this.isApproved = isApproved;
        this.decisionNo = decisionNo;
        this.noCredit = noCredit;
        this.degreeLevel = degreeLevel;
        this.timeAllocation = timeAllocation;
        this.description = description;
        this.studentTasks = studentTasks;
        this.tools = tools;
        this.scoringScale = scoringScale;
        this.note = note;
        this.MinAvgMarkToPass = MinAvgMarkToPass;
        this.approvedDate = approvedDate;
        this.subject = subject;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectNameEN() {
        return subjectNameEN;
    }

    public void setSubjectNameEN(String subjectNameEN) {
        this.subjectNameEN = subjectNameEN;
    }

    public String getSubjectNameVN() {
        return subjectNameVN;
    }

    public void setSubjectNameVN(String subjectNameVN) {
        this.subjectNameVN = subjectNameVN;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public boolean isIsApproved() {
        return isApproved;
    }

    public void setIsApproved(boolean isApproved) {
        this.isApproved = isApproved;
    }

    public String getDecisionNo() {
        return decisionNo;
    }

    public void setDecisionNo(String decisionNo) {
        this.decisionNo = decisionNo;
    }

    public int getNoCredit() {
        return noCredit;
    }

    public void setNoCredit(int noCredit) {
        this.noCredit = noCredit;
    }

    public String getDegreeLevel() {
        return degreeLevel;
    }

    public void setDegreeLevel(String degreeLevel) {
        this.degreeLevel = degreeLevel;
    }

    public String getTimeAllocation() {
        return timeAllocation;
    }

    public void setTimeAllocation(String timeAllocation) {
        this.timeAllocation = timeAllocation;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStudentTasks() {
        return studentTasks;
    }

    public void setStudentTasks(String studentTasks) {
        this.studentTasks = studentTasks;
    }

    public String getTools() {
        return tools;
    }

    public void setTools(String tools) {
        this.tools = tools;
    }

    public int getScoringScale() {
        return scoringScale;
    }

    public void setScoringScale(int scoringScale) {
        this.scoringScale = scoringScale;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getMinAvgMarkToPass() {
        return MinAvgMarkToPass;
    }

    public void setMinAvgMarkToPass(int MinAvgMarkToPass) {
        this.MinAvgMarkToPass = MinAvgMarkToPass;
    }

    public Date getApprovedDate() {
        return approvedDate;
    }

    public void setApprovedDate(Date approvedDate) {
        this.approvedDate = approvedDate;
    }

    public String getApprovedDateFormat(){
        SimpleDateFormat date = new SimpleDateFormat("dd-mm-yyyy");
        return date.format(this.approvedDate);
    }
    
    
    @Override
    public String toString() {
        return "Syllabus{" + "subjectCode=" + subjectCode + ", subjectNameEN=" + subjectNameEN + ", subjectNameVN=" + subjectNameVN + ", isActive=" + isActive + ", isApproved=" + isApproved + ", decisionNo=" + decisionNo + ", noCredit=" + noCredit + ", degreeLevel=" + degreeLevel + ", timeAllocation=" + timeAllocation + ", description=" + description + ", studentTasks=" + studentTasks + ", tools=" + tools + ", scoringScale=" + scoringScale + ", note=" + note + ", MinAvgMarkToPass=" + MinAvgMarkToPass + ", approvedDate=" + approvedDate + ", subject=" + subject + '}';
    }
    
    
}
