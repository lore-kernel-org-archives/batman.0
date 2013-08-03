Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 3 Aug 2013 23:10:56 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130803211053.GE12891@pandem0nium>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
 <1375303667-3018-7-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <1375303667-3018-7-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 06/10] batman-adv: add bat_metric_compare
 API function
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2013 at 10:47:43PM +0200, Antonio Quartulli wrote:
> diff --git a/types.h b/types.h
> index 8885dc0..516d30d 100644
> --- a/types.h
> +++ b/types.h
> @@ -993,6 +993,8 @@ struct batadv_forw_packet {
>   * @bat_ogm_emit: send scheduled OGM
>   * @bat_metric_is_equiv_or_better: check if new_metric is good enough to=
 be
>   *  comparable with metric
> + *  with metric

???

> + * @bat_metric_compare: compare two metric values
>   * @bat_orig_print: print the originator table
>   */
>  struct batadv_algo_ops {
> @@ -1007,6 +1009,7 @@ struct batadv_algo_ops {
>  	uint32_t (*bat_metric_get)(struct batadv_neigh_node *neigh_node);
>  	bool (*bat_metric_is_equiv_or_better)(uint32_t metric,
>  					      uint32_t new_metric);
> +	int (*bat_metric_compare)(uint32_t metric, uint32_t new_metric);
>  	/* orig_node handling API */
>  	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
>  };
> --=20
> 1.8.1.5
>=20

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlH9cd0ACgkQrzg/fFk7axaNKQCgnZWF9E6BaidLUoPFZlUhjlSr
5vIAoNHvOhfe3tL6WDqPKotHfSuBMJlO
=2Y7D
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
