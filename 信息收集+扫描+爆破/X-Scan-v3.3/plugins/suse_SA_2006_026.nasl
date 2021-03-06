#
# (C) Tenable Network Security
#
# This plugin text was extracted from SuSE Security Advisory SUSE-SA:2006:026
#


if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(21622);
 script_version ("$Revision: 1.3 $");
 
 name["english"] = "SUSE-SA:2006:026: foomatic-filters";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing the patch for the advisory SUSE-SA:2006:026 (foomatic-filters).


A bug in cupsomatic/foomatic-filters that allowed remote printer
users to execute arbitrary commands with the UID of the printer
daemon has been fixed (CVE-2004-0801).

While the same problem was fixed in earlier products, the fix got
lost during package upgrade of foomatic-filters for SUSE Linux 9.3.

Only SUSE Linux 9.3, 10.0 and 10.1 still contained this bug." );
 script_set_attribute(attribute:"solution", value:
"http://www.suse.de/security/advisories/2006-05-30.html" );
 script_set_attribute(attribute:"risk_factor", value:"High" );



 script_end_attributes();

 
 summary["english"] = "Check for the version of the foomatic-filters package";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2006 Tenable Network Security");
 family["english"] = "SuSE Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");
if ( rpm_check( reference:"foomatic-filters-3.0.2-4.2", release:"SUSE10.0") )
{
 security_hole(0);
 exit(0);
}
if ( rpm_check( reference:"foomatic-filters-3.0.2-3.2", release:"SUSE9.3") )
{
 security_hole(0);
 exit(0);
}
