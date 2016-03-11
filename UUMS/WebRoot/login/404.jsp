<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>页面不存在</title>
<style type="text/css">
*{margin:0px;}
html,body{height:100%;
background-color:#ffffff;}
.error_dw {
	background-image: url(login/style/image/500/error_dw.jpg);
	background-repeat: repeat-x;
}
.error_title {
	font-family: "黑体";
	font-size: 32px;
	text-decoration: none;
	line-height: 46px;
	color: #666666;
}
.error_txt {
	font-family: "宋体";
	font-size: 12px;
	text-decoration: none;
	line-height: 28px;
	color: #333333;
}

#error a:link {
	font-family: "宋体";
	font-size: 12px;
	color: #C70600;
	text-decoration: none;
	line-height: 18px;
}


#error a:hover {
	font-family: "宋体";
	font-size: 12px;
	color: #307EAF;
	text-decoration: underline;
	line-height: 18px;
}
#error a:visited {
	font-family: "宋体";
	font-size: 12px;
	color: #C70600;
	text-decoration: none;
	line-height: 18px;
}
</style>
<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="avicit/platform6/modules/system/sysdashboard/portal/lib/jquery-ui-1.10.4.custom.min.js"></script>

</head>
<body>
<script type="text/javascript">
function returnLogin(){
	top.location.href="<%=ViewUtil.getRequestPath(request)%>"+"index.jsp";
}
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="error_dw">
  <tr>
    <td><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150" align="left" valign="top"><img src="login/style/image/500/error_ico01.gif" width="127" height="133" /></td>
            <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><div align="center" class="error_title"></div></td>
                <td><div align="center"><span class="error_title">页面不存在</span></div></td>
              </tr>
              <tr>
                <td width="25"><div align="center"><img src="login/style/image/500/error_ico02.gif" width="18" height="15" vspace="3" /></div></td>
                <td align="left" valign="top" class="error_txt">对不起，您所访问的页面已经不存在！</td>
              </tr>
              <tr>
                <td><div align="center"><img src="login/style/image/500/error_ico03.gif" width="18" height="15" vspace="3" /></div></td>
                <td align="left" valign="top" class="error_txt"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="error_txt">
                  <tr>
                    <td width="80" align="left" valign="top">错误内容是：</td>
                    <td><a href="#" class="btn" onclick="returnLogin();">返回网站首页</a></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
     <!--  <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="left" valign="top"><table width="170" border="0" cellpadding="0" cellspacing="0" id="error">
              <tr>
                <td width="20" height="19"><img src="login/style/image/500/error_list01.gif" width="20" height="19" /></td>
                <td align="center" valign="bottom" bgcolor="#DEDFDE"><a href="javascript:showHideDetail();">查看详细错误信息</a></td>
                <td width="4" height="19"><img src="login/style/image/500/error_list02.gif" width="4" height="19" /></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td align="left" valign="top"><img src="login/style/image/500/error_line.gif" width="100%" height="4" /></td>
          </tr>
        </table></td>
      </tr> -->
      <%-- <tr>
        <td>
        	<textarea id="detailErrorInfo" style="width:100%; height:300px; display:none"><%=errorDetail %></textarea>
        </td>
      </tr> --%>
    </table></td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
