/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

/**
 *
 * @author tient
 */
public class PreRequisite {
    private int preID;
    private String subjectCode;
    private String subjectPre;

    public PreRequisite() {
    }

    public PreRequisite(int preID, String subjectCode, String subjectPre) {
        this.preID = preID;
        this.subjectCode = subjectCode;
        this.subjectPre = subjectPre;
    }

    public int getPreID() {
        return preID;
    }

    public void setPreID(int preID) {
        this.preID = preID;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectPre() {
        return subjectPre;
    }

    public void setSubjectPre(String subjectPre) {
        this.subjectPre = subjectPre;
    }
    
    
    
}
