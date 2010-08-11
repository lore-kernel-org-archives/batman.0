Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 11 Aug 2010 13:20:04 +0200
References: <mailman.1.1281002401.15834.b.a.t.m.a.n@lists.open-mesh.org>
	<4C627FCF.4090303@web.de>
In-Reply-To: <4C627FCF.4090303@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5414195.8imNG8xgXh";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008111320.14389.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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
Cc: Tim <Timbo2001@web.de>

--nextPart5414195.8imNG8xgXh
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 11 August 2010 12:47:43 Tim wrote:
[...]
> After restarting the network the console says: "segmentation fault" and
> freezes. When doing "reboot" instead the device also freezes and the
> power-led keeps flashing.
> I also tried only changing the config in /etc/config/wireless and
> restarted the device, with the same effect.
>=20
> In order to make sure the error isn't related to any errors while
> compiling the image, I compiled an Image without the batman-adv package.
> After that I was able to configure the router as usual without any freeze=
s.

Thanks for the steps to reproduce. That should help a little bit.

I don't have hardware here at the moment to test it. So cannot tell what th=
e=20
problem may be. Maybe another person has some free time to test it and chec=
k=20
for a possible problem (but I don't think that anyone active has a WRT54GL).

what you could try is to setup the stuff by yourself using
 http://open-mesh.net/wiki/batman-adv-quick-start-guide and test which comm=
and=20
may cause the problem (when it is batman-adv related).

> As I already mentioned I'm not very used to Linux, so I have not yet
> found a way to connect to the router with serial console without
> building an JTAG-Cable. Is that right?

No, JTAG and serial port are completely unrelated:
http://nuwiki.openwrt.org/oldwiki/OpenWrtDocs/Hardware/Linksys/WRT54GL#seri=
al.port

But yes, you must build something. But it is highly recommended to have som=
e=20
serial console on embedded devices anyway.

Best regards,
	Sven

--nextPart5414195.8imNG8xgXh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMYodlAAoJEF2HCgfBJntGr9sQANPcJ+FKB7NwqmakmXawUTuU
TnaZkGvSGV/CgbGVBdZuj+NRblShRLwIHrvWskk9DXv7zf5+oNA+MekV+3eZ/jSf
DRzxuyPD12/1x81roMERBmqSlxUF8LeE5aYFTWipd/Rw57WStmbWf0SBFPD0/Sut
ttyY3jwMQBL+7reuKxLmkLrQOnXcqtDwTZnGTmc0vw02ipBFat3xL1LUDixgNhdg
u8jd3kM3drptwV0xXsQrAUKRpswwyUCXUt5pqQMGP0ZOc74QjSFgrQ0WFZXZYjY8
ATCJGs17IGSdL5rOGHLJ3xEQPAInfvoE9oWklGqG5dUGvnl1QXsXnkVUlM5FyO6y
AbsnEnuP6eorrCrTp/Is6YjuPFOC4DSPfoeXtlEX+fieYIJ5eRI4hxetXPOy39pZ
41Tj7QnxtDBu3cYPr8ZWfoAFqd+qNwbwIdkaPa/Og80W4qXX916fJcokZtrWo05R
GKajZUnZis/FZPB9j+k7/Uw4NiGoj5+ikWcmwpnr3zGEuXPC0YPunG27k1gMvGpD
2uwibOBJC02sMTlKMfcLgJ4XFQ5cLW42kmU4nm0Nw5DLFIDXHaBK8WtdiZTxa046
1wb16HEeuRVv/FruEtsdhePYbVWgYZGfhO1HDv2/cU3RFLegk8u0R2TUWZr8vpsL
rV1XayhCWK57p7v9IyY7
=rRoP
-----END PGP SIGNATURE-----

--nextPart5414195.8imNG8xgXh--
