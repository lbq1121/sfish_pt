#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(24244);
 script_version ("$Revision: 1.7 $");
 name["english"] = "Microsoft .NET Custom Errors Not Set";
 script_name(english:name["english"]);

 script_set_attribute(attribute:"synopsis", value:
"The remote ASP.NET web server does not have custom errors set" );
 script_set_attribute(attribute:"description", value:
"The remote ASP.NET web server is configured to show verbose
error messages, which might lead into the disclosure of potential
sensitive information about the remote installation (such as the
path under which the remote web server resides) or about the
remote ASP.NET applications." );
 script_set_attribute(attribute:"solution", value:
"Configure your server such as the option 'customErrors mode' is set
to 'On' instead of 'Off'" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:N/A:N" );
script_end_attributes();


 summary["english"] = "Checks for the error message of the .NET framework";

 script_summary(english:summary["english"]);

 script_category(ACT_GATHER_INFO);


 script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");
 family["english"] = "Web Servers";
 script_family(english:family["english"]);
 script_dependencie("http_version.nasl");
 script_require_ports("Services/www", 80);
 exit(0);
}

#
# The script code starts here
#
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


list = make_list(".ashx", ".aspx", ".asmx");
port = get_http_port(default:80, embedded: 0);


foreach ext (list) 
{
 u = "/" + rand_str(length:8) + ext;
 r = http_send_recv3(method: "GET", item: u, port:port);
 if ( "[FileNotFoundException]:" >< r[2] || "[HttpException]:" >< r[2] )
	{
	 start = strstr(r[2], "[FileNotFoundException]");
 	 if ( ! start ) start = strstr(r[2], "[HttpException]");
	 end   = strstr(start, "-->");
 	 msg = str_replace(find:"&quot;", replace:"'", string:start - end);
	 security_warning(port:port,
		extra: 'The following error message could be obtained :\n\n' + msg);
	 exit(0);
	}
}

