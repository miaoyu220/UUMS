package avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.rest;

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

import avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.dto.UumsOrgSynchRecordDTO;
import avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.service.UumsOrgSynchRecordService;

@RestEasyController
@Path("/api/uums/synch/toappsys/orgdept/uumsorgsynchrecord/UumsOrgSynchRecordRest")
public class UumsOrgSynchRecordRest{
    private static final Logger logger =  LoggerFactory.getLogger(UumsOrgSynchRecordRest.class);
    
	@Autowired
	private UumsOrgSynchRecordService uumsOrgSynchRecordService;
	/**
	 * 通过ID获取单条记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UumsOrgSynchRecordDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<UumsOrgSynchRecordDTO> responseMsg = new ResponseMsg<UumsOrgSynchRecordDTO>();
		UumsOrgSynchRecordDTO dto = uumsOrgSynchRecordService.queryUumsOrgSynchRecordByPrimaryKey(id);
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
	public ResponseMsg<String> save(UumsOrgSynchRecordDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = uumsOrgSynchRecordService.insertUumsOrgSynchRecord(dto);
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
	public ResponseMsg<Integer> updateSensitive(UumsOrgSynchRecordDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsOrgSynchRecordService.updateUumsOrgSynchRecordSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(UumsOrgSynchRecordDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsOrgSynchRecordService.updateUumsOrgSynchRecord(dto);
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
		int count = uumsOrgSynchRecordService.deleteUumsOrgSynchRecordById(id);
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
	public ResponseMsg<QueryRespBean<UumsOrgSynchRecordDTO>> searchByPage(QueryReqBean<UumsOrgSynchRecordDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<UumsOrgSynchRecordDTO>> responseMsg = new ResponseMsg<QueryRespBean<UumsOrgSynchRecordDTO>>();
		QueryRespBean<UumsOrgSynchRecordDTO> queryRespBean = uumsOrgSynchRecordService.searchUumsOrgSynchRecordByPage(queryReqBean);
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
	public ResponseMsg<List<UumsOrgSynchRecordDTO>> search(QueryReqBean<UumsOrgSynchRecordDTO> queryReqBean) throws Exception {
		ResponseMsg<List<UumsOrgSynchRecordDTO>> responseMsg = new ResponseMsg<List<UumsOrgSynchRecordDTO>>();
		List<UumsOrgSynchRecordDTO> queryRespBean = uumsOrgSynchRecordService.searchUumsOrgSynchRecord(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
}
