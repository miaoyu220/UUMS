package avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dao;
import java.util.List;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
/**
 * @classname: UumsSynchOrgUserMapperDao
 * @description: 定义 应用系统组织和用户同步映射信息 持久层 接口
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * @author:  AVICIT DEV
 */
@MyBatisRepository
public interface UumsSynchOrgUserMapperDao {
    

    /**
     * @author AVICIT DEV
     * @description:查询 应用系统组织和用户同步映射信息 
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsSynchOrgUserMapperDTO findUumsSynchOrgUserMapperById(String id);
    
    /**
     * @author AVICIT DEV
     * @description:按照应用系统id查询对象
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public List<UumsSynchOrgUserMapperDTO> findUumsSynchOrgUserMapperByPid(String pid);
    
    /**
     * @author AVICIT DEV
     * @description:根据应用系统ID和主体类型、字段Code不为空条件查询对象
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public List<UumsSynchOrgUserMapperDTO> findMapperByPidAndMaintypeAndColumnCode(UumsSynchOrgUserMapperDTO uumsSynchOrgUserMapperDTO);
    
    
    /**
     * @author miaoyu
     * @description: 根据应用系统ID和主体类型查询对象
     * @date 2015-12-7
     * @param uumsSynchOrgUserMapperDTO
     * @return
     */
    public Page<UumsSynchOrgUserMapperDTO> findUumsSynchOrgUserMapperByPidAndMaintype(UumsSynchOrgUserMapperDTO uumsSynchOrgUserMapperDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 新增应用系统组织和用户同步映射信息 
     * @date 2014-12-26 11:13:20
     * @param paramMap
     * @return
     */
    public int insertUumsSynchOrgUserMapper(UumsSynchOrgUserMapperDTO uumsSynchOrgUserMapperDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新应用系统组织和用户同步映射信息 
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsSynchOrgUserMapperSensitive(UumsSynchOrgUserMapperDTO uumsSynchOrgUserMapperDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新应用系统组织和用户同步映射信息 
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsSynchOrgUserMapperAll(UumsSynchOrgUserMapperDTO uumsSynchOrgUserMapperDTO);
    
    
    /**
     * @author AVICIT DEV
     * @description: 按主键删除应用系统组织和用户同步映射信息
     * @date 2014-12-26 11:13:20
     * @param ids
     * @return
     */ 
    public int deleteUumsSynchOrgUserMapperById(String id);
}
