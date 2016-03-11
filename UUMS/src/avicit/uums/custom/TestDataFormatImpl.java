package avicit.uums.custom;

import java.math.BigDecimal;
import java.util.Date;

public class TestDataFormatImpl {

	public Object sexFormat(Object obj) {
		if(obj == null){
			return null;
		}
		if(obj instanceof Date){
			
		}else if(obj instanceof BigDecimal){
			
		}else{
			obj = obj + "";
			if("1".equals(obj)){
				obj = "男";
			}else{
				obj = "女";
			}
		}
		return obj;
	}

	

}
