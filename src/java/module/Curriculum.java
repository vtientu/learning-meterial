package module;

import java.util.ArrayList;

/**
 *
 * @author inuya
 */
public class Curriculum {
    /*
    CurriculumCode NVARCHAR(20),
	majorID int,
	CurriculumNameEN NVARCHAR(255) not null,
	CurriculumNameVN NVARCHAR(255) not null,
	Description TEXT not null,
	primary key (CurriculumCode)
    */
    private int curID;
    private String curriculumCode;
    private Major major;
    private String curriculumNameEN;
    private String curriculumNameVN;
    private String description;
    private Decision decision;
    private int approve;
    private ArrayList<Subject> subject;
    private ArrayList<Elective> elective;

    public Curriculum() {
    }

    public Curriculum(int curID, String curriculumCode, Major major, String curriculumNameEN, String curriculumNameVN, String description, Decision decision,int approve) {
        this.curID = curID;
        this.curriculumCode = curriculumCode;
        this.major = major;
        this.curriculumNameEN = curriculumNameEN;
        this.curriculumNameVN = curriculumNameVN;
        this.description = description;
        this.decision = decision;
        this.approve = approve;
    }

    public int getCurID() {
        return curID;
    }

    public void setCurID(int curID) {
        this.curID = curID;
    }

    public String getCurriculumCode() {
        return curriculumCode;
    }

    public void setCurriculumCode(String curriculumCode) {
        this.curriculumCode = curriculumCode;
    }

    public Major getMajor() {
        return major;
    }

    public void setMajor(Major major) {
        this.major = major;
    }

    public String getCurriculumNameEN() {
        return curriculumNameEN;
    }

    public void setCurriculumNameEN(String curriculumNameEN) {
        this.curriculumNameEN = curriculumNameEN;
    }

    public String getCurriculumNameVN() {
        return curriculumNameVN;
    }

    public void setCurriculumNameVN(String curriculumNameVN) {
        this.curriculumNameVN = curriculumNameVN;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Decision getDecision() {
        return decision;
    }

    public void setDecision(Decision decision) {
        this.decision = decision;
    }

    public int getApprove() {
        return approve;
    }

    public void setApprove(int approve) {
        this.approve = approve;
    }

    public ArrayList<Subject> getSubject() {
        return subject;
    }

    public void setSubject(ArrayList<Subject> subject) {
        this.subject = subject;
    }

    public ArrayList<Elective> getElective() {
        return elective;
    }

    public void setElective(ArrayList<Elective> elective) {
        this.elective = elective;
    }

    

}
