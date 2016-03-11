package avicit.uums.permission.workflow.uumsuserappworkflow.service;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import avicit.uums.permission.workflow.uumsuserappworkflow.dao.UumsPermissionWorkflowDao;
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsPermissionWorkflowDTO;

/**
 * @classname:  UumsPermissionWorkflowService
 * @description: 定义用户应用系统权限审批流程实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsPermissionWorkflowService  implements Serializable {

	private static final Logger logger =  LoggerFactory.getLogger(UumsPermissionWorkflowService.class);
	
    private static final long serialVersionUID = 1L;
	
	@Autowired
	private UumsPermissionWorkflowDao dao;


	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsPermissionWorkflowDTO> searchUumsPermissionWorkflowByPage(QueryReqBean<Map<String, Object>> queryReqBean) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			Map<String, Object> searchParams = queryReqBean.getSearchParams();

			Page<UumsPermissionWorkflowDTO> dataList =  dao.searchUumsPermissionWorkflowByPage(searchParams);
			QueryRespBean<UumsPermissionWorkflowDTO> queryRespBean =new QueryRespBean<UumsPermissionWorkflowDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsPermissionWorkflowByPaging出错：", e);
			throw e;
		}
	}
	
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsPermissionWorkflowDTO> searchUumsPermissionWorkflow(QueryReqBean<UumsPermissionWorkflowDTO> queryReqBean) throws Exception {
	    try{
	    	UumsPermissionWorkflowDTO searchParams = queryReqBean.getSearchParams();
	    	List<UumsPermissionWorkflowDTO> dataList = dao.searchUumsPermissionWorkflow(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchUumsPermissionWorkflow出错：", e);
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
	public UumsPermissionWorkflowDTO queryUumsPermissionWorkflowByPrimaryKey(String id) throws Exception {
		try{
			UumsPermissionWorkflowDTO dto = dao.findUumsPermissionWorkflowById(id);
			//记录日志
			//SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsPermissionWorkflow出错：", e);
	    	throw new DaoException("",e);
	    }
	}
	
	/**
	 * 根据权限审批流程ID查询
	 * @param workflowId 审批流程ID
	 * @return
	 * @throws Exception
	 */
	public List<UumsPermissionWorkflowDTO> searchUumsPermissionWorkflowByWorkflowId(String workflowId) throws Exception{
		try {
			UumsPermissionWorkflowDao dao = SpringFactory.getBean(UumsPermissionWorkflowDao.class);
			List<UumsPermissionWorkflowDTO> pwList = dao.searchUumsPermissionWorkflowByWorkflowId(workflowId);
			return pwList;
		} catch (Exception e) {
			logger.error("queryUumsPermissionWorkflowByWorkflowId出错：", e);
	    	throw new DaoException("",e);
		}
	}
	
	
	public List<UumsPermissionWorkflowDTO> searchPermissionWorkflowByWorkflowId(String workflowId) throws Exception{
		try {
			List<UumsPermissionWorkflowDTO> pwList = dao.searchUumsPermissionWorkflowByWorkflowId(workflowId);
			return pwList;
		} catch (Exception e) {
			logger.error("queryUumsPermissionWorkflowByWorkflowId出错：", e);
	    	throw new DaoException("",e);
		}
	}

	/**
	 * 新增并启动流程
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public String insertUumsPermissionWorkflow(UumsPermissionWorkflowDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dao.insertUumsPermissionWorkflow(dto);
			//记录日志
			//SysLogUtil.log4Insert(dto);
			return id;
		}catch(Exception e){
			logger.error("insertUumsPermissionWorkflow出错：", e);
			throw new DaoException("",e);
		}
	}
	/**
	 * 修改对象全部字段
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int updateUumsPermissionWorkflow(UumsPermissionWorkflowDTO dto) throws Exception {
		try{
			//记录日志
			UumsPermissionWorkflowDTO old =findById(dto.getId());
			//SysLogUtil.log4Update(dto,old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dao.updateUumsPermissionWorkflowAll(old);
			if(ret ==0){
				throw new DaoException("数据失效，请从新更新");
			}
			return ret;
		}catch(Exception e){
			logger.error("updateDemoBusinessFlow出错：", e);
			throw new DaoException("",e);
		}

	}
	/**
	 * 修改对象
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int updateUumsPermissionWorkflowSensitive(UumsPermissionWorkflowDTO dto) throws Exception {
		try{
			//记录日志
			UumsPermissionWorkflowDTO old =findById(dto.getId());
			//SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dao.updateUumsPermissionWorkflowAll(old);
			if(ret ==0){
				throw new DaoException("数据失效，请从新更新");
			}
			return ret;
		}catch(Exception e){
			logger.error("updateDemoBusinessFlow出错：", e);
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
	public int deleteUumsPermissionWorkflowById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			SysLogUtil.log4Delete(findById(id));
			return dao.deleteUumsPermissionWorkflowById(id);
		}catch(Exception e){
			e.printStackTrace();
			logger.error("deleteUumsPermissionWorkflow出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsPermissionWorkflowByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsPermissionWorkflowById(id);
			result++;
		}
		return result;
	}
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsPermissionWorkflowDTO findById(String id) throws Exception {
		try{
			UumsPermissionWorkflowDTO dto = dao.findUumsPermissionWorkflowById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("findUumsPermissionWorkflow出错：", e);
	    		throw e;
	    }
	}
	

}

