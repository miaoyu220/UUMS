package avicit.uums.permission.workflow.uumsuserappworkflow.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsUserAppWorkflowDTO;
/**
 * @classname: UumsUserAppWorkflowDao
 * @description: 定义  用户应用系统权限审批表持久层 接口
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * @author:   AVICIT DEV
 */
@MyBatisRepository
public interface UumsUserAppWorkflowDao {
    
    /**
     * @author AVICIT DEV
     * @description: 分页查询 用户应用系统权限审批表
     * @param searchParams
     * @return
     */
    public Page<UumsUserAppWorkflowDTO> searchUumsUserAppWorkflowByPage(Map<String, Object> uumsUserAppWorkflowDTO) ;
    
    /**
     * @author  AVICIT DEV
     * @description:查询对象用户应用系统权限审批表
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public List<UumsUserAppWorkflowDTO> searchUumsUserAppWorkflow(UumsUserAppWorkflowDTO uumsUserAppWorkflowDTO);

    /**
     * @author AVICIT DEV
     * @description:查询对象 用户应用系统权限审批表
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsUserAppWorkflowDTO findUumsUserAppWorkflowById(String id);
    
    /**
     * @author AVICIT DEV
     * @description: 新增对象 用户应用系统权限审批表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     * @return
     */
    public int insertUumsUserAppWorkflow(UumsUserAppWorkflowDTO uumsUserAppWorkflowDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 用户应用系统权限审批表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsUserAppWorkflowSensitive(UumsUserAppWorkflowDTO uumsUserAppWorkflowDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 用户应用系统权限审批表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsUserAppWorkflowAll(UumsUserAppWorkflowDTO uumsUserAppWorkflowDTO);
    
    
    /**
     * @author AVICIT DEV
     * @description: 按主键删除 用户应用系统权限审批表
     * @date 2014-12-26 11:13:20
     * @param ids
     * @return
     */ 
    public int deleteUumsUserAppWorkflowById(String id);
    
    public int generatorWorkFlowNo(@Param("startDate")Date startDate, @Param("endDate")Date endDate);
}
