package avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.dao;

import java.util.List;
import java.util.Map;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.dto.UumsSynchMapperMetaDataDTO;
/**
 * @classname: UumsSynchMapperMetaDataDao
 * @description: 定义  组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化 持久层 接口
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * @author:  AVICIT DEV
 */
@MyBatisRepository
public interface UumsSynchMapperMetaDataDao {
    
    /**
     * @author AVICIT DEV
     * @description: 分页查询 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public Page<UumsSynchMapperMetaDataDTO> searchUumsSynchMapperMetaDataByPage(UumsSynchMapperMetaDataDTO uumsSynchMapperMetaDataDTO) ;
    
    /**
     * @author AVICIT DEV
     * @description:查询对象 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public List<UumsSynchMapperMetaDataDTO> searchUumsSynchMapperMetaData(UumsSynchMapperMetaDataDTO uumsSynchMapperMetaDataDTO);

    /**
     * @author AVICIT DEV
     * @description:查询对象 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsSynchMapperMetaDataDTO findUumsSynchMapperMetaDataById(String id);
    
    /**
     * @author AVICIT DEV
     * @description:查询对象 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化
     * @date 2014-12-26 11:13:20
     * @param type 主体类型：UUMS_ORG | UUMS_USER
     * @return
     */
    public List<UumsSynchMapperMetaDataDTO> searchUumsSynchMapperMetaDataByType(String type);
    
    /**
     * @author AVICIT DEV
     * @description: 新增对象 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化
     * @date 2014-12-26 11:13:20
     * @param paramMap
     * @return
     */
    public int insertUumsSynchMapperMetaData(UumsSynchMapperMetaDataDTO uumsSynchMapperMetaDataDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsSynchMapperMetaDataSensitive(UumsSynchMapperMetaDataDTO uumsSynchMapperMetaDataDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsSynchMapperMetaDataAll(UumsSynchMapperMetaDataDTO uumsSynchMapperMetaDataDTO);
    
    
    /**
     * @author AVICIT DEV
     * @description: 按主键删除 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化
     * @date 2014-12-26 11:13:20
     * @param ids
     * @return
     */ 
    public int deleteUumsSynchMapperMetaDataById(String id);
}
