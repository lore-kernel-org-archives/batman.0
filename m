Return-Path: <antonio@meshcoding.com>
Message-ID: <545CF861.2000304@meshcoding.com>
Date: Fri, 07 Nov 2014 17:50:41 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAEbDFcSO2jVkSKwS5KirqNLmfT69X5jDA0qW_nP3KaZRkFnNuw@mail.gmail.com>
In-Reply-To: <CAEbDFcSO2jVkSKwS5KirqNLmfT69X5jDA0qW_nP3KaZRkFnNuw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uhbLalLkEg12sUPNXi179OJVfAxUQ4GAN"
Subject: Re: [B.A.T.M.A.N.] Queues in batman-adv
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uhbLalLkEg12sUPNXi179OJVfAxUQ4GAN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/11/14 05:07, Krishnathiepan Rasanayagam wrote:
> hi All,
>=20
> Can any one explain me how the tcp buffers were handled in batman-adv.
> or which files it handled ?
> We are trying to modify the way batman-adv handles the data buffer.


Hi Krishnathiepan,

batman-adv does not have any buffer for outgoing packets.

Moreover batman-adv has no clue about the upper layer protocols,
therefore it has no knowledge about TCP or UDP.


Cheers,


--=20
Antonio Quartulli


--uhbLalLkEg12sUPNXi179OJVfAxUQ4GAN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUXPhlAAoJEJgn97Bh2u9efZYQAI0mmhFMJBCgJnaDpmncUFwt
wgVsbaSv+sE6HRgD1GUP+jHvKO+a4a8+fXDtX5c0+OCwGzMT/bBHZG+GgpmFASyQ
jFPpOibY7kSg9ZkKgwAKHVc9JiW+/1KW/KkUiEmEmUlGX245y/fBOntM7k0nqRSw
PVWlA29CkjYPN1rPFT9vRA7GVXPHcZXzmoF2PULjuCl977n8eyShmr5hFiCcWOeU
+rv1bSYmDKYWvkKUfeb9vYs2MShoi/WeAVqTbAAOIFb52xObV2gtjr0MxK+30npg
bvZRUr8h+0zLT2PNyDJO/bUc4Am6c78m2aQYUUltCxnp/om29idm9PISXOD8XfWo
ePZa5jy/68753BLfws+PYbyN/7N5TJ1w/g2+7hO8b+pwghquhayZH9iLLcs1G63v
WPfegCrbS+yBebvp2h92tTOHKZATLJafG3Djkwq8x3nf2+IXXeQf1gauxIgp/ku2
r0ciN/PjTaBVICnlIdtoFTZBthn4qf1XgYIKL2luQgOnoNfHhcqSp2i7+T3+UsjV
6hmTPNFnvr5KpCP+fZas8wV6IUBkjXGOCyFGEewgYyRSBfsi17e2DU98thOjrylR
BZKzu+0syGxUCdlDZlvhScXJvyeVHmJo7G/XHhIHN90vyLFHo81TVHt7SNnhTWpf
mtqSSKGnpmm6OFYAhWyO
=ZHgp
-----END PGP SIGNATURE-----

--uhbLalLkEg12sUPNXi179OJVfAxUQ4GAN--
