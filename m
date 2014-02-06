Return-Path: <antonio@meshcoding.com>
Message-ID: <52F3871B.4020704@meshcoding.com>
Date: Thu, 06 Feb 2014 13:59:07 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAOyZXpTWbaPckhZisRRO4itnYVSRAamddXPZkoUWibhsKs2dLw@mail.gmail.com>
 <201402061055.11799.sw@simonwunderlich.de>
 <CAOyZXpT8mRYrWfMfkKOr+7ks3H=3PzhRAPeyJ1oLvSoYx1uz_A@mail.gmail.com>
 <52F3831F.3080203@meshcoding.com>
 <CAOyZXpRA2+gLxwNc-10c-HVJcN58vP8bnfFSGb5f-m9wzCh2rw@mail.gmail.com>
In-Reply-To: <CAOyZXpRA2+gLxwNc-10c-HVJcN58vP8bnfFSGb5f-m9wzCh2rw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KbN4paJafp3DkNI0miWH8adGqu3mNScPb"
Subject: Re: [B.A.T.M.A.N.] How to send message/execute script on clients
 from server?
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KbN4paJafp3DkNI0miWH8adGqu3mNScPb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/02/14 13:54, Le Tran Dat wrote:
> Hi Antonio,
>=20
> Could you explain more about opening a socket on the bat0 interface?
> Should I write a new user space deamon or write it inside batman adv?

everything is userspace in this case. It's about writing a program in
userspace that sends raw Ethernet frames. batman-adv in this case can be
seen like an Ethernet switch, so you can treat you bat0 like it was a
normal eth0 connected to this switch. No need to touch batman-adv at all.=


Cheers,

--=20
Antonio Quartulli


--KbN4paJafp3DkNI0miWH8adGqu3mNScPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS84ceAAoJEEKTMo6mOh1VMFAP/3Tk1e4hh0qxXAbI6mSaGcHT
XnEo7QwhALF2tIAm6vnFlWQaoeby62s1fpPy5xsekuXxtNXeKZfMfQQ+V6OxthbA
O+lioiJgtAfaOeBEIw9+7+SJAbu/j0L1Wzs3IjY6PDxWLAMnFsDQU1xYNdk5lE5q
cnK/x9vur2ptZu+E0PPBVRW6EAEj2BXM/TwJAUj49QmnZlnGX8j4m+SpBPNDR/lA
4cuTYDGSkgKQrvBbo4c57WTGHwNV3ktfBe+K3xOceki4anfIRBdEqhJYHz126dY4
sdkK+U4OhY7A8Icd8kwqpGXyJqPOGwa2SN5oqfGa3ieQ0eLFatP5LxSd7NUgR0a0
jahrxcXg4yAro8JjUNhNryaRrphsfW1npgCxLJmGwEAz72jZ2UWjoxkyd11YrHOI
L0I+APYZ+GyHDywUU8nCZlb02QcfozX/MmRb5yBkGZnWxxRA7UftzZig2TCS9/PI
SHTbjObjZq/cDph97PA5ES7FBfF5nyB/Bs8vEuhURRK7RAWpZVnenbzLYwSoWv/j
cWSPHRrl3f/SP7w3qqzUo3U3nszwokebrPng52DLUAbqQJPlFFw8RWzGlSHRgt83
DqDn5x6XsReEnHB0BB62yerMyS0wNKFDa/BMtemgtinDv3KnIU76ojiPxN32sEjw
w23YchXozpabokhvEO5X
=Qo+D
-----END PGP SIGNATURE-----

--KbN4paJafp3DkNI0miWH8adGqu3mNScPb--
