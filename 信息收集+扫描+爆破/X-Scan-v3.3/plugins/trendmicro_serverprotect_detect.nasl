#
# (C) Tenable Network Security
#
# 


include("compat.inc");

if (description)
{
 script_id(24679);
 script_version("$Revision: 1.7 $");

 name["english"] = "Trend Micro ServerProtect Detection";
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is running an antivirus." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Trend Micro ServerProtect for Windows /
NetWare, an AntiVirus / AntiSpyware for Windows and NetWare servers." );
 script_set_attribute(attribute:"solution", value:"N/A");
 script_set_attribute(attribute:"risk_factor", value:"None" );
script_end_attributes();

 
 summary["english"] = "Checks for ServerProtect version";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 script_family(english:"Service detection");

 script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

 script_require_ports(5168);
 exit(0);
}


include ('smb_func.inc');

 
port = 5168;
if ( ! get_port_state(port) )
  exit(0);

soc = open_sock_tcp (port);
if (!soc)
  exit (0);

ret = dce_rpc_bind(cid:session_get_cid(), uuid:"25288888-bd5b-11d1-9d53-0080c83a5c2c", vers:1);
send (socket:soc, data:ret);
resp = recv (socket:soc, length:4096);

if (!resp)
{
 close (soc);
 exit (0); 
}

ret = dce_rpc_parse_bind_ack (data:resp);
if (isnull (ret) || (ret != 0))
{
 close (soc);
 exit (0);
}

data = 
	raw_dword(d:0x000A0006)  +
	raw_dword(d:0) +
	raw_dword(d:0) +
	raw_dword(d:0x300);


ret = dce_rpc_request (code:0x00, data:data);
send (socket:soc, data:ret);
resp = recv (socket:soc, length:4096);

resp = dce_rpc_parse_response (data:resp);
if (strlen(resp) != 0x308)
  exit (0);

code = get_dword(blob:resp, pos:strlen(resp)-4);

# not valid ip -> exit
if (code != 0x6ab)
{
 pattern = get_string(blob:resp, pos:8, _type:0);
 version = get_string(blob:resp, pos:28, _type:0);
 engine = get_string(blob:resp, pos:56, _type:0);
 path = get_string(blob:resp, pos:76, _type:0);

 set_kb_item(name:"Antivirus/TrendMicro/ServerProtect", value:version);

 ret = string (
	"Pattern : ", pattern, "\n",
	"Version : ", version, "\n",
	"Engine  : ", engine, "\n",
	"Path    : ", path, "\n"
	);

 report = string(
	"\n",
	ret,"\n"
  	);

 security_note(port:port, extra:report);
}
else
 security_note(port);

