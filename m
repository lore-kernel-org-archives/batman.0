Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 10 Nov 2015 17:46:59 +0100
Message-ID: <1712822.pO4f8xYhfX@prime>
In-Reply-To: <F52F175DFC537F48A43937B50B44BCA2820C1D1B@EXCHANGE.mediaspot.local>
References: <F52F175DFC537F48A43937B50B44BCA2820C1278@EXCHANGE.mediaspot.local>
 <1899407.TVXecW4so9@prime>
 <F52F175DFC537F48A43937B50B44BCA2820C1D1B@EXCHANGE.mediaspot.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5677407.g1uH1MZ53O";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] bridge detaching crash
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Alessandro Bolletta <alessandro@mediaspot.net>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart5677407.g1uH1MZ53O
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Alessandro,

one question unanswered is which interfaces are used for batman-adv in =
your=20
setup. In your kernel log we see eth0.90 and eth0.20.

Also was puzzling me is the message "tried to remove device eth0 from b=
at0.2".=20
This is coming from __netdev_adjacent_dev_remove(), but I don't see how=
 eth0=20
would be adjacent to bat0.2 ...

Can you please post batctl if and brctl show while your setup is runnin=
g?

How repeatable is this problem? Is one node sufficient to reproduce?

Thanks,
    Simon

On Monday 09 November 2015 22:21:51 Alessandro Bolletta wrote:
> Hi Simon,
>=20
> - batman-adv 2015.1.0 with patches from OpenWRT feeds
> - the unique bridge present on this machine is between eth0.6 and bat=
0.2
> - /etc/init.d/network restart
> - OS: OpenWRT 15.05 stable downloaded from git repo with lastest patc=
hes
> ________________________________________
> Da: Simon Wunderlich [sw@simonwunderlich.de]
> Inviato: luned=EC 9 novembre 2015 16.31
> A: b.a.t.m.a.n@lists.open-mesh.org
> Cc: Alessandro Bolletta
> Oggetto: Re: [B.A.T.M.A.N.] bridge detaching crash
>=20
> Hi,
>=20
> On Sunday 08 November 2015 23:45:14 Alessandro Bolletta wrote:
> > Hi,
> > in my Openwrt x86 testbed, I created a bridge between a vlan over e=
th0 and
> > a vlan over bat0. It works as expected but, when I try to restart
> > network, bridge seems to be not correctly detached and networking s=
tack
> > gets hanged.
> >=20
> >=20
> >=20
> > Can you help me to debug this crash?
>=20
> Could you please post:
>=20
>  * batman-adv version
>  * your network setup (batctl if, brctl show, etc)
>  * commands you use to restart network (OpenWRT or something else?)
>=20
> Thanks,
>     Simon

--nextPart5677407.g1uH1MZ53O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlZCH4MACgkQrzg/fFk7axa0XACgkyFAVhriE/VMewU3g0RxcljE
qO8An20QiF+OxB1acuw7U26q51QO+zyi
=M80+
-----END PGP SIGNATURE-----

--nextPart5677407.g1uH1MZ53O--

