# This script was automatically generated from the SSA-2009-086-02
# Slackware Security Advisory
# It is released under the Nessus Script Licence.
# Slackware Security Advisories are copyright 1999-2009 Slackware Linux, Inc.
# SSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.
# See http://www.slackware.com/about/ or http://www.slackware.com/security/
# Slackware(R) is a registered trademark of Slackware Linux, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(36038);
script_version("$Revision: 1.2 $");
script_category(ACT_GATHER_INFO);
script_family(english: "Slackware Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_copyright("This script is Copyright (C) 2009 Tenable Network Security, Inc.");
script_require_keys("Host/Slackware/release", "Host/Slackware/packages");

script_set_attribute(attribute:'synopsis', value:
'The remote host is missing the SSA-2009-086-02 security update');
script_set_attribute(attribute:'description', value: '
New glib2 packages are available for Slackware 12.0, 12.1, 12.2, and -current
to fix overflows that may be security issues.

More details about this issue may be found in the Common
Vulnerabilities and Exposures (CVE) database:

  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-4316


');
script_set_attribute(attribute:'solution', value: 
'Update the packages that are referenced in the security advisory.');
script_xref(name: "SSA", value: "2009-086-02");
script_summary("SSA-2009-086-02 glib2 ");
script_name(english: "SSA-2009-086-02 glib2 ");
script_cve_id("CVE-2008-4316");
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();
exit(0);
}

include('slackware.inc');
include('global_settings.inc');

if ( ! get_kb_item('Host/Slackware/packages') ) exit(1, 'Could not obtain the list of packages');

extrarep = NULL;
if (slackware_check(osver: "12.0", pkgname: "glib2", pkgver: "2.12.12", pkgnum:  "2", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package glib2 is vulnerable in Slackware 12.0
Upgrade to glib2-2.12.12-i486-2_slack12.0 or newer.
');
}
if (slackware_check(osver: "12.1", pkgname: "glib2", pkgver: "2.14.6", pkgnum:  "5", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package glib2 is vulnerable in Slackware 12.1
Upgrade to glib2-2.14.6-i486-5_slack12.1 or newer.
');
}
if (slackware_check(osver: "12.2", pkgname: "glib2", pkgver: "2.16.6", pkgnum:  "2", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package glib2 is vulnerable in Slackware 12.2
Upgrade to glib2-2.16.6-i486-2_slack12.2 or newer.
');
}
if (slackware_check(osver: "-current", pkgname: "glib2", pkgver: "2.18.4", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package glib2 is vulnerable in Slackware -current
Upgrade to glib2-2.18.4-i486-1 or newer.
');
}

if (w) { security_warning(port: 0, extra: extrarep); }

else exit(0, "Host is not affected");
