package avicit.uums.synch.log.userlog.uumslogsynchuser.rest;

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

import avicit.uums.synch.log.userlog.uumslogsynchuser.dto.UumsLogSynchUserDTO;
import avicit.uums.synch.log.userlog.uumslogsynchuser.service.UumsLogSynchUserService;

@RestEasyController
@Path("/api/uums/synch/log/userlog/uumslogsynchuser/UumsLogSynchUserRest")
public class UumsLogSynchUserRest{
    private static final Logger logger =  LoggerFactory.getLogger(UumsLogSynchUserRest.class);
    
	@Autowired
	private UumsLogSynchUserService uumsLogSynchUserService;
	/**
	 * 通过ID获取单条记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UumsLogSynchUserDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<UumsLogSynchUserDTO> responseMsg = new ResponseMsg<UumsLogSynchUserDTO>();
		UumsLogSynchUserDTO dto = uumsLogSynchUserService.queryUumsLogSynchUserByPrimaryKey(id);
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
	public ResponseMsg<String> save(UumsLogSynchUserDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = uumsLogSynchUserService.insertUumsLogSynchUser(dto);
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
	public ResponseMsg<Integer> updateSensitive(UumsLogSynchUserDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsLogSynchUserService.updateUumsLogSynchUserSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(UumsLogSynchUserDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsLogSynchUserService.updateUumsLogSynchUser(dto);
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
		int count = uumsLogSynchUserService.deleteUumsLogSynchUserById(id);
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
	public ResponseMsg<QueryRespBean<UumsLogSynchUserDTO>> searchByPage(QueryReqBean<UumsLogSynchUserDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<UumsLogSynchUserDTO>> responseMsg = new ResponseMsg<QueryRespBean<UumsLogSynchUserDTO>>();
		QueryRespBean<UumsLogSynchUserDTO> queryRespBean = uumsLogSynchUserService.searchUumsLogSynchUserByPage(queryReqBean);
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
	public ResponseMsg<List<UumsLogSynchUserDTO>> search(QueryReqBean<UumsLogSynchUserDTO> queryReqBean) throws Exception {
		ResponseMsg<List<UumsLogSynchUserDTO>> responseMsg = new ResponseMsg<List<UumsLogSynchUserDTO>>();
		List<UumsLogSynchUserDTO> queryRespBean = uumsLogSynchUserService.searchUumsLogSynchUser(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
}
