package avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.service;
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
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.dao.UumsSynchMapperMetaDataDao;
import avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.dto.UumsSynchMapperMetaDataDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @classname:  UumsSynchMapperMetaDataService
 * @description: 定义 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsSynchMapperMetaDataService  implements Serializable {

	private static final Logger logger =  LoggerFactory.getLogger(UumsSynchMapperMetaDataService.class);
	
    private static final long serialVersionUID = 1L;
    
//	@Autowired
//	private SysLogUtil sysLogUtil;
	
	@Autowired
	private UumsSynchMapperMetaDataDao dao;


	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsSynchMapperMetaDataDTO> searchUumsSynchMapperMetaDataByPage(QueryReqBean<UumsSynchMapperMetaDataDTO> queryReqBean) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			UumsSynchMapperMetaDataDTO searchParams = queryReqBean.getSearchParams();

			Page<UumsSynchMapperMetaDataDTO> dataList =  dao.searchUumsSynchMapperMetaDataByPage(searchParams);
			QueryRespBean<UumsSynchMapperMetaDataDTO> queryRespBean =new QueryRespBean<UumsSynchMapperMetaDataDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsSynchMapperMetaDataByPaging出错：", e);
			throw e;
		}
	}
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsSynchMapperMetaDataDTO> searchUumsSynchMapperMetaData(QueryReqBean<UumsSynchMapperMetaDataDTO> queryReqBean) throws Exception {
	    try{
	    	UumsSynchMapperMetaDataDTO searchParams = queryReqBean.getSearchParams();
	    	List<UumsSynchMapperMetaDataDTO> dataList = dao.searchUumsSynchMapperMetaData(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchUumsSynchMapperMetaData出错：", e);
	    	throw new DaoException("",e);
	    }
    }
	
	/**
	 * 通过主体类型查询数据
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public List<UumsSynchMapperMetaDataDTO> searchUumsSynchMapperMetaDataByType(String type) throws Exception{
		try{
			List<UumsSynchMapperMetaDataDTO> dto = dao.searchUumsSynchMapperMetaDataByType(type);
			//记录日志
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsSynchMapperMetaDataByType出错：", e);
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
	public UumsSynchMapperMetaDataDTO queryUumsSynchMapperMetaDataByPrimaryKey(String id) throws Exception {
		try{
			UumsSynchMapperMetaDataDTO dto = dao.findUumsSynchMapperMetaDataById(id);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsSynchMapperMetaData出错：", e);
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
	public String insertUumsSynchMapperMetaData(UumsSynchMapperMetaDataDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dao.insertUumsSynchMapperMetaData(dto);
			//记录日志
			SysLogUtil.log4Insert(dto);
			return id;
		}catch(Exception e){
			logger.error("insertUumsSynchMapperMetaData出错：", e);
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
	public int updateUumsSynchMapperMetaData(UumsSynchMapperMetaDataDTO dto) throws Exception {
			//记录日志
			UumsSynchMapperMetaDataDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dao.updateUumsSynchMapperMetaDataAll(old);
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
	public int updateUumsSynchMapperMetaDataSensitive(UumsSynchMapperMetaDataDTO dto) throws Exception {
		try{
			//记录日志
			UumsSynchMapperMetaDataDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dao.updateUumsSynchMapperMetaDataSensitive(old);
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
	public int deleteUumsSynchMapperMetaDataById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			SysLogUtil.log4Delete(findById(id));
			return dao.deleteUumsSynchMapperMetaDataById(id);
		}catch(Exception e){
			logger.error("deleteUumsSynchMapperMetaData出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsSynchMapperMetaDataByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsSynchMapperMetaDataById(id);
			result++;
		}
		return result;
	}
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsSynchMapperMetaDataDTO findById(String id) throws Exception {
		try{
			UumsSynchMapperMetaDataDTO dto = dao.findUumsSynchMapperMetaDataById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("findUumsSynchMapperMetaData出错：", e);
	    		throw e;
	    }
	}
		

}

