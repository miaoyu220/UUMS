package avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service;
import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;

import avicit.platform6.core.exception.DaoException;

import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dao.UumsSynchOrgUserMapperDao;

import avicit.platform6.modules.system.syslog.service.SysLogUtil;


/**
 * @classname: UumsSynchOrgUserMapperService
 * @description: 定义  应用系统组织和用户同步映射信息 实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsSynchOrgUserMapperService  implements Serializable {

	private static final Logger logger =  LoggerFactory.getLogger(UumsSynchOrgUserMapperService.class);
	
    private static final long serialVersionUID = 1L;
    
	@Autowired
	private UumsSynchOrgUserMapperDao dao;
	/**
	 * 通过主键查询单条记录
	 * @param id
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public UumsSynchOrgUserMapperDTO queryUumsSynchOrgUserMapperByPrimaryKey(String id) throws Exception {
		try{
			UumsSynchOrgUserMapperDTO dto = dao.findUumsSynchOrgUserMapperById(id);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsSynchOrgUserMapper出错：", e);
	    	throw new DaoException("",e);
	    }
	}
	/**
	 * 通过父键查询单条记录
	 * @param id
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public List<UumsSynchOrgUserMapperDTO> queryUumsSynchOrgUserMapperByPid(String pid) throws Exception {
		try{
			List<UumsSynchOrgUserMapperDTO> dto = dao.findUumsSynchOrgUserMapperByPid(pid);
			//记录日志
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsSynchOrgUserMapper出错：", e);
	    	throw new DaoException("",e);
	    }
	}
	
	/**
	 * 通过父键和主体类型查询记录
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsSynchOrgUserMapperDTO> queryUumsSynchOrgUserMapperByPidAndMaintype(QueryReqBean<UumsSynchOrgUserMapperDTO> queryReqBean) throws Exception {
		try{
			UumsSynchOrgUserMapperDTO searchParams = queryReqBean.getSearchParams();
			List<UumsSynchOrgUserMapperDTO> dtoList = dao.findUumsSynchOrgUserMapperByPidAndMaintype(searchParams);
			//记录日志
			return dtoList;
		}catch(Exception e){
	    	logger.error("searchUumsSynchOrgUserMapper出错：", e);
	    	throw new DaoException("",e);
	    }
	}

	/**
	 * 通过父键和主体类型且字段CODE不为空条件查询记录
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsSynchOrgUserMapperDTO> queryUumsSynchOrgUserMapperByPidMaintypeColCode(QueryReqBean<UumsSynchOrgUserMapperDTO> queryReqBean) throws Exception {
		try{
			UumsSynchOrgUserMapperDTO searchParams = queryReqBean.getSearchParams();
			List<UumsSynchOrgUserMapperDTO> dto = dao.findMapperByPidAndMaintypeAndColumnCode(searchParams);
			//记录日志
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsSynchOrgUserMapper出错：", e);
	    	throw new DaoException("",e);
	    }
	}
	
	/**
	 * 通过父键和主体类型且字段CODE不为空条件查询记录
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsSynchOrgUserMapperDTO> queryUumsSynchOrgUserMapperByPidMaintypeColCode(String typeId, String mainType) throws Exception {
		try{
			UumsSynchOrgUserMapperDTO mapperDto = new UumsSynchOrgUserMapperDTO();
			mapperDto.setTypeId(typeId);
			mapperDto.setMainType(mainType);
			List<UumsSynchOrgUserMapperDTO> dtoList = dao.findMapperByPidAndMaintypeAndColumnCode(mapperDto);
			
			return dtoList;
		}catch(Exception e){
	    	logger.error("searchUumsSynchOrgUserMapper出错：", e);
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
	public String insertUumsSynchOrgUserMapper(UumsSynchOrgUserMapperDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dao.insertUumsSynchOrgUserMapper(dto);
			//记录日志
			SysLogUtil.log4Insert(dto);
			return id;
		}catch(Exception e){
			logger.error("insertUumsSynchOrgUserMapper出错：", e);
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
	public int updateUumsSynchOrgUserMapper(UumsSynchOrgUserMapperDTO dto) throws Exception {
			
			//记录日志
			UumsSynchOrgUserMapperDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto,old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dao.updateUumsSynchOrgUserMapperAll(old);
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
	public int updateUumsSynchOrgUserMapperSensitive(UumsSynchOrgUserMapperDTO dto) throws Exception {
		try{
			//记录日志
			UumsSynchOrgUserMapperDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, findById(dto.getId()));
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dao.updateUumsSynchOrgUserMapperSensitive(old);
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
	public int deleteUumsSynchOrgUserMapperById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			SysLogUtil.log4Delete(findById(id));
			return dao.deleteUumsSynchOrgUserMapperById(id);
		}catch(Exception e){
			logger.error("searchUumsSynchOrgUserMapper出错：", e);
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
	public int deleteUumsSynchOrgUserMapper(UumsSynchOrgUserMapperDTO dto) throws Exception {
		try{
			//记录日志
			SysLogUtil.log4Delete(dto);
			return dao.deleteUumsSynchOrgUserMapperById(dto.getId());
		}catch(Exception e){
			logger.error("searchUumsSynchOrgUserMapper出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsSynchOrgUserMapperByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsSynchOrgUserMapperById(id);
			result++;
		}
		return result;
	}
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsSynchOrgUserMapperDTO findById(String id) throws Exception {
		try{
			UumsSynchOrgUserMapperDTO dto = dao.findUumsSynchOrgUserMapperById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("searchUumsSynchOrgUserMapper出错：", e);
	    		throw e;
	    }
	}
		

}

