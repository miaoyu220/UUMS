package avicit.uums.synch.log.orglog.uumslogsynchorg.rest;

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

import avicit.uums.synch.log.orglog.uumslogsynchorg.dto.UumsLogSynchOrgDTO;
import avicit.uums.synch.log.orglog.uumslogsynchorg.service.UumsLogSynchOrgService;

@RestEasyController
@Path("/api/uums/synch/log/orglog/uumslogsynchorg/UumsLogSynchOrgRest")
public class UumsLogSynchOrgRest{
    private static final Logger logger =  LoggerFactory.getLogger(UumsLogSynchOrgRest.class);
    
	@Autowired
	private UumsLogSynchOrgService uumsLogSynchOrgService;
	/**
	 * 通过ID获取单条记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UumsLogSynchOrgDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<UumsLogSynchOrgDTO> responseMsg = new ResponseMsg<UumsLogSynchOrgDTO>();
		UumsLogSynchOrgDTO dto = uumsLogSynchOrgService.queryUumsLogSynchOrgByPrimaryKey(id);
		responseMsg.setResponseBody(dto);
		return responseMsg;
	}
	
	/**
	 * 插入一条记录
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/save/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<String> save(UumsLogSynchOrgDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = uumsLogSynchOrgService.insertUumsLogSynchOrg(dto);
		responseMsg.setResponseBody(id);
		return responseMsg;
	}
	/**
	 * 修改一条记录，按照匹配字段修改
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/updateSensitive/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateSensitive(UumsLogSynchOrgDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsLogSynchOrgService.updateUumsLogSynchOrgSensitive(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 修改一条记录的全部字段
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/updateAll/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> updateAll(UumsLogSynchOrgDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsLogSynchOrgService.updateUumsLogSynchOrg(dto);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 按照ID删除一条记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/deleteById/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<Integer> deleteById(String id) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsLogSynchOrgService.deleteUumsLogSynchOrgById(id);
		responseMsg.setResponseBody(count);
		return responseMsg;
	}
	/**
	 * 按条件分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/searchByPage/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<QueryRespBean<UumsLogSynchOrgDTO>> searchByPage(QueryReqBean<UumsLogSynchOrgDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<UumsLogSynchOrgDTO>> responseMsg = new ResponseMsg<QueryRespBean<UumsLogSynchOrgDTO>>();
		QueryRespBean<UumsLogSynchOrgDTO> queryRespBean = uumsLogSynchOrgService.searchUumsLogSynchOrgByPage(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	/**
	 * 按条件不分页查询
	 * @param queryReqBean
	 * @return
	 * @throws Exception
	 */
	@POST
	@Path("/search/v1/")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/json;charset=UTF-8")
	public ResponseMsg<List<UumsLogSynchOrgDTO>> search(QueryReqBean<UumsLogSynchOrgDTO> queryReqBean) throws Exception {
		ResponseMsg<List<UumsLogSynchOrgDTO>> responseMsg = new ResponseMsg<List<UumsLogSynchOrgDTO>>();
		List<UumsLogSynchOrgDTO> queryRespBean = uumsLogSynchOrgService.searchUumsLogSynchOrg(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
}
