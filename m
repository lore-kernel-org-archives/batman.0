Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Oct 2009 19:10:15 +0200
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
	<200910201717.12868.sven.eckelmann@gmx.de>
	<45f642440910200902l14132a61o484e5a674b8e4985@mail.gmail.com>
In-Reply-To: <45f642440910200902l14132a61o484e5a674b8e4985@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3640206.WyZ1rS6C5t";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910201910.16032.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart3640206.WyZ1rS6C5t
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=46rancesco wrote:
> Hi Sven,
>=20
> > There is nothing like batman-adv 3.2. Where did you got it from?
>=20
> Sorry, my fault, i meant 0.3.2 release.
There is no 0.3.2 release. batman-adv hasn't reached 0.2 yet. See=20
http://downloads.open-mesh.net/batman/releases/ for the current releases of=
=20
batman and batman-adv. The current version of batman-adv in development is=
=20
<0.2-beta (it is not known yet if there will be real a beta or if the next=
=20
release is simply 0.2). So the current snapshot of batman-adv would be=20
"B.A.T.M.A.N. advanced 0.2-beta r1453 (compatibility version 8)"

[...]
> It shows 4 of 5 nodes I have online at this very moment.
>=20
> Say i fire ping from the box missing:
>=20
> root@francesco-desktop:/home/francesco# ping 192.168.1.2
> PING 192.168.1.2 (192.168.1.2) 56(84) bytes of data.
> 64 bytes from 192.168.1.2: icmp_seq=3D1 ttl=3D64 time=3D3.16 ms
> 64 bytes from 192.168.1.2: icmp_seq=3D2 ttl=3D64 time=3D3.55 ms
> 64 bytes from 192.168.1.2: icmp_seq=3D3 ttl=3D64 time=3D8.01 ms
> ^C
> --- 192.168.1.2 ping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss, time 2011ms
> rtt min/avg/max/mdev =3D 3.167/4.911/8.012/2.198 ms
>=20
> Everything ok. But if I try to batctl ping a node that I can see with
> $batctl o:
>=20
> root@francesco-desktop:/home/francesco# batctl ping 00:0b:6b:2f:53:03
> PING 00:0b:6b:2f:53:03 (00:0b:6b:2f:53:03) 19(47) bytes of data
>=20
> >From 00:0b:6b:2f:53:03: Destination Host Unreachable (icmp_seq 6170)
> >From 00:0b:6b:2f:53:03: Destination Host Unreachable (icmp_seq 6170)
> >From 00:0b:6b:2f:53:03: Destination Host Unreachable (icmp_seq 6170)
If you say that normal ping over bat0 works I would guess that you are usin=
g a=20
wrong combination of batctl and kernel module. Please use bleeding edge svn=
=20
batctl only with bleeding edge svn batman-adv-kernelland module.

Best regards,
	Sven

--nextPart3640206.WyZ1rS6C5t
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJK3e73AAoJEF2HCgfBJntGBmYP/iSIaghs9lGZww3Jmzj6j6IY
KocAkXy0i0qtZjfOoNCpgiQmZSObiuphjCwUHHvKwVtp/MXiFmL0v58mvUvgJ7hh
VBVDw8wTSBCBg+d/fxRU8L3esT7BmOX5NIv8jaJvQAINRdSUonU7svdShJRVcLKm
cHyxLowjiSSU2gz9gzhbdOCS99/gSCnRwAlbACaTztVB5NDxCYYvJ3pwWNFCdwUd
LljsszuQ11AG+Ss9T+tox35QtzPrTVjvbLtTyV92nv1kY8RfcKaavlslyiF7HlV9
fQlQ4hW4dZnErajFgQStjMHXlYZRe5fJSnUsvN9EP1aAK4KBqWqDT2YTXIr22Tya
Tsx2Wf8O1wVspCS7ArjS4pLL/Pg8arZJmH8QVlNtXBu38qZoJO4eF/TJJ4wNDKlD
7Dz5tFNcPJdHwNp3WP11SgdMo9NPu8muBitwQD85IEBGjM3senRjudTzCLNUCGNc
epEmqPbIJLafM68wnICqXjXd3zZwRMihPUTHT+VJo5BYH+V8CD/nnXpnQUpn6HJq
zT+Q5tx/n8SPtA97rUJbq/Tue0V7UZdmACGb1aoLKSpKG2FdtAvPvEiAkeYgjwNa
465hpYNhaCR+re1cI7zsHM6KgP67bl4wGz8li4L26kZcaONWmmtsKenfWk2BUxsD
ntIotyPgnnmMeEsPCbc1
=Thhl
-----END PGP SIGNATURE-----

--nextPart3640206.WyZ1rS6C5t--
