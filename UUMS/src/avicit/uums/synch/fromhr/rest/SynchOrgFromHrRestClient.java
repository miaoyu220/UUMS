package avicit.uums.synch.fromhr.rest;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.GenericType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import avicit.platform6.api.sysuser.dto.SysOrgVo;
import avicit.platform6.core.rest.client.RestClient;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.rest.msg.Muti2Bean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.msg.ResponseStatus;

@Component
public class SynchOrgFromHrRestClient {
	
	private static final Logger logger =  LoggerFactory.getLogger(SynchOrgFromHrRestClient.class);
	
	public void insertOrgInfoRest(SysOrgVo sysOrgVo) {
		HashMap<String, Object> sessionParam = new HashMap<String, Object>();
		sessionParam.put("currentLanguageCode", "zh_CN");
		
		Muti2Bean<SysOrgVo, Map<String, Object>> arg = new Muti2Bean<SysOrgVo, Map<String, Object>>();
		arg.setDto1(sysOrgVo);
		arg.setDto2(sessionParam);
		
		String url = RestClientConfig.getRestHost(RestClientConfig.sysuser) + "/api/platform6/sysorguser/SysOrgContrl/insert/v1";
		RestClient.doPost(url, arg, new GenericType<ResponseMsg<Map<String,Object>>>(){}).getResponseBody();
	}
	
	public void updateOrgInfoRest(SysOrgVo sysOrgVo) {
		HashMap<String, Object> sessionParam = new HashMap<String, Object>();
		sessionParam.put("currentLanguageCode", "zh_CN");
		
		Muti2Bean<SysOrgVo, Map<String, Object>> arg = new Muti2Bean<SysOrgVo, Map<String, Object>>();
		arg.setDto1(sysOrgVo);
		arg.setDto2(sessionParam);
		
		String url = RestClientConfig.getRestHost(RestClientConfig.sysuser) + "/api/platform6/sysorguser/SysOrgContrl/update/v1";
		RestClient.doPost(url, arg, new GenericType<ResponseMsg<Map<String,Object>>>(){}).getResponseBody();
	}
	
	public String isHaveChildrenRest(String deptId) {
		HashMap<String, Object> sessionParam = new HashMap<String, Object>();
		sessionParam.put("currentLanguageCode", "zh_CN");
		
		Map<String,Object> parameter = new HashMap<String,Object>();
		parameter.put("deptId", deptId);
		parameter.put("sessionParam", sessionParam);
		ResponseMsg<String> responseMsg = RestClient.doPost(RestClientConfig.getRestHost(RestClientConfig.sysuser) + "/api/platform6/sysorguser/SysDept/isHaveChildren/v1", parameter, new GenericType<ResponseMsg<String>>(){});
		if(responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)){
			return responseMsg.getResponseBody();
		}else{
			logger.error("error:" + responseMsg.getErrorDesc());
			return null;
		}
	}
	
	public void deleteSysOrgByIdsRest(List<Map<String, String>> list) throws Exception{
		try {
			Map<String, Object> sessionParam = new HashMap<String, Object>();
			sessionParam.put("currentLanguageCode", "zh_CN");
			
			Muti2Bean<Collection<Map<String,String>>, Map<String, Object>> bean = new Muti2Bean<Collection<Map<String,String>>, Map<String,Object>>(list, sessionParam);
			
			String url = RestClientConfig.getRestHost(RestClientConfig.sysuser) + "/api/platform6/sysorguser/SysOrgContrl/delete/v1";
			ResponseMsg<String> responseMsg = RestClient.doPost(url, bean, new GenericType<ResponseMsg<String>>(){});
			if(!responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)){
				throw new Exception(responseMsg.getErrorDesc());
			}
		} catch (Exception e) {
			throw e;
		}
	}
}
