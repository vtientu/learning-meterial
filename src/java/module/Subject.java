/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

import java.util.ArrayList;

/**
 *
 * @author tient
 */
public class Subject {
    private int subjectID;
    private int noCredit;
    private int semester;
    private String subjectCode;
    private String subjectName;
    private ArrayList<PreRequisite> prerequisite;
    private boolean isActive;
    private int electiveID;
    private int comboID;

    public Subject() {
    }

    public Subject(int subjectID, int noCredit, int semester, String subjectCode, String subjectName, ArrayList<PreRequisite> prerequisite, boolean isActive, int electiveID, int comboID) {
        this.subjectID = subjectID;
        this.noCredit = noCredit;
        this.semester = semester;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.prerequisite = prerequisite;
        this.isActive = isActive;
        this.electiveID = electiveID;
        this.comboID = comboID;
    }
    
    

    public Subject(int noCredit, int semester, String subjectCode, String subjectName, ArrayList<PreRequisite> prerequisite, boolean isActive) {
        this.noCredit = noCredit;
        this.semester = semester;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.prerequisite = prerequisite;
        this.isActive = isActive;
    }

    public Subject(int noCredit, int semester, String subjectCode, String subjectName, ArrayList<PreRequisite> prerequisite, boolean isActive, int electiveID, int comboID) {
        this.noCredit = noCredit;
        this.semester = semester;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.prerequisite = prerequisite;
        this.isActive = isActive;
        this.electiveID = electiveID;
        this.comboID = comboID;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }
    
    
    
    public int getElectiveID() {
        return electiveID;
    }

    public void setElectiveID(int electiveID) {
        this.electiveID = electiveID;
    }

    public int getComboID() {
        return comboID;
    }

    public void setComboID(int comboID) {
        this.comboID = comboID;
    }

    


    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public ArrayList<PreRequisite> getPrerequisite() {
        return prerequisite;
    }

    public void setPrerequisite(ArrayList<PreRequisite> prerequisite) {
        this.prerequisite = prerequisite;
    }
   

    public int getNoCredit() {
        return noCredit;
    }

    public void setNoCredit(int noCredit) {
        this.noCredit = noCredit;
    }


    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    
    
}
