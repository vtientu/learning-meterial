/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

/**
 *
 * @author tient
 */
public class Feedback {
    private int fbID;
    private int accountID;
    private int syllabusID;
    private String displayName;
    private String email;
    private String title;
    private String description;

    public Feedback() {
    }

    public Feedback(int fbID, int accountID, int syllabusID, String displayName, String email, String title, String description) {
        this.fbID = fbID;
        this.accountID = accountID;
        this.syllabusID = syllabusID;
        this.displayName = displayName;
        this.email = email;
        this.title = title;
        this.description = description;
    }

    

    

    public int getFbID() {
        return fbID;
    }

    public void setFbID(int fbID) {
        this.fbID = fbID;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }
 
    

    public int getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(int syllabusID) {
        this.syllabusID = syllabusID;
    }
    
    
    
}
