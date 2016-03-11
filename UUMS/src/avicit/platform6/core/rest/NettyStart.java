package avicit.platform6.core.rest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.util.Assert;

import avicit.platform6.commons.utils.NetUtil;
import avicit.platform6.core.rest.resteasy.NettyServer;

public class NettyStart {

	public static void main(String[] args) throws Exception {

		String port = "10001";
		String executorThreadCount = "2000";
		if(args!=null&&args.length>0){
			port = args[0];
		}
		if(args!=null&&args.length>0){
			executorThreadCount = args[1];
		}
		String config[] =new String[]{"spring-netty.xml"};
		ApplicationContext ac = new ClassPathXmlApplicationContext(config);
		Assert.notNull(ac);
		NettyServer netty = ac.getBean(NettyServer.class);
		netty.start("",Integer.valueOf(port),  Integer.valueOf(executorThreadCount));
		

	}
	
	
	
	
}
