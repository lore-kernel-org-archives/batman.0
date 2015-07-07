Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jul 2015 16:41:12 +0800
Message-ID: <2499178.5J3uHqtEmg@voltaire>
In-Reply-To: <1435940999-3829-2-git-send-email-linus.luessing@c0d3.blue>
References: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
 <1435940999-3829-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5314148.erHIZXBnJv";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint 1/4] batman-adv: Fix broken DAT
	capability check
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


--nextPart5314148.erHIZXBnJv
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, July 03, 2015 18:29:56 Linus L=FCssing wrote:
> The introduction of set_bit() and clear_bit() calls in batman-adv
> wrongly passed bitmasks and not the bit numbers to these functions.
> This leads to broken capability checks.
>=20
> Fixing this by making the capability enum a non-bitmasked one and by
> that passing non-masked values to set_bit()/clear_bit().
>=20
> Fixes: bfd0fbaef270 ("batman-adv: Make DAT capability changes atomic"=
)
> Reported-by: Def <def@laposte.net>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  distributed-arp-table.c |    2 +-
>  types.h                 |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied in revision de46667.

Thanks,
Marek

--nextPart5314148.erHIZXBnJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVm5CrAAoJEFNVTo/uthzABUoIAKH8WSX+bCTODIYJAHVD0qkp
K+rT78dE9UBO+Yn6ZTF7AqR8x3Tc7feEIHaPMst+eRo6O+z3B8WeuVu5EcK3oNgw
78wcx33eXqAcCPCB+/hoQYTwcPpzV4y3W9t/PNris2vbgd5Ok6jMLLzEG1QTfXdj
KdNiq9j0t05iXQIgKq8pOng8kRux5gL5NMC1Yze07UVdCqKU0N62XsIk9UnNlonJ
FYL2lgz6zng25OeMb7DtjP4M+gPYHj26DWj/rimqUYUe5tHcBewQTzcRXrCji74A
7y1eaQ0D1w8IqzVSbuaBItkOOBC8V5it9+zo9tqfox5pWL64AKwUMvOI5lZgHhI=
=wlTG
-----END PGP SIGNATURE-----

--nextPart5314148.erHIZXBnJv--

