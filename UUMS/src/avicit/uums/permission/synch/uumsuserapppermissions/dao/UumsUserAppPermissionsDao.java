package avicit.uums.permission.synch.uumsuserapppermissions.dao;

import java.util.List;
import java.util.Map;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.uums.permission.synch.uumsuserapppermissions.dto.UumsUserAppPermissionsDTO;
/**
 * @classname: UumsUserAppPermissionsDao
 * @description: 定义  用户应用系统权限管理 持久层 接口
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * @author:  AVICIT DEV
 */
@MyBatisRepository
public interface UumsUserAppPermissionsDao {
    
    /**
     * @author AVICIT DEV
     * @description: 分页查询 用户应用系统权限管理
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public Page<UumsUserAppPermissionsDTO> searchUumsUserAppPermissionsByPage(UumsUserAppPermissionsDTO uumsUserAppPermissionsDTO) ;
    
    /**
     * @author AVICIT DEV
     * @description:查询对象 用户应用系统权限管理
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public List<UumsUserAppPermissionsDTO> searchUumsUserAppPermissions(UumsUserAppPermissionsDTO uumsUserAppPermissionsDTO);

    /**
     * @author AVICIT DEV
     * @description:查询对象 用户应用系统权限管理
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsUserAppPermissionsDTO findUumsUserAppPermissionsById(String id);
    
    /**
     * @author AVICIT DEV
     * @description: 新增对象 用户应用系统权限管理
     * @date 2014-12-26 11:13:20
     * @param paramMap
     * @return
     */
    public int insertUumsUserAppPermissions(UumsUserAppPermissionsDTO uumsUserAppPermissionsDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 用户应用系统权限管理
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsUserAppPermissionsSensitive(UumsUserAppPermissionsDTO uumsUserAppPermissionsDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 用户应用系统权限管理
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsUserAppPermissionsAll(UumsUserAppPermissionsDTO uumsUserAppPermissionsDTO);
    
    
    /**
     * @author AVICIT DEV
     * @description: 按主键删除 用户应用系统权限管理
     * @date 2014-12-26 11:13:20
     * @param ids
     * @return
     */ 
    public int deleteUumsUserAppPermissionsById(String id);
    
}
