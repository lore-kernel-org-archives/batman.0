Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 3 Aug 2013 23:07:15 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130803210715.GC12891@pandem0nium>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
 <1375303667-3018-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <1375303667-3018-4-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 03/10] batman-adv: add bat_orig_print
 function API
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


--rQ2U398070+RC21q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2013 at 10:47:40PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Each routing protocol has its own metric and private
> variables, therefore it is useful to introduce a new API
> for originator information printing.
>=20
> This API needs to be implemented by each protocol in order
> to provide its specific originator table output.
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_iv_ogm.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  originator.c | 66 +++++++++---------------------------------------------=
-----
>  types.h      |  3 +++
>  3 files changed, 80 insertions(+), 56 deletions(-)
>=20
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index 595fcb0..605c954 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -1391,6 +1391,72 @@ static int batadv_iv_ogm_receive(struct sk_buff *s=
kb,
>  	return NET_RX_SUCCESS;
>  }
> =20
> +/**
> + * batadv_iv_ogm_orig_print - print the originator table
> + * @bat_priv: the bat priv with all the soft interface information
> + * @seq: debugfs table seq_file struct
> + */
> +static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
> +				     struct seq_file *seq)
> +{
> +	struct batadv_hashtable *hash =3D bat_priv->orig_hash;
> +	struct hlist_head *head;
> +	struct batadv_orig_node *orig_node;
> +	struct batadv_neigh_node *neigh_node, *neigh_node_tmp;
> +	int batman_count =3D 0;
> +	int last_seen_secs;
> +	int last_seen_msecs;
> +	unsigned long last_seen_jiffies;
> +	uint32_t i;
> +
> +

unneccesary double newline?

Rest looks good.

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlH9cQMACgkQrzg/fFk7axb98QCguG95DhWyTz5fV1GJpFYrwyr2
o4EAoO5qT7vPZLMpHjwKZvJhUhYAAwFA
=j9bE
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
