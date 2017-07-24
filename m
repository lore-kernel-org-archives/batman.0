Return-Path: <a@unstable.cc>
References: <20170706050225.24455-1-linus.luessing@c0d3.blue>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <cb81a912-4a0e-0e4b-bbb3-fc9f16f7b346@unstable.cc>
Date: Mon, 24 Jul 2017 13:48:01 +0800
MIME-Version: 1.0
In-Reply-To: <20170706050225.24455-1-linus.luessing@c0d3.blue>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B5JViUNG0jlAFLQhUbVG2wNduFhnuK7q2"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: fix TT sync flag
 inconsistencies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B5JViUNG0jlAFLQhUbVG2wNduFhnuK7q2
Content-Type: multipart/mixed; boundary="Kw59eaW8RkFH59xgF1LNhhSKPgJsLXkB0";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Message-ID: <cb81a912-4a0e-0e4b-bbb3-fc9f16f7b346@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: fix TT sync flag
 inconsistencies
References: <20170706050225.24455-1-linus.luessing@c0d3.blue>
In-Reply-To: <20170706050225.24455-1-linus.luessing@c0d3.blue>

--Kw59eaW8RkFH59xgF1LNhhSKPgJsLXkB0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/07/17 13:02, Linus L=C3=BCssing wrote:
> This patch fixes an issue in the translation table code potentially
> leading to a TT Request + Response storm. The issue may occur for nodes=

> involving BLA and an inconsistent configuration of the batman-adv AP
> isolation feature. However, since the new multicast optimizations, a
> single, malformed packet may lead to a mesh-wide, persistent
> Denial-of-Service, too.
>=20
> The issue occurs because nodes are currently OR-ing the TT sync flags o=
f
> all originators announcing a specific MAC address via the
> translation table. When an intermediate node now receives a TT Request
> and wants to answer this on behave of the destination node then this
> intermediate node now responds with an altered flag field and broken
> CRC. The next OGM of the real destination will lead to a CRC mismatch
> and triggering a TT Request and Response again.
>=20
> Furthermore, the OR-ing is currently never undone as long as at least
> one originator announcing the according MAC address remains, leading to=

> the potential persistency of this issue.
>=20
> This patch fixes this issue by storing the flags used in the CRC
> calculation on a a per TT orig entry basis to be able to respond with
> the correct, original flags in an intermediate TT Response for one
> thing. And to be able to correctly unset sync flags once all nodes
> announcing a sync flag vanish for another.
>=20
> Fixes: fa614fd04692 ("batman-adv: fix tt_global_entries flags update")
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
>=20
> ---
>=20
> Changes v2:
> * Fix an issue with not applying the TEMP flag, introduced in v1
>   -> Remove the OR-ing operation for TT SYNC flags only


Version 2 looks good to me. I had some doubts but I managed to clarify
them with Linus on IRC.

Acked-by: Antonio Quartulli <a@unstable.cc>

Cheers,

--=20
Antonio Quartulli


--Kw59eaW8RkFH59xgF1LNhhSKPgJsLXkB0--

--B5JViUNG0jlAFLQhUbVG2wNduFhnuK7q2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAll1ihQACgkQ0+HICM1s
oFAQ/w/+JDzaM/FYPvsBxKNEyA+AGTOaSvIxFOEar+Z5+2MDh/oJWSVUVWOFCrpL
/IZMz+y9SGgX2DdnGePR+HYsgs7k7oN8tcYv9CDrchTBbBM/BZhFZwCLwTN/bQx0
snvq2p6oVXzhkwLEm/unRZLSyBaDHqJ1sgDJ48b9SsE7xn1IwowxlT+pD2SvVG+v
dpWrOWbsmGdknapeO3bxGzOLcywranHTariox2UC5fTz2UZ3Hn6143OUB5sl7DSl
OYvkS1XsgGcFt+5YbHHXzfGUIVsJ4+BKSl0Vzy9CcnBnNXsYWzpRxXWaP9QFDgfH
fyepuT5rZNAsYloHZxUXQ9gUekD38Fpi1aEAg0JIoZL9V/8fe6jf2i1FQePb+r5b
CIj2X2vQRkHDsWT1lxBdnvfQN5GCWSk7OQWM8bRrh+aooiqbHmxuOCBZs7yBBI/x
QILnDlzFu4ExZnsS5j9l/O8jLGx1KVz4zhMj0G6tZIEKAdQrXErKqLGLAo0MiHgp
+bePZVLU6Hy4Xoh5fXi/typzkE4V7ud7luQpgCYR8CDeE6Ji6uiAu9SqC1s/nzMt
8fGW8PigPTiLElgV/NNvMNu7eep6XZQVB5XjX3VvTL6At0rqHVnh14ciWNNiUARO
YAEqPeVFL2PWG80dDpaZxfLMftLkRuzJweCGN/MSprjRWSyVlrE=
=LVPO
-----END PGP SIGNATURE-----

--B5JViUNG0jlAFLQhUbVG2wNduFhnuK7q2--
