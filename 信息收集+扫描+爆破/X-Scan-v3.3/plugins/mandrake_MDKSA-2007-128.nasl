
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(25563);
 script_version ("$Revision: 1.6 $");
 script_name(english: "MDKSA-2007:128: libexif");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2007:128 (libexif).");
 script_set_attribute(attribute: "description", value: "Another integer overflow was found in the way libexif parses EXIF
image tags. An individual who opened a carefully-crafted EXIF image
file could cause the application linked against libexif to crash or
possibly execute arbitrary code.
Updated packages have been patched to prevent this issue.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2007:128");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

 script_cve_id("CVE-2006-4168");
script_summary(english: "Check for the version of the libexif package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"libexif12-0.6.13-2.2mdv2007.0", release:"MDK2007.0", yank:"mdv") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libexif12-devel-0.6.13-2.2mdv2007.0", release:"MDK2007.0", yank:"mdv") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libexif12-0.6.13-4.2mdv2007.1", release:"MDK2007.1", yank:"mdv") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libexif12-devel-0.6.13-4.2mdv2007.1", release:"MDK2007.1", yank:"mdv") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"libexif-", release:"MDK2007.0")
 || rpm_exists(rpm:"libexif-", release:"MDK2007.1") )
{
 set_kb_item(name:"CVE-2006-4168", value:TRUE);
}
exit(0, "Host is not affected");
