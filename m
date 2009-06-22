Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 22:46:11 +0200
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<5161afcd0906221257m589d5ac3leea3bcd22dd20182@mail.gmail.com>
	<5635aa0d0906221331nad876c8x6fec3fde12332c41@mail.gmail.com>
In-Reply-To: <5635aa0d0906221331nad876c8x6fec3fde12332c41@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1683534.He0sQW0En8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906222246.11849.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] HTTP transfers greater than 1000 bytes fail
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1683534.He0sQW0En8
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 22 June 2009 22:31:57 Outback Dingo wrote:
> when you say dont go thru, what exactly are they not passing through, whi=
ch
> interface or meaning thru the DSL / internet link, we need to try to
> detmine also the bottleneck of the issue, so what interface is data not
> passing through, and icmp tests wount decipher much in regards to MTU....
> tcpdump however might tell us where the traffic is getting stopped at
I would guess that the data gets stopped at the bat0 interface. Lets say th=
at=20
the workstation sends a big sized ethernet frame (aka 1500 bytes) with ip=20
data. Then it comes to the workstation over the eth0 interface which accept=
s=20
frames till the size of 1500 bytes (everything happy until now). The bridge=
=20
now sends it to the bat0 interface.... and oh noes, this fails because the=
=20
bat0 only accepts ethernet frames of the size of 1476 bytes (see the mtu of=
=20
the ath0 - 24 bytes for bat-adv stuff). The bridge should now send informat=
ion=20
(icmp packet) back the path that it cannot send the ethernet frame through=
=20
this chokepoint[1]. This doesn't seem to happen here or isn't recognized by=
=20
the client.

Regards,
Sven

[1] ftp://ftp.rfc-editor.org/in-notes/rfc1191.txt

--nextPart1683534.He0sQW0En8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKP+2TAAoJEF2HCgfBJntGkZkP/iEAi37BJSe/9GJ3AzufCxIu
z7Kwr1x7uFdN75rSGBz1XrCkNu/qLA2yypEbTc5Q6bSP/xSnctAaev8vr5QXQLdL
tHzUoODdUzHUbHz8oiMyYS/xmE/Q0ofh/1XEFM5tDmcD7nhxVMpxO6yMG5O6gNdA
g+TjXkckAi30dyFpy+3P6DAAKj5BfnB0xmGfJrrwFBZWBLomcKTIf5tN1gfdr0Zp
XWJmmKnyHPVpD9vnYZMow35XsDebaQrR9JsqcQM/+Y5OWZPfEChlD9ic0kxC4GdG
AH7B5dkfo2N6Ti7Jj/JCrkrKUyUwVIugXX+iol+Aj06/+jqaVXTzrKFROP/IdYtV
sEsEhrNyNh73udVy99N2Y1QEMFs7TzxeQL1/fRI7MDPSv+rtPqpugcD4c/rakgrl
dm0Safvnd/JSNSRpu+F6dMBBDz8fE2lKvorCJOm86HzxrewqV3cjpux2Muhv0Td9
+Vo3+kjrTjkxH48iu+2I7pqdgp9lZy0m7uH6+w27F1FLAboAAn827bel59sDwVkK
jG7Arp7sdFBJdei7TvfVp/wYcmbZ+Ux9T+kddH/6Z7ah/SBOjQdYaiHhXFyh5ZvM
7JJ0r8mmrF1Kfa/AA0kTmHeiMImfV8tKevdGpHGiSmgQ9D/2vxvu4EErMYsLdnpc
ermQGHYxEdaN+639lhac
=Ft/5
-----END PGP SIGNATURE-----

--nextPart1683534.He0sQW0En8--
