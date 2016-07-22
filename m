Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 22 Jul 2016 15:12:57 +0200
Message-ID: <2274431.CFHQGBLaok@sven-edge>
In-Reply-To: <1469187482-29894-2-git-send-email-linus.luessing@c0d3.blue>
References: <1469187482-29894-1-git-send-email-linus.luessing@c0d3.blue>
 <1469187482-29894-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2090576.3BdRfHitFX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Simple (re)broadcast
	avoidance
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

--nextPart2090576.3BdRfHitFX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

see the inline comments. Most things appear multiple times.

On Freitag, 22. Juli 2016 13:38:02 CEST Linus L=FCssing wrote:
> @@ -182,6 +183,25 @@ static void batadv_v_ogm_send(struct work_struct *wo=
rk)
>  		if (!kref_get_unless_zero(&hard_iface->refcount))
>  			continue;
> =20
> +		ret =3D batadv_hardif_no_broadcast(hard_iface, NULL, NULL);
> +		if (ret) {
> +			char *type =3D "unknown";
> +
> +			if (ret =3D=3D BATADV_HARDIF_BCAST_NORECIPIENT)
> +				type =3D "no neighbor";
> +
> +			if (ret =3D=3D BATADV_HARDIF_BCAST_DUPFWD)
> +				type =3D "single neighbor is source";
> +
> +			if (ret =3D=3D BATADV_HARDIF_BCAST_DUPORIG)
> +				type =3D "single neighbor is originator";

what about using "switch (ret)" here?

> +
> +			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 from ourselve on %s sur=
pressed: %s\n",
> +				   hard_iface->net_dev->name, type);
> +
> +			continue;
> +		}
> +

Where is the put for hard_iface when continue is done after
batadv_hardif_no_broadcast? See the previous chunk for
"kref_get_unless_zero(&hard_iface->refcount)".


> @@ -716,6 +737,29 @@ static void batadv_v_ogm_process(const struct sk_buf=
f *skb, int ogm_offset,
>  		if (!kref_get_unless_zero(&hard_iface->refcount))
>  			continue;
> =20
> +		ret =3D batadv_hardif_no_broadcast(hard_iface,
> +						 hardif_neigh->orig_node,
> +						 ogm_packet->orig);
> +
> +		if (ret) {
> +			char *type =3D "unknown";
> +
> +			if (ret =3D=3D BATADV_HARDIF_BCAST_NORECIPIENT)
> +				type =3D "no neighbor";
> +
> +			if (ret =3D=3D BATADV_HARDIF_BCAST_DUPFWD)
> +				type =3D "single neighbor is source";
> +
> +			if (ret =3D=3D BATADV_HARDIF_BCAST_DUPORIG)
> +				type =3D "single neighbor is originator";

what about using "switch (ret)" here?

> +
> +			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "OGM2 packet from %pM on %s s=
urpressed: %s\n",
> +				   ogm_packet->orig, hard_iface->net_dev->name,
> +				   type);
> +
> +			continue;
> +		}
> +

Where is the put for hard_iface when continue is done after
batadv_hardif_no_broadcast? See the previous chunk for
"kref_get_unless_zero(&hard_iface->refcount)".

> @@ -517,7 +518,8 @@ batadv_neigh_node_get(const struct batadv_orig_node *=
orig_node,
>   */
>  static struct batadv_hardif_neigh_node *
>  batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
> -			   const u8 *neigh_addr)
> +			   const u8 *neigh_addr,
> +			   struct batadv_orig_node *orig_node)
>  {
>  	struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->soft_iface);
>  	struct batadv_hardif_neigh_node *hardif_neigh =3D NULL;
> @@ -534,10 +536,12 @@ batadv_hardif_neigh_create(struct batadv_hard_iface=
 *hard_iface,
>  		goto out;
> =20
>  	kref_get(&hard_iface->refcount);
> +	kref_get(&orig_node->refcount);
>  	INIT_HLIST_NODE(&hardif_neigh->list);
>  	ether_addr_copy(hardif_neigh->addr, neigh_addr);
>  	hardif_neigh->if_incoming =3D hard_iface;
>  	hardif_neigh->last_seen =3D jiffies;
> +	hardif_neigh->orig_node =3D orig_node;

Can you please move the kref_get near the place where new reference is used?


> @@ -634,6 +641,46 @@ static void batadv_send_outstanding_bcast_packet(str=
uct work_struct *work)
[...]
> +		if (ret) {
> +			char *type =3D "unknown";
> +
> +			if (ret =3D=3D BATADV_HARDIF_BCAST_NORECIPIENT)
> +				type =3D "no neighbor";
> +
> +			if (ret =3D=3D BATADV_HARDIF_BCAST_DUPFWD)
> +				type =3D "single neighbor is source";
> +
> +			if (ret =3D=3D BATADV_HARDIF_BCAST_DUPORIG)
> +				type =3D "single neighbor is originator";

what about using "switch (ret)" here?

Kind regards,
	Sven

--nextPart2090576.3BdRfHitFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXkhvZAAoJEF2HCgfBJntGIdQP/A3jdbiFSueNF4txk1Q2LPnC
uA3id8B10GJIQ47yhu12YqGTWOy5fbe3RTqCsLkV3Ft/le5D50RF23//DuYI/MGn
sq42Gq5FCJtHPCCuSUNeZSkbw5DZaasyEQ5PSMvjHACsGnb0FqehTKXbbJByPi5r
enKM1mbn/TkwECvIi6nj6eMisTidQ/tKvwzu4UXZyaC6ro6HuJtMngZHlIgd5v8C
vo52953kw7E+JVfpP5hFsMtgJjbvVHGB9u4lETHpTqIourtbl5Ue8KUyoz7IMfbz
HmuCSx5B04idZLgv8/r3UPJxFNt2z7ajk8NWyY/U6MNrS7cQX9MqoCQQud6jUiMh
WOBehOCLOM2yiwbu29uJpLjXZsFhFQOioM954dckvz62jQRSw+9qi8Kvb29UELAX
3OFiIzyyJ1+iG+6JaeSXZrCTrgwAtBSn0INv3VJwaIx/Ice+Lf6kR91wnvCHX9lK
LFtUE9MD1ZRAz+0MTlRgZFY7VGFb0AuBfWpyPdKvMEVUFgYtUm+GReis92sTX7nq
CCoIj6DBARXJ/v+sxztferzh68vhaHlfHqqrM8C9Rm2TWLW6mDL8NSoQ1j1ZMlST
8sG+I21zOcWOun9q3zVhXEkWf+I+QNE9CpaqZHnHHVN8zjV6JuXwNP2Co70vGFst
pqVUu/EBjBSYM0HyJoMC
=6eLJ
-----END PGP SIGNATURE-----

--nextPart2090576.3BdRfHitFX--

