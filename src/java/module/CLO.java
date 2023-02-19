/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

/**
 *
 * @author tient
 */
public class CLO {
    private int cloID;
    private int syID;
    private String cloName;
    private String cloDetails;
    private String loDetails;

    public CLO() {
    }

    public CLO(int cloID, int syID, String cloName, String cloDetails, String loDetails) {
        this.cloID = cloID;
        this.syID = syID;
        this.cloName = cloName;
        this.cloDetails = cloDetails;
        this.loDetails = loDetails;
    }

    public int getCloID() {
        return cloID;
    }

    public void setCloID(int cloID) {
        this.cloID = cloID;
    }

    public int getSyID() {
        return syID;
    }

    public void setSyID(int syID) {
        this.syID = syID;
    }

    public String getCloName() {
        return cloName;
    }

    public void setCloName(String cloName) {
        this.cloName = cloName;
    }

    public String getCloDetails() {
        return cloDetails;
    }

    public void setCloDetails(String cloDetails) {
        this.cloDetails = cloDetails;
    }

    public String getLoDetails() {
        return loDetails;
    }

    public void setLoDetails(String loDetails) {
        this.loDetails = loDetails;
    }
    
    
}
