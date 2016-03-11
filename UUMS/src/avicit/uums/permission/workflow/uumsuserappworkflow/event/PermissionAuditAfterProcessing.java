package avicit.uums.permission.workflow.uumsuserappworkflow.event;

import org.springframework.beans.factory.annotation.Autowired;

import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;
import avicit.uums.permission.synch.uumsuserapppermissions.service.UumsUserAppPermissionsService;

/**
 * @description 应用系统权限审批流程结束节点的前置事件处理程序
 * @author miaoyu
 * @since 2016年1月4日
 *
 */
public class PermissionAuditAfterProcessing implements EventListener{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void notify(EventListenerExecution execution) throws Exception {
		UumsUserAppPermissionsService permissionService = SpringFactory.getBean(UumsUserAppPermissionsService.class);
		//业务表单Id,
		String formId = (String) execution.getVariable("id");
		if(formId != null){
			//更新用户权限审批结果和活动状态
			permissionService.saveAuditStatusAfterWorkflow(formId);
		}
	}

}
