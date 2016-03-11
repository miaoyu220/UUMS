package avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dao.UumsSynchTypeConfigDao;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;


import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;

import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @classname: UumsSynchTypeConfigService
 * @description: 定义  出差信息表 实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsSynchTypeConfigService  implements Serializable {

	private static final Logger logger =  LoggerFactory.getLogger(UumsSynchTypeConfigService.class);
	
    private static final long serialVersionUID = 1L;
    
//	@Autowired
//	private SysLogUtil sysLogUtil;
	
	@Autowired
	private UumsSynchTypeConfigDao dao;
	@Autowired
    private UumsSynchOrgUserMapperService serviceSub;
	@Autowired
	private UumsAppSysService appSysService;
	@Autowired
	private UumsSynchOrgUserMapperService synchOrgUserMapperService;

	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsSynchTypeConfigDTO> searchUumsSynchTypeConfigByPage(QueryReqBean<UumsSynchTypeConfigDTO> queryReqBean) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			UumsSynchTypeConfigDTO searchParams = queryReqBean.getSearchParams();

			Page<UumsSynchTypeConfigDTO> dataList =  dao.searchUumsSynchTypeConfigByPage(searchParams);
			QueryRespBean<UumsSynchTypeConfigDTO> queryRespBean =new QueryRespBean<UumsSynchTypeConfigDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsSynchTypeConfigByPaging出错：", e);
			throw e;
		}
	}
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsSynchTypeConfigDTO> searchUumsSynchTypeConfig(QueryReqBean<UumsSynchTypeConfigDTO> queryReqBean) throws Exception {
	    try{
	    	UumsSynchTypeConfigDTO searchParams = queryReqBean.getSearchParams();
	    	List<UumsSynchTypeConfigDTO> dataList = dao.searchUumsSynchTypeConfig(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchUumsSynchTypeConfig出错：", e);
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
	public UumsSynchTypeConfigDTO queryUumsSynchTypeConfigByPrimaryKey(String id) throws Exception {
		try{
			UumsSynchTypeConfigDTO dto = dao.findUumsSynchTypeConfigById(id);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsSynchTypeConfig出错：", e);
	    	throw new DaoException("",e);
	    }
	}
	
	/**
	 * 通过应用系统ID查询单条记录
	 * @param appId 应用系统ID
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public UumsSynchTypeConfigDTO queryUumsSynchTypeConfigByAppId(String appId) throws Exception {
		try{
			UumsSynchTypeConfigDTO dto = dao.findUumsSynchTypeConfigByAppId(appId);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsSynchTypeConfig出错：", e);
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
	public String insertUumsSynchTypeConfig(UumsSynchTypeConfigDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dao.insertUumsSynchTypeConfig(dto);
			//记录日志
			SysLogUtil.log4Insert(dto);
			return id;
		}catch(Exception e){
			logger.error("insertUumsSynchTypeConfig出错：", e);
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
	public int updateUumsSynchTypeConfig(UumsSynchTypeConfigDTO dto) throws Exception {
			//记录日志
			UumsSynchTypeConfigDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dao.updateUumsSynchTypeConfigAll(old);
			if(count ==0){
				throw new DaoException("数据失效，请从新更新");
			}
			return count;

	}
	/**
	 * 修改对象部分字段
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int updateUumsSynchTypeConfigSensitive(UumsSynchTypeConfigDTO dto) throws Exception {
			//记录日志
			UumsSynchTypeConfigDTO  old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dao.updateUumsSynchTypeConfigSensitive(old);
			if(count ==0){
				throw new DaoException("数据失效，请从新更新");
			}
			return count;

	}
	
	/**
	 * 按主键单条删除
	 * @param id
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsSynchTypeConfigById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			UumsSynchTypeConfigDTO obje = findById(id);
			SysLogUtil.log4Delete(obje);
			//删除子表
			for(UumsSynchOrgUserMapperDTO sub :serviceSub.queryUumsSynchOrgUserMapperByPid(obje.getId())){
				serviceSub.deleteUumsSynchOrgUserMapper(sub);
			}
			//删除主表
			return dao.deleteUumsSynchTypeConfigById(id);
		}catch(Exception e){
			logger.error("searchUumsSynchTypeConfig出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsSynchTypeConfigByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsSynchTypeConfigById(id);
			result++;
		}
		return result;
	}
	
	/**
	 * 查询应用注册信息、同步方式配置信息、同步映射配置信息并放在一个Map集合中，<br>
	 * Map中包含三个元素，键-值关系如下：<br>
	 * app-UumsAppSysDTO <br>
	 * synchType-UumsSynchTypeConfigDTO <br>
	 * mapperList-List<UumsSynchOrgUserMapperDTO> <br>
	 * @param appId 应用系统ID
	 * @param orgOrUser 组织或用户映射，组织-UUMS_ORG，用户-UUMS_USER
	 * @return Map<String, Object> 
	 * @throws Exception
	 */
	public Map<String, Object> getSynchConfigInfoMapByAppid(String appId, String orgOrUser) throws Exception{
		Assert.notNull(appId, "传入参数应用系统ID无效:NULL");
		Assert.notNull(orgOrUser, "传入参数映射类型orgOrUser无效:NULL");
		//查询应用系统注册信息
		UumsAppSysDTO appsysDto = appSysService.queryUumsAppSysByPrimaryKey(appId);
		Assert.notNull(appsysDto, "无法获取应用系统注册信息，应用系统ID: "+ appId);
		//查询应用系统同步配置信息
		UumsSynchTypeConfigDTO synchTypeDto = this.queryUumsSynchTypeConfigByAppId(appsysDto.getId());
		Assert.notNull(synchTypeDto, "无法获取应用系统同步配置信息，应用系统ID: "+ appId);
		
		//查询应用系统同步映射配置信息
		List<UumsSynchOrgUserMapperDTO> mappList = synchOrgUserMapperService.queryUumsSynchOrgUserMapperByPidMaintypeColCode(synchTypeDto.getId(), orgOrUser);
		Assert.notEmpty(mappList, "请先配置应用系统同步映射信息，然后再进行同步操作！");
		
		Map<String, Object> confMap = new HashMap<String, Object>();
		confMap.put("app", appsysDto);
		confMap.put("synchType", synchTypeDto);
		confMap.put("mapperList", mappList);
		
		return confMap;
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsSynchTypeConfigDTO findById(String id) throws Exception {
		try{
			UumsSynchTypeConfigDTO dto = dao.findUumsSynchTypeConfigById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("searchUumsSynchTypeConfig出错：", e);
	    		throw e;
	    }
	}
		

}

