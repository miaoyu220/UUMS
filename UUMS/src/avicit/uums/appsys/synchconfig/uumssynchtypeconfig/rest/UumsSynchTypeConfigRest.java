package avicit.uums.appsys.synchconfig.uumssynchtypeconfig.rest;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;

import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchTypeConfigService;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchOrgUserMapperService;
//import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.Service;


@RestEasyController
@Path("/api/uums/appsys/synchconfig/uumssynchtypeconfig/UumsSynchTypeConfigRest")
public class UumsSynchTypeConfigRest{
    private static final Logger logger =  LoggerFactory.getLogger(UumsSynchTypeConfigRest.class);
    
	@Autowired
	private UumsSynchTypeConfigService uumsSynchTypeConfigService;
	
	@Autowired
	private UumsSynchOrgUserMapperService uumsSynchOrgUserMapperService;
	
	/**
	 * 通过主表id获得主表数据
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@GET
	@Path("/getMain/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UumsSynchTypeConfigDTO> getMainById(@PathParam("id") String id) throws Exception {
		ResponseMsg<UumsSynchTypeConfigDTO> responseMsg = new ResponseMsg<UumsSynchTypeConfigDTO>();
		UumsSynchTypeConfigDTO dto = uumsSynchTypeConfigService.queryUumsSynchTypeConfigByPrimaryKey(id);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	/**
	 * 保存一条主表数据
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/saveMain/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<String> saveMain(UumsSynchTypeConfigDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id =  uumsSynchTypeConfigService.insertUumsSynchTypeConfig(dto);
		responseMsg.setResponseBody(id);
		return responseMsg;
	}
	/**
	 * 更新主表数据
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/updateMain/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateMainSensitive(UumsSynchTypeConfigDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsSynchTypeConfigService.updateUumsSynchTypeConfigSensitive(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 修改主表一条记录的全部字段
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/updateMainAll/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateMainAll(UumsSynchTypeConfigDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsSynchTypeConfigService.updateUumsSynchTypeConfig(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 按条件分页查询主表数据
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/searchMainByPage/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<UumsSynchTypeConfigDTO>> searchMainByPage(QueryReqBean<UumsSynchTypeConfigDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<UumsSynchTypeConfigDTO>> responseMsg = new ResponseMsg<QueryRespBean<UumsSynchTypeConfigDTO>>();
		QueryRespBean<UumsSynchTypeConfigDTO> queryRespBean = uumsSynchTypeConfigService.searchUumsSynchTypeConfigByPage(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
	/**
	 * 按条件不分页查询主表数据
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/searchMain/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<UumsSynchTypeConfigDTO>> searchMain(QueryReqBean<UumsSynchTypeConfigDTO> queryReqBean) throws Exception {
		ResponseMsg<List<UumsSynchTypeConfigDTO>> responseMsg = new ResponseMsg<List<UumsSynchTypeConfigDTO>>();
		List<UumsSynchTypeConfigDTO> queryRespBean = uumsSynchTypeConfigService.searchUumsSynchTypeConfig(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
	/**
	 * 按照ID删除一条主表记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/deleteMainById/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> deleteMainById(String id) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsSynchTypeConfigService.deleteUumsSynchTypeConfigById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	
	//*********************************子表操作*********************************************
	//按照父id获得子表数据
	@GET
	@Path("/getSubByPid/v1/{pid}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<List<UumsSynchOrgUserMapperDTO>> getSubByPid(@PathParam("pid") String pid) throws Exception {
		ResponseMsg<List<UumsSynchOrgUserMapperDTO>> responseMsg = new ResponseMsg<List<UumsSynchOrgUserMapperDTO>>();
		List<UumsSynchOrgUserMapperDTO> dto = uumsSynchOrgUserMapperService.queryUumsSynchOrgUserMapperByPid(pid);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	
	/**
	 * 通过子表id获得数据
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@GET
	@Path("/getSub/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UumsSynchOrgUserMapperDTO> getSubById(@PathParam("id") String id) throws Exception {
		ResponseMsg<UumsSynchOrgUserMapperDTO> responseMsg = new ResponseMsg<UumsSynchOrgUserMapperDTO>();
		UumsSynchOrgUserMapperDTO dto = uumsSynchOrgUserMapperService.queryUumsSynchOrgUserMapperByPrimaryKey(id);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	/**
	 * 更新子表数据
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/updateSub/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateSubSensitive(UumsSynchOrgUserMapperDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsSynchOrgUserMapperService.updateUumsSynchOrgUserMapper(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 修改子表一条记录的全部字段
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/updateSubAll/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateSubAll(UumsSynchOrgUserMapperDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsSynchOrgUserMapperService.updateUumsSynchOrgUserMapperSensitive(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 按照ID删除一条子表记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/deleteSubById/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> deleteSubById(String id) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsSynchOrgUserMapperService.deleteUumsSynchOrgUserMapperById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
}
