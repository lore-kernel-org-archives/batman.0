Return-Path: <mschiffer@universe-factory.net>
Message-ID: <528E193B.3070701@universe-factory.net>
Date: Thu, 21 Nov 2013 15:31:23 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
 <528D81CA.8000106@universe-factory.net> <20131121072143.GD311@neomailbox.net>
 <528E115E.6070901@universe-factory.net> <20131121142010.GE311@neomailbox.net>
In-Reply-To: <20131121142010.GE311@neomailbox.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DDDP1x74wmjBNT6npklAX1UcCarrmvMGV"
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
--DDDP1x74wmjBNT6npklAX1UcCarrmvMGV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/21/2013 03:20 PM, Antonio Quartulli wrote:
> On Thu, Nov 21, 2013 at 02:57:50PM +0100, Matthias Schiffer wrote:
>> On 11/21/2013 08:21 AM, Antonio Quartulli wrote:
>>> On Thu, Nov 21, 2013 at 04:45:14AM +0100, Matthias Schiffer wrote:
>>>> You are casting a u32 * to unsigned long *? Won't this break horribl=
y
>>>> when sizeof(u32) !=3D sizeof(unsigned long)?
>>>>
>>>
>>> It will break when sizeof(unsigned long) > sizeof(uint32). For exampl=
e on
>>> x86_64. Hopefully nobody would use such ancient kernel on his machine=
=2E But you
>>> are right.
>>>
>>> What do you think of the attached patch?
>>>
>>
>> That's better, but if you care about overflow, you should add somethin=
g like
>>
>> if (_v !=3D (unsigned long)v)
>> 	_r =3D -ERANGE;
>=20
> yeah, thanks! I'll add this!
>=20
>>
>> Also, the comment in the line above doesn't make sense anymore...
>=20
> yeah, I removed that already.
>=20
>=20

Ah, and I overlooked that you have to dereference v and take the address
of _v; adding parantheses around the parameters might also be a good
idea as it is a macro.

So I'd recommend something like this (not even compile tested...):

({\
	unsigned long _v;\
	int _r;\
	_r =3D strict_strtoul((cp), (base), &_v);\
	if (_v =3D=3D (unsigned long)(u32)_v)\
		*(v) =3D (u32)_v;\
	else\
		_r =3D -ERANGE;\
	_r;\
})



--DDDP1x74wmjBNT6npklAX1UcCarrmvMGV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKOGTsACgkQq3qIxbiQM9gNggCgxOy0aMoryED+cR/Jkv7OP4Te
LRkAnRhLzHP+LNUZQkGwxpp0IoyzoyQl
=0oIC
-----END PGP SIGNATURE-----

--DDDP1x74wmjBNT6npklAX1UcCarrmvMGV--
