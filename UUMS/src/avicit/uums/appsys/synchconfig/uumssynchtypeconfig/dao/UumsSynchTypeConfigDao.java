package avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dao;
import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
/**
 * @classname:  UumsSynchTypeConfigDao
 * @description: 定义  应用系统同步方式配置信息 持久层 接口
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * @author:   AVICIT DEV
 */
@MyBatisRepository
public interface UumsSynchTypeConfigDao {
    
    /**
     * @author AVICIT DEV
     * @description: 分页查询应用系统同步方式配置信息
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public Page<UumsSynchTypeConfigDTO> searchUumsSynchTypeConfigByPage(UumsSynchTypeConfigDTO uumsSynchTypeConfigDTO) ;
    
    /**
     * @author AVICIT DEV
     * @description:查询对象 应用系统同步方式配置信息
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public List<UumsSynchTypeConfigDTO> searchUumsSynchTypeConfig(UumsSynchTypeConfigDTO uumsSynchTypeConfigDTO);

    /**
     * @author AVICIT DEV
     * @description:查询对象 应用系统同步方式配置信息
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsSynchTypeConfigDTO findUumsSynchTypeConfigById(String id);
    
    /**
     * @author AVICIT DEV
     * @description:通过应用系统ID查询对象 应用系统同步方式配置信息
     * @date 2014-12-26 11:13:20
     * @param appId
     * @return
     */
    public UumsSynchTypeConfigDTO findUumsSynchTypeConfigByAppId(String appId);
    
    /**
     * @author AVICIT DEV
     * @description: 新增对象出差信息表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     * @return
     */
    public int insertUumsSynchTypeConfig(UumsSynchTypeConfigDTO uumsSynchTypeConfigDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象应用系统同步方式配置信息
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsSynchTypeConfigSensitive(UumsSynchTypeConfigDTO uumsSynchTypeConfigDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象应用系统同步方式配置信息
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsSynchTypeConfigAll(UumsSynchTypeConfigDTO uumsSynchTypeConfigDTO);
    
    
    /**
     * @author AVICIT DEV
     * @description: 按主键删除应用系统同步方式配置信息
     * @date 2014-12-26 11:13:20
     * @param ids
     * @return
     */ 
    public int deleteUumsSynchTypeConfigById(String id);
}
