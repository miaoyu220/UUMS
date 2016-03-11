package avicit.uums.appsys.register.uumsappsys.rest;

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

import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;

@RestEasyController
@Path("/api/uums/appsys/register/uumsappsys/UumsAppSysRest")
public class UumsAppSysRest{
    private static final Logger logger =  LoggerFactory.getLogger(UumsAppSysRest.class);
    
	@Autowired
	private UumsAppSysService uumsAppSysService;
	/**
	 * 通过ID获取单条记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UumsAppSysDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<UumsAppSysDTO> responseMsg = new ResponseMsg<UumsAppSysDTO>();
		UumsAppSysDTO dto = uumsAppSysService.queryUumsAppSysByPrimaryKey(id);
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
	public ResponseMsg<String> save(UumsAppSysDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = uumsAppSysService.insertUumsAppSys(dto);
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
	public ResponseMsg<Integer> updateSensitive(UumsAppSysDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsAppSysService.updateUumsAppSysSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(UumsAppSysDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsAppSysService.updateUumsAppSys(dto);
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
		int count = uumsAppSysService.deleteUumsAppSysById(id);
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
	public ResponseMsg<QueryRespBean<UumsAppSysDTO>> searchByPage(QueryReqBean<UumsAppSysDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<UumsAppSysDTO>> responseMsg = new ResponseMsg<QueryRespBean<UumsAppSysDTO>>();
		QueryRespBean<UumsAppSysDTO> queryRespBean = uumsAppSysService.searchUumsAppSysByPage(queryReqBean);
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
	public ResponseMsg<List<UumsAppSysDTO>> search(QueryReqBean<UumsAppSysDTO> queryReqBean) throws Exception {
		ResponseMsg<List<UumsAppSysDTO>> responseMsg = new ResponseMsg<List<UumsAppSysDTO>>();
		List<UumsAppSysDTO> queryRespBean = uumsAppSysService.searchUumsAppSys(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
}
