package avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.rest;

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

import avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.dto.UumsSynchMapperMetaDataDTO;
import avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.service.UumsSynchMapperMetaDataService;

@RestEasyController
@Path("/api/uums/appsys/synchmappermeta/uumssynchmappermetadata/UumsSynchMapperMetaDataRest")
public class UumsSynchMapperMetaDataRest{
    private static final Logger logger =  LoggerFactory.getLogger(UumsSynchMapperMetaDataRest.class);
    
	@Autowired
	private UumsSynchMapperMetaDataService uumsSynchMapperMetaDataService;
	/**
	 * 通过ID获取单条记录
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@GET
	@Path("/get/v1/{id}")
	@Produces("application/json;charset=UTF-8")
	public ResponseMsg<UumsSynchMapperMetaDataDTO> get(@PathParam("id") String id) throws Exception {
		ResponseMsg<UumsSynchMapperMetaDataDTO> responseMsg = new ResponseMsg<UumsSynchMapperMetaDataDTO>();
		UumsSynchMapperMetaDataDTO dto = uumsSynchMapperMetaDataService.queryUumsSynchMapperMetaDataByPrimaryKey(id);
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
	public ResponseMsg<String> save(UumsSynchMapperMetaDataDTO dto) throws Exception {
		ResponseMsg<String> responseMsg = new ResponseMsg<String>();
		String id = uumsSynchMapperMetaDataService.insertUumsSynchMapperMetaData(dto);
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
	public ResponseMsg<Integer> updateSensitive(UumsSynchMapperMetaDataDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsSynchMapperMetaDataService.updateUumsSynchMapperMetaDataSensitive(dto);
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
	public ResponseMsg<Integer> updateAll(UumsSynchMapperMetaDataDTO dto) throws Exception {
		ResponseMsg<Integer> responseMsg = new ResponseMsg<Integer>();
		int count = uumsSynchMapperMetaDataService.updateUumsSynchMapperMetaData(dto);
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
		int count = uumsSynchMapperMetaDataService.deleteUumsSynchMapperMetaDataById(id);
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
	public ResponseMsg<QueryRespBean<UumsSynchMapperMetaDataDTO>> searchByPage(QueryReqBean<UumsSynchMapperMetaDataDTO> queryReqBean) throws Exception {
		ResponseMsg<QueryRespBean<UumsSynchMapperMetaDataDTO>> responseMsg = new ResponseMsg<QueryRespBean<UumsSynchMapperMetaDataDTO>>();
		QueryRespBean<UumsSynchMapperMetaDataDTO> queryRespBean = uumsSynchMapperMetaDataService.searchUumsSynchMapperMetaDataByPage(queryReqBean);
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
	public ResponseMsg<List<UumsSynchMapperMetaDataDTO>> search(QueryReqBean<UumsSynchMapperMetaDataDTO> queryReqBean) throws Exception {
		ResponseMsg<List<UumsSynchMapperMetaDataDTO>> responseMsg = new ResponseMsg<List<UumsSynchMapperMetaDataDTO>>();
		List<UumsSynchMapperMetaDataDTO> queryRespBean = uumsSynchMapperMetaDataService.searchUumsSynchMapperMetaData(queryReqBean);
		responseMsg.setResponseBody(queryRespBean);
		return responseMsg;
	}
	
}
