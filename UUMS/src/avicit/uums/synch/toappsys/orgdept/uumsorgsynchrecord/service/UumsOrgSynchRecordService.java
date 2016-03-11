package avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.service;
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
import avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.dao.UumsOrgSynchRecordDao;
import avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.dto.UumsOrgSynchRecordDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @classname:  UumsOrgSynchRecordService
 * @description: 定义 组织信息同步记录表实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsOrgSynchRecordService  implements Serializable {

	private static final Logger logger =  LoggerFactory.getLogger(UumsOrgSynchRecordService.class);
	
    private static final long serialVersionUID = 1L;
    
//	@Autowired
//	private SysLogUtil sysLogUtil;
	
	@Autowired
	private UumsOrgSynchRecordDao dao;


	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsOrgSynchRecordDTO> searchUumsOrgSynchRecordByPage(QueryReqBean<UumsOrgSynchRecordDTO> queryReqBean) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			UumsOrgSynchRecordDTO searchParams = queryReqBean.getSearchParams();

			Page<UumsOrgSynchRecordDTO> dataList =  dao.searchUumsOrgSynchRecordByPage(searchParams);
			QueryRespBean<UumsOrgSynchRecordDTO> queryRespBean =new QueryRespBean<UumsOrgSynchRecordDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsOrgSynchRecordByPaging出错：", e);
			throw e;
		}
	}
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsOrgSynchRecordDTO> searchUumsOrgSynchRecord(QueryReqBean<UumsOrgSynchRecordDTO> queryReqBean) throws Exception {
	    try{
	    	UumsOrgSynchRecordDTO searchParams = queryReqBean.getSearchParams();
	    	List<UumsOrgSynchRecordDTO> dataList = dao.searchUumsOrgSynchRecord(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchUumsOrgSynchRecord出错：", e);
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
	public UumsOrgSynchRecordDTO queryUumsOrgSynchRecordByPrimaryKey(String id) throws Exception {
		try{
			UumsOrgSynchRecordDTO dto = dao.findUumsOrgSynchRecordById(id);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsOrgSynchRecord出错：", e);
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
	public String insertUumsOrgSynchRecord(UumsOrgSynchRecordDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dao.insertUumsOrgSynchRecord(dto);
			//记录日志
			SysLogUtil.log4Insert(dto);
			return id;
		}catch(Exception e){
			logger.error("insertUumsOrgSynchRecord出错：", e);
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
	public int updateUumsOrgSynchRecord(UumsOrgSynchRecordDTO dto) throws Exception {
			//记录日志
			UumsOrgSynchRecordDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dao.updateUumsOrgSynchRecordAll(old);
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
	public int updateUumsOrgSynchRecordSensitive(UumsOrgSynchRecordDTO dto) throws Exception {
		try{
			//记录日志
			UumsOrgSynchRecordDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dao.updateUumsOrgSynchRecordSensitive(old);
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
	public int deleteUumsOrgSynchRecordById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			SysLogUtil.log4Delete(findById(id));
			return dao.deleteUumsOrgSynchRecordById(id);
		}catch(Exception e){
			logger.error("deleteUumsOrgSynchRecord出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsOrgSynchRecordByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsOrgSynchRecordById(id);
			result++;
		}
		return result;
	}
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsOrgSynchRecordDTO findById(String id) throws Exception {
		try{
			UumsOrgSynchRecordDTO dto = dao.findUumsOrgSynchRecordById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("findUumsOrgSynchRecord出错：", e);
	    		throw e;
	    }
	}
		

}

