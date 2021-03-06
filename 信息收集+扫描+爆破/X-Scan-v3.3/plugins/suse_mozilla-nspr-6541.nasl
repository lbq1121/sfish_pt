
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(42190);
 script_version ("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  Security update for Mozilla NSS (mozilla-nspr-6541)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch mozilla-nspr-6541");
 script_set_attribute(attribute: "description", value: "The Mozilla NSS security framework was updated to version
3.12.3.1.

CVE-2009-2404 / MFSA 2009-43 : Heap-based buffer overflow
in a regular-expression parser in Mozilla Network Security
Services (NSS) before 3.12.3, as used in Firefox,
Thunderbird, SeaMonkey, Evolution, Pidgin, and AOL Instant
Messenger (AIM), allows remote SSL servers to cause a
denial of service (application crash) or possibly execute
arbitrary code via a long domain name in the subject's
Common Name (CN) field of an X.509 certificate, related to
the cert_TestHostName function.

MFSA 2009-42 / CVE-2009-2408: IOActive security researcher
Dan Kaminsky reported a mismatch in the treatment of domain
names in SSL certificates between SSL clients and the
Certificate Authorities (CA) which issue server
certificates. In particular, if a malicious person
requested a certificate for a host name with an invalid
null character in it most CAs would issue the certificate
if the requester owned the domain specified after the null,
while most SSL clients (browsers) ignored that part of the
name and used the unvalidated part in front of the null.
This made it possible for attackers to obtain certificates
that would function for any site they wished to target.
These certificates could be used to intercept and
potentially alter encrypted communication between the
client and a server such as sensitive bank account
transactions. This vulnerability was independently reported
to us by researcher Moxie Marlinspike who also noted that
since Firefox relies on SSL to protect the integrity of
security updates this attack could be used to serve
malicious updates.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch mozilla-nspr-6541");
script_end_attributes();

script_cve_id("CVE-2009-2404", "CVE-2009-2408");
script_summary(english: "Check for the mozilla-nspr-6541 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"mozilla-nspr-4.8-1.4.2", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"mozilla-nspr-devel-4.8-1.4.2", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"mozilla-nss-3.12.3.1-1.4.2", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"mozilla-nss-devel-3.12.3.1-1.4.2", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
