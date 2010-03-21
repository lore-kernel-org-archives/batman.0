Return-Path: <linus.luessing@web.de>
Date: Sun, 21 Mar 2010 21:26:33 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100321202626.GA6101@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] batctl manpage adjustments
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--wULyF7TL5taEdwHz
Content-Type: multipart/mixed; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

So here are the few modifications made to the batctl manpage.

Cheers, Linus :)

--QRj9sO5tAVLaXnSD
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="batctl-manpage.patch"

batctl: Adjust layout of and add -w option to manpage

Index: man/batctl.8
===================================================================
--- man/batctl.8	(revision 1602)
+++ man/batctl.8	(working copy)
@@ -58,10 +58,9 @@
 otherwise the parameter(s) are added as new interfaces. Use the "none"
 keyword to deactivate all interfaces.
 .br
-.IP "\fBoriginators\fP|\fBo\fP   [\fB\-b\fP][\fB\-n\fP]"
-Display the originator table. Once started batctl will refresh the
-displayed originator table every second. The "\-b" option causes the
-table to be displayed only once (useful for scripts). If "\-n" is
+.IP "\fBoriginators\fP|\fBo\fP  [\fB\-w\fP][\fB\-n\fP]"
+Once started batctl will display the originator table. Use the "\-w"
+option to let batctl refresh the list every second. If "\-n" is
 given batctl will not replace the MAC addresses with bat\-host names
 in the output.
 .br
@@ -73,33 +72,33 @@
 .IP "\fBloglevel\fP|\fBll\fP    [\fIlevel\fP]"
 If no parameter is given the current log level settings are displayed
 otherwise the parameter is used to set the log level. Level 0 disables
-all logging. Level 1 enables messages related to routing / flooding /
-broadcasting. Level 2 enables messages related to route or hna added /
-changed / deleted. Level 3 enables all messages. The messages are sent
-to the kernel log. Use \fBdmesg\fP(1) to see them.
+all verbose logging. Level 1 enables messages related to routing / flooding / broadcasting.
+Level 2 enables messages related to route or hna added / changed / deleted.
+Level 3 enables all messages. The messages are sent to the kernel log.
+Use \fBdmesg\fP(1) to see them. Make sure to have debugging output
+enabled when compiling the module otherwise the verbose logging output as
+well as the loglevel options won't be available.
 .br
-.IP "\fBlog\fP|\fBl\fP           [\fIlogfile\fP][\fB\-b\fP][\fB\-n\fP]\fP"
+.IP "\fBlog\fP|\fBl\fP          [\fIlogfile\fP][\fB\-w\fP][\fB\-n\fP]\fP"
 batctl will read the file logfile, or stdin if the logfile parameter
 is not given, applying filtering so only the B.A.T.M.A.N. Advanced
-messages are displayed. Whenever there are new log messages appended
-to the file batctl will display them. The option "\-b" causes batctl
-to exit once the end of the file has been reached. If "\-n" is given
-batctl will not replace the MAC addresses with bat\-host names in the
-output.
+messages are displayed. Once the end of the file has been reached batctl
+will exit unless the option "\-w" was specified which causes batctl to
+continue reading the file and print log output whenever new log data has
+been appended to the file. If "\-n" is given batctl will not replace the
+MAC addresses with bat\-host names in the output.
 .br
-.IP "\fBtranslocal\fP|\fBtl\fP   [\fB\-b\fP][\fB\-n\fP]"
-Display the local translation table. batctl will refresh the
-displayed table every second. The "\-b" option causes the table to be
-displayed only once (useful for scripts). If "\-n" is given batctl
-will not replace the MAC addresses with bat\-host names in the output.
+.IP "\fBtranslocal\fP|\fBtl\fP  [\fB\-w\fP][\fB\-n\fP]"
+Display the local translation table. Use the "\-w" option to let batctl
+refresh the list every second. If "\-n" is given batctl will not replace
+the MAC addresses with bat\-host names in the output.
 .br
-.IP "\fBtransglobal\fP|\fBtg\fP  [\fB\-b\fP][\fB\-n\fP]"
-Display the global translation table. batctl will refresh the
-displayed table every second. The "\-b" option causes the table to be
-displayed only once (useful for scripts). If "\-n" is given batctl
-will not replace the MAC addresses with bat\-host names in the output.
+.IP "\fBtransglobal\fP|\fBtg\fP [\fB\-w\fP][\fB\-n\fP]"
+Display the global translation table. Use the "\-w" option to let batctl
+refresh the list every second. If "\-n" is given batctl will not replace
+the MAC addresses with bat\-host names in the output.
 .br
-.IP "\fBvis dot\fP         [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+.IP "\fBvis dot\fP        [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
 Display the visualisation data in graphviz \fBdot\fP(1) format. If
 "\-\-numbers" or "\-n" is given batctl will not replace the MAC
 addresses with bat-host names in the output. With "\-\-no-HNA" or
@@ -107,7 +106,7 @@
 be seen. With "\-\-no-2nd" or "\-2" a dot cluster is not formed around
 primary and secondary addresses from the same device.
 .br
-.IP "\fBvis json\fP        [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+.IP "\fBvis json\fP       [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
 Display the visualisation data in JSON format. If "\-\-numbers" or
 "\-n" is given batctl will not replace the MAC addresses with bat-host
 names in the output. With "\-\-no-HNA" or "\-H" the HNA entries are
@@ -129,14 +128,14 @@
 you can set the default interval between pings and the timeout time
 for replies, both in seconds.
 .br
-.IP "\fBtraceroute\fP|\fBtr\fP  [\fB\-n\fP] \fIMAC_address\fP|\fIbat\-host_name\fP"
+.IP "\fBtraceroute\fP|\fBtr\fP  [\fB\-n\fP] \fIMAC_address\fP|\fBbat\-host_name\fP"
 Layer 2 traceroute to a MAC address or bat\-host name. batctl will try
 to find the bat\-host name if the given parameter was not a MAC
 address. batctl will send 3 packets to each host and display the
 response time. If "\-n" is given batctl will not replace the MAC
 addresses with bat\-host names in the output.
 .br
-.IP "\fBtcpdump\fP|\fBtd\fP     [\fB\-p \fP\fIfilter\fP][\fB\-n\fP] \fIinterface ...\fP"
+.IP "\fBtcpdump\fP|\fBtd\fP     [\fB\-p \fP\fIfilter\fP][\fB\-n\fP] \fBinterface ...\fP"
 batctl will display all packets that are seen on the given
 interface(s). The "\-p" options allows the filtering of certain packet
 types: 1 - batman ogm packets, 2 - batman icmp packets, 4 - unicast
@@ -146,7 +145,7 @@
 packets only. If "\-n" is given batctl will not replace the MAC
 addresses with bat\-host names in the output.
 .br
-.IP "\fBbisect\fP               [\fB\-l \fP\fIMAC\fP][\fB\-t \fP\fIMAC\fP][\fB\-r \fP\fIMAC\fP][\fB\-s \fP\fImin\fP [\fB\- \fP\fImax\fP]][\fB\-o \fP\fIMAC\fP][\fB\-n\fP] \fIlogfile1\fP [\fIlogfile2\fP ... \fIlogfileN\fP]"
+.IP "\fBbisect\fP         [\fB\-l \fP\fIMAC\fP][\fB\-t \fP\fIMAC\fP][\fB\-r \fP\fIMAC\fP][\fB\-s \fP\fImin\fP [\fB\- \fP\fImax\fP]][\fB\-o \fP\fIMAC\fP][\fB\-n\fP] \fIlogfile1\fP [\fIlogfile2\fP ... \fIlogfileN\fP]"
 Analyses the logfiles to build a small internal database of all sent
 sequence numbers and routing table changes. This database can then be
 analyzed in a number of different ways. With "\-l" the database can be

--QRj9sO5tAVLaXnSD--

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLpoD5AAoJEBKw7u43QNpfgZMP/0Lw2FnuOXrDuGVlgp/SI32k
wEBcp233KNJVZXWS9C3DguFIAUozapNjaF+kz9lp8B3iGrueq9pXkLxcydy81csn
azRHYQAiXf5gYGsbCUMjFHhUOghYK809JTk7bAIBtGsSASCTIKl9UZSBBSaUNsCD
kz16XBxSptKCLSH0d6tX4D7MGk0dEkNLZfkBSdeykj7JSLu6UqHezVGAEmXXC5VF
4KAi9SkZ33Omy7Ac0u5UtCsS9OCt5CjbIhPlJ+AvheVh92RFp0xXEOb+EyectXNy
gZtJDd+wwJQg+1B2OTHxYXEZb9crio/AfcCCzxqsMH7NALN21BSkFUgJPT60hNiB
j/tQajb6weOt6IfEXOXx2MlDewlPmeAy43x0kER19DUtdc+/awCk4dv9MPWaAeuu
hJARvHi33NeDb399HOWaVPczII6rJYd6o60gjnnp3VURwKCRpK3982kloCozR0ge
t+T5Y2pXDfXHQ2N+qzzZF6i4oTbR/7DlzFrMqknU7MA53L8bUqk73q+6kqkKVm6D
oEKDtGqa0X4VGdSpe7usfD9hHBPw91D9uAUFrmC96C4JD6iE6XhmkrzONKkgxbHR
/YePB0To0/wKGTfNA/NpjSlqdJSC1HqITyqvqC3IQFCBYhviUVrGbzzQDNebtQvf
vp/2Nwcd9PpJWcI85tRV
=8PZj
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
