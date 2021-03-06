
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(29963);
 script_version ("$Revision: 1.2 $");
 script_name(english: "SuSE Security Update:  xen hypervisor crash problems (xen-4901)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch xen-4901");
 script_set_attribute(attribute: "description", value: "This update fixes Xen security issues.

Two security problems were fixed: CVE-2007-5906: Xen
allowed virtual guest system users to cause a denial of
service (hypervisor crash) by using a debug register (DR7)
to set certain breakpoints.

CVE-2007-5907: Xen 3.1.1 does not prevent modification of
the CR4 TSC from applications, which allows pv guests to
cause a denial of service (crash).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:M/Au:N/C:N/I:N/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch xen-4901");
script_end_attributes();

script_cve_id("CVE-2007-5906", "CVE-2007-5907");
script_summary(english: "Check for the xen-4901 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"xen-3.0.3_11774-23", release:"SUSE10.2") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"xen-devel-3.0.3_11774-23", release:"SUSE10.2") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"xen-doc-html-3.0.3_11774-23", release:"SUSE10.2") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"xen-doc-pdf-3.0.3_11774-23", release:"SUSE10.2") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"xen-doc-ps-3.0.3_11774-23", release:"SUSE10.2") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"xen-libs-3.0.3_11774-23", release:"SUSE10.2") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"xen-tools-3.0.3_11774-23", release:"SUSE10.2") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"xen-tools-ioemu-3.0.3_11774-23", release:"SUSE10.2") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
