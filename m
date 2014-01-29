Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52E97715.3060306@wirelesspt.net>
Date: Wed, 29 Jan 2014 16:48:05 -0500
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
 <861tzsgaub.fsf@coulee.tdb.com>	<52E70836.3050502@wirelesspt.net>
 <867g9jciol.fsf@coulee.tdb.com>
In-Reply-To: <867g9jciol.fsf@coulee.tdb.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IWEPlPwVBKEGMwhlxtCDp5hhPQ3nhjRPF"
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
--IWEPlPwVBKEGMwhlxtCDp5hhPQ3nhjRPF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

inline reply:

On 01/29/2014 03:10 AM, Russell Senior wrote:
>>>>>> "cmsv" =3D=3D cmsv  <cmsv@wirelesspt.net> writes:
>=20
>=20
>>> Can you paste your feeds.conf file?
>=20
> cmsv> Of course:
>=20
>=20
> cmsv> for AA and batman-adv 2014.0.0 in feeds.default.conf
>=20
> cmsv> src-svn packages svn://svn.openwrt.org/openwrt/branches/packages_=
12.09=20
> cmsv> src-git routing git://github.com/openwrt-routing/packages.git
>=20
>=20
> cmsv> For the hostapd and mentioned mac80211 you will need to clone
> cmsv> git clone git://git.openwrt.org/12.09/openwrt.git
>=20
> cmsv> Then obtain the specific revisions and replace the original
> cmsv> hostapd and mac80211 from AA.
>=20
> I am not following exactly.  Do you know which change in particular
> makes the memory leak come and go? =20
I do not know exactly what causes the leak because i don't have the leak
in my builds and have not found a better way than the ones mentioned
before to try to find what may cause it.


> AA implies an older kernel, 3.3.8
> or something.
Yes 3.3.8

>=20
> Also, obtain specific revisions from trunk? and then copy
> them into the AA tree? =20

Not from trunk.  I posted the wrong git before.
git clone git://nbd.name/aa-mac80211.git

> package/kernel/mac80211 r39150 =3D commit 886b3c876b71122ed9523834488f3=
73908224663
> package/network/services/hostapd r39155 =3D commit 64820db4b264472e03ac=
b9ea6b5536fa7633a8ca
>=20
> Is that right?  Do those mac80211/hostapd revisions come from
> bisection (i.e. the last "good" rev) or happenstance?
You have to ask the maintainer. To me they are in between AA and trunk
in terms of stability.



> Thanks for clarification!
>=20
>=20


--IWEPlPwVBKEGMwhlxtCDp5hhPQ3nhjRPF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS6XcbAAoJENmyd4cVxLOCQjcP/1XJuD/SzSBi5Xx12N3F/4gr
vj+Z9PPJXY2cKcveOzEEhlkBCN3xgrXq6S6DcDoZnfufZfD7usEDsPlXLIJvbdNg
NwaNwNKIcEiRrR3qQ/IbKcyRHNvkQg6LxsmIn+Qs0gRl9fFhccWEDU9AW6D0GHQB
/qWwkLzwuEHczhBNAFCnK3+JO5K11Yq6Qh6oqFGE/Luka4/9s+2jk3ejEC+ApifS
foDCZS+aqHgsXfV/5BGPf0ysQLipR0aMbbSLb5pZxtCDRaCSkdgO9LN9V3kU8pLl
meqj0XbYcEqNMC5BbImfDT1e9HKs+77xYzuQo3ROV2ViNsOsChL8vs/Pjp0ezuUP
wjDnbfxyr9qDifgtyaDE1MJ8/fizACLElBE5TyxkdQy36I/oXxsMDsT1WblrSukM
RiNy80INbVjo9S9E+FZjXwNR1/T7tSNZHozMJx+qKjO5GAsqK+c+Y7d6rRCbeG6o
LV9GDaAvU7Z6/aNPmBdLko0vntzDWQ7KKKOHBkhSiDbrTRwovYEoNZnaqjIJP22r
reff0MctHLN01DyxO8iSDC6lyXAghAAZCL5JMYE1wtsPBZo9lLEbW35V5M49zt9F
GEgNNI/YxQiH87gqYen79rMDhRc5ToL6YDK1B17ee83eQBnSqADJ881oXS31sZKn
DXd/xbA8mlV3ruoREOXD
=YIcN
-----END PGP SIGNATURE-----

--IWEPlPwVBKEGMwhlxtCDp5hhPQ3nhjRPF--
