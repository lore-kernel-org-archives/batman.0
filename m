Return-Path: <ordex@autistici.org>
Date: Wed, 3 Apr 2013 10:11:45 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130403081145.GC14372@ritirata.org>
References: <20130330131029.GB4024@ritirata.org>
 <1364952313-3163-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <1364952313-3163-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Fix rcu_barrier() miss
 due to double call_rcu() in TT code
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


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2013 at 03:25:13AM +0200, Linus L=C3=BCssing wrote:
> rcu_barrier() only waits for the currently scheduled rcu functions
> to finish - it won't wait for any function scheduled via another
> call_rcu() within an rcu scheduled function.
>=20
> Unfortunately our batadv_tt_orig_list_entry_free_ref() does just that,
> via a batadv_orig_node_free_ref() call, leading to our rcu_barrier()
> call potentially missing such a batadv_orig_node_free_ref().
>=20
> This patch fixes this issue by calling the batadv_orig_node_free_rcu()
> directly from the rcu callback, removing the unnecessary, additional
> call_rcu() layer here.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Acked-by: Antonio Quartulli <ordex@autistici.org>

Thanks a lot

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRW+RBAAoJEADl0hg6qKeOSaYP/095D3Vl780B4zr0RpYwhp/2
eVDUCV1HXMExGJInx6aS7lfqVsCUpdWFgXzIZgoKMDX3v0+u5i20+DsIuUVbM6NB
jhZeHs5tFPZIR870sCrsQMwAQRAdd0pO6FBSnuJtr0CwdGe+ST3eX9LFnx8thqaN
lJuaaM4U9+hKKpFYNuu2kCv8TKamCIIG5WoUDw8F0JTmkSxEMhtSwXyz5hHT+0m7
Z9mKzSPEhzIi4CXQX1B6tiFLr1gId+39oGZvopEV04qCm+ttt+e11y9FnR9Bf/Tj
TUozkuuICwY2E9l2xYhej7R/yrfa1iN9ivBoLINSddGp/b6sryaoD9TM2YvMcoH2
Dh/l8WSLgu5k7lp03hG1hC6N4w09hmnA38OfIVAUPC+zHgSa8FEBbSsfunGhArAy
pqHhzo6QTnDxKXNm6LIhlvKr9VMuVAVmNYGAavmIt5MxwbWyHefF2DIoMV4udT7i
ov482rHZKWqN1IVRexZTFjoYPgjNXj6BBS+09pCd10JUkJuKrrHuExkhmzQoEQKG
bnkF9igU2sCIfK5zoYbSWDEMueJw1qa8EHuXZ2GdHgnqe9kYH44vHXwuqKvPLYoS
X+Kk/8j+G4m1geln7ARkjpfudEnP2cw9eRKShzUD7lskUggnQ3uA0vmWZnneT/Sr
lel9mjHgttDBSQrH2swn
=fbpS
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
