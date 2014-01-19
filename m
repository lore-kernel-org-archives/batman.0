Return-Path: <mschiffer@universe-factory.net>
Message-ID: <52DC00A5.3030409@universe-factory.net>
Date: Sun, 19 Jan 2014 17:43:17 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <d48019225b19f19f5ac724d3b1a247cdf921f92b.1390143639.git.mschiffer@universe-factory.net>
 <52DBFA49.1090102@meshcoding.com>
In-Reply-To: <52DBFA49.1090102@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="enJuJbkj5NdRwHrS4Eaf2geDlUHFRMJMc"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batadv-vis: don't leak socket fd in
	get_if_mac()
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--enJuJbkj5NdRwHrS4Eaf2geDlUHFRMJMc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/19/2014 05:16 PM, Antonio Quartulli wrote:
> On 19/01/14 16:01, Matthias Schiffer wrote:
>> Leaking an fd every time get_if_mac() is called causes a batadv-vis se=
rver
>> process to hit the open file limit in a matter of hours when it is as =
low as
>> 1024 (which it is on OpenWRT).
>>
>> Reported-by: Jan-Philipp Litza <janphilipp@litza.de>
>> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>=20
> Matthias,
>=20
> what repository is this patch against?
>=20
>> ---
>>  vis/vis.c | 8 ++++++--
>=20
> I am puzzled because your commit subject says "batadv-vis" but the patc=
h
> does not seem to be against batman-adv/batctl. Can you clarify please?
>=20
> Cheers,
>=20
>=20
>=20

Sorry, I forgot to change the subject to [PATCH alfred]...


--enJuJbkj5NdRwHrS4Eaf2geDlUHFRMJMc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLcAKUACgkQq3qIxbiQM9iF9wCgyynxV2g+38WbJrt663/pqnpI
LuwAoIqele1/q1bBPgVzcM4r2qE5lNds
=Jwdi
-----END PGP SIGNATURE-----

--enJuJbkj5NdRwHrS4Eaf2geDlUHFRMJMc--
