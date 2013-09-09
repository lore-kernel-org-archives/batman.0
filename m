Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 9 Sep 2013 19:21:40 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130909172140.GC12716@pandem0nium>
References: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
 <1378741567-25152-3-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <1378741567-25152-3-git-send-email-sven@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/7] alfred: Fix warning about assigning
 const to non-const
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
Cc: Sven Eckelmann <sven@open-mesh.com>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 05:46:03PM +0200, Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> ---
>  alfred.h       | 8 ++++----
>  batadv_query.c | 6 +++---
>  batadv_query.h | 6 +++---
>  debugfs.c      | 3 ++-
>  debugfs.h      | 2 +-
>  unix_sock.c    | 4 ++--
>  vis/vis.h      | 2 +-
>  7 files changed, 16 insertions(+), 15 deletions(-)
>=20

Applied in revision 669fb47.

Thanks,
    Simon


--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIuA6QACgkQrzg/fFk7axZwOgCfX+faaJ0ERNhUgiwa+Maxs0jo
slwAoOuE4PmP2FvpGFTlZb3Yz6osrMci
=euIn
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
