/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

import java.util.ArrayList;

/**
 *
 * @author inuya
 */
public class Elective {

    /*
    elective.ElectiveID,
elective.ElectiveNameEN,
elective.ElectiveNameVN,
elective.isActive,
elective.note,
     */
    private int electiveID;
    private String electiveNameEN;
    private String electiveNameVN;
    private int isActive;
    private String note;
    private ArrayList<Subject> subject;

    public Elective() {
    }

    public Elective(int electiveID, String electiveNameEN, String electiveNameVN, int isActive, String note) {
        this.electiveID = electiveID;
        this.electiveNameEN = electiveNameEN;
        this.electiveNameVN = electiveNameVN;
        this.isActive = isActive;
        this.note = note;
    }

    public int getElectiveID() {
        return electiveID;
    }

    public void setElectiveID(int electiveID) {
        this.electiveID = electiveID;
    }

    public String getElectiveNameEN() {
        return electiveNameEN;
    }

    public void setElectiveNameEN(String electiveNameEN) {
        this.electiveNameEN = electiveNameEN;
    }

    public String getElectiveNameVN() {
        return electiveNameVN;
    }

    public void setElectiveNameVN(String electiveNameVN) {
        this.electiveNameVN = electiveNameVN;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ArrayList<Subject> getSubject() {
        return subject;
    }

    public void setSubject(ArrayList<Subject> subject) {
        this.subject = subject;
    }

}
