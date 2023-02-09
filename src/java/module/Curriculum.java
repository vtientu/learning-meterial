package module;

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
    private String curriculumCode;
    private Major major;
    private String curriculumNameEN;
    private String curriculumNameVN;
    private String description;
    private String decisionNo;

    public Curriculum() {
    }

    public Curriculum(String curriculumCode, Major major, String curriculumNameEN, String curriculumNameVN, String description, String decisionNo) {
        this.curriculumCode = curriculumCode;
        this.major = major;
        this.curriculumNameEN = curriculumNameEN;
        this.curriculumNameVN = curriculumNameVN;
        this.description = description;
        this.decisionNo = decisionNo;
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

    public String getDecisionNo() {
        return decisionNo;
    }

    public void setDecisionNo(String decisionNo) {
        this.decisionNo = decisionNo;
    }

}
