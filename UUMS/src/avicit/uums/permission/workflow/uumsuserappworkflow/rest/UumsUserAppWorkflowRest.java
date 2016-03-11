package avicit.uums.permission.workflow.uumsuserappworkflow.rest;

import java.util.List;
import java.util.Map;

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
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsUserAppWorkflowDTO;
import avicit.uums.permission.workflow.uumsuserappworkflow.service.UumsUserAppWorkflowService;

@RestEasyController
@Path("/api/uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowRest")
public class UumsUserAppWorkflowRest{
    private static final Logger logger =  LoggerFactory.getLogger(UumsUserAppWorkflowRest.class);
    
	@Autowired
	private UumsUserAppWorkflowService uumsUserAppWorkflowService;
	/**
	 * 通过ID获取单条记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UumsUserAppWorkflowDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<UumsUserAppWorkflowDTO> responseMsg = new ResponseMsg<UumsUserAppWorkflowDTO>();
		UumsUserAppWorkflowDTO dto = uumsUserAppWorkflowService.queryUumsUserAppWorkflowByPrimaryKey(id);
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
	public ResponseMsg<String> save(UumsUserAppWorkflowDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = uumsUserAppWorkflowService.insertUumsUserAppWorkflow(dto);
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
	public ResponseMsg<Integer> updateSensitive(UumsUserAppWorkflowDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsUserAppWorkflowService.updateUumsUserAppWorkflowSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(UumsUserAppWorkflowDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsUserAppWorkflowService.updateUumsUserAppWorkflow(dto);
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
		int count = uumsUserAppWorkflowService.deleteUumsUserAppWorkflowById(id);
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
	public ResponseMsg<QueryRespBean<UumsUserAppWorkflowDTO>> searchByPage(QueryReqBean<Map<String, Object>> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<UumsUserAppWorkflowDTO>> responseMsg = new ResponseMsg<QueryRespBean<UumsUserAppWorkflowDTO>>();
		QueryRespBean<UumsUserAppWorkflowDTO> queryRespBean = uumsUserAppWorkflowService.searchUumsUserAppWorkflowByPage(queryReqBean);
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
	public ResponseMsg<List<UumsUserAppWorkflowDTO>> search(QueryReqBean<UumsUserAppWorkflowDTO> queryReqBean) throws Exception {
		ResponseMsg<List<UumsUserAppWorkflowDTO>> responseMsg = new ResponseMsg<List<UumsUserAppWorkflowDTO>>();
		List<UumsUserAppWorkflowDTO> queryRespBean = uumsUserAppWorkflowService.searchUumsUserAppWorkflow(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
}
