#
# (C) Tenable Network Security, Inc.
#
# 


include("compat.inc");

if (description) {
  script_id(20729);
  script_version("$Revision: 1.10 $");

  script_cve_id("CVE-2005-4459");
  script_bugtraq_id(15998);
  script_xref(name:"OSVDB", value:"22006");
  name["english"] = "VMware Remote Arbitrary Code Execution Vulnerability";
  script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"It is possible to execute code on the remote system." );
 script_set_attribute(attribute:"description", value:
"According to its version number, the VMware program on the remote host
may allow an attacker to execute code on the system hosting the VMware
instance. 

The vulnerability can be exploited by sending specially crafted FTP
PORT and EPRT requests. 

To be exploitable, the VMware system must be configured to use NAT
networking." );
 script_set_attribute(attribute:"see_also", value:"http://www.vmware.com/support/kb/enduser/std_adp.php?p_faqid=2000" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to :

- VMware Workstation 5.5.1 or higher
- VMware Workstation 4.5.2 or higher
- VMware Player 1.0.1 or higher
- VMware GSX Server 3.2.1 or higher" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );

script_end_attributes();

 
  summary["english"] = "Checks for VMware version";
  script_summary(english:summary["english"]);
 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("smb_hotfixes.nasl");
  script_require_keys("SMB/Registry/Enumerated");
  script_require_ports(139, 445);

  exit(0);
}


include("smb_func.inc");
if (!get_kb_item("SMB/Registry/Enumerated")) exit(0);

port = get_kb_item("SMB/transport");

# VMware Workstation

key1 = "SMB/Registry/HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/Uninstall/{98D1A713-438C-4A23-8AB6-41B37C4A2D47}/DisplayName";
key2 = "SMB/Registry/HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/Uninstall/{98D1A713-438C-4A23-8AB6-41B37C4A2D47}/DisplayVersion";

name = get_kb_item (key1);
version = get_kb_item (key2);

if (!isnull (name) && (name == "VMware Workstation") )
{
 version = split (version, sep:".", keep:FALSE);

 version[0] = int(version[0]);
 version[1] = int(version[1]);
 version[2] = int(version[2]);

 if ( (version[0] < 4) ||
      ( (version[0] == 4) && (version[1] < 5) ) ||
      ( (version[0] == 4) && (version[1] == 5) && (version[2] < 3) ) ||
      ( (version[0] == 5) && (version[1] < 5) ) ||
      ( (version[0] == 5) && (version[1] == 5) && (version[2] < 1) ) )
 {
  security_hole(port);
  exit (0);
 }
}


# VMware GSX Server

key1 = "SMB/Registry/HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/Uninstall/{5B9605EF-01FA-4429-8174-5A1039B0A7A5}/DisplayName";
key2 = "SMB/Registry/HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/Uninstall/{5B9605EF-01FA-4429-8174-5A1039B0A7A5}/DisplayVersion";

name = get_kb_item (key1);
version = get_kb_item (key2);

if (!isnull (name) && (name >< "VMware GSX Server") )
{
 version = split (version, sep:".", keep:FALSE);

 version[0] = int(version[0]);
 version[1] = int(version[1]);
 version[2] = int(version[2]);

 if ( (version[0] < 3) ||
      ( (version[0] == 3) && (version[1] < 2) ) ||
      ( (version[0] == 3) && (version[1] == 2) && (version[2] < 1) ) )
 {
  security_hole(port);
  exit (0);
 }
}


# VMware Player

key1 = "SMB/Registry/HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/Uninstall/{31799B14-B3E7-4522-B393-6206C03EC5D3}/DisplayName";
key2 = "SMB/Registry/HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/Uninstall/{31799B14-B3E7-4522-B393-6206C03EC5D3}/DisplayVersion";

name = get_kb_item (key1);
version = get_kb_item (key2);

if (!isnull (name) && (name >< "VMware Player") )
{
 version = split (version, sep:".", keep:FALSE);

 version[0] = int(version[0]);
 version[1] = int(version[1]);
 version[2] = int(version[2]);

 if ( (version[0] < 1) ||
      ( (version[0] == 1) && (version[1] == 0) && (version[2] < 1) ) )
 {
  security_hole(kb_smb_transport());
  exit (0);
 }
}
