package avicit.uums.synch.log.userlog.uumslogsynchuser.service;
import java.io.Serializable;
import java.util.List;
import java.util.concurrent.Callable;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.DateUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.uums.synch.fromhr.dto.UumsOrgDept;
import avicit.uums.synch.log.orglog.uumslogsynchorg.dto.UumsLogSynchOrgDTO;
import avicit.uums.synch.log.userlog.uumslogsynchuser.dao.UumsLogSynchUserDao;
import avicit.uums.synch.log.userlog.uumslogsynchuser.dto.UumsLogSynchUserDTO;
import avicit.uums.synch.toappsys.dto.UumsUser;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @classname:  UumsLogSynchUserService
 * @description: 定义 用户同步日志表实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsLogSynchUserService  implements Serializable, Callable<String> {

	private static final Logger logger =  LoggerFactory.getLogger(UumsLogSynchUserService.class);
	
    private static final long serialVersionUID = 1L;
    
//	@Autowired
//	private SysLogUtil sysLogUtil;
	
	@Autowired
	private UumsLogSynchUserDao dao;
	private List<UumsUser> userList;
	private List<UumsLogSynchUserDTO> logList;


	public List<UumsUser> getUserList() {
		return userList;
	}
	public void setUserList(List<UumsUser> userList) {
		this.userList = userList;
	}
	public List<UumsLogSynchUserDTO> getLogList() {
		return logList;
	}
	public void setLogList(List<UumsLogSynchUserDTO> logList) {
		this.logList = logList;
	}
	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsLogSynchUserDTO> searchUumsLogSynchUserByPage(QueryReqBean<UumsLogSynchUserDTO> queryReqBean) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			UumsLogSynchUserDTO searchParams = queryReqBean.getSearchParams();

			Page<UumsLogSynchUserDTO> dataList =  dao.searchUumsLogSynchUserByPage(searchParams);
			QueryRespBean<UumsLogSynchUserDTO> queryRespBean =new QueryRespBean<UumsLogSynchUserDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsLogSynchUserByPaging出错：", e);
			throw e;
		}
	}
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsLogSynchUserDTO> searchUumsLogSynchUser(QueryReqBean<UumsLogSynchUserDTO> queryReqBean) throws Exception {
	    try{
	    	UumsLogSynchUserDTO searchParams = queryReqBean.getSearchParams();
	    	List<UumsLogSynchUserDTO> dataList = dao.searchUumsLogSynchUser(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchUumsLogSynchUser出错：", e);
	    	throw new DaoException("",e);
	    }
    }
	/**
	 * 通过主键查询单条记录
	 * @param id
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public UumsLogSynchUserDTO queryUumsLogSynchUserByPrimaryKey(String id) throws Exception {
		try{
			UumsLogSynchUserDTO dto = dao.findUumsLogSynchUserById(id);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsLogSynchUser出错：", e);
	    	throw new DaoException("",e);
	    }
	}

	/**
	 * 新增对象
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public String insertUumsLogSynchUser(UumsLogSynchUserDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dao.insertUumsLogSynchUser(dto);
			//记录日志
			SysLogUtil.log4Insert(dto);
			return id;
		}catch(Exception e){
			logger.error("insertUumsLogSynchUser出错：", e);
			throw new DaoException("",e);
		}
	}
	/**
	 * 新增对象,多线程执行专用
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public void insertUumsLogSynchUser(){
		if(this.userList == null && this.userList.size() == 0){
			return;
		}
		int i = 0;
		for(UumsUser user : this.userList){
			try {
				UumsLogSynchUserDTO dto = this.logList.get(i);
				String id = ComUtil.getId();
				dto.setId(id);
				PojoUtil.setSysProperties(dto, OpType.insert);
				dto.setUserId(user.getLoginName());
				dto.setUserName(user.getName());
				dto.setSynchTime(DateUtil.getToday());
				dto.setOperFlag(user.getOperFlag());
				
				dao.insertUumsLogSynchUser(dto);
			} catch (Exception e) {
				logger.error("insertUumsLogSynchUser出错：", e);
			}
		}
	}
	/**
	 * 修改对象全部字段
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int updateUumsLogSynchUser(UumsLogSynchUserDTO dto) throws Exception {
			//记录日志
			UumsLogSynchUserDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dao.updateUumsLogSynchUserAll(old);
			if(ret ==0){
				throw new DaoException("数据失效，请从新更新");
			}
			return ret;

	}
	/**
	 * 修改对象部分字段
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int updateUumsLogSynchUserSensitive(UumsLogSynchUserDTO dto) throws Exception {
		try{
			//记录日志
			UumsLogSynchUserDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dao.updateUumsLogSynchUserSensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请从新更新");
			}
			return count;
		}catch(Exception e){
			logger.error("searchDemoBusinessTrip出错：", e);
			throw new DaoException("",e);
		}

	}
	
	/**
	 * 按主键单条删除
	 * @param id
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsLogSynchUserById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			SysLogUtil.log4Delete(findById(id));
			return dao.deleteUumsLogSynchUserById(id);
		}catch(Exception e){
			logger.error("deleteUumsLogSynchUser出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsLogSynchUserByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsLogSynchUserById(id);
			result++;
		}
		return result;
	}
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsLogSynchUserDTO findById(String id) throws Exception {
		try{
			UumsLogSynchUserDTO dto = dao.findUumsLogSynchUserById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("findUumsLogSynchUser出错：", e);
	    		throw e;
	    }
	}
	@Override
	public String call() throws Exception {
		this.insertUumsLogSynchUser();
		return null;
	}
		

}

