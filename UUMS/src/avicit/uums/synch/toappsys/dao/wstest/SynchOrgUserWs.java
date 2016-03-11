package avicit.uums.synch.toappsys.dao.wstest;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

@WebService
public interface SynchOrgUserWs {

	@WebMethod(operationName = "synchOrg")
	public int synchOrg(@WebParam(name = "orgJsonStr") String orgJsonStr);
	
	@WebMethod(operationName = "synchUser")
	public int synchUser(@WebParam(name = "userJsonStr") String userJsonStr);
}
