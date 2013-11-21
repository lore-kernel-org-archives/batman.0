Return-Path: <mschiffer@universe-factory.net>
Message-ID: <528E115E.6070901@universe-factory.net>
Date: Thu, 21 Nov 2013 14:57:50 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
 <528D81CA.8000106@universe-factory.net> <20131121072143.GD311@neomailbox.net>
In-Reply-To: <20131121072143.GD311@neomailbox.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JwH0EXmX8RwaTCmx7Sch1I8tgxPeM2j80"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat code for kstrtou32
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
--JwH0EXmX8RwaTCmx7Sch1I8tgxPeM2j80
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/21/2013 08:21 AM, Antonio Quartulli wrote:
> On Thu, Nov 21, 2013 at 04:45:14AM +0100, Matthias Schiffer wrote:
>> You are casting a u32 * to unsigned long *? Won't this break horribly
>> when sizeof(u32) !=3D sizeof(unsigned long)?
>>
>=20
> It will break when sizeof(unsigned long) > sizeof(uint32). For example =
on
> x86_64. Hopefully nobody would use such ancient kernel on his machine. =
But you
> are right.
>=20
> What do you think of the attached patch?
>=20

That's better, but if you care about overflow, you should add something l=
ike

if (_v !=3D (unsigned long)v)
	_r =3D -ERANGE;

Also, the comment in the line above doesn't make sense anymore...


--JwH0EXmX8RwaTCmx7Sch1I8tgxPeM2j80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKOEV4ACgkQq3qIxbiQM9jQYgCfVgQKxw0QD/oFW9JuWLzJrDaU
u9oAnAqBfwvYn5TxjSq3O0l/JByjEcA3
=9dUQ
-----END PGP SIGNATURE-----

--JwH0EXmX8RwaTCmx7Sch1I8tgxPeM2j80--
