package avicit.uums.synch.toappsys.dao;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.xml.namespace.QName;

import org.apache.commons.lang.StringUtils;
import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import avicit.platform6.commons.utils.DateUtil;
import avicit.platform6.commons.utils.reflection.ReflectionUtils;
import avicit.platform6.commons.utils.web.WsUtil;
import avicit.platform6.core.domain.BeanDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.custom.TestDataFormatImpl;

/**
 * WebService同步组织用户数据服务类
 * @author miaoyu
 * @since 2016-2-23
 *
 */
@Service
public class WsOrgUserDao {

	private static final Logger logger = LoggerFactory
			.getLogger(WsOrgUserDao.class);
	/**
	 * WebService方式同步组织部门数据
	 * @param beanDto BeanDTO
	 * @param mappList  List<UumsSynchOrgUserMapperDTO>
	 * @param synchTypeDto UumsSynchTypeConfigDTO
	 * @return 1-成功，0-失败
	 * @throws Exception
	 */
	public int synchOrg(BeanDTO beanDto, List<UumsSynchOrgUserMapperDTO> mappList, 
			UumsSynchTypeConfigDTO synchTypeDto) throws Exception {
		
		return this.synOrgUser(beanDto, mappList, synchTypeDto, "synchOrg");
	}
	
	/**
	 * WebService方式同步用户数据
	 * @param beanDto BeanDTO
	 * @param mappList  List<UumsSynchOrgUserMapperDTO>
	 * @param synchTypeDto UumsSynchTypeConfigDTO
	 * @return 1-成功，0-失败
	 * @throws Exception
	 */
	public int synchUser(BeanDTO beanDto, List<UumsSynchOrgUserMapperDTO> mappList, 
			UumsSynchTypeConfigDTO synchTypeDto) throws Exception {
		
		return this.synOrgUser(beanDto, mappList, synchTypeDto, "synchUser");
	}
	
	/**
	 * WebService方式同步组织、部门、用户数据
	 * @param beanDto BeanDTO
	 * @param mappList  List<UumsSynchOrgUserMapperDTO>
	 * @param synchTypeDto UumsSynchTypeConfigDTO
	 * @param operName webservice方法名：synchOrg-同步组织, synchUser-同步用户
	 * @return 1-成功，0-失败
	 * @throws Exception
	 */
	private int synOrgUser(BeanDTO beanDto, List<UumsSynchOrgUserMapperDTO> mappList, 
			UumsSynchTypeConfigDTO synchTypeDto, String operName) throws Exception{
		String wsdlUrl = synchTypeDto.getWsUrl();
		Assert.notNull(wsdlUrl, "WebService地址不能为空！");
		
		JaxWsDynamicClientFactory clientFactory = JaxWsDynamicClientFactory.newInstance();
		Client client = clientFactory.createClient(wsdlUrl);
		QName opName = WsUtil.getOperationName(client.getEndpoint(), operName);
		
		String dataJsonStr = "{";
		for(UumsSynchOrgUserMapperDTO mapper : mappList){
			dataJsonStr += "\"" + mapper.getColumnCode() + "\":";
			
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
						e.printStackTrace();
						logger.error("执行自定义数据格式化时错误：" + dataFormatClassStr);
					}
				}
			}
			
			if(obj == null){
				dataJsonStr += "\"\",";
				continue;
			}
			
			//字段类型处理
			if("date".equals(mapper.getDataType().toLowerCase())){
				if(obj != null && obj instanceof Date){
					obj = DateUtil.format((Date)obj, "yyyy-MM-dd");
				}else{// 非日期格式
					obj = DateUtil.getTodayStr();
				}
			}else if("number".equals(mapper.getDataType().toLowerCase())){
				if(obj != null && obj instanceof BigDecimal){
					obj = obj.toString();
				}else{
					try {//是数字
						BigDecimal bd = new BigDecimal((String)obj);
					} catch (Exception e) {//非数字
						obj = 0;
					}
				}
			}else if("blob".equals(mapper.getDataType().toLowerCase())){
				//to-do
				
			}else{//字符类型
				//to-do
			}
			
			dataJsonStr += "\"" + obj + "\",";
		}
		dataJsonStr = StringUtils.removeEnd(dataJsonStr, ",");
		dataJsonStr += "}";
		Object[] result = client.invoke(opName, dataJsonStr);
		return (int)result[0];
	}
	
}
