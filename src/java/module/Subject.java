/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

/**
 *
 * @author tient
 */
public class Subject {
    private int noCredit;
    private int semester;
    private String subjectCode;
    private String subjectName;
    private PreRequisite prerequisite;
    private boolean isActive;

    public Subject() {
    }

    public Subject(int noCredit, int semester, String subjectCode, String subjectName, PreRequisite prerequisite, boolean isActive) {
        this.noCredit = noCredit;
        this.semester = semester;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.prerequisite = prerequisite;
        this.isActive = isActive;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    

    public PreRequisite getPrerequisite() {
        return prerequisite;
    }

    public void setPrerequisite(PreRequisite prerequisite) {
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
