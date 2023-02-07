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
    private String preRequisite;
    private int semester;
    private String subjectCode;
    private String subjectName;

    public Subject() {
    }

    public Subject(int noCredit, String preRequisite, int semester, String subjectCode, String subjectName) {
        this.noCredit = noCredit;
        this.preRequisite = preRequisite;
        this.semester = semester;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
    }

    public int getNoCredit() {
        return noCredit;
    }

    public void setNoCredit(int noCredit) {
        this.noCredit = noCredit;
    }

    public String getPreRequisite() {
        return preRequisite;
    }

    public void setPreRequisite(String preRequisite) {
        this.preRequisite = preRequisite;
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

    @Override
    public String toString() {
        return "Subject{" + "noCredit=" + noCredit + ", preRequisite=" + preRequisite + ", semester=" + semester + ", subjectCode=" + subjectCode + ", subjectName=" + subjectName + '}';
    }
    
    
}
