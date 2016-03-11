package avicit.uums.synch.fromhr.service;

import java.sql.Blob;
import org.springframework.stereotype.Service;
import avicit.platform6.modules.system.sysorguser.sysuser.domain.SysUser;
import avicit.platform6.modules.system.sysorguser.sysuser.service.SysUserEvent;
import avicit.uums.synch.fromhr.dto.UumsUserCache;

/**
 * 平台用户管理的事件处理，主要是进行用户照片的管理
 * @author miaoyu
 * @since 2016年3月10日
 *
 */
@Service
public class SynchUserFromHrEventImpl implements SysUserEvent {

	@Override
	public void beforeUpdateSysUser(SysUser sysUser) {
		if(sysUser == null){
			return;
		}
		Blob photo = UumsUserCache.PHOTO_CAHCHE.get(sysUser.getNo());
		if(photo != null){
			sysUser.setPhoto(photo);
			UumsUserCache.PHOTO_CAHCHE.remove(sysUser.getNo());
		}
	}

	@Override
	public void afterUpdateSysUser(SysUser sysUser) {
		// TODO Auto-generated method stub

	}

	@Override
	public void beforeInsertSysUser(SysUser sysUser) {
		if(sysUser == null){
			return;
		}
		Blob photo = UumsUserCache.PHOTO_CAHCHE.get(sysUser.getNo());
		if(photo != null){
			sysUser.setPhoto(photo);
			UumsUserCache.PHOTO_CAHCHE.remove(sysUser.getNo());
		}
	}

	@Override
	public void afterInsertSysUser(SysUser sysUser) {
		// TODO Auto-generated method stub

	}

	@Override
	public void beforeDeleteSysUser(SysUser sysUser) {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterDeleteSysUser(SysUser sysUser) {
		// TODO Auto-generated method stub

	}

}
