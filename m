Return-Path: <mschiffer@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <3565172.dz0c0eMaPu@prime> <57173083.6020305@universe-factory.net>
 <243525463.WEoUOFbSir@bentobox>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <57173485.2060407@universe-factory.net>
Date: Wed, 20 Apr 2016 09:49:25 +0200
MIME-Version: 1.0
In-Reply-To: <243525463.WEoUOFbSir@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SdfD450rnQVLguLpQrcVmml4Gd6QNL6MQ"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SdfD450rnQVLguLpQrcVmml4Gd6QNL6MQ
Content-Type: multipart/mixed; boundary="C7rExgSpunaiSsW2DfVSHmplG8154G9JQ"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Message-ID: <57173485.2060407@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <3565172.dz0c0eMaPu@prime> <57173083.6020305@universe-factory.net>
 <243525463.WEoUOFbSir@bentobox>
In-Reply-To: <243525463.WEoUOFbSir@bentobox>

--C7rExgSpunaiSsW2DfVSHmplG8154G9JQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/20/2016 09:39 AM, Sven Eckelmann wrote:
> On Wednesday 20 April 2016 09:32:19 Matthias Schiffer wrote:
> [...]
>> As I've mentioned before, regarding the batctl support, I'd love to se=
e a
>> little library ("libbatadv"?) on top of libnl that could be used by ba=
tctl,
>> alfred and other monitoring tools (like the ones we are using in the G=
luon
>> Freifunk firmwares).
>=20
> Hm, then we would have to make everything ABI stable. So we would loose=
 the=20
> flexibility of netlink (adding more fields) again just to keep the libr=
ary=20
> stable.
>=20
> Or what kind of functionality should this library expose that can be ea=
sily be=20
> kept stable?
>=20
> Kind regards,
> 	Sven
>=20

I don't understand. The same code that would we added to batctl and alfre=
d
could just be made a library with a nicer API, so other projects can easi=
ly
reuse it. Of course, the library API/ABI would need to be designed in a w=
ay
that keeps it extensible without breaking ABI.

I'm thinking of functions like "iterate over all originators", which woul=
d
query the netlink API, and then just call a callback with the netlink
attribute set for each originator. Just a thin wrapper making things more=

usable.

Regards,
Matthias


--C7rExgSpunaiSsW2DfVSHmplG8154G9JQ--

--SdfD450rnQVLguLpQrcVmml4Gd6QNL6MQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXFzSFAAoJEBbvP2TLIB2cB4wP/2/zz2c0zhZRV+CIBD+gxnnl
QdkacaFh23ph2SfH009tq4EkCxG/j2m2b0/VcMilz8gOsNx4TRZbSk3djVyaVypE
PmCCdvBXgUvEqs0bCXGlw56EXOZ6xEycpdThsxNizC9cT9PeF93Vqnouk3roHXYc
OPWm9eF7eGsNwxwupWQ67jFx55bVfKIflfku0jEPcJUIczhh+dOVqVI0K/DiJ6FE
GeknCfhvRedU5VgyuX9aIUnUYs+xa1JdWpkmiq8r0F/ipSKwg7Me4RoA1ayktgXv
40NjX+NGPwIZwi0E1n7PT5Y4LwGTGqTgvQ0yMnq8MgJvyqdGVL00Q3vve8IINfSm
pCiqmsCx1W2sQUGOUkmc1u+KaW5GpISYq+YxbQfsi4EYV1ut0euD5eozvTb3cSLf
PWQ8LRk51nG3dTyb2yJUGWNmekbKVJUSKP4krNotpdEkoVOmtvSd63GCQly57EES
U296uIDh3Yn9TO3pp6l8j8DOx2yTK1g5UVDY48Bo/apDwQmOkiwjMSb5Yn3AIHb4
IfE2l1FPitU0bd+Oy5W09z1TKx7nRgZybe43ALCcPL4zJz1F+uD6AsgKRs9WBwm8
yXC+gu+fXN+FfTBflqbfKsZowEq07h0CP/jnrugj3/2aV7w09B98O9YlEHMNX8Mg
81OdgeLRCNZ9DarGkc95
=WumC
-----END PGP SIGNATURE-----

--SdfD450rnQVLguLpQrcVmml4Gd6QNL6MQ--
