#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if(description)
{
 script_id(19429);
 script_version("$Revision: 1.5 $");

 script_name(english:"Zotob Worm Detection");
 script_summary(english:"Connects to port 8888 to detect Zotob Worm infection");
 
 script_set_attribute(
   attribute:"synopsis",
   value:"The remote host may have been compromised by a worm."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "A Microsoft Windows shell is running on port 8888. This may\n",
     "indicate an infection by the Zotob worm, although other worms may\n",
     "also create a shell on this port."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://securityresponse.symantec.com/avcenter/venc/data/w32.zotob.a.html"
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://www.microsoft.com/presspass/press/2005/aug05/08-16zotob.mspx"
 );
 script_set_attribute(
   attribute:"solution", 
   value:string(
     "Verify if the remote host has been compromised, and reinstall\n",
     "the system if necessary."
   )
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C"
 );
 script_end_attributes();
 
 script_category(ACT_GATHER_INFO); 
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

 script_family(english:"Backdoors");
 script_require_ports(8888);
 exit(0);
}

#
# The script code starts here
#

port = 8888;
if ( get_port_state(port) )
{
 soc = open_sock_tcp(port);
 if ( ! soc ) exit(0);
 buffer = recv(socket:soc, length:4096);
 if ( "Microsoft Windows" >< buffer &&
     "(C) Copyright 1985-" >< buffer &&
     egrep(pattern:"^[A-Za-z]:.*>", string:buffer) ) security_hole(port);
}
