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
    private Subject subject;
    private String subjectPre;

    public PreRequisite() {
    }

    public PreRequisite(int preID, Subject subject, String subjectPre) {
        this.preID = preID;
        this.subject = subject;
        this.subjectPre = subjectPre;
    }

    public int getPreID() {
        return preID;
    }

    public void setPreID(int preID) {
        this.preID = preID;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public String getSubjectPre() {
        return subjectPre;
    }

    public void setSubjectPre(String subjectPre) {
        this.subjectPre = subjectPre;
    }
}
