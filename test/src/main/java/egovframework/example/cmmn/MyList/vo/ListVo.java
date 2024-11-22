package egovframework.example.cmmn.MyList.vo;

import java.util.Date;

public class ListVo {
	private int testId;
	private String testTitle;
	private String testContent;
	private String testName;
	private Date testDate;
	private String password;
	private boolean isNew;
	
	public int getTestId() {
		return testId;
	}
	public void setTestId(int testId) {
		this.testId = testId;
	}
	public String getTestTitle() {
		return testTitle;
	}
	public void setTestTitle(String testTitle) {
		this.testTitle = testTitle;
	}
	public String getTestContent() {
		return testContent;
	}
	public void setTestContent(String testContent) {
		this.testContent = testContent;
	}
	public String getTestName() {
		return testName;
	}
	public void setTestName(String testName) {
		this.testName = testName;
	}
	public Date getTestDate() {
		return testDate;
	}
	public void setTestDate(Date testDate) {
		this.testDate = testDate;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public boolean getisNew() {
		return isNew;
	}
	
	public void setIsNew(boolean isNew) {
		this.isNew = isNew;
	}
}
