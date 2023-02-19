/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module;

/**
 *
 * @author tient
 */
public class Assessment {
//    SELECT `assessment`.`assessmentID`,
//    `assessment`.`SyllabusID`,
//    `assessment`.`category`,
//    `assessment`.`Type`,
//    `assessment`.`Part`,
//    `assessment`.`Weight`,
//    `assessment`.`CompletionCriteria`,
//    `assessment`.`Duration`,
//    `assessment`.`QuestionType`,
//    `assessment`.`NoQuestion`,
//    `assessment`.`KnowledgeandSkill`,
//    `assessment`.`GradingGuide`,
//    `assessment`.`Note`
//FROM `swp391`.`assessment`;
    private int assessmentID;
    private int syllabusID;
    private String category;
    private String type;
    private int part;
    private String weight;
    private String completionCriteria;
    private String duration;
    private String questionType;
    private String noQuestion;
    private String knowledgeandSkill;
    private String gradingGuide;
    private String note;

    public Assessment() {
    }

    public Assessment(int assessmentID, int syllabusID, String category, String type, int part, String weight, String completionCriteria, String duration, String questionType, String noQuestion, String knowledgeandSkill, String gradingGuide, String note) {
        this.assessmentID = assessmentID;
        this.syllabusID = syllabusID;
        this.category = category;
        this.type = type;
        this.part = part;
        this.weight = weight;
        this.completionCriteria = completionCriteria;
        this.duration = duration;
        this.questionType = questionType;
        this.noQuestion = noQuestion;
        this.knowledgeandSkill = knowledgeandSkill;
        this.gradingGuide = gradingGuide;
        this.note = note;
    }

   

    public int getAssessmentID() {
        return assessmentID;
    }

    public void setAssessmentID(int assessmentID) {
        this.assessmentID = assessmentID;
    }

    public int getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(int syllabusID) {
        this.syllabusID = syllabusID;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getPart() {
        return part;
    }

    public void setPart(int part) {
        this.part = part;
    }

    

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getCompletionCriteria() {
        return completionCriteria;
    }

    public void setCompletionCriteria(String completionCriteria) {
        this.completionCriteria = completionCriteria;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getQuestionType() {
        return questionType;
    }

    public void setQuestionType(String questionType) {
        this.questionType = questionType;
    }

    public String getNoQuestion() {
        return noQuestion;
    }

    public void setNoQuestion(String noQuestion) {
        this.noQuestion = noQuestion;
    }

    public String getKnowledgeandSkill() {
        return knowledgeandSkill;
    }

    public void setKnowledgeandSkill(String knowledgeandSkill) {
        this.knowledgeandSkill = knowledgeandSkill;
    }

    public String getGradingGuide() {
        return gradingGuide;
    }

    public void setGradingGuide(String gradingGuide) {
        this.gradingGuide = gradingGuide;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
    
}
