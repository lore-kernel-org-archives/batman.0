Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Fri, 08 Nov 2013 00:25:32 +0100
Message-ID: <4645807.Ug7HQD34Gu@flohlap>
In-Reply-To: <201311041128.20618.sw@simonwunderlich.de>
References: <2578313.zUW7Pc5dQb@flohlap>
 <201311041128.20618.sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1509439.jf5Y1I195u";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Bad link quality if routers are connected by 2
	interfaces
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1509439.jf5Y1I195u
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Montag, 4. November 2013, 11:28:20 schrieben Sie:
> this is certainly not the expected behaviour. Are you building a brid=
ge loop
> by any chance? Please explain your configuration (batctl if, brctl sh=
ow,
> ...) and check if you have a high amount of broadcasts somehow.

Sorry for my late answer. I was busy during the week and didnt find the=
 time to=20
look into out setup in detail till now.

We have two wireless interfaces wlan0 and wlan0-1. We also have two eth=
ernet=20
interfaces eth0.1 and eth0.3 and one VPN interface ffolVPN.

The interfaces wlan0 and eth0.1 are the interfaces used for clients. Th=
ey are=20
bridged together with bat0:
root@RosenplatzVPN:~# brctl show
bridge name   bridge id                     STP enabled     interfaces
br-mesh          8000.a0f3c15b54a6   no                    bat0
                                                                       =
          eth0.1
                                                                       =
          wlan0

The interfaces wlan0-1 and eth0.3 are the interfaces we use for meshing=
 with=20
other routers in the same "mesh cloud". These are the interfaces both r=
outers=20
are connected by each other. The vpn interface ffolVPN is used to conne=
ct with=20
outher "mesh clouds" but the two routers in this case are not connected=
 by=20
this interface. On the interfaces wlan0-1, eth0.3 and ffolVPN runs Batm=
an=20
advanced:
root@RosenplatzVPN:~# batctl if
eth0.3: active
wlan0-1: active
ffolVPN: active

To analyze the amount of broadcast traffic I did a tcpdump on the Batma=
n=20
interfaces wlan0-1 and eth0.3. For me there seems to be a big amount of=
=20
broadcast traffic, but I don=B4t know the normal level of brodcasts so =
I can=B4t=20
compare which amount is right and which is wrong. But maybe you can so =
I=20
uploaded the files for you. You can analyze them using wireshark or som=
e other=20
tool:
* https://dev.freifunk-ol.de/tcpdumps/eth0.3.dump
* https://dev.freifunk-ol.de/tcpdumps/wlan0-1.dump

If you need more data just ask and I will try to provide it.

Kind regards
Clemens
--=20
#Clemens John <clemens-john@gmx.de>
#GnuPG:
Identifier: 0xD92F6BA5
Fingerprint: 1D6D 3EC6 C80F C1D4 CE1F 1133 6607 476C 0DB6 96A3
   Always encrypt your messages
--nextPart1509439.jf5Y1I195u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlJ8IXEACgkQZgdHbA22lqPigwCdFqDHjQZattOPprOHDeLpy2eT
3CkAn3Mqd9jU3FFmaw9/kK0Ox/wtNk+2
=LcZz
-----END PGP SIGNATURE-----

--nextPart1509439.jf5Y1I195u--

