package avicit.uums.synch.fromhr.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import avicit.platform6.commons.utils.reflection.ReflectionUtils;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.synch.fromhr.dto.UumsOrgDept;
import avicit.uums.synch.util.JdbcTemplateUtil;

@Repository
public class SynchOrgFromHrDao {

	private static final Logger logger = LoggerFactory
			.getLogger(SynchOrgFromHrDao.class);
	/**
	 * 从权威数据源同步组织部门数据
	 * @param synchTypeDto UumsSynchTypeConfigDTO
	 * @param mappList List<UumsSynchOrgUserMapperDTO>
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @param orgOrDept 1-组织，2-部门
	 * @return
	 * @throws Exception
	 */
	public List<UumsOrgDept> synchOrgFromHr(UumsSynchTypeConfigDTO synchTypeDto,
			List<UumsSynchOrgUserMapperDTO> mappList, String operType, String orgOrDept) throws Exception {
		try {
			if (synchTypeDto != null && mappList.size() > 0) {
				JdbcTemplate jdbcTemplate = JdbcTemplateUtil.getJdbcTemplate(
						synchTypeDto.getDriverClass(),
						synchTypeDto.getConnectStr(),
						synchTypeDto.getUserName(), synchTypeDto.getPassword());
				
				String synchFlagColumn = "SYNCH_FLAG";
				for(UumsSynchOrgUserMapperDTO mapper : mappList){
					if("synchFlag".equals(mapper.getUumsAttribute())){
						synchFlagColumn = mapper.getColumnCode();
					}
				}
				
				String sql = "select * from " + synchTypeDto.getOrgTable() + " where " + synchFlagColumn + " = '0' "
						+ " and oper_flag = '" + operType + "' and org_or_dept = '" + orgOrDept + "'";
				List<Map<String, Object>> orgList = jdbcTemplate
						.queryForList(sql);
				List<UumsOrgDept> deptList = new ArrayList<UumsOrgDept>();
				for (Map<String, Object> orgMaps : orgList) {
					UumsOrgDept dept = new UumsOrgDept();
					for (UumsSynchOrgUserMapperDTO mapp : mappList) {
						Object obj = orgMaps.get(mapp.getColumnCode());
						String dataFormatClassStr = mapp.getDataFormat();
						
						// 调用格式化接口对数据进行格式化
						obj = this.formatData(dataFormatClassStr, obj);
						if(obj != null){
							ReflectionUtils.invokeSetterMethod(dept,
									mapp.getUumsAttribute(),obj);
						}else if("orderBy".equals(mapp.getUumsAttribute())){
							dept.setOrderBy(new BigDecimal(0));
						}
					}
					dept.setOrgCode(dept.getDeptCode());
					dept.setOrgName(dept.getDeptName());
					dept.setOrgDesc(dept.getDeptDesc());
					dept.setOrgPlace(dept.getDeptPlace());
					dept.setDeptType("1");
					deptList.add(dept);
				}
				return deptList;
			}else{
				return null;
			}
		} catch (Exception e) {
			throw e;
		}
	}
	
	/**
	 * 同步字段数据格式化，通过反射机制调用自定义格式化类和方法
	 * @param dataFormatClassStr 格式：自定义数据格式化类全路径#方法，如：com.demo.test.HelloWorld#sayHello
	 * @param obj 需要进行格式化的数据
	 * @return 格式化后的数据
	 */
	private Object formatData(String dataFormatClassStr, Object obj){
		if(dataFormatClassStr != null){
			int separIndex = dataFormatClassStr.indexOf("#");
			if(separIndex != -1){
				try {
					String[] classAndMethod = dataFormatClassStr.split("#");
					Object dataFormatClass = Class.forName(classAndMethod[0]).newInstance();
					obj = ReflectionUtils.invokeMethod(dataFormatClass, classAndMethod[1], new Class[]{Object.class}, new Object[]{obj});
				} catch (Exception e) {
					logger.error("执行自定义数据格式化时错误：" + dataFormatClassStr);
				}
			}
		}
		return obj;
	}
	
	/**
	 * 同步成功后更新权威数据源HR组织表中的同步状态
	 * 表字段SYNCH_FLAG的值改为1，表示该条数据已同步成功
	 * @param deptIdList
	 * @param synchTypeDto
	 * @param mappList
	 * @throws Exception
	 */
	public void updateSynchFlagToHr(List<Object[]> deptIdList, UumsSynchTypeConfigDTO synchTypeDto,
			List<UumsSynchOrgUserMapperDTO> mappList)throws Exception{
		try {
			if(deptIdList.size() == 0){
				return;
			}
			if (synchTypeDto != null && mappList.size() > 0) {
				JdbcTemplate jdbcTemplate = JdbcTemplateUtil.getJdbcTemplate(
						synchTypeDto.getDriverClass(),
						synchTypeDto.getConnectStr(),
						synchTypeDto.getUserName(), synchTypeDto.getPassword());
				String synchFlagColumn = "SYNCH_FLAG";
				String idColumn = "ID";
				for(UumsSynchOrgUserMapperDTO mapper : mappList){
					if("sid".equals(mapper.getUumsAttribute())){
						idColumn = mapper.getColumnCode();
					}else if("synchFlag".equals(mapper.getUumsAttribute())){
						synchFlagColumn = mapper.getColumnCode();
					}
				}
				String updateSql = "update " + synchTypeDto.getOrgTable()
						+ " set "+ synchFlagColumn +" = '1' where " + idColumn + " = ?";
				
				jdbcTemplate.batchUpdate(updateSql, deptIdList);
			}
		} catch (Exception e) {
			throw e;
		}
	}
	
}
