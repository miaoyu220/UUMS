package avicit.uums.synch.toappsys.dto;

import java.util.Date;

import avicit.platform6.api.sysuser.dto.SysUser;

public class UumsUser extends SysUser {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Date synchTime; // 同步时间
	private String operFlag; // 操作类型（1:新增, 2:更新, 3:删除）
	private byte[] uumsPhoto; // 照片
	private String sid; //HR同步表中的ID
	
	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public byte[] getUumsPhoto() {
		return uumsPhoto;
	}

	public void setUumsPhoto(byte[] uumsPhoto) {
		this.uumsPhoto = uumsPhoto;
	}

	public Date getSynchTime() {
		return synchTime;
	}

	public void setSynchTime(Date synchTime) {
		this.synchTime = synchTime;
	}

	public String getOperFlag() {
		return operFlag;
	}

	public void setOperFlag(String operFlag) {
		this.operFlag = operFlag;
	}
	
	
}
