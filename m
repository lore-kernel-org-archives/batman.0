Return-Path: <ordex@autistici.org>
Date: Mon, 6 May 2013 21:42:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130506194203.GK3773@ritirata.org>
References: <1367869192-3322-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Content-Disposition: inline
In-Reply-To: <1367869192-3322-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't use call_rcu if not
 needed
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


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2013 at 09:39:52PM +0200, Antonio Quartulli wrote:
> batadv_tt_global_entry_free_ref uses call_rcu to schedule a
> function which will only free the global entry itself.
>=20
> For this reason call_rcu is useless and kfree_rcu can be
> used to simplify the code.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  compat.c            | 11 +++++++++++
>  translation-table.c | 20 ++++++--------------
>  2 files changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/compat.c b/compat.c
> index 1f3a39d..6226f81 100644
> --- a/compat.c
> +++ b/compat.c
> @@ -27,6 +27,17 @@
> =20
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)

This compat code has not been tested because of lack of kernels...

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRiAeLAAoJEADl0hg6qKeOwt8P/i7Nqch5aipScwUpnRk5e086
LQGpWUWpgjum4O1smldEC6JQtqB2D7l/DDbLgVpZz4aJo+zljKa1ucp7zu4T+obM
WvMROCX5SubGyrMGOQZrjgF9MU3VzeOp3OkuLOOsUdL/fwPvZFiOf/aitT0VG2fp
BNUKRW+Tkybhd+czusKw/jx8kPyLppHbZ/IA/3pX6k1FC//i+BS5sbdLlrO13fWr
OzaI0vVYUN839ypbGFVF5VjWq/Cxe3uEQ3fJKHL6DXqjlgRpOv3hwiKt+NNreYzT
wfcuJxBB/MKco44O5/MHa+pcwXX8eDQSkrW+SRR9egzdofSm/MFWgrwzZSMoSbTW
cYemaYCVZUMcmUjwCLIgt7U7jGsOlBHNSTzCZKjZiOE9PQ/f8ynq3wA8vI03ys4t
fFiXIUmgIGAUGHjVikciR82k5aAofijSrXJeCfOIFb8huW4ghOa4m1mFWPt1iV7v
qaAvTOp/1fErdsXYxZNDkuoYdSZ9U4gDuNrRAsoapZf2U+O80ajSC9cdiExNVicx
FbH7NHSJYlIT5yiZ6Bbju67xABEpmkpE903BXgZktqpDw2kFSpnbVQggv25SARX1
C64pHcn6gjKt665KUklCCTHybzJfYIdK6hnJpBw6EnWo2cSSPQX7CY7VkDWZSUl+
T7g4T/g5rqU4WniQnJt/
=BGFP
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--
