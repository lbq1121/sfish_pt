# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200411-38.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(15846);
 script_version("$Revision: 1.7 $");
 script_xref(name: "GLSA", value: "200411-38");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200411-38 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200411-38
(Sun and Blackdown Java: Applet privilege escalation)


    All Java plug-ins are subject to a vulnerability allowing unrestricted
    Java package access.
  
Impact

    A remote attacker could embed a malicious Java applet in a web page and
    entice a victim to view it. This applet can then bypass security
    restrictions and execute any command or access any file with the rights
    of the user running the web browser.
  
Workaround

    As a workaround you could disable Java applets on your web browser.
  
');
script_set_attribute(attribute:'solution', value: '
    All Sun JDK users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-java/sun-jdk-1.4.2.06"
    All Sun JRE users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-java/sun-jre-bin-1.4.2.06"
    All Blackdown JDK users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-java/blackdown-jdk-1.4.2.01"
    All Blackdown JRE users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-java/blackdown-jre-1.4.2.01"
    Note: You should unmerge all vulnerable versions to be fully protected.
  ');
script_set_attribute(attribute: 'risk_factor', value: 'Medium');
script_set_attribute(attribute: 'see_also', value: 'http://www.idefense.com/application/poi/display?id=158&type=vulnerabilities');
script_set_attribute(attribute: 'see_also', value: 'http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2004-1029');
script_set_attribute(attribute: 'see_also', value: 'http://www.blackdown.org/java-linux/java2-status/security/Blackdown-SA-2004-01.txt');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200411-38.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200411-38] Sun and Blackdown Java: Applet privilege escalation');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Sun and Blackdown Java: Applet privilege escalation');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-java/blackdown-jre", arch: "x86 amd64", unaffected: make_list("ge 1.4.2.01"), vulnerable: make_list("lt 1.4.2.01")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "dev-java/sun-jre-bin", arch: "x86 amd64", unaffected: make_list("ge 1.4.2.06"), vulnerable: make_list("lt 1.4.2.06")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "dev-java/sun-jdk", arch: "x86 amd64", unaffected: make_list("ge 1.4.2.06"), vulnerable: make_list("lt 1.4.2.06")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "dev-java/blackdown-jdk", arch: "x86 amd64", unaffected: make_list("ge 1.4.2.01"), vulnerable: make_list("lt 1.4.2.01")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
