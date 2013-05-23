Return-Path: <ordex@autistici.org>
Date: Thu, 23 May 2013 10:51:43 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130523085143.GD1679@ritirata.org>
References: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 0/3] Fragmentation version 2
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2013 at 12:48:16PM +0200, Martin Hundeb=C3=B8ll wrote:
> These are the second revision of a few patches to remove the current frag=
mentation code and replace it with a new version that supports more packet =
types and more fragments per packet, thus allowing bigger payloads.
>=20
> The patches are based on current master and are meant for the next big bu=
mp in compat number. Revision 3 is changed according to Antonios review.

Side note:

While testing aligned vs unaligned memory I saw that fragmentation raised I=
CMP
latency (tested by means of ping) from 1msec to 20msecs.

Test has been done between two neighbouring nodes and one of them was confi=
gured
as follows:

- mesh0 mtu =3D 1000
- bat0 mtu =3D 1500
- mesh0 is enslaved in bat0
- ping packet was 1408 bytes big


Conclusion is: fragmentation worked as expected (at least in this case :-))=
, so
batman-adv should also be able to work over Bluetooth as well, but it is
recommended to avoid it :D


Thanks a lot for your work Martin!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRndifAAoJEADl0hg6qKeO4mYP/RPxi2f24kZnRcOOQ6v3GKsL
krwBGkbVpQk3WMIJ81KEW7LRYZmgWkv0AbpigOeHTVv6oaYDv6ZkM+pq7nB+zUvF
QJYjNKgHjSDnbEHBvI3noljqy1AMGByfgigRR9Lof0bsTb7Tz+eruozohNODRuY2
lA8fARrln6TEM9OXkwz+tEU4SVt3IeVOg+V4yWDYhXJILrYrH1MNt0j9BqaQWj/n
HcHaEyxtmMLfe6PTZxTZGhc/YWukDX14oXWeVi3Jv0oUwRF7bUiaIa5HM+rvMrAf
ikX0Sl+zjllD7t+Led3a0o6vY9wV28BpcbFY9gtAFzctJPTDKEpa3/AG8ZGSO9vq
u6NyvwUDWdO6P05nQxq/XM5lwODErf4rYCa61FZ6zobhQYjmfFaenqiQu5QksAVo
1IxiQC7r6FmsGkF6RIBPQU8LlVRCL2ynUOf53JTkUqxYeQa6hPf06MTEyypKdfIh
U0KSi4T4dQKRznFtdjH3ztWjqhbv7bTAyhMXrBFJvQGxLMqi66n1dJk9psk7/tel
98a+1DcyY4ypktFezLVjnXwkkljsMfKx1xXxgMTcJUaj/xGuyR9DVS0wQDKjbZgf
UQ78DncWohHfFnfjOD6OsMHeLgksKm3rflt0+XRnIkvkkBKpPtLtysJz1GLZ7G2S
4C71ZO8CFEQ52iDTDTk6
=oxpA
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
