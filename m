Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 19 Jan 2010 16:11:27 +0100
References: <20100118112706.91160@gmx.net>
	<201001192007.38210.lindner_marek@yahoo.de>
	<20100119145151.294630@gmx.net>
In-Reply-To: <20100119145151.294630@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4128943.XGuJRCAdNv";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001191611.30799.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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
To: Juha =?iso-8859-1?q?Yl=F6nen?= <ylonen@gmx.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4128943.XGuJRCAdNv
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Juha Yl=F6nen wrote:
> I got the latest trunk up and running, some changes were required to get =
it
>  to crosscompile for ARM (and 2.6.24 kernel). Same behaviour as before,
>  device log shows a lot of activity, but laptop batman doesn't seem to be
>  doing much anything. I tried the wireshark and got a log ok (which shows=
 a
>  lot of multicast traffic from the device until I disabled the service) b=
ut
>  I'm at loss to decipher possible batman packages. What should they look
>  like in wireshark? I only noticed couple of IPX packages from device to
>  (broadcast?) but nothing else. I attached the log file, is anyone able to
>  say if there are batman packages included?

There is a dissector for wireshark at
 http://gitorious.org/wireshark-batman-plugins/wireshark-batman-adv=20
(compatible with 0.2, but haven't added new code to make it compatible with=
=20
new functionality in trunk). I will add support for protocol version 9 afte=
r=20
finishing some other non-paid work.

Your log is for version 9 of the protocol (trunk). So it is harder to read =
:)

As far as I can see only data from 00:22:fa:dc:9a:ce can be seen (send from=
 us=20
aka laptop?). Have you tested if the adhoc connection between this two devi=
ces=20
(arm <-> laptop) is really working (just set up the adhoc network as usual =
and=20
then give them an ip instead of adding to /proc/net/batman-adv/interfaces. =
A=20
simple ping test should be sufficient to say that it works(tm)).

Best regards,
	Sven

--nextPart4128943.XGuJRCAdNv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLVcugAAoJEF2HCgfBJntG9WQQAIi48cJFg7ZJgF+Gsoyxbary
im83AML+zTcOryZi1VikjvdUewoIfE8OxeCJREIw3X4MgUBEQTD1LMj5WdLTyAn2
iVrujUn7AXhuH/eSrG/J1pRQrKMrCQmCEazBGMOeDIsu8Axlsr9MURwQY3jIIAKK
F2pzw5w2FKB2wnqDKn/iJ8uEiENcM1ES1fm0hgRtA8YQr4y9EJyNkwyeltozP5an
96mn3LZIeZQRGTCB/Knlfd7Z8AJDCR5SIaLelOpu8/GoQK0/KA6MTBOC0wW+l6H7
thoA2Gx9Sk/Nq1lM+nOlnHv8LnzPp+Eita15umwnio6hkxB4nUvPaQZj0nNqZ/S5
TJbsflWnhQlnBoSjgGKyUf780vU1qiUxkiWJXNhO4ioRrGQw8MKk2cpgWmwUiMAb
hrl5UPmWcNS+SwvTeA2T9cYcXc0E6rgWUOQS0w/VLJ7oYSr4EJzauAsPa8zxtW8K
HNOkqDC16X7TuNJK3Hyxr8NTbL5uSuyIpF+ExTdidz1GT7aze8wWorq3IUg3EbI6
nA9okuUcvOxl4M+FdRmiZFOO1ofMqWT4dYw3nvXILrAFQ8C/eZS2bGyJ7UmCcGVE
OXSiE8OOCvJ8hW2nxgpM9/4+YdXlOESaBdAJE1O0oMuL6bJNarU11TocTzjAg16I
ZwqKfH0wBaCSoDmumrnO
=gtSx
-----END PGP SIGNATURE-----

--nextPart4128943.XGuJRCAdNv--
