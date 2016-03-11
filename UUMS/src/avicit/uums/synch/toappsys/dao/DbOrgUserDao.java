package avicit.uums.synch.toappsys.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import avicit.platform6.commons.utils.DateUtil;
import avicit.platform6.commons.utils.reflection.ReflectionUtils;
import avicit.platform6.core.domain.BeanDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.synch.toappsys.dto.UumsUser;
import avicit.uums.synch.util.JdbcTemplateUtil;

@Repository
public class DbOrgUserDao {
	private static final Logger logger = LoggerFactory
			.getLogger(DbOrgUserDao.class);

	/**
	 * 数据库同步方式同步组织和部门数据到应用系统
	 * @param beanDto 组织和部门对象
	 * @param mappList List<UumsSynchOrgUserMapperDTO> 应用系统同步映射信息
	 * @param synchTypeDto UumsSynchTypeConfigDTO 应用同步配置信息
	 * @param orgUser 组织或用户，org-组织，user-用户
	 * @return int 成功记录数
	 * @throws Exception
	 */
	public int insertOrgUserIntoApp(BeanDTO beanDto, List<UumsSynchOrgUserMapperDTO> mappList, 
			UumsSynchTypeConfigDTO synchTypeDto, String orgUser) throws Exception{
		JdbcTemplate jdbcTemplate = JdbcTemplateUtil.getJdbcTemplate(synchTypeDto.getDriverClass(), 
				synchTypeDto.getConnectStr(), synchTypeDto.getUserName(), synchTypeDto.getPassword());
		
		String tableName = synchTypeDto.getOrgTable();
		if("user".equals(orgUser)){
			tableName = synchTypeDto.getUserTable();
		}
		String insertSql = "insert into " + tableName;
		String column = "(";
		String values = " values(";
		Object[] objs = new Object[mappList.size()];
		int index = 0;
		for(UumsSynchOrgUserMapperDTO mapper : mappList){
			column += mapper.getColumnCode() + ",";
			values += "?,";
			
			//调用自定义数据格式化类和方法，进行数据格式化
			Object obj = ReflectionUtils.invokeGetterMethod(beanDto, mapper.getUumsAttribute());
			String dataFormatClassStr = mapper.getDataFormat();
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
			
			//字段数据库类型处理
			if("date".equals(mapper.getDataType().toLowerCase())){
				if(obj != null && obj instanceof Date){
					objs[index] = obj;
				}else{// 非日期格式
					objs[index] = DateUtil.getToday();
				}
			}else if("number".equals(mapper.getDataType().toLowerCase())){
				if(obj != null && obj instanceof BigDecimal){
					objs[index] = obj;
				}else{
					try {//是数字
						BigDecimal bd = new BigDecimal((String)obj);
						objs[index] = bd;
					} catch (Exception e) {//非数字
						objs[index] = 0;
					}
				}
			}else if("blob".equals(mapper.getDataType().toLowerCase())){
				//to-do
				if("photo".equals(mapper.getUumsAttribute())){
					if(beanDto instanceof UumsUser){
						objs[index] = ((UumsUser)beanDto).getUumsPhoto();
					}
					
				}
			}else{//字符类型
				objs[index] = obj;
			}
			index++;
		}
		column = StringUtils.removeEnd(column, ",");
		values = StringUtils.removeEnd(values, ",");
		column += ") ";
		values += ") ";
		insertSql = insertSql + column + values;
		
		// 执行数据库操作-保存
		return jdbcTemplate.update(insertSql, objs);
	}
	
}
