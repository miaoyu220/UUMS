package avicit.uums.synch.util;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;

import org.springframework.util.Assert;

/**
 * LDAP打开连接和关闭连接工具类
 * @author miaoyu
 * @since 2016-1-21
 *
 */
public class LdapUtil {

	/**
	 * 打开LDAP连接
	 * @param host 主机地址
	 * @param port 端口号
	 * @param admin 管理员DN
	 * @param password 密码
	 * @return
	 * @throws NamingException
	 */
	public static DirContext connect(String host, String port, String admin, String password) throws NamingException {
		try {
			Assert.notNull(host);
			Assert.notNull(port);
			Assert.notNull(admin);
			Assert.notNull(password);
			
			Hashtable<String, Object> env = new Hashtable<String, Object>(5);
			String url = "ldap://" + host + ":" + port;
			env.put(Context.INITIAL_CONTEXT_FACTORY,
					"com.sun.jndi.ldap.LdapCtxFactory");
			env.put(Context.PROVIDER_URL, url);
			env.put(Context.SECURITY_AUTHENTICATION, "simple");
			env.put(Context.SECURITY_PRINCIPAL, admin);
			env.put(Context.SECURITY_CREDENTIALS, password);

			DirContext ds = new InitialDirContext(env);

			return ds;
		} catch (NamingException e) {
			throw new NamingException("打开LDAP连接时错误：" + e.getMessage());
		}
	}
	
	/**
	 * 关闭LDAP连接
	 * @param ds LDAP上下文
	 * @throws NamingException
	 */
	public static void close(DirContext ds) throws NamingException{
		if (ds != null) {
			try {
				ds.close();
			} catch (NamingException e) {
				throw new NamingException("关闭LDAP连接时错误：" + e.getMessage());
			}
		}
	}
}
