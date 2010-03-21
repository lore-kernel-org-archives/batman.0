Return-Path: <linus.luessing@web.de>
Date: Sun, 21 Mar 2010 21:52:36 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100321205236.GA6356@Linus-Debian>
References: <20100321202626.GA6101@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <20100321202626.GA6101@Linus-Debian>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batctl manpage adjustments
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


--ZJcv+A0YCCLh2VIg
Content-Type: multipart/mixed; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Second try, the new format for the vis settings now added.

Cheers, Linus

--5G06lTa6Jq83wMTw
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="batctl-manpage.patch"
Content-Transfer-Encoding: quoted-printable

batctl: adjust "-w" option, vis options and minor layout things

This patch adds documentation for the new way of enabling/disabling
and handling the vis server. It also adds documentation for the change
=66rom "-b" to "-w" in the according options. Furthermore, the sub-option
alignment has been altered in some places.

Signed-Off-by: Linus L=C3=BCssing <linus.luessing@web.de>
Index: batctl.8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
@@ -73,42 +72,38 @@
 .IP "\fBloglevel\fP|\fBll\fP    [\fIlevel\fP]"
 If no parameter is given the current log level settings are displayed
 otherwise the parameter is used to set the log level. Level 0 disables
-all logging. Level 1 enables messages related to routing / flooding /
-broadcasting. Level 2 enables messages related to route or hna added /
-changed / deleted. Level 3 enables all messages. The messages are sent
-to the kernel log. Use \fBdmesg\fP(1) to see them.
+all verbose logging. Level 1 enables messages related to routing / floodin=
g / broadcasting.
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
-.IP "\fBvis dot\fP         [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-=
no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
-Display the visualisation data in graphviz \fBdot\fP(1) format. If
-"\-\-numbers" or "\-n" is given batctl will not replace the MAC
-addresses with bat-host names in the output. With "\-\-no-HNA" or
-"\-H" the HNA entries are not displayed, so the pure mesh topology can
-be seen. With "\-\-no-2nd" or "\-2" a dot cluster is not formed around
-primary and secondary addresses from the same device.
+.IP "\fBvis_server\fP|\fBvs\fP  [\fBenabled\fP|\fBdisabled\fP]"
+If no parameter is given the current vis server setting is displayed.
+Otherwise the parameter is used to enable or disable the vis server.
 .br
-.IP "\fBvis json\fP        [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-H\fP|\fB\-\-=
no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
-Display the visualisation data in JSON format. If "\-\-numbers" or
+.IP "\fBvis_data\fP|\fBvd\fP    \fBdot|\fBjson [\fB\-n\fP|\fB\-\-numbers\f=
P][\fB\-H\fP|\fB\-\-no-HNA\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
+Display the visualisation data in \fBdot\fP(1) or JSON format. If "\-\-num=
bers" or=20
 "\-n" is given batctl will not replace the MAC addresses with bat-host
 names in the output. With "\-\-no-HNA" or "\-H" the HNA entries are
 not displayed, so the pure mesh topology can be seen. With
@@ -129,14 +124,14 @@
 you can set the default interval between pings and the timeout time
 for replies, both in seconds.
 .br
-.IP "\fBtraceroute\fP|\fBtr\fP  [\fB\-n\fP] \fIMAC_address\fP|\fIbat\-host=
_name\fP"
+.IP "\fBtraceroute\fP|\fBtr\fP  [\fB\-n\fP] \fIMAC_address\fP|\fBbat\-host=
_name\fP"
 Layer 2 traceroute to a MAC address or bat\-host name. batctl will try
 to find the bat\-host name if the given parameter was not a MAC
 address. batctl will send 3 packets to each host and display the
 response time. If "\-n" is given batctl will not replace the MAC
 addresses with bat\-host names in the output.
 .br
-.IP "\fBtcpdump\fP|\fBtd\fP     [\fB\-p \fP\fIfilter\fP][\fB\-n\fP] \fIint=
erface ...\fP"
+.IP "\fBtcpdump\fP|\fBtd\fP     [\fB\-p \fP\fIfilter\fP][\fB\-n\fP] \fBint=
erface ...\fP"
 batctl will display all packets that are seen on the given
 interface(s). The "\-p" options allows the filtering of certain packet
 types: 1 - batman ogm packets, 2 - batman icmp packets, 4 - unicast
@@ -146,7 +141,7 @@
 packets only. If "\-n" is given batctl will not replace the MAC
 addresses with bat\-host names in the output.
 .br
-.IP "\fBbisect\fP               [\fB\-l \fP\fIMAC\fP][\fB\-t \fP\fIMAC\fP]=
[\fB\-r \fP\fIMAC\fP][\fB\-s \fP\fImin\fP [\fB\- \fP\fImax\fP]][\fB\-o \fP\=
fIMAC\fP][\fB\-n\fP] \fIlogfile1\fP [\fIlogfile2\fP ... \fIlogfileN\fP]"
+.IP "\fBbisect\fP         [\fB\-l \fP\fIMAC\fP][\fB\-t \fP\fIMAC\fP][\fB\-=
r \fP\fIMAC\fP][\fB\-s \fP\fImin\fP [\fB\- \fP\fImax\fP]][\fB\-o \fP\fIMAC\=
fP][\fB\-n\fP] \fIlogfile1\fP [\fIlogfile2\fP ... \fIlogfileN\fP]"
 Analyses the logfiles to build a small internal database of all sent
 sequence numbers and routing table changes. This database can then be
 analyzed in a number of different ways. With "\-l" the database can be

--5G06lTa6Jq83wMTw--

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLpocUAAoJEBKw7u43QNpf0FQP/2/KdJwa8SV/zuS9tXCl5jcU
7yLag+wM+S8JCKov43dik/YTlfQwPZKCcq1o64Q8TMJZjhrWOd4wIo4SfbdkzozL
3WLyw2qB5slvkZMe4gu4iZJW7SM7u9OG6P9TIH7SQp4w6MbV4PXIDaxt4C4a3+pI
Tn15XoD/in1NLjO9YQHbmCOi3uzUhYb4lSiBnlWgSmyax6FQ5mfTt8cgVK6DpBBM
1yC2vYNv3kXvg4a8kyBgrJvQwdwJtHBYuSHZBJc+7m/SxzKafxH6DrFbluq7ZK42
NJ+mVagip/vat+5HGWguVdBe5iKSL0I905DY9YlAtGECrExInSaqBmL/v1tnvG8q
kl09d8CZSWPZtg3kWH1ljuO8HZs3vkanua9unByyLau9XxTgHHaVDI5bjtAoiWHn
VjnUkPUZNuxTIzuG8HyRFhGk9/MqlkswN3IV0N9/pbeDkMYX1Bo5kx9rZxEg++WO
J2Ct5MLOyXM0vuwDsIpCJ0j4Ry9+kpCPCykw3bkKT0qYymiTE8Y5OMZVb3/8AwQp
b3Et7Ir120juI35pEdeLCdQaF8d9gD9Q5JEnn/qCgCH1w61jGmpOw7+J714/lAYG
jDhxWrWxBXP7TV+jccw18LNUyrmTgiJU6I3XUUgEUi9TWpK8+ei1bRnyswAyQIDR
nFCq0cGH7HBLMIQXryYc
=NexF
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
