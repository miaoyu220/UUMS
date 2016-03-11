package avicit.uums.synch.log.userlog.uumslogsynchuser.dao;

import java.util.List;
import java.util.Map;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.uums.synch.log.userlog.uumslogsynchuser.dto.UumsLogSynchUserDTO;
/**
 * @classname: UumsLogSynchUserDao
 * @description: 定义  用户同步日志表 持久层 接口
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * @author:  AVICIT DEV
 */
@MyBatisRepository
public interface UumsLogSynchUserDao {
    
    /**
     * @author AVICIT DEV
     * @description: 分页查询 用户同步日志表
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public Page<UumsLogSynchUserDTO> searchUumsLogSynchUserByPage(UumsLogSynchUserDTO uumsLogSynchUserDTO) ;
    
    /**
     * @author AVICIT DEV
     * @description:查询对象 用户同步日志表
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public List<UumsLogSynchUserDTO> searchUumsLogSynchUser(UumsLogSynchUserDTO uumsLogSynchUserDTO);

    /**
     * @author AVICIT DEV
     * @description:查询对象 用户同步日志表
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsLogSynchUserDTO findUumsLogSynchUserById(String id);
    
    /**
     * @author AVICIT DEV
     * @description: 新增对象 用户同步日志表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     * @return
     */
    public int insertUumsLogSynchUser(UumsLogSynchUserDTO uumsLogSynchUserDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 用户同步日志表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsLogSynchUserSensitive(UumsLogSynchUserDTO uumsLogSynchUserDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 用户同步日志表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsLogSynchUserAll(UumsLogSynchUserDTO uumsLogSynchUserDTO);
    
    
    /**
     * @author AVICIT DEV
     * @description: 按主键删除 用户同步日志表
     * @date 2014-12-26 11:13:20
     * @param ids
     * @return
     */ 
    public int deleteUumsLogSynchUserById(String id);
}
