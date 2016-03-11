package avicit.uums.synch.fromhr.rest;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.core.GenericType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.core.rest.client.RestClient;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.msg.ResponseStatus;

@Component
public class SynchDeptFromHrRestClient {
	
	private static final Logger logger =  LoggerFactory.getLogger(SynchDeptFromHrRestClient.class);
	
	public SysDept insertDeptInfoRest(SysDept sysDeptVo) {
		sysDeptVo.setCurrentLanguageCode("zh_CN");
		ResponseMsg<SysDept> responseMsg = RestClient
				.doPost(RestClientConfig.getRestHost(RestClientConfig.sysuser)
						+ "/api/platform6/sysorguser/SysDept/insertDeptInfo/v1",
						sysDeptVo, new GenericType<ResponseMsg<SysDept>>() {
						});
		if (responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)) {
			return responseMsg.getResponseBody();
		} else {
			logger.error("error:" + responseMsg.getErrorDesc());
			return null;
		}
	}
	
	public SysDept updateDeptInfoRest(SysDept sysDeptVo) {
		// Map<String,Object> parameter = new HashMap<String,Object>();
		sysDeptVo.setCurrentLanguageCode("zh_CN");
		ResponseMsg<SysDept> responseMsg = RestClient
				.doPost(RestClientConfig.getRestHost(RestClientConfig.sysuser)
						+ "/api/platform6/sysorguser/SysDept/updateDeptInfo/v1",
						sysDeptVo, new GenericType<ResponseMsg<SysDept>>() {
						});
		if (responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)) {
			return responseMsg.getResponseBody();
		} else {
			logger.error("error:" + responseMsg.getErrorDesc());
			return null;
		}
	}
	
	public String isHaveChildrenRest(String deptId) {
		Map<String, Object> sessionParam = new HashMap<String, Object>();
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
	
	public void deleteSysDeptByIdRest(String deptId) {
		Map<String,Object> parameter = new HashMap<String,Object>();
		parameter.put("deptId", deptId);
		ResponseMsg<Void> responseMsg = RestClient.doPost(RestClientConfig.getRestHost(RestClientConfig.sysuser) + "/api/platform6/sysorguser/SysDept/deleteSysDeptById/v1", deptId, new GenericType<ResponseMsg<Void>>(){});
		if(!responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)){
			throw new RuntimeException(responseMsg.getErrorDesc());
		}
	}
}
