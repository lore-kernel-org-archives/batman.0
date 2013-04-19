Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 19 Apr 2013 15:12:47 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130419131246.GA30263@pandem0nium>
References: <1366292627-6417-1-git-send-email-ordex@autistici.org>
 <1366292627-6417-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1366292627-6417-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: print the VID properly
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2013 at 03:43:47PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Since the MSB bits of any vid variable are now used for
> storing flags, print the vid properly by taking the flags
> away and printing -1 in case of VID representing no real
> VLAN.
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bridge_loop_avoidance.c | 57 ++++++++++++++++++++++++++-----------------=
------
>  main.h                  |  2 ++
>  2 files changed, 32 insertions(+), 27 deletions(-)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index 16f9239..24a62ac 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -307,7 +307,8 @@ static void batadv_bla_send_claim(struct batadv_priv =
*bat_priv, uint8_t *mac,
>  		 */
>  		memcpy(ethhdr->h_source, mac, ETH_ALEN);
>  		batadv_dbg(BATADV_DBG_BLA, bat_priv,
> -			   "bla_send_claim(): CLAIM %pM on vid %hu\n", mac, vid);
> +			   "bla_send_claim(): CLAIM %pM on vid %hd\n", mac,
> +			   BATADV_PRINT_VID(vid));

You've changed all these strings from %d into %hu and now back to %hd? Why =
not just leave everything
at %d and reduce the bloat of these patches? It should not hurt anyone - ye=
s, printing -1 is not pretty
but this is developer debug info anyway. And keeping %d instead of %hd shou=
ld not be a problem as far
as I understand.

Apart from that, using the BATADV_PRINT_VID macro is a good idea IMHO.

Cheers,
	Simon

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlFxQs4ACgkQrzg/fFk7axZKfgCgr9hp+ewk0FcS6Te+3aSo5agv
VTIAoM3H7HhHinrX+iq9PG02/6JvLunP
=qU38
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
