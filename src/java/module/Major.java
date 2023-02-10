/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

/**
 *
 * @author inuya
 */
public class Major {
    /*
    majorID int AUTO_INCREMENT primary key,
	keyword NVARCHAR(255) not null,
	majorNameEN NVARCHAR(255) not null,
	majorNameVN NVARCHAR(255) not null
    */
    private int majorID;
    private String keyword;
    private String majorNameEN;
    private String majorNameVN;
    private boolean isActive;

    public Major() {
    }

    public Major(int majorID, String keyword, String majorNameEN, String majorNameVN, boolean isActive) {
        this.majorID = majorID;
        this.keyword = keyword;
        this.majorNameEN = majorNameEN;
        this.majorNameVN = majorNameVN;
        this.isActive = isActive;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    

    public int getMajorID() {
        return majorID;
    }

    public void setMajorID(int majorID) {
        this.majorID = majorID;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getMajorNameEN() {
        return majorNameEN;
    }

    public void setMajorNameEN(String majorNameEN) {
        this.majorNameEN = majorNameEN;
    }

    public String getMajorNameVN() {
        return majorNameVN;
    }

    public void setMajorNameVN(String majorNameVN) {
        this.majorNameVN = majorNameVN;
    }
    
}
