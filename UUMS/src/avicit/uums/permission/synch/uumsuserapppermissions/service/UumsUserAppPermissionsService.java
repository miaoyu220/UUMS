package avicit.uums.permission.synch.uumsuserapppermissions.service;
import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.spring.SpringFactory;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;
import avicit.uums.permission.synch.uumsuserapppermissions.dao.UumsUserAppPermissionsDao;
import avicit.uums.permission.synch.uumsuserapppermissions.dto.UumsUserAppPermissionsDTO;
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsPermissionWorkflowDTO;
import avicit.uums.permission.workflow.uumsuserappworkflow.service.UumsPermissionWorkflowService;

/**
 * @classname:  UumsUserAppPermissionsService
 * @description: 定义 用户应用系统权限管理实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsUserAppPermissionsService  implements Serializable, LoaderConstant{

	private static final Logger logger =  LoggerFactory.getLogger(UumsUserAppPermissionsService.class);
	
    private static final long serialVersionUID = 1L;
    
//	@Autowired
//	private SysLogUtil sysLogUtil;
	
	@Autowired
	private UumsUserAppPermissionsDao dao;
	@Autowired
	private UumsPermissionWorkflowService pwfService;

	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsUserAppPermissionsDTO> searchUumsUserAppPermissionsByPage(QueryReqBean<UumsUserAppPermissionsDTO> queryReqBean) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			UumsUserAppPermissionsDTO searchParams = queryReqBean.getSearchParams();

			Page<UumsUserAppPermissionsDTO> dataList =  dao.searchUumsUserAppPermissionsByPage(searchParams);
			QueryRespBean<UumsUserAppPermissionsDTO> queryRespBean =new QueryRespBean<UumsUserAppPermissionsDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsUserAppPermissionsByPaging出错：", e);
			throw e;
		}
	}
	
	/**
	 * 按主键集合分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsUserAppPermissionsDTO> searchUumsUserAppPermissionsByIds(QueryReqBean<UumsUserAppPermissionsDTO> queryReqBean, List<String> idList) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			Page<UumsUserAppPermissionsDTO> dataList =  new Page<UumsUserAppPermissionsDTO>();
			for(String id : idList){
				UumsUserAppPermissionsDTO dto = dao.findUumsUserAppPermissionsById(id);
				dataList.add(dto);
			}
			QueryRespBean<UumsUserAppPermissionsDTO> queryRespBean =new QueryRespBean<UumsUserAppPermissionsDTO>();
			queryRespBean.setResult(dataList);
			
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsUserAppPermissionsByIds出错：", e);
			throw e;
		}
	}
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsUserAppPermissionsDTO> searchUumsUserAppPermissions(QueryReqBean<UumsUserAppPermissionsDTO> queryReqBean) throws Exception {
	    try{
	    	UumsUserAppPermissionsDTO searchParams = queryReqBean.getSearchParams();
	    	List<UumsUserAppPermissionsDTO> dataList = dao.searchUumsUserAppPermissions(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchUumsUserAppPermissions出错：", e);
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
	public UumsUserAppPermissionsDTO queryUumsUserAppPermissionsByPrimaryKey(String id) throws Exception {
		try{
			UumsUserAppPermissionsDao dao = SpringFactory.getBean(UumsUserAppPermissionsDao.class);
			UumsUserAppPermissionsDTO dto = dao.findUumsUserAppPermissionsById(id);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsUserAppPermissions出错：", e);
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
	public String insertUumsUserAppPermissions(UumsUserAppPermissionsDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dao.insertUumsUserAppPermissions(dto);
			//记录日志
			SysLogUtil.log4Insert(dto);
			return dto.getId();
		}catch(Exception e){
			logger.error("insertUumsUserAppPermissions出错：", e);
			throw new DaoException("",e);
		}
	}
	
	/**
	 * 如果该应用系统中该用户权限已存在，则更新，否则新增
	 * @param dto
	 * @throws Exception
	 */
	public void insertOrUpdatePermission(UumsUserAppPermissionsDTO dto, boolean isAudit)throws Exception{
		try {
			Assert.notNull(dto);
			UumsUserAppPermissionsDTO temp = new UumsUserAppPermissionsDTO();
			temp.setAppId(dto.getAppId());
			temp.setUserId(dto.getUserId());
			List<UumsUserAppPermissionsDTO> oldPerList = dao.searchUumsUserAppPermissions(temp);
			if(oldPerList == null || oldPerList.size() == 0){
//				if(isAudit){
//					dto.setActFlag("0");//新增且需要审批情况下默认活动状态：禁止
//				}else{
//					dto.setActFlag("1");//新增不需要审批情况下默认活动状态：活动
//				}
				dto.setActFlag("0");//新增未同步情况下默认活动状态：禁止
				SysUser user = sysUserLoader.getSysUserById(dto.getUserId());
				if(user != null){
					dto.setUnitCode(user.getUnitCode());
					dto.setUserName(user.getName());
				}
				this.insertUumsUserAppPermissions(dto);
			}else{
				dto.setId(oldPerList.get(0).getId());
				if(!isAudit){//不需要审批且为删除权限操作时活动状态设为：禁止，否则设为：活动
					if("3".equals(dto.getOperFlag())){
						dto.setActFlag("0");
					}else{
						dto.setActFlag("1");
					}
				}
				this.updateUumsUserAppPermissionsSensitive(dto);
			}
		} catch (Exception e) {
			logger.error("insertOrUpdatePermission出错：", e);
			throw e;
		}
	}
	
	/**
	 * 修改对象全部字段
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int updateUumsUserAppPermissions(UumsUserAppPermissionsDTO dto) throws Exception {
			//记录日志
			UumsUserAppPermissionsDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dao.updateUumsUserAppPermissionsAll(old);
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
	public int updateUumsUserAppPermissionsSensitive(UumsUserAppPermissionsDTO dto) throws Exception {
		try{
			//记录日志
			UumsUserAppPermissionsDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			UumsUserAppPermissionsDao dao = SpringFactory.getBean(UumsUserAppPermissionsDao.class);
			int count = dao.updateUumsUserAppPermissionsSensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请从新更新");
			}
			return count;
		}catch(Exception e){
			logger.error("updateUumsUserAppPermissionsSensitive出错：", e);
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
	public int deleteUumsUserAppPermissionsById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			SysLogUtil.log4Delete(findById(id));
			return dao.deleteUumsUserAppPermissionsById(id);
		}catch(Exception e){
			logger.error("deleteUumsUserAppPermissions出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsUserAppPermissionsByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsUserAppPermissionsById(id);
			result++;
		}
		return result;
	}
	
	/**
	 * 审批流程结束后，更新用户权限审批结果和活动状态
	 * @param workflowId 审批流程ID
	 * @throws Exception
	 */
	public void saveAuditStatusAfterWorkflow(String workflowId) throws Exception{
		try {
			UumsPermissionWorkflowService pwfService = SpringFactory.getBean(UumsPermissionWorkflowService.class);
			List<UumsPermissionWorkflowDTO> pwList = pwfService.searchUumsPermissionWorkflowByWorkflowId(workflowId);
			if(pwList == null){
				return;
			}
			for(UumsPermissionWorkflowDTO pw : pwList){
				UumsUserAppPermissionsDTO dto = this.queryUumsUserAppPermissionsByPrimaryKey(pw.getUpId());
				
				if("3".equals(dto.getOperFlag())){//删除
					if("1".equals(dto.getAuditStatus())){//最终审批状态为：通过
						dto.setAuditFlag("2");//审批状结果：审批通过
						//dto.setActFlag("0");//活动状态：禁止
					}else{//最终审批状态为：不通过
						dto.setAuditFlag("4");//审批状结果：审批不通过
					}
				}else{//新增或更新
					if("1".equals(dto.getAuditStatus())){//最终审批状态为：通过
						dto.setAuditFlag("2");//审批状结果：审批通过
						//dto.setActFlag("1");//活动状态：活动
					}else{//最终审批状态为：不通过
						dto.setAuditFlag("4");//审批状结果：审批不通过
					}
				}
				this.updateUumsUserAppPermissionsSensitive(dto);
			}
		} catch (Exception e) {
			logger.error("saveAuditStatusAfterWorkflow出错：", e);
			throw e;
		}
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsUserAppPermissionsDTO findById(String id) throws Exception {
		try{
			UumsUserAppPermissionsDTO dto = dao.findUumsUserAppPermissionsById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("findUumsUserAppPermissions出错：", e);
	    		throw e;
	    }
	}
		

}

