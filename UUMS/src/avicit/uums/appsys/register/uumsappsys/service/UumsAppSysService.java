package avicit.uums.appsys.register.uumsappsys.service;
import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.commons.utils.web.TreeNode;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.uums.appsys.register.uumsappsys.dao.UumsAppSysDao;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @classname:  UumsAppSysService
 * @description: 定义 应用系统注册管理实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsAppSysService  implements Serializable {

	private static final Logger logger =  LoggerFactory.getLogger(UumsAppSysService.class);
	
    private static final long serialVersionUID = 1L;
    
//	@Autowired
//	private SysLogUtil sysLogUtil;
	
	@Autowired
	private UumsAppSysDao dao;


	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsAppSysDTO> searchUumsAppSysByPage(QueryReqBean<UumsAppSysDTO> queryReqBean) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			UumsAppSysDTO searchParams = queryReqBean.getSearchParams();

			Page<UumsAppSysDTO> dataList =  dao.searchUumsAppSysByPage(searchParams);
			QueryRespBean<UumsAppSysDTO> queryRespBean =new QueryRespBean<UumsAppSysDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsAppSysByPaging出错：", e);
			throw e;
		}
	}
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsAppSysDTO> searchUumsAppSys(QueryReqBean<UumsAppSysDTO> queryReqBean) throws Exception {
	    try{
	    	UumsAppSysDTO searchParams = queryReqBean.getSearchParams();
	    	List<UumsAppSysDTO> dataList = dao.searchUumsAppSys(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchUumsAppSys出错：", e);
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
	public UumsAppSysDTO queryUumsAppSysByPrimaryKey(String id) throws Exception {
		try{
			UumsAppSysDTO dto = dao.findUumsAppSysById(id);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("queryUumsAppSysByPrimaryKey出错：", e);
	    	throw new DaoException("",e);
	    }
	}
	
	/**
	 * 通过应用系统编码查询单条记录
	 * @param appCode 应用系统编码
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public UumsAppSysDTO queryUumsAppSysByAppCode(String appCode) throws Exception {
		try{
			if(StringUtils.isEmpty(appCode)){
				return null;
			}
			UumsAppSysDTO dto = dao.findUumsAppSysByAppCode(appCode);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("queryUumsAppSysByAppCode出错：", e);
	    	throw new DaoException("",e);
	    }
	}
	
	/**
	 * 查询权威数据源HR对象，目前不支持多数据源，如果存在则返回一个对象，否则返回NULL
	 * @return
	 * @throws Exception
	 */
	public UumsAppSysDTO queryHrAppSys() throws Exception{
		try{
			UumsAppSysDTO searchParams = new UumsAppSysDTO();
			searchParams.setIsDataSource("Y");
			List<UumsAppSysDTO> dtoList = dao.searchUumsAppSys(searchParams);
			if(dtoList.size() > 0){
				return dtoList.get(0);
			}
			//记录日志
			SysLogUtil.log4Query(searchParams);
			return null;
		}catch(Exception e){
	    	logger.error("queryUumsAppSysByAppCode出错：", e);
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
	public String insertUumsAppSys(UumsAppSysDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dto.setCreateTime(dto.getCreationDate());
			dto.setUpdateTime(dto.getCreationDate());
			dao.insertUumsAppSys(dto);
			//记录日志
			SysLogUtil.log4Insert(dto);
			return id;
		}catch(Exception e){
			logger.error("insertUumsAppSys出错：", e);
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
	public int updateUumsAppSys(UumsAppSysDTO dto) throws Exception {
			//记录日志
			UumsAppSysDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			old.setUpdateTime(old.getLastUpdateDate());
			int ret = dao.updateUumsAppSysAll(old);
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
	public int updateUumsAppSysSensitive(UumsAppSysDTO dto) throws Exception {
		try{
			//记录日志
			UumsAppSysDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			old.setUpdateTime(old.getLastUpdateDate());
			int count = dao.updateUumsAppSysSensitive(old);
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
	public int deleteUumsAppSysById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			SysLogUtil.log4Delete(findById(id));
			return dao.deleteUumsAppSysById(id);
		}catch(Exception e){
			logger.error("deleteUumsAppSys出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsAppSysByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsAppSysById(id);
			result++;
		}
		return result;
	}
	
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsAppSysDTO findById(String id) throws Exception {
		try{
			UumsAppSysDTO dto = dao.findUumsAppSysById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("findUumsAppSys出错：", e);
	    		throw e;
	    }
	}
		

}

