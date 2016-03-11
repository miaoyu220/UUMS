package avicit.uums.synch.toappsys.dao.wstest;

import javax.jws.WebService;

import com.fasterxml.jackson.core.type.TypeReference;

import avicit.platform6.commons.utils.JsonHelper;
import avicit.uums.synch.fromhr.dto.UumsOrgDept;

//@WebService(endpointInterface = "avicit.uums.synch.toappsys.dao.wstest.SynchOrgUserWs")
@WebService
public class SynchOrgUserWsImpl implements SynchOrgUserWs {

	@Override
	public int synchOrg(String orgJsonStr) {
		// TODO Auto-generated method stub
		System.out.println("server: " + orgJsonStr);
		UumsOrgDept[] org = JsonHelper.getInstance().readValue(orgJsonStr, UumsOrgDept[].class);
		System.out.println(org[0].getDeptCode());
		System.out.println(org[0].getDeptName());
		System.out.println(org[1].getParentOrgCode());
		
		return 1;
	}

	@Override
	public int synchUser(String userJsonStr) {
		// TODO Auto-generated method stub
		System.out.println(userJsonStr);
		
		return 1;
	}

}
