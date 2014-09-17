Return-Path: <antonio@meshcoding.com>
Message-ID: <5419358C.4030500@meshcoding.com>
Date: Wed, 17 Sep 2014 09:17:32 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1410936979-2219-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1410936979-2219-1-git-send-email-martin@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tkL0emQmVfNfI5O9N35CQtQNuVjRdtpcb"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: clear control block of
 received socket buffers
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
Cc: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tkL0emQmVfNfI5O9N35CQtQNuVjRdtpcb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 17/09/14 08:56, Martin Hundeb=C3=B8ll wrote:
> Since other network components (and some drivers) uses the control bloc=
k
> provided in skb's, the network coding feature might wrongly assume that=

> an SKB has been decoded, and thus not try to code it with another packe=
t
> again. This happens for instance when batman-adv is running on a bridge=
 device.
>=20
> Fix this by clearing the control block for every received SKB.
>=20
> Introduced-by: 3c12de9a5c756b23fe7c9ab332474ece1568914c ("batman-adv: n=
etwork coding - code and transmit packets if possible")

maybe the maintainer can split this line before pushing the patch, but
next time split this it in two of them :-) (like other patches we have)


Cheers,

--=20
Antonio Quartulli


--tkL0emQmVfNfI5O9N35CQtQNuVjRdtpcb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUGTWQAAoJEJgn97Bh2u9eP2sP/j4r9ZjXXzAcIWIBVa16EQZz
hoHLU4EKSnG92TIjJ9S6BQ8W95lNdi+RoTDUILC5kYlFpCti42CAHzIIxDvayXlO
7/0WcZ6cZSq9kfofAL+yH+Gc4A+MNZPoVBTlrFp86GPrgQs3TAWcAcgPpg+Ecz3K
4F2MYPF7HQnVbhwq1ZhmvkjskW5fVhEr9HAOFixyCSjhTAIXwuaDehv+g94hcMAj
x+E5JqCaXNWtRBTdpo5zA8jmK66VzBtrVXVDkRMYltrPUYOjEH2CDe+Alhoe09wM
kwOY8sa5JDt3k7OrrKmc2WWwrdoFW0o6sNFnBW3gLFgpY2YNg1XqIMQNckQMRfSy
8czEgTCTu8mhQrLmRgsSuGtxUUINp8kcEbxcvWeg465FD5B7rRdUxq9kA2Qg3rhf
3Q7VGNbMInNLHGVL2zmjCEAts1cRwx5dqF6XD/jottoG90pPJnL1OPC75TQv1O2Q
zaPQPDoUWtPQCcEUHGonkPo8IzMm62/O/AjKtuTeEVY1VmyRUex2N99TQvJpNn6E
t2+XZxrRzbTpC2FX9rGJ5n/W6QxFXyoHgv2yZmCnDWHBhC2zPufRQiAPnFfu+xCL
vCdz6dfO3Y/hnvBddtFuQO0WJJAFiTucckSQJnK9ATNdAcegSFVKULZ5Xatgte05
+OYGK+e708QDGp4qemPx
=LPzj
-----END PGP SIGNATURE-----

--tkL0emQmVfNfI5O9N35CQtQNuVjRdtpcb--
