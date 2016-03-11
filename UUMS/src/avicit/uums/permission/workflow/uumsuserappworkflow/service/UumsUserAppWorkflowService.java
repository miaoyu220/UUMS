package avicit.uums.permission.workflow.uumsuserappworkflow.service;
import java.io.Serializable;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import avicit.platform6.bpmclient.bpm.service.BpmOperateService;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.DateUtil;
import avicit.platform6.commons.utils.JsonUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.domain.BeanProcess;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;
import avicit.uums.permission.synch.uumsuserapppermissions.dto.UumsUserAppPermissionsDTO;
import avicit.uums.permission.synch.uumsuserapppermissions.service.UumsUserAppPermissionsService;
import avicit.uums.permission.workflow.uumsuserappworkflow.dao.UumsUserAppWorkflowDao;
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsPermissionWorkflowDTO;
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsUserAppWorkflowDTO;

/**
 * @classname:  UumsUserAppWorkflowService
 * @description: 定义用户应用系统权限审批表实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsUserAppWorkflowService  implements Serializable {

	private static final Logger logger =  LoggerFactory.getLogger(UumsUserAppWorkflowService.class);
	
	@Autowired
	private BpmOperateService bpmOperateService;
	
    private static final long serialVersionUID = 1L;
    
//	@Autowired
//	private SysLogUtil sysLogUtil;
	
	@Autowired
	private UumsUserAppWorkflowDao dao;
	@Autowired
	private UumsPermissionWorkflowService pwService;
	@Autowired
	private UumsUserAppPermissionsService permissionService;


	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsUserAppWorkflowDTO> searchUumsUserAppWorkflowByPage(QueryReqBean<Map<String, Object>> queryReqBean) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			Map<String, Object> searchParams = queryReqBean.getSearchParams();

			Page<UumsUserAppWorkflowDTO> dataList =  dao.searchUumsUserAppWorkflowByPage(searchParams);
			QueryRespBean<UumsUserAppWorkflowDTO> queryRespBean =new QueryRespBean<UumsUserAppWorkflowDTO>();

			/**
			for(DemoBusinessFlowR3DTO dto : dataList.getResult()){
				Map<String, String> map = bpmOperateService.getActivitynamesByFormid(dto.getId());
				dto.setActivityalias_(map.get("activityalias_"));
				dto.setBusinessstate_(processStateCode2StateName(map.get("businessstate_")));
			}
			*/
			for(UumsUserAppWorkflowDTO dto : dataList.getResult()){
				dto.setBusinessstate_(processStateCode2StateName(dto.getBusinessstate_()));
			}
			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsUserAppWorkflowByPaging出错：", e);
			throw e;
		}
	}
	
	/**
	 * 流程的编码转换成名称
	 * @param stateCode
	 * @return
	 */
	private String processStateCode2StateName(String stateCode){
		String stateName = "";
		if(stateCode!=null&&stateCode.equals("active")){
			stateName = "流转中";
		}else if(stateCode!=null&&stateCode.equals("ended")){
			stateName = "结束";
		}else if(stateCode!=null&&stateCode.equals("start")){
			stateName = "草稿";
		}
		return stateName;
	}
	
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsUserAppWorkflowDTO> searchUumsUserAppWorkflow(QueryReqBean<UumsUserAppWorkflowDTO> queryReqBean) throws Exception {
	    try{
	    	UumsUserAppWorkflowDTO searchParams = queryReqBean.getSearchParams();
	    	List<UumsUserAppWorkflowDTO> dataList = dao.searchUumsUserAppWorkflow(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchUumsUserAppWorkflow出错：", e);
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
	public UumsUserAppWorkflowDTO queryUumsUserAppWorkflowByPrimaryKey(String id) throws Exception {
		try{
			UumsUserAppWorkflowDTO dto = dao.findUumsUserAppWorkflowById(id);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("queryUumsUserAppWorkflowByPrimaryKey出错：", e);
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
	public String insertUumsUserAppWorkflow(UumsUserAppWorkflowDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dao.insertUumsUserAppWorkflow(dto);
			//记录日志
			SysLogUtil.log4Insert(dto);
			
			this.saveUserSysPermission(dto);
			
			return id;
		}catch(Exception e){
			logger.error("insertUumsUserAppWorkflow出错：", e);
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
	public int updateUumsUserAppWorkflow(UumsUserAppWorkflowDTO dto) throws Exception {
		try{
			//记录日志
			UumsUserAppWorkflowDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto,old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dao.updateUumsUserAppWorkflowAll(old);
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
	 * 修改对象部分字段
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int updateUumsUserAppWorkflowSensitive(UumsUserAppWorkflowDTO dto) throws Exception {
		try{
			//记录日志
			UumsUserAppWorkflowDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dao.updateUumsUserAppWorkflowSensitive(old);
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
	 * 同步保存用户应用系统权限数据和权限审批流程关系数据
	 * @param dto
	 * @throws Exception
	 */
	private void saveUserSysPermission(UumsUserAppWorkflowDTO dto)throws Exception{
		try {
			String[] userIds = dto.getUserId().split(",");
			for(String uid : userIds){
				UumsUserAppPermissionsDTO permission = new UumsUserAppPermissionsDTO();
				//permission.setActFlag("0");//活动状态：禁止
				permission.setAppId(dto.getAppId());
				permission.setAuditFlag("1");//审批状态：审批中 
				if("addP".equals(dto.getOperType())){
					permission.setOperFlag("1");//操作状态：新增
				}else if("delP".equals(dto.getOperType())){
					permission.setOperFlag("3");//操作状态：删除
				}else{
					permission.setOperFlag("2");//操作状态：更新
				}
				
				permission.setSynchFlag("0");//同步状态：未同步
				permission.setUserId(uid);
				permission.setAuditStatus("1");//审批结果：默认通过
				//保存或更新
				permissionService.insertOrUpdatePermission(permission, true);
				//同步保存流程和权限对应关系数据
				UumsPermissionWorkflowDTO pwDto = new UumsPermissionWorkflowDTO();
				pwDto.setWfId(dto.getId());
				pwDto.setUpId(permission.getId());
				pwService.insertUumsPermissionWorkflow(pwDto);
			}
		} catch (Exception e) {
			throw new Exception("",e);
		}
	}
	
	/**
	 * 按主键单条删除
	 * @param id
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsUserAppWorkflowById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			SysLogUtil.log4Delete(findById(id));
			return dao.deleteUumsUserAppWorkflowById(id);
		}catch(Exception e){
			logger.error("deleteUumsUserAppWorkflow出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsUserAppWorkflowByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsUserAppWorkflowById(id);
			String flowInstanceId = bpmOperateService.getInstanceIdByFormid(id);
			if(flowInstanceId != null && !"".equals(flowInstanceId)){
				bpmOperateService.deleteProcessInstanceCascade(flowInstanceId);
			}
			result++;
			
			List<UumsPermissionWorkflowDTO> pwList = pwService.searchUumsPermissionWorkflowByWorkflowId(id);
			for(UumsPermissionWorkflowDTO pw : pwList){
				pwService.deleteUumsPermissionWorkflowById(pw.getId());
			}
		}
		return result;
	}
	
	/**
	 * 按照规则自动生成流程编号，格式为：年月流水号，如2015120001
	 * @return
	 * @throws Exception
	 */
	public String generatorWorkFlowNo()throws Exception{
		try {
			Date startDate = DateUtil.getFirstDay(DateUtil.getToday());
			Date endDate = DateUtil.getLastDay(DateUtil.getToday());
			int count = dao.generatorWorkFlowNo(startDate, endDate) + 1;
			String workFlowNo = "" + DateUtil.getYearMonth(DateUtil.getToday());
			if(count < 10){
				workFlowNo += "000" + count;
			}else if(count < 100){
				workFlowNo += "00" + count;
			}else if(count <1000){
				workFlowNo += "0" + count;
			}else{
				workFlowNo += count;
			}
			
			return workFlowNo;
		} catch (Exception e) {
			logger.error("generatorWorkFlowNo出错：", e);
			throw new DaoException("",e);
		}
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsUserAppWorkflowDTO findById(String id) throws Exception {
		try{
			UumsUserAppWorkflowDTO dto = dao.findUumsUserAppWorkflowById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("findUumsUserAppWorkflow出错：", e);
	    		throw e;
	    }
	}
	
	/**
	 * 保存表单并启动流程
	 * @param bean 表单对象
	 * @param parameter 启动流程所需要的参数
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public BeanProcess insertUumsUserAppWorkflowAndStartProcess(UumsUserAppWorkflowDTO bean, Map<String, Object> parameter) throws Exception{
		Assert.notNull(parameter, "启动流程失败，请传递流程启动参数！");
		String processDefId = (String)parameter.get("processDefId");
		String formCode = (String)parameter.get("formCode");
		String jsonString = (String)parameter.get("jsonString");
		String userId = (String)parameter.get("userId");
		String deptId = (String)parameter.get("deptId");
		String processInstanceId = null; //流程实例ID
		String taskUrl = ""; //待办url
		Assert.hasText(processDefId, "启动流程失败，请传递流程启动参数！");
		//业务操作
		String formId = this.insertUumsUserAppWorkflow(bean);
		//
		Map<String, Object> variables = new HashMap<String, Object>();
		//web表单传递过来(除表单对象外)的变量，可以为空
		if(jsonString != null && !jsonString.equals("")){
			Map<String, Object> extVariables = JsonUtil.parseJSON2Map((String)jsonString);
			variables.putAll(extVariables);
		}
		//把表单对象转换成map,传递给流程变量
		Map<String, Object> pojoMap = (Map<String, Object>) PojoUtil.toMap(bean);
		variables.putAll(pojoMap);
		
		processInstanceId = bpmOperateService.startProcessInstanceById(processDefId, formCode, userId, deptId, variables);
		//取待办URL，如果不需要直接打开可以注释以下代码//
		taskUrl = bpmOperateService.getTaskUrl(String.valueOf(processInstanceId), "");
		
		//返回对象
		BeanProcess bp = new BeanProcess();
		bp.setFormId(formId);
		bp.setProcessInstanceId(processInstanceId);
		bp.setTaskUrl(taskUrl);
		return bp;
	}
	
	public static void main(String[] args) {
		try {
			System.err.println(DateUtil.getFirstDay(DateUtil.getToday()));
			System.err.println(DateUtil.getLastDay(DateUtil.getToday()));
			System.err.println(DateUtil.getToday());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

