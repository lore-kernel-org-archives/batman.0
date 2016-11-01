Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 08:32:15 +0100
Message-ID: <1720803.eIts5pQzPc@bentobox>
In-Reply-To: <20161101061750.15995-1-sven@narfation.org>
References: <20161101061750.15995-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24635308.9XOuk1hDtn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Deactivate __ro_after_init for
	kernels < 4.10
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

--nextPart24635308.9XOuk1hDtn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 1. November 2016 07:17:50 CET Sven Eckelmann wrote:
> The pre-4.10 kernels must write to batadv_netlink_family after the family
> was registered. Thus disabling __ro_after_init for now is required on the=
se
> kernels.
>=20
> Fixes: c776b4a071d8 ("batman-adv: genetlink: mark families as __ro_after_=
init")
> Reported-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Tested-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  compat-include/linux/cache.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied in 83e3cb32617d07a33fb43faa0957b91b3ac622c5 [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/83e3cb32617d07a33fb43fa=
a0957b91b3ac622c5
--nextPart24635308.9XOuk1hDtn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGET/AAoJEF2HCgfBJntGF14P/j2indIPO5k62qpPMwi+v6km
oVhfJkR6C1XK0kvgaI5NwI15XnflpyZkLOVEG39EpZrZSR5JU5i0jD1FzzxgAmkq
pfRzycPE92BiZ+wXxaMV+HcoH/HraUGcBydiLZnNedTCJiQlg/UtuHLZ6bZHznYM
qsQMuKXOvbu6+jBsIw9uf9y2ms8DwSMAIiRuGA/VH8udMNFrlZj7gF15L/6nBKCG
wxNIs343D3UOyVmW2gIA3ERHEncHS/0ItAIBRZLm5+q99XhVzAdYdjYUgqbouPjw
Y3iKeXmPk1SCwVvHTGkqSn9oy9qS6wdfAnboCC6ipSg1IZHv3WfUKa3wmtGRN8J4
Cy4PsU5+U5nJ3E03NuyrmFApZUb1umZZ7OXd9CQEIue4w89RZntVH+CYKkZitnbU
sZKiLbljF8Hetfm4Zjyhhzr2Dp1X7PujAjB/cW6RGVMyqZ2YYCC2aZKLPylJfwlA
TrXHB5z3XZVRhnWw5hubruaOkG5DjIRDzeSf38oGkUhWnGTqpoyI578e7HVDsVxb
f6VaMGtF0LOefAAVjeLtejbzH2hqD2OLW4RbJhjVzzwY5eZ3UlXWEJdsV/gULbMm
vjSMJ1v0oEwOd87a0s7vHEVw+JUCAqivCI37PH+IwYs7KB5aa7Pf9ivniEZCcfCF
m5mRd+WsD8BNh2jzdX73
=i+3+
-----END PGP SIGNATURE-----

--nextPart24635308.9XOuk1hDtn--

