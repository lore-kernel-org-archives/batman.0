Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 08 Jul 2016 17:53:53 +0800
Message-ID: <2083685.gmP6z3vbnN@voltaire>
In-Reply-To: <1466865846-32621-1-git-send-email-sven@narfation.org>
References: <1466865846-32621-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5647500.NnT9KMtjY0";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: use kmem_cache for
	translation table
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

--nextPart5647500.NnT9KMtjY0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday, June 25, 2016 16:44:06 Sven Eckelmann wrote:
> The translation table (global, local) is usually the part of batman-a=
dv
> which has the most dynamical allocated objects. Most of them
> (tt_local_entry, tt_global_entry, tt_orig_list_entry, tt_change_node,=

> tt_req_node, tt_roam_node) are equally sized. So it makes sense to ha=
ve
> them allocated from a kmem_cache for each type.
>=20
> This approach allowed a small wireless router (TP-Link TL-841NDv8; SL=
UB
> allocator) to store 34% more translation table entries compared to th=
e
> current implementation.
>=20
> [1] https://open-mesh.org/projects/batman-adv/wiki/Kmalloc-kmem-cache=
=2Dtests
>=20
> Reported-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/main.c              |  16 +++-
>  net/batman-adv/translation-table.c | 169
> +++++++++++++++++++++++++++++++++---- net/batman-adv/translation-tabl=
e.h
> |   3 +
>  3 files changed, 169 insertions(+), 19 deletions(-)

Applied in revision eb079fb.

Thanks,
Marek

--nextPart5647500.NnT9KMtjY0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXf3gxAAoJEFNVTo/uthzAWTYIALY3M8i/cyV9hS+3r0z8LlwU
u+7TR/ebkaYWXRz/Lw6eNavEHKMpDbmZRKJEV3D4y7g/BRD2f7xvoBCK1lZX23DB
4Yrlkv77RF2arY9ekLMXHCrVpcB9hXB4EzS0cFzjpMGIOh2V/PKd3MdvR+YTYUYf
PTXz8UHREXsfNZl1ljzo7S2iFH/gtkrUzBPSjXTCBAjsDs3EieIzWHhtXJqGUPAg
Pu5lFAWKuy8uJ/4hRg3gR+beT+BE+Nc2LBuzuCKkqybI7tEu/xG07HDw35XabY3u
c5EwxSqZyy17lrhACYJoHzYWJeiH/vCcop2G28ZD+upfciVRoF+34tKO51S3KAQ=
=85RV
-----END PGP SIGNATURE-----

--nextPart5647500.NnT9KMtjY0--

