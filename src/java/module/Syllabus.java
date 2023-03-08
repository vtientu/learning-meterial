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
    private int syllabusID;
    private String syllabusNameEN;
    private String syllabusNameVN;
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
    private String preRequisite;
    private Subject subject;
    private Decision decision;

    public Syllabus() {
    }

    public Syllabus(int syllabusID, String syllabusNameEN, String syllabusNameVN, boolean isActive, boolean isApproved, String decisionNo, int noCredit, String degreeLevel, String timeAllocation, String description, String studentTasks, String tools, int scoringScale, String note, int MinAvgMarkToPass, Date approvedDate, String preRequisite, Subject subject, Decision decision) {
        this.syllabusID = syllabusID;
        this.syllabusNameEN = syllabusNameEN;
        this.syllabusNameVN = syllabusNameVN;
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
        this.preRequisite = preRequisite;
        this.subject = subject;
        this.decision = decision;
    }

    

    public Decision getDecision() {
        return decision;
    }

    public void setDecision(Decision decision) {
        this.decision = decision;
    }

    

    public String getPreRequisite() {
        return preRequisite;
    }

    public void setPreRequisite(String preRequisite) {
        this.preRequisite = preRequisite;
    }

    

    public int getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(int syllabusID) {
        this.syllabusID = syllabusID;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public String getSyllabusNameEN() {
        return syllabusNameEN;
    }

    public void setSyllabusNameEN(String syllabusNameEN) {
        this.syllabusNameEN = syllabusNameEN;
    }

    public String getSyllabusNameVN() {
        return syllabusNameVN;
    }

    public void setSyllabusNameVN(String syllabusNameVN) {
        this.syllabusNameVN = syllabusNameVN;
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
    
          
    
    
    
}
