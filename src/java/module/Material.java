/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

/**
 *
 * @author tient
 */
public class Material {
    private int materialID;
    private String materialDescription;
    private int syllabusID;
    private String author;
    private String publisher;
    private String publishedDate;
    private String edition;
    private String ISBN;
    private boolean isMainMaterial;
    private boolean isHardCopy;
    private boolean isOnline;
    private String note;
    private boolean isActive;

    public Material() {
    }

    public Material(int materialID, String materialDescription, int syllabusID, String author, String publisher, String publishedDate, String edition, String ISBN, boolean isMainMaterial, boolean isHardCopy, boolean isOnline, String note, boolean isActive) {
        this.materialID = materialID;
        this.materialDescription = materialDescription;
        this.syllabusID = syllabusID;
        this.author = author;
        this.publisher = publisher;
        this.publishedDate = publishedDate;
        this.edition = edition;
        this.ISBN = ISBN;
        this.isMainMaterial = isMainMaterial;
        this.isHardCopy = isHardCopy;
        this.isOnline = isOnline;
        this.note = note;
        this.isActive = isActive;
    }

    public int getMaterialID() {
        return materialID;
    }

    public void setMaterialID(int materialID) {
        this.materialID = materialID;
    }

    public String getMaterialDescription() {
        return materialDescription;
    }

    public void setMaterialDescription(String materialDescription) {
        this.materialDescription = materialDescription;
    }

    public int getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(int syllabusID) {
        this.syllabusID = syllabusID;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(String publishedDate) {
        this.publishedDate = publishedDate;
    }

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public boolean isIsMainMaterial() {
        return isMainMaterial;
    }

    public void setIsMainMaterial(boolean isMainMaterial) {
        this.isMainMaterial = isMainMaterial;
    }

    public boolean isIsHardCopy() {
        return isHardCopy;
    }

    public void setIsHardCopy(boolean isHardCopy) {
        this.isHardCopy = isHardCopy;
    }

    public boolean isIsOnline() {
        return isOnline;
    }

    public void setIsOnline(boolean isOnline) {
        this.isOnline = isOnline;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
    
    
    
}
