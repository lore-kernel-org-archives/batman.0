Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2011 16:29:16 +0200
References: <201106121152.02177.sven@narfation.org>
	<20110613132507.GA18690@ritirata.org>
In-Reply-To: <20110613132507.GA18690@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart76942878.PljAZ0tEW4";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201106131629.19141.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] Combination of flags in tt_query packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart76942878.PljAZ0tEW4
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
> > just looked a little bit closer at your tt_query implementation and was
> > reminded that we had a small discussion in IRC some weeks ago.
> >=20
> > <ecsv> can those flags be mixed?
> > <ordex> mixed? in which way?
> > <ecsv> request | table -> still a valid package
> > <ecsv> sry, packet
> > <ordex> yes it is, because it means "I'm requesting a full table"
> > <ordex> all the combinations are valid
> >=20
> > This sounds wrong when I look at the tt_query packet. There we have a
> > tt_data field which can used used exclusive by either TT_REQUEST (x)or
> > TT_RESPONSE. Therefore, it is not possible to use both flags at the same
> > time. Can you please explain how this is handled or otherwise change it
> > so that only one bit in flags is used to decide if it is an response or
> > a request.
>=20
> At the beginning we had one bit only with this meaning:
>=20
> 0 =3D> TT_REQUEST
> 1 =3D> TT_RESPONSE

Could be correct - never followed the discussion in detail. I asked Marek a=
nd=20
he said something about roaming.

> But then we had a disussion about:
> 1) what will we do if we want to add more packet types in the future?

Depends on the type. For example full-table creates different packet types=
=20
together with the TT_REQUEST and TT_RESPONSE. But using TT_REQUEST and=20
TT_RESPONSE together doesn't work at all. So forget about the flag and thin=
k=20
more about a currently undefined amount of bits which encode the type of=20
packet. Encoding the request and reply in two different bits and call them=
=20
flags doesn't really make sense.=20

> 2) is it correct or not to use 0x0 as flag?

A not existing bit position is not really a "flag". The bit at position zer=
o=20
(lsb) could be used as flag to decide if it is a request or a response - bu=
t=20
using nothing to store something is... <please insert your favourite swear=
=20
word here>.

> Regarding 1) I thought that using a "two bits flag" could help in reservi=
ng
> two configurations more for the future (0x0 and 0x3).

Then you say that you don't use flags but 2 bits to store 2 values. Please=
=20
don't use it in your code as flags, but use something like (x & TT_TYPE_MAS=
K)=20
to extract the corresponding bits and compare the resulting values against=
=20
representation of TT_RESPONSE and TT_RESPONSE (TT_TYPE_MASK would be 0x3,=20
TT_RESPONSE 0 and TT_REQUEST 3). Also remove the TT_RESPONSE and TT_REQUEST=
=20
from the enum tt_query_flags and use another enum for them.

Kind regards,
	Sven

--nextPart76942878.PljAZ0tEW4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN9h69AAoJEF2HCgfBJntGpdEP/AxPy/KiE6c659UiY9gUJZty
icTY61QNo/Up9rl7pjg+mWRbwjSdWx9qeuJ1moqPUvTkD4wkCLFDLQfVo2HP0ud+
KYImzCfUPpvloxGa9/dvAtNH1R5ztGlmYpIE88ra8inVUPsX05XILuvYdknD46iz
3SnMr0A594r3i/Jyy8bY8rReRcLtyKkiD7hCZt5SJLp+0aJ3PyI6rp8quyDrAPyb
PF84DBDAcWB8XqEySURn8vl5IiH8gXkd+/naMQZOMyu6xuVND4vScWEg+ubQv1Kn
G+NHiwt7x5ALVWhwzPyNh/kZ2mz2JXsckYxwfqd3IEqL/fw3yWyJrDGdPs/9C9Cp
PB6bgyxguejalSJxZOaAqeORDvP159QOpZKPU8UBXyZYTydHxpEtMBJ6tIsHfdiA
7KVxe9SpaAORaCbraMUfnIRdmtuH1vj3BsuGJ3M0cNHz47/8L47LeZOd2oIAN2hy
Lr9motuB3afJ4X/2I0favxotcRdPgLu9taNi712s8RGWQwWuo5+JOXyqOvaWXeYj
O0qVhhhoX8nJN1SFfcvatNSsB8hsEq+hRQlY9oH+F9c4cd+B/i0czrIWcfQI1+0F
zNNaMN5eCywwq6Mwx2lB2MEn8tlZhLCZLc+1DF8yr2tELgDEjPMRpIohgAK6Rm2H
it4mFDwL3k2SmkLHlrD/
=D6kQ
-----END PGP SIGNATURE-----

--nextPart76942878.PljAZ0tEW4--
