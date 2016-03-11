package avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.dao;

import java.util.List;
import java.util.Map;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.dto.UumsOrgSynchRecordDTO;
/**
 * @classname: UumsOrgSynchRecordDao
 * @description: 定义  组织信息同步记录表 持久层 接口
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * @author:  AVICIT DEV
 */
@MyBatisRepository
public interface UumsOrgSynchRecordDao {
    
    /**
     * @author AVICIT DEV
     * @description: 分页查询 组织信息同步记录表
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public Page<UumsOrgSynchRecordDTO> searchUumsOrgSynchRecordByPage(UumsOrgSynchRecordDTO uumsOrgSynchRecordDTO) ;
    
    /**
     * @author AVICIT DEV
     * @description:查询对象 组织信息同步记录表
     * @date 2014-12-26 11:13:20
     * @param searchParams
     * @return
     */
    public List<UumsOrgSynchRecordDTO> searchUumsOrgSynchRecord(UumsOrgSynchRecordDTO uumsOrgSynchRecordDTO);

    /**
     * @author AVICIT DEV
     * @description:查询对象 组织信息同步记录表
     * @date 2014-12-26 11:13:20
     * @param id
     * @return
     */
    public UumsOrgSynchRecordDTO findUumsOrgSynchRecordById(String id);
    
    /**
     * @author AVICIT DEV
     * @description: 新增对象 组织信息同步记录表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     * @return
     */
    public int insertUumsOrgSynchRecord(UumsOrgSynchRecordDTO uumsOrgSynchRecordDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 组织信息同步记录表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsOrgSynchRecordSensitive(UumsOrgSynchRecordDTO uumsOrgSynchRecordDTO);
    
    /**
     * @author AVICIT DEV
     * @description: 更新对象 组织信息同步记录表
     * @date 2014-12-26 11:13:20
     * @param paramMap
     */
    public int updateUumsOrgSynchRecordAll(UumsOrgSynchRecordDTO uumsOrgSynchRecordDTO);
    
    
    /**
     * @author AVICIT DEV
     * @description: 按主键删除 组织信息同步记录表
     * @date 2014-12-26 11:13:20
     * @param ids
     * @return
     */ 
    public int deleteUumsOrgSynchRecordById(String id);
}
