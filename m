Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52E70836.3050502@wirelesspt.net>
Date: Mon, 27 Jan 2014 20:30:30 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net>	<86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net>	<52E08DFE.9030604@makrotopia.org>
 <52E5063E.3080408@makrotopia.org>	<52E51A04.8020800@meshcoding.com>
 <52E5322D.60202@wirelesspt.net>	<52E532D0.2000907@meshcoding.com>
 <52E5341F.30800@meshcoding.com>	<52E69D7D.80905@wirelesspt.net>
 <861tzsgaub.fsf@coulee.tdb.com>
In-Reply-To: <861tzsgaub.fsf@coulee.tdb.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WVVCf30s0VrEed1DgB6tAIJ5dfDf6FiwJ"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: Russell Senior <russell@personaltelco.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WVVCf30s0VrEed1DgB6tAIJ5dfDf6FiwJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

inline:

On 01/27/2014 08:21 PM, Russell Senior wrote:
>>>>>> "cmsv" =3D=3D cmsv  <cmsv@wirelesspt.net> writes:
>=20
> cmsv> Here is an update of some tests i ran in the past 24h with the
> cmsv> following build:
>=20
> cmsv> routers used: dlink dir 601a and tplink wr703n in "ng"
> cmsv> mode. (atheros)
>=20
> cmsv> My current AA DISTRIB_REVISION=3D"r39154" mac80211 r39150 from
> cmsv> openwrt trunk hostapd r39155 from trunk
>=20
> I just went to try to set up an AA build environment from:
>=20
>   git://git.openwrt.org/12.09/openwrt.git
>=20
> in order to replicate.  The default feeds.conf from that tree seems to
> point at a 'for-12.09.x' branch of the routing feed, and the
> batman-adv Makefile there seems to use 2013.4.0, not 2014.0.0. =20
>=20
> Can you paste your feeds.conf file?

Of course:


for AA and batman-adv 2014.0.0 in feeds.default.conf

src-svn packages svn://svn.openwrt.org/openwrt/branches/packages_12.09
src-git routing git://github.com/openwrt-routing/packages.git


For the hostapd and mentioned mac80211 you will need to clone
git clone git://git.openwrt.org/12.09/openwrt.git

Then obtain the specific revisions and replace  the original hostapd and
mac80211 from AA.









--WVVCf30s0VrEed1DgB6tAIJ5dfDf6FiwJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS5wg6AAoJENmyd4cVxLOCz0QP/AvoFGJDdd613tfajQ77O6Qb
p6sNrpOZQ8aCsuuayL8IphAWBESBrOmB7ccAid+amBlSu6Ng4vSRLi/CvmugFiST
kuZVisncWpq1Sw4SfeNRaGfzDnb13txZPH2IajoPnxBnFk2twdkGuVO/kQTbBn54
BXzvCCXNnb4XAZ8qak991ozKbikaeBMaBrFzaFd4Ru1Tgq2DpoMsW+23kOY4XhtI
6gdsX2rHRUTpv3czudFzR+jjMdoiWOj75rXZnQB2jSnVA3ABUhWivfJptG3oKcXE
0r+kSMWdzgV6/ljkLg98qX7829xaT3ODyJ6Lf9Q24KvCrGZL67LR9Ke/JpaSaw2G
idNg8WfgAOl4adKIsdRPorjkDKwRDmrappKvcMqlteag5cdK7lncbppjRk7pLPy6
T01D0K3uls8oyZeZjJYEfH5t+PqE7hpeE4UE6+1flxpB+Briza2pY0QOua6oP1J0
bCYjfExINfq6EO0XVyp76gZXmb57vm3oHXDGuTKL26vD7zGUqiZmJIXcMvqw1Vws
fKa2shTK2At+BKpK5pnMY+eqzgyCJYQTAKRCt9Ne9zze/k8XmH0tPt/w9k8lKpnX
n9hjqJAGHcDHfmUAB4ndMXGY11vmF+Etb5gaFISeSNqOYaZ9aSkfdf8Fg6v90s2e
k2nobjglD+1SeHHnPOpN
=ovM9
-----END PGP SIGNATURE-----

--WVVCf30s0VrEed1DgB6tAIJ5dfDf6FiwJ--
