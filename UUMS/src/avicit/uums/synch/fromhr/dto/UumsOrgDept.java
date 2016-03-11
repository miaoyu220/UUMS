package avicit.uums.synch.fromhr.dto;

import java.util.Date;

import avicit.platform6.api.sysuser.dto.SysDept;

public class UumsOrgDept extends SysDept {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String orgCode; // 组织代码
	private String parentOrgId; // 父组织ID
	private String operFlag; // 操作类型（1:新增, 2:更新, 3:删除）
	private String orgOrDept; // 组织或部门（1:组织, 2:部门）
	private String parentOrgCode; // 父组织代码
	private java.lang.String orgName; // 名称
	private java.lang.String orgDesc; // 描述
	private java.lang.String orgPlace; // 办公地点
	private Date synchTime; //同步时间
	private String synchFlag;//同步状态（0：未同步，1：同步成功）
	private String sid; //HR同步表中的ID
	
	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getSynchFlag() {
		return synchFlag;
	}

	public void setSynchFlag(String synchFlag) {
		this.synchFlag = synchFlag;
	}

	public Date getSynchTime() {
		return synchTime;
	}

	public void setSynchTime(Date synchTime) {
		this.synchTime = synchTime;
	}

	public java.lang.String getOrgName() {
		return orgName;
	}

	public void setOrgName(java.lang.String orgName) {
		this.orgName = orgName;
	}

	public java.lang.String getOrgDesc() {
		return orgDesc;
	}

	public void setOrgDesc(java.lang.String orgDesc) {
		this.orgDesc = orgDesc;
	}

	public java.lang.String getOrgPlace() {
		return orgPlace;
	}

	public void setOrgPlace(java.lang.String orgPlace) {
		this.orgPlace = orgPlace;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getParentOrgId() {
		return parentOrgId;
	}

	public void setParentOrgId(String parentOrgId) {
		this.parentOrgId = parentOrgId;
	}

	public String getOperFlag() {
		return operFlag;
	}

	public void setOperFlag(String operFlag) {
		this.operFlag = operFlag;
	}

	public String getOrgOrDept() {
		return orgOrDept;
	}

	public void setOrgOrDept(String orgOrDept) {
		this.orgOrDept = orgOrDept;
	}

	public String getParentOrgCode() {
		return parentOrgCode;
	}

	public void setParentOrgCode(String parentOrgCode) {
		this.parentOrgCode = parentOrgCode;
	}

}
