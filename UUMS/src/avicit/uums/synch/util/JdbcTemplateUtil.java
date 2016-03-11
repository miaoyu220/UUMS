package avicit.uums.synch.util;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.util.Assert;

public class JdbcTemplateUtil {
	public static JdbcTemplate getJdbcTemplate(String className, String connUrl,
			String username, String password) throws Exception {
		Assert.notNull(className);
		Assert.notNull(password);
		Assert.notNull(username);
		Assert.notNull(connUrl);
		try {
			DriverManagerDataSource ds = new DriverManagerDataSource();
			ds.setDriverClassName(className);
			ds.setUrl(connUrl);
			ds.setUsername(username);
			ds.setPassword(password);

			JdbcTemplate jdbcTemplate = new JdbcTemplate();
			jdbcTemplate.setDataSource(ds);

			return jdbcTemplate;
		} catch (Exception e) {
			throw new Exception("获取JdbcTemplate数据源错误：", e);
		}
	}
}
