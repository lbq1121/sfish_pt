#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(14732);
 script_version("$Revision: 1.19 $");

 script_cve_id("CVE-2004-0573");
 script_bugtraq_id(11172);
 script_xref(name:"IAVA", value:"2004-t-0029");
 script_xref(name:"OSVDB", value:"9950");

 name["english"] = "MS04-027: Vulnerability in WordPerfect Converter (884933)";
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"Arbitrary code can be executed on the remote host through Office." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of Microsoft Office that contains
a flaw in its WordPerfect converter, which might allow an attacker to
execute arbitrary code on the remote host. 

To exploit this flaw, an attacker would need to send a specially
crafted file to a user on the remote host and wait for him to open it
using Microsoft Office. 

When opening the malformed file, Microsoft Office will encounter a
buffer overflow that may be exploited to execute arbitrary code." );
 script_set_attribute(attribute:"solution", value:
"Microsoft has released a set of patches for Office 2000, XP and 2003 :

http://www.microsoft.com/technet/security/bulletin/ms04-027.mspx" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
 summary["english"] = "Determines the version of MSCONV97.dll";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 family["english"] = "Windows : Microsoft Bulletins";
 script_family(english:family["english"]);
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/name", "SMB/login", "SMB/password", "SMB/WindowsVersion", "SMB/registry_access");

 script_require_ports(139, 445);
 exit(0);
}


include("smb_func.inc");
include("smb_hotfixes.inc");
include("smb_hotfixes_fcheck.inc");

version = hotfix_check_office_version ();

if ( !version || ((version >!< "10.0") && (version >!< "9.0")) ) exit(0);


CommonFilesDir = hotfix_get_commonfilesdir();
if ( ! CommonFilesDir ) exit(1);


login	=  kb_smb_login();
pass  	=  kb_smb_password();
domain 	=  kb_smb_domain();
port    =  kb_smb_transport();


if(!get_port_state(port))exit(1);

soc = open_sock_tcp(port);
if(!soc)exit(1);


session_init(socket:soc, hostname:kb_smb_name());
share = ereg_replace(pattern:"^([A-Za-z]):.*", replace:"\1$", string:CommonFilesDir);
dll =  ereg_replace(pattern:"^[A-Za-z]:(.*)", replace:"\1\Microsoft Shared\TextConv\MSCONV97.dll", string:CommonFilesDir);

r = NetUseAdd(login:login, password:pass, domain:domain, share:share);
if ( r != 1 ) exit(1);

handle = CreateFile (file:dll, desired_access:GENERIC_READ, file_attributes:FILE_ATTRIBUTE_NORMAL, share_mode:FILE_SHARE_READ, create_disposition:OPEN_EXISTING);

if ( ! isnull(handle) )
{
 v = GetFileVersion(handle:handle);
 CloseFile(handle:handle);
 if ( isnull( v )) {
	NetUseDel();
	exit(1);
	}


 if ( v[0] < 2003 || ( v[0] == 2003 && ( v[1] < 1100 || (v[1] == 1100 && v[2] < 6252 )))) {
 set_kb_item(name:"SMB/Missing/MS04-027", value:TRUE);
 hotfix_security_hole();
 }
}
