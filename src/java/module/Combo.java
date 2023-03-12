/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

/**
 *
 * @author inuya
 */
public class Combo {
    /*
    ComboID int AUTO_INCREMENT primary key,
	ComboName NVARCHAR(255),
    isActive bit DEFAULT 1,
	note TEXT
     */
    private int comboID;
    private String comboName;
    private int isActive;
    private String note;

    public Combo() {
    }

    public Combo(int comboID, String comboName, int isActive, String note) {
        this.comboID = comboID;
        this.comboName = comboName;
        this.isActive = isActive;
        this.note = note;
    }

    public int getComboID() {
        return comboID;
    }

    public void setComboID(int comboID) {
        this.comboID = comboID;
    }

    public String getComboName() {
        return comboName;
    }

    public void setComboName(String comboName) {
        this.comboName = comboName;
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
    
}
