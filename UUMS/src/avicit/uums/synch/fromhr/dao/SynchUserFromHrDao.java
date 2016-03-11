package avicit.uums.synch.fromhr.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.hibernate.LobHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import avicit.platform6.commons.utils.reflection.ReflectionUtils;
import avicit.platform6.core.dao.hibernate.CommonHibernateDao2;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.synch.toappsys.dto.UumsUser;
import avicit.uums.synch.util.JdbcTemplateUtil;

@Repository
public class SynchUserFromHrDao {
	private static final Logger logger =  LoggerFactory.getLogger(SynchUserFromHrDao.class);
	@Autowired
	private CommonHibernateDao2 hibernateDao;
	
	/**
	 * 从权威数据源HR同步用户数据
	 * @param synchTypeDto UumsSynchTypeConfigDTO
	 * @param mappList List<UumsSynchOrgUserMapperDTO>
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @return
	 * @throws Exception
	 */
	public List<UumsUser> synchUserFromHr(UumsSynchTypeConfigDTO synchTypeDto,
			List<UumsSynchOrgUserMapperDTO> mappList, String operType) throws Exception {
		try {
			if (synchTypeDto != null && mappList.size() > 0) {
				JdbcTemplate jdbcTemplate = JdbcTemplateUtil.getJdbcTemplate(
						synchTypeDto.getDriverClass(),
						synchTypeDto.getConnectStr(),
						synchTypeDto.getUserName(), synchTypeDto.getPassword());
				
				String synchFlagColumn = "SYNCH_FLAG";
				String sql = "select * from " + synchTypeDto.getUserTable()+ " where " + synchFlagColumn + " = '0' "
						+ " and oper_flag = '" + operType + "'";
				List<Map<String, Object>> synchUserList = jdbcTemplate
						.queryForList(sql);
				List<UumsUser> userList = new ArrayList<UumsUser>();
				for (Map<String, Object> userMaps : synchUserList) {
					UumsUser user = new UumsUser();
					for (UumsSynchOrgUserMapperDTO mapp : mappList) {
						//调用自定义数据格式化类和方法，进行数据格式化
						Object obj = userMaps.get(mapp.getColumnCode());
						String dataFormatClassStr = mapp.getDataFormat();
						obj = this.formatData(dataFormatClassStr, obj);
						
						if (obj != null) {
							if("photo".equals(mapp.getUumsAttribute())){//读取头像照片数据
								LobHelper lobHelper = hibernateDao.getSession().getLobHelper();
								user.setPhoto(lobHelper.createBlob((byte[])obj));
								continue;
							}
							
							//利用反射机制为用户对象各属性赋值
							ReflectionUtils.invokeSetterMethod(user,
									mapp.getUumsAttribute(), obj);
							
						}else if("orderBy".equals(mapp.getUumsAttribute())){//默认排序为0
							user.setOrderBy(new BigDecimal(0));
						}
					}
					userList.add(user);
				}
				return userList;
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
	 * 同步成功后更新权威数据源HR用户表中的同步状态
	 * 表字段SYNCH_FLAG的值改为1，表示该条数据已同步成功
	 * @param deptIdList
	 * @param synchTypeDto
	 * @param mappList
	 * @throws Exception
	 */
	public void updateSynchFlagToHr(List<Object[]> userIdList, UumsSynchTypeConfigDTO synchTypeDto,
			List<UumsSynchOrgUserMapperDTO> mappList)throws Exception{
		try {
			if(userIdList.size() == 0){
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
				String updateSql = "update " + synchTypeDto.getUserTable()
						+ " set "+ synchFlagColumn +" = '1' where " + idColumn + " = ?";
				
				jdbcTemplate.batchUpdate(updateSql, userIdList);
			}
		} catch (Exception e) {
			throw e;
		}
	}
}
