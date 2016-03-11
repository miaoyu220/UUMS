package avicit.uums.synch.fromhr.rest;

import java.util.Map;

import javax.ws.rs.core.GenericType;
import org.springframework.stereotype.Component;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.core.rest.client.RestClient;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.rest.msg.Muti2Bean;
import avicit.platform6.core.rest.msg.Muti3Bean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.msg.ResponseStatus;

@Component
public class SynchUserFromHrRestClient {
	
	public void insertUserInfoRest(Muti2Bean<SysUser, String> parameterbean) {
		ResponseMsg<Void> responseMsg = RestClient
				.doPost(RestClientConfig.getRestHost(RestClientConfig.sysuser)
						+ "/api/platform6/sysorguser/SysUser/insertSysUserVo/v1",
						parameterbean, new GenericType<ResponseMsg<Void>>() {
						});
		if (responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)) {

		} else {
			throw new RuntimeException(responseMsg.getErrorDesc());
		}
	}

	public void updateUserInfoRest(Muti3Bean<SysUser, Map<String, Object>, Void> parameterbean) {
		ResponseMsg<Boolean> responseMsg = RestClient
				.doPost(RestClientConfig.getRestHost(RestClientConfig.sysuser)
						+ "/api/platform6/sysorguser/SysUser/updateSysUserVo/v1",
						parameterbean, new GenericType<ResponseMsg<Boolean>>() {
						});
		if (responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)) {

		} else {
			throw new RuntimeException(responseMsg.getErrorDesc());
		}
	}

	public void deleteOperationsRest(
			Muti3Bean<String[], String[], Void> parameterbean) {
		ResponseMsg<Void> responseMsg = RestClient
				.doPost(RestClientConfig.getRestHost(RestClientConfig.sysuser)
						+ "/api/platform6/sysorguser/SysUser/deleteOperations/v1",
						parameterbean, new GenericType<ResponseMsg<Void>>() {
						});
		if (responseMsg.getRetCode().equals(ResponseStatus.HTTP_OK)) {

		} else {
			throw new RuntimeException(responseMsg.getErrorDesc());
		}
	}

}
