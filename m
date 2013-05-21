Return-Path: <ordex@autistici.org>
Date: Tue, 21 May 2013 21:10:11 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130521191011.GA3435@ritirata.org>
References: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
 <1369133299-8325-3-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <1369133299-8325-3-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/3] batman-adv: Receive fragmented
 packets and merge
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2013 at 12:48:18PM +0200, Martin Hundeb=C3=B8ll wrote:
> +bool batadv_frag_skb_fwd(struct sk_buff *skb,
> +			 struct batadv_hard_iface *recv_if,
> +			 struct batadv_orig_node *orig_node_src)
> +{
> +	struct batadv_priv *bat_priv =3D netdev_priv(recv_if->soft_iface);
> +	struct batadv_orig_node *orig_node_dst =3D NULL;
> +	struct batadv_neigh_node *neigh_node =3D NULL;
> +	struct batadv_frag_packet *packet;
> +	uint16_t total_size;
> +	bool ret =3D false;
> +
> +	packet =3D (struct batadv_frag_packet *)skb->data;
> +	orig_node_dst =3D batadv_orig_hash_find(bat_priv, packet->dest);
> +	if (!orig_node_dst)
> +		goto out;
> +
> +	neigh_node =3D batadv_find_router(bat_priv, orig_node_dst, recv_if);
> +	if (!neigh_node)
> +		goto out;
> +
> +	/* Forward the fragment, if the merged packet would be too big to
> +	 * be assembled.
> +	 */
> +	total_size =3D ntohs(packet->total_size) + ETH_HLEN;
> +	if (total_size > neigh_node->if_incoming->net_dev->mtu) {

I guess here you forgot to remove the ETH_LEN from the total_size computati=
on.

> +		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_FWD);
> +		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_FWD_BYTES,
> +				   skb->len + ETH_HLEN);

and here should ETH_HLEN be counted in the amount of bytes sent?

Moreover we are always avoiding third person in kernel doc ("Returns" shoul=
d be
"Return" and so on..) and you should not put () (in the kernel doc).


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRm8aTAAoJEADl0hg6qKeOa/gQAIyMBX5+ENzUun2/mpje+Geb
aFwxh5h6w9LDgWqHLZI0ZAP9CTtCw+et77xBbEwQas9U2NtPwfaeJBBsTkDWezBT
XlyeOUKv6cmYrZIms5jSHJcZGlnH0C3JeAbAVE5L90jDsW8togBPcL6kvki5IdIM
9gvFhSYuvH+q0gn5Mn3WZw44H1pkW2p5P9DzCnbtp2gKbTeOlYwZRBIkInv6/oBc
6udxptxPtx9s5tnFJQgSFf5DkwAA6mDLXSN8bGNbeLB0HY1p5snLZthIOaw0FWUr
vZN9rdEZMOnV06bKtxMjezusFv0LqZkXPM0h4zrZyxEHjKtrqbyJvBma868skdUE
uRlqTufsgm9oK33acRKmMvE0FsboR58NLBMKSc3740f9Ys8322XFh+MOdZNVcMv1
RhXISJtHx/a2YMyj4G828dzlLgXXIxscxrcgMDpItQ2eRg0APlKCa1SfYqTLgHyc
QLoFKumJ1DK1lFtOzCgZWHUA/8tqJhu6LmlfcuqZ0YHZ/E5RxhpbtYxyVE55jvdu
aF5AZeBTd+VvcuQ3r6GPW1aFLzKlMPC0Cpa0H5GVohOoRydTggcEfVKro+Y+UpKT
auqgu7s9KqXYrvsQ+6/XBRyyMIReJuTsyn+cmIB+KAEonMeNE54G4YOiltsdEdSQ
1TZOhu2gz1bdDfqoU3FQ
=/slg
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
