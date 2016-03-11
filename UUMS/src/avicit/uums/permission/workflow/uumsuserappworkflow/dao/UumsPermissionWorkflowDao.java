package avicit.uums.permission.workflow.uumsuserappworkflow.dao;

import java.util.List;
import java.util.Map;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsPermissionWorkflowDTO;
/**
 * @classname: UumsPermissionWorkflowDao
 * @description: 定义  用户应用系统权限审批流程持久层 接口
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * @author:   AVICIT DEV
 */
@MyBatisRepository
public interface UumsPermissionWorkflowDao {
    
    /**
     * @author AVICIT DEV
     * @description: 分页查询 用户应用系统权限审批流程
     * @param searchParams
     * @return
     */
    public Page<UumsPermissionWorkflowDTO> searchUumsPermissionWorkflowByPage(Map<String, Object> uumsPermissionWorkflowDTO) ;
    
    /**
     * @author  AVICIT DEV
     * @description:查询对象用户应用系统权限审批流程
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public List<UumsPermissionWorkflowDTO> searchUumsPermissionWorkflow(UumsPermissionWorkflowDTO uumsPermissionWorkflowDTO);

    /**
     * @author AVICIT DEV
     * @description:查询对象 用户应用系统权限审批流程
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsPermissionWorkflowDTO findUumsPermissionWorkflowById(String id);
    
    /**
     * @author AVICIT DEV
     * @description: 新增对象 用户应用系统权限审批流程
     * @date 2014-12-26 11:13:20
     * @param paramMap
     * @return
     */
    public int insertUumsPermissionWorkflow(UumsPermissionWorkflowDTO uumsPermissionWorkflowDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 用户应用系统权限审批流程
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsPermissionWorkflowAll(UumsPermissionWorkflowDTO uumsPermissionWorkflowDTO);
    
    
    /**
     * @author AVICIT DEV
     * @description: 按主键删除 用户应用系统权限审批流程
     * @date 2014-12-26 11:13:20
     * @param ids
     * @return
     */ 
    public int deleteUumsPermissionWorkflowById(String id);
    
    /**
     * 根据权限审批流程ID查询实体
     * @param workflowId 流程ID
     * @return
     */
    public List<UumsPermissionWorkflowDTO> searchUumsPermissionWorkflowByWorkflowId(String workflowId);
}
