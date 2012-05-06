Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 6 May 2012 22:14:35 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120506201435.GA27416@pandem0nium>
References: <4FA54C09.6000303@universe-factory.net>
	<7f84c7e913b9a0c9a22cc19864c6b7d9e2a347de.1336233103.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <7f84c7e913b9a0c9a22cc19864c6b7d9e2a347de.1336233103.git.mschiffer@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
 without neighbors on the primary interface
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Your patch does the trick, although I think this ugly function could use a =
rewrite.
First counting bytes and then allocating this size to do exactly the same t=
hing again
is not really good style. If you would like to volunteer to do this job (or=
 plan to
work more on vis), please tell me, otherwise I'll put it in on my TODO list.

Thanks
	Simon


On Sat, May 05, 2012 at 05:51:53PM +0200, Matthias Schiffer wrote:
> The primary entry and the corresponding secondary entries are missing whe=
n there
> are no neighbors on the primary interface. This also causes the TT entrie=
s to
> miss and makes nodes with multiply secondary interface fall apart since t=
here
> is no way to see they are related without a primary entry.
>=20
> Fix this by always emitting a primary entry.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  vis.c |   21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/vis.c b/vis.c
> index cec216f..c515927 100644
> --- a/vis.c
> +++ b/vis.c
> @@ -207,7 +207,6 @@ int vis_seq_print_text(struct seq_file *seq, void *of=
fset)
>  	int vis_server =3D atomic_read(&bat_priv->vis_mode);
>  	size_t buff_pos, buf_size;
>  	char *buff;
> -	int compare;
> =20
>  	primary_if =3D primary_if_get_selected(bat_priv);
>  	if (!primary_if)
> @@ -228,14 +227,18 @@ int vis_seq_print_text(struct seq_file *seq, void *=
offset)
>  			entries =3D (struct vis_info_entry *)
>  				((char *)packet + sizeof(*packet));
> =20
> +			vis_data_insert_interface(packet->vis_orig,
> +						  &vis_if_list, true);
> +
>  			for (j =3D 0; j < packet->entries; j++) {
>  				if (entries[j].quality =3D=3D 0)
>  					continue;
> -				compare =3D
> -				 compare_eth(entries[j].src, packet->vis_orig);
> +				if (compare_eth(entries[j].src,
> +						packet->vis_orig))
> +					continue;
>  				vis_data_insert_interface(entries[j].src,
>  							  &vis_if_list,
> -							  compare);
> +							  false);
>  			}
> =20
>  			hlist_for_each_entry(entry, pos, &vis_if_list, list) {
> @@ -276,14 +279,18 @@ int vis_seq_print_text(struct seq_file *seq, void *=
offset)
>  			entries =3D (struct vis_info_entry *)
>  				((char *)packet + sizeof(*packet));
> =20
> +			vis_data_insert_interface(packet->vis_orig,
> +						  &vis_if_list, true);
> +
>  			for (j =3D 0; j < packet->entries; j++) {
>  				if (entries[j].quality =3D=3D 0)
>  					continue;
> -				compare =3D
> -				 compare_eth(entries[j].src, packet->vis_orig);
> +				if (compare_eth(entries[j].src,
> +						packet->vis_orig))
> +					continue;
>  				vis_data_insert_interface(entries[j].src,
>  							  &vis_if_list,
> -							  compare);
> +							  false);
>  			}
> =20
>  			hlist_for_each_entry(entry, pos, &vis_if_list, list) {
> --=20
> 1.7.10.1
>=20
>=20

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk+m26sACgkQrzg/fFk7axYuyACfXlioPSbpAGkZU3mE68M72+S7
i4wAoObkP81josJC4NXSQyqCzGj8+Ctp
=whPi
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
