package avicit.uums.permission.synch.uumsuserapppermissions.rest;

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

import avicit.uums.permission.synch.uumsuserapppermissions.dto.UumsUserAppPermissionsDTO;
import avicit.uums.permission.synch.uumsuserapppermissions.service.UumsUserAppPermissionsService;

@RestEasyController
@Path("/api/uums/permission/synch/uumsuserapppermissions/UumsUserAppPermissionsRest")
public class UumsUserAppPermissionsRest{
    private static final Logger logger =  LoggerFactory.getLogger(UumsUserAppPermissionsRest.class);
    
	@Autowired
	private UumsUserAppPermissionsService uumsUserAppPermissionsService;
	/**
	 * 通过ID获取单条记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UumsUserAppPermissionsDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<UumsUserAppPermissionsDTO> responseMsg = new ResponseMsg<UumsUserAppPermissionsDTO>();
		UumsUserAppPermissionsDTO dto = uumsUserAppPermissionsService.queryUumsUserAppPermissionsByPrimaryKey(id);
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
	public ResponseMsg<String> save(UumsUserAppPermissionsDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = uumsUserAppPermissionsService.insertUumsUserAppPermissions(dto);
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
	public ResponseMsg<Integer> updateSensitive(UumsUserAppPermissionsDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsUserAppPermissionsService.updateUumsUserAppPermissionsSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(UumsUserAppPermissionsDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsUserAppPermissionsService.updateUumsUserAppPermissions(dto);
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
		int count = uumsUserAppPermissionsService.deleteUumsUserAppPermissionsById(id);
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
	public ResponseMsg<QueryRespBean<UumsUserAppPermissionsDTO>> searchByPage(QueryReqBean<UumsUserAppPermissionsDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<UumsUserAppPermissionsDTO>> responseMsg = new ResponseMsg<QueryRespBean<UumsUserAppPermissionsDTO>>();
		QueryRespBean<UumsUserAppPermissionsDTO> queryRespBean = uumsUserAppPermissionsService.searchUumsUserAppPermissionsByPage(queryReqBean);
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
	public ResponseMsg<List<UumsUserAppPermissionsDTO>> search(QueryReqBean<UumsUserAppPermissionsDTO> queryReqBean) throws Exception {
		ResponseMsg<List<UumsUserAppPermissionsDTO>> responseMsg = new ResponseMsg<List<UumsUserAppPermissionsDTO>>();
		List<UumsUserAppPermissionsDTO> queryRespBean = uumsUserAppPermissionsService.searchUumsUserAppPermissions(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
}
