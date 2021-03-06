
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(42236);
 script_version ("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  Security update for libapr (libapr-util1-6546)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch libapr-util1-6546");
 script_set_attribute(attribute: "description", value: "This update of libapr-util1 and libapr1 fixes multiple
integer overflows that could probably be used to execute
arbitrary code remotely. (CVE-2009-2412)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch libapr-util1-6546");
script_end_attributes();

script_cve_id("CVE-2009-2412");
script_summary(english: "Check for the libapr-util1-6546 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"libapr-util1-1.2.2-13.10.1", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libapr-util1-devel-1.2.2-13.10.1", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libapr1-1.2.2-13.8.2", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libapr1-devel-1.2.2-13.8.2", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
