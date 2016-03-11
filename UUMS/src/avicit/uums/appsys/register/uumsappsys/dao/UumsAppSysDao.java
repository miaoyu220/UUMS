package avicit.uums.appsys.register.uumsappsys.dao;

import java.util.List;
import java.util.Map;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
/**
 * @classname: UumsAppSysDao
 * @description: 定义  应用系统注册管理 持久层 接口
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * @author:  AVICIT DEV
 */
@MyBatisRepository
public interface UumsAppSysDao {
    
    /**
     * @author AVICIT DEV
     * @description: 分页查询 应用系统注册管理
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public Page<UumsAppSysDTO> searchUumsAppSysByPage(UumsAppSysDTO uumsAppSysDTO) ;
    
    /**
     * @author AVICIT DEV
     * @description:查询对象 应用系统注册管理
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public List<UumsAppSysDTO> searchUumsAppSys(UumsAppSysDTO uumsAppSysDTO);

    /**
     * @author AVICIT DEV
     * @description:查询对象 应用系统注册管理
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsAppSysDTO findUumsAppSysById(String id);
    
    /**
     * @author AVICIT DEV
     * @description:根据应用系统编码查询对象 应用系统注册管理
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsAppSysDTO findUumsAppSysByAppCode(String appCode);
    
    /**
     * @author AVICIT DEV
     * @description: 新增对象 应用系统注册管理
     * @date 2014-12-26 11:13:20
     * @param paramMap
     * @return
     */
    public int insertUumsAppSys(UumsAppSysDTO uumsAppSysDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 应用系统注册管理
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsAppSysSensitive(UumsAppSysDTO uumsAppSysDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 应用系统注册管理
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsAppSysAll(UumsAppSysDTO uumsAppSysDTO);
    
    
    /**
     * @author AVICIT DEV
     * @description: 按主键删除 应用系统注册管理
     * @date 2014-12-26 11:13:20
     * @param ids
     * @return
     */ 
    public int deleteUumsAppSysById(String id);
}
