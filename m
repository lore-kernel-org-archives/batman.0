Return-Path: <antonio@meshcoding.com>
Message-ID: <556C794E.2040407@meshcoding.com>
Date: Mon, 01 Jun 2015 17:25:02 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1433172014-755-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1433172014-755-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="46fot2UNNWfksbGq7bjoNNU1Q0PiiJQk2"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: avoid DAT to mess up
 LAN state
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
--46fot2UNNWfksbGq7bjoNNU1Q0PiiJQk2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/06/15 17:20, Antonio Quartulli wrote:
> When a node running DAT receives an ARP request from the LAN for the
> first time, it is likely that this node will request the ARP entry
> through the distributed ARP table (DAT) in the mesh.
>=20
> Once a DAT reply is received the asking node must check if the MAC
> address for which the IP address has been asked is local. If it is, the=

> node must drop the ARP reply bceause the client should have replied on
> its own locally.
>=20
> Forwarding this reply means fooling any L2 bridge (e.g. Ethernet
> switches) lying between the batman-adv node and the LAN. This happens
> because the L2 bridge will think that the client sending the ARP reply
> lies somewhere in the mesh, while this node is sitting in the same LAN.=

>=20
> Reported-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>

Although this patch is for the maint branch it was (unintentionally)
implemented on top of master.

Please use the "git am -3 $filename" when applying this patch on top of
maint.

Cheers,

--=20
Antonio Quartulli


--46fot2UNNWfksbGq7bjoNNU1Q0PiiJQk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVbHlbAAoJEOb/4TMchkvf6U0QAMrRoh1L0uD8reFSuoGvBW57
NbNzOkxyvc5aRdtBEGuoN7NMA81wEilHqMrzRfP2lLAMZ4nSuaZK4pE+Daiwb9VJ
+KU/qOWbSnxTgXlr4acQ9Z94oohqPpc84Pg0VFOsbLnYX2/oycZOzZqXjcUxacK7
H1UNnSZzP1XUuC9xAtnq7cM5BvXmpueykSERTqGPaIUTfVSOkicEyGcg4dpRsLMz
w+Q/FeJW36qVX4h1u31xx5mxWXW0v6S/gjf2q4lXmQc+QE8/1wqPSijZaxAK9VF1
n1Zs+lP2oO5VkHYI6ZWf2O5HPLZBvtHOjAgIDGFNjep39Jdfw0Fxgmu0z4wjllwW
TdvLImjGOP9vqeIts1BuwHbffnXhxd8OZGOA0f6wBvlPqxgs/r6oTWVQAbFcMvE2
1y4JyLvU5T+RS5mCfctNBvsZ58X3eZGSVGWGs0BBweuexw6SjwwaJ+rRn7mutie2
5IJ5Qbl9CB1lFjuUpw4rnsbcGP+VK7YJaIc0A5vBtag88531pR28FWdkl28Qlj79
6cWcGqicMLYUphYnhE7yuWnj1r0dJaLcSyHlyUOgVmrF0yFJOfdLlIRu1rL8oGJ8
VOwT2tAjhETtUGpA+MdapXWlhtEWdN3yI9r0tDh6MUI2hs7n95m3CMpZXwNK5TGp
EE78fq/TRFxsDRiHFFG0
=c0o4
-----END PGP SIGNATURE-----

--46fot2UNNWfksbGq7bjoNNU1Q0PiiJQk2--
