package avicit.uums.synch.toappsys.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import avicit.platform6.commons.utils.DateUtil;
import avicit.platform6.commons.utils.reflection.ReflectionUtils;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.synch.toappsys.dto.UumsUser;
import avicit.uums.synch.util.LdapUtil;

/**
 * 用户数据目录同步服务类
 * @author miaoyu
 * @since 2016-1-26
 *
 */
@Service
public class LdapUserDao {
	private static final Logger logger = LoggerFactory
			.getLogger(LdapUserDao.class);
	/**
	 * 新增或更新用户
	 * @param user UumsUser
	 * @param mappList List<UumsSynchOrgUserMapperDTO>
	 * @param synchTypeDto UumsSynchTypeConfigDTO
	 * @return
	 * @throws Exception
	 */
	public int addOrUpdate(UumsUser user, List<UumsSynchOrgUserMapperDTO> mappList, 
			UumsSynchTypeConfigDTO synchTypeDto) throws Exception{
		String searchBase = synchTypeDto.getUserOu();
		String searchFilter = "uid=" + user.getNo();//需要考虑变更
		boolean result = this.searchExist(searchBase, searchFilter, synchTypeDto);
		if(!result){
			return this.add(user, mappList, synchTypeDto);
		}else{
			return this.update(user, mappList, synchTypeDto);
		}
	}
	
	/**
	 * 新增用户数据
	 * @param user UumsUser
	 * @param mappList List<UumsSynchOrgUserMapperDTO>
	 * @param synchTypeDto UumsSynchTypeConfigDTO
	 * @return
	 * @throws NamingException
	 */
	public int add(UumsUser user, List<UumsSynchOrgUserMapperDTO> mappList, 
			UumsSynchTypeConfigDTO synchTypeDto) throws NamingException {
		DirContext ds = LdapUtil.connect(synchTypeDto.getHostIp(), synchTypeDto.getHostPort(),
				synchTypeDto.getUserName(), synchTypeDto.getPassword());
		try {
			Attributes attrs = this.preAddUpdateFormat(user, mappList);
			
			// 用户类或扩展类
			Attribute objclass = new BasicAttribute("objectClass");
			objclass.add("inetOrgPerson");
			//TO-DO:考虑多个扩展类的处理
			if(StringUtils.isNotEmpty(synchTypeDto.getUserObject())){
				objclass.add(synchTypeDto.getUserObject());
			}
			attrs.put(objclass);

			String dn = "uid=" + user.getNo() + "," + synchTypeDto.getUserOu();
			ds.createSubcontext(dn, attrs);
			
			return 1;
		} catch (Exception e) {
			throw e;
		}finally{
			LdapUtil.close(ds);
		}
	}
	
	/**
	 * 查询用户是否存在，如果存在返回true，否则返回false
	 * @param searchBase 查询入口节点
	 * @param searchFilter 查询过滤器
	 * @param synchTypeDto
	 * @return boolean true-存在，false-不存在
	 * @throws NamingException
	 */
	public boolean searchExist(String searchBase, String searchFilter, UumsSynchTypeConfigDTO synchTypeDto) throws NamingException {
		Assert.notNull(searchBase);
		Assert.notNull(searchFilter);
		DirContext ds = LdapUtil.connect(synchTypeDto.getHostIp(), synchTypeDto.getHostPort(),
				synchTypeDto.getUserName(), synchTypeDto.getPassword());
		try {
			SearchControls searchCtls = new SearchControls();

			// Specify the search scope
			searchCtls.setSearchScope(SearchControls.SUBTREE_SCOPE);

			// Search for objects using the filter
			NamingEnumeration<SearchResult> entries = ds.search(searchBase,
					searchFilter, searchCtls);
			if(entries.hasMoreElements()){
				return true;
			}
			
			return false;
		} catch (Exception e) {
			throw e;
		}finally{
			LdapUtil.close(ds);
		}
	}

	/**
	 * 更新用户数据
	 * @param user UumsUser
	 * @param mappList List<UumsSynchOrgUserMapperDTO>
	 * @param synchTypeDto UumsSynchTypeConfigDTO
	 * @return
	 * @throws NamingException
	 */
	public int update(UumsUser user, List<UumsSynchOrgUserMapperDTO> mappList, 
			UumsSynchTypeConfigDTO synchTypeDto) throws NamingException {
		DirContext ds = LdapUtil.connect(synchTypeDto.getHostIp(), synchTypeDto.getHostPort(),
				synchTypeDto.getUserName(), synchTypeDto.getPassword());
		try {
			Attributes attrs = this.preAddUpdateFormat(user, mappList);

			String dn = "uid=" + user.getNo() + "," + synchTypeDto.getUserOu();
			ds.modifyAttributes(dn, DirContext.REPLACE_ATTRIBUTE, attrs);

			return 1;
		} catch (Exception e) {
			throw e;
		}finally{
			LdapUtil.close(ds);
		}
	}

	/**
	 * 删除目录用户数据
	 * @param user UumsUser
	 * @param mappList List<UumsSynchOrgUserMapperDTO>
	 * @param synchTypeDto UumsSynchTypeConfigDTO
	 * @return
	 * @throws Exception
	 */
	public int delete(UumsUser user, UumsSynchTypeConfigDTO synchTypeDto, 
			List<UumsSynchOrgUserMapperDTO> mappList) throws Exception {
		DirContext ds = LdapUtil.connect(synchTypeDto.getHostIp(), synchTypeDto.getHostPort(),
				synchTypeDto.getUserName(), synchTypeDto.getPassword());
		try {
			String dn = "uid=" + user.getUnitCode() + "," + synchTypeDto.getUserOu();
			ds.destroySubcontext(dn);
			
			return 1;
		} catch (Exception e) {
			throw e;
		}finally{
			LdapUtil.close(ds);
		}
	}
	
	/**
	 * 封装目录属性，格式化数据处理
	 * @param user
	 * @param mappList
	 * @return
	 * @throws NamingException
	 */
	private Attributes preAddUpdateFormat(UumsUser user, 
			List<UumsSynchOrgUserMapperDTO> mappList) throws NamingException {
		Attributes attrs = new BasicAttributes();
		attrs.put("sn", user.getName());
		attrs.put("cn", user.getNo());
		for(UumsSynchOrgUserMapperDTO mapper : mappList){
			//调用自定义数据格式化类和方法，进行数据格式化
			Object obj = ReflectionUtils.invokeGetterMethod(user, mapper.getUumsAttribute());
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
			if(!"photo".equals(mapper.getUumsAttribute()) && obj == null){
				continue;
			}
			if("date".equals(mapper.getDataType().toLowerCase())){
				if(obj instanceof Date){
					obj = DateUtil.getDateStr((Date)obj);
				}else{// 非日期格式
					obj = DateUtil.getCurDateStr("yyyy-MM-dd");
				}
			}else if("number".equals(mapper.getDataType().toLowerCase())){
				if(obj instanceof BigDecimal){
					obj = obj + "";
				}else{
					try {//是数字
						BigDecimal bd = new BigDecimal((String)obj);
						obj = bd.toString();
					} catch (Exception e) {//非数字
						obj = "0";
					}
				}
			}else if("blob".equals(mapper.getDataType().toLowerCase())){
				//to-do 图片处理
				if("photo".equals(mapper.getUumsAttribute())){
					obj = user.getUumsPhoto();
					if(obj == null){
						continue;
					}
				}
			}else{
				obj = obj.toString();
			}
			
			attrs.put(mapper.getColumnCode() , obj);
		}

		return attrs;
	}
}
