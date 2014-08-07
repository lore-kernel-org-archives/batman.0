Return-Path: <antonio@meshcoding.com>
Message-ID: <53E337A3.3060801@meshcoding.com>
Date: Thu, 07 Aug 2014 10:24:03 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <53E32F6D.3010207@aliyun.com>
In-Reply-To: <53E32F6D.3010207@aliyun.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eb8FkecNV582N6aaBKpLRBCucUxOA41sa"
Subject: Re: [B.A.T.M.A.N.] how to make IP layer handle the change of
 network topology
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
To: b.a.t.m.a.n@lists.open-mesh.org, liudows@aliyun.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eb8FkecNV582N6aaBKpLRBCucUxOA41sa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Lui,

there is no direct way to get a topology change in userspace unless you
want to parse the originator table (and even in that case you will only
see "local" changes).

The behaviour you described about the ARP packets is normal because the
IP layer does not know anything about changes happening at the
batman-adv layer. You need to handle them by yourself (if possible).

However it looks like you want to detect a "gateway change" rather than
a real "topology change".

Please check this link[1] out that is explaining how batman-adv tells
userspace about GW changes.

Cheers,


[1] http://www.open-mesh.org/projects/batman-adv/wiki/Uevent#Gateway-ueve=
nts

On 07/08/14 09:49, liudows wrote:
> Hello, eveyone, I am learning the batman.adv recently.  =20
>=20
> We know that batman.adv works on layer 2. When the network topology cha=
nge, batman.adv can know this change and handle it. But the IP layer does=
n't know that. How to make IP layer handle the change of network topology=
? =20
>=20
> For example, I have 3 mesh nodes, client node A, gateway node B and get=
eway node C. A connects  to internet via B. Then I shutdown B. I guess A =
will switch to C as it's gateway node automatically. But it's not so. A c=
ontinuously send the ARP request packet to search the MAC address of B. T=
he default gateway is still B, not C. =20
>=20
> So, how should I do to make the IP layer be aware of that the gateway h=
as swithed to another one? =20
>=20
> Thanks! Best regards. =20
>=20
> liu =20
>=20

--=20
Antonio Quartulli


--eb8FkecNV582N6aaBKpLRBCucUxOA41sa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJT4zerAAoJEJgn97Bh2u9eaGEP/iEimOXeg27I3J486Ze+nbh4
2GzTtHckeIpR6wSvOswMTs+i3GozftfK3wT2QWTkLuctiZpRVQG7Inm+YP+mpK7o
ut+iSUcy/DySPPv2vAjnZWkTy7Cxw/+GnhB/Q14eeZtr/u205z49acuioidYIbk5
cU7DOs8MEUnGN/CcAlvG443JhH+zvkFTWR/Jmg8YuPYSM1aedWzHPj7tJggiKWSg
NBbMjx9wQsM8X42c2jM3mJAmYFzijrk0LykkvrQnRSjXPtMHEmi96yESmk9CMAW+
ydRY02XoK/amF0W+RbaN1KZ/pp/NkznUOXQbCGh2dlYKt3hDtHv8ONUv6TlCFLu7
tzbA/LyLqTVUnHvPilfgv/09kmYFzJd1QOxnNGwbP569QgAG3IHAZXJhjz2MlC/J
2LXgD5tVjKM1OdFUFh8qx5/Tp3RiZuDw1C2CQKHt78tXh2ewAV7qteGkCIrgpZMC
kQ2dPfnuV3UupVrfdBTH0UFA4WL7DWqeTfsac4gsB4K1FJtxGDL49PXf0DnNQVY4
SlPgvPRS37jJcDi76tzVWjV0RUsWwjWKKojrubXwK45t6zsFwWvmfOYqodvKjv8B
Dvk9Qi/WU084Bjtnzl9rlAN/gVJUiKsrg0FqlqBrHU1RbQIDSkZ+Ti2o4ngiAmgX
RgKLAn4RCK7ofhhFAm73
=n/XN
-----END PGP SIGNATURE-----

--eb8FkecNV582N6aaBKpLRBCucUxOA41sa--
