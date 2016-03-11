package avicit.uums.synch.log.orglog.uumslogsynchorg.service;
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
import avicit.uums.synch.log.orglog.uumslogsynchorg.dao.UumsLogSynchOrgDao;
import avicit.uums.synch.log.orglog.uumslogsynchorg.dto.UumsLogSynchOrgDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @classname:  UumsLogSynchOrgService
 * @description: 定义 组织同步日志表实现类
 * @author:  AVICIT DEV
 */
@Service
public class UumsLogSynchOrgService  implements Serializable, Callable<String> {

	private static final Logger logger =  LoggerFactory.getLogger(UumsLogSynchOrgService.class);
	
    private static final long serialVersionUID = 1L;
    
//	@Autowired
//	private SysLogUtil sysLogUtil;
	
	@Autowired
	private UumsLogSynchOrgDao dao;
	private List<UumsOrgDept> orgList;
	private List<UumsLogSynchOrgDTO> logList;

	

	public List<UumsOrgDept> getOrgList() {
		return orgList;
	}
	public void setOrgList(List<UumsOrgDept> orgList) {
		this.orgList = orgList;
	}
	public void setLogList(List<UumsLogSynchOrgDTO> logList) {
		this.logList = logList;
	}
	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public QueryRespBean<UumsLogSynchOrgDTO> searchUumsLogSynchOrgByPage(QueryReqBean<UumsLogSynchOrgDTO> queryReqBean) throws Exception {
		try{
			PageHelper.startPage(queryReqBean.getPageParameter());
			UumsLogSynchOrgDTO searchParams = queryReqBean.getSearchParams();

			Page<UumsLogSynchOrgDTO> dataList =  dao.searchUumsLogSynchOrgByPage(searchParams);
			QueryRespBean<UumsLogSynchOrgDTO> queryRespBean =new QueryRespBean<UumsLogSynchOrgDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		}catch(DaoException e){
			logger.error("searchUumsLogSynchOrgByPaging出错：", e);
			throw e;
		}
	}
	/**
	 * 按条件查询，不分页
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	public List<UumsLogSynchOrgDTO> searchUumsLogSynchOrg(QueryReqBean<UumsLogSynchOrgDTO> queryReqBean) throws Exception {
	    try{
	    	UumsLogSynchOrgDTO searchParams = queryReqBean.getSearchParams();
	    	List<UumsLogSynchOrgDTO> dataList = dao.searchUumsLogSynchOrg(searchParams);
	    	return dataList;
	    }catch(Exception e){
	    	logger.error("searchUumsLogSynchOrg出错：", e);
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
	public UumsLogSynchOrgDTO queryUumsLogSynchOrgByPrimaryKey(String id) throws Exception {
		try{
			UumsLogSynchOrgDTO dto = dao.findUumsLogSynchOrgById(id);
			//记录日志
			SysLogUtil.log4Query(dto);
			return dto;
		}catch(Exception e){
	    	logger.error("searchUumsLogSynchOrg出错：", e);
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
	public String insertUumsLogSynchOrg(UumsLogSynchOrgDTO dto) throws Exception {
		try{
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			dao.insertUumsLogSynchOrg(dto);
			//记录日志
			SysLogUtil.log4Insert(dto);
			return id;
		}catch(Exception e){
			logger.error("insertUumsLogSynchOrg出错：", e);
			throw new DaoException("",e);
		}
	}
	/**
	 * 新增对象
	 * @param orgList
	 * @param logList
	 */
	public void insertUumsLogSynchOrg(List<UumsOrgDept> orgList, List<UumsLogSynchOrgDTO> logList){
		if(orgList == null || orgList.size() == 0){
			return;
		}
		int i = 0;
		for(UumsOrgDept orgDept : orgList){
			try {
				UumsLogSynchOrgDTO dto = logList.get(i);
				String id = ComUtil.getId();
				dto.setId(id);
				PojoUtil.setSysProperties(dto, OpType.insert);
				dto.setOrgName(orgDept.getDeptName());
				dto.setOrgCode(orgDept.getDeptCode());
				dto.setSynchTime(DateUtil.getToday());
				dto.setOperFlag(orgDept.getOperFlag());
				
				dao.insertUumsLogSynchOrg(dto);
			} catch (Exception e) {
				logger.error("insertUumsLogSynchOrg出错：", e);
			}
			i++;
		}
	}
	/**
	 * 新增日志，执行多线程专用
	 */
	public void insertUumsLogSynchOrg(){
		if(orgList == null || orgList.size() == 0){
			return;
		}
		int i = 0;
		for(UumsOrgDept orgDept : orgList){
			try {
				UumsLogSynchOrgDTO dto = logList.get(i);
				String id = ComUtil.getId();
				dto.setId(id);
				PojoUtil.setSysProperties(dto, OpType.insert);
				dto.setOrgName(orgDept.getDeptName());
				dto.setOrgCode(orgDept.getDeptCode());
				dto.setSynchTime(DateUtil.getToday());
				dto.setOperFlag(orgDept.getOperFlag());
				
				dao.insertUumsLogSynchOrg(dto);
			} catch (Exception e) {
				logger.error("insertUumsLogSynchOrg出错：", e);
			}
			i++;
		}
	}
	/**
	 * 修改对象全部字段
	 * @param dto
	 * @param logBase
	 * @return
	 * @throws Exception
	 */
	public int updateUumsLogSynchOrg(UumsLogSynchOrgDTO dto) throws Exception {
			//记录日志
			UumsLogSynchOrgDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int ret = dao.updateUumsLogSynchOrgAll(old);
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
	public int updateUumsLogSynchOrgSensitive(UumsLogSynchOrgDTO dto) throws Exception {
		try{
			//记录日志
			UumsLogSynchOrgDTO old =findById(dto.getId());
			SysLogUtil.log4Update(dto, old);
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto,true);
			int count = dao.updateUumsLogSynchOrgSensitive(old);
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
	public int deleteUumsLogSynchOrgById(String id) throws Exception {
		if(StringUtils.isEmpty(id)) throw new Exception("删除失败！传入的参数主键为null");
		try{
			//记录日志
			SysLogUtil.log4Delete(findById(id));
			return dao.deleteUumsLogSynchOrgById(id);
		}catch(Exception e){
			logger.error("deleteUumsLogSynchOrg出错：", e);
			throw new DaoException("",e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return
	 * @throws Exception
	 */
	public int deleteUumsLogSynchOrgByIds(String[] ids) throws Exception{
		int result =0;
		for(String id : ids ){
			deleteUumsLogSynchOrgById(id);
			result++;
		}
		return result;
	}
	/**
	 * 日志专用，内部方法，不再记录日志
	 */
	private UumsLogSynchOrgDTO findById(String id) throws Exception {
		try{
			UumsLogSynchOrgDTO dto = dao.findUumsLogSynchOrgById(id);
			return dto;
		}catch(DaoException e){
	    		logger.error("findUumsLogSynchOrg出错：", e);
	    		throw e;
	    }
	}

	/**
	 * 多线程启动执行入口
	 */
	@Override
	public String call() throws Exception {
		this.insertUumsLogSynchOrg();
		return null;
	}
}

