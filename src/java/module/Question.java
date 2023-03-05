/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

/**
 *
 * @author tient
 */
public class Question {
    private int questionID;
    private int syllabusID;
    private int sessionID;
    private String questionName;
    private String details;

    public Question() {
    }

    public Question(int questionID, int syllabusID, int sessionID, String questionName, String details) {
        this.questionID = questionID;
        this.syllabusID = syllabusID;
        this.sessionID = sessionID;
        this.questionName = questionName;
        this.details = details;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public int getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(int syllabusID) {
        this.syllabusID = syllabusID;
    }

    public int getSessionID() {
        return sessionID;
    }

    public void setSessionID(int sessionID) {
        this.sessionID = sessionID;
    }

    public String getQuestionName() {
        return questionName;
    }

    public void setQuestionName(String questionName) {
        this.questionName = questionName;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }
    
    
}
