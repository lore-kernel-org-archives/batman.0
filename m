Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 22 Dec 2010 14:43:14 +0100
References: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
	<1292320696-11983-5-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1292320696-11983-5-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201012221443.15238.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: Send neighbor
	discovery packets
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

On Tuesday 14 December 2010 10:58:10 Linus L=C3=BCssing wrote:
> @@ -331,7 +332,9 @@ int hardif_enable_interface(struct batman_if
> *batman_if, char *iface_name)
>=20
>  	atomic_set(&batman_if->seqno, 1);
>  	atomic_set(&batman_if->frag_seqno, 1);
> -	ndp_init(batman_if);
> +	ret =3D ndp_init(batman_if);
> +	if (ret)
> +		goto err;

This introduces a potential memory leak, next to other problems. If the cod=
e=20
jumps to "err" batman_if->packet_buff is not free()'d, bat_priv->num_ifaces=
 is=20
wrong, the orig_hash has one interface too much, etc. Please check the erro=
r=20
handling here and make sure that there is a clean rollback.


> +	skb =3D skb_clone(batman_if->ndp_skb, GFP_ATOMIC);
> +	ndp_packet =3D (struct batman_packet_ndp*)skb->data;
> +	ndp_packet->seqno =3D htonl(atomic_read(&batman_if->ndp_seqno));
> +	ndp_packet->num_neighbors =3D 0;
> +	memcpy(ndp_packet->orig, bat_priv->primary_if->net_dev->dev_addr,
> +	       ETH_ALEN);

I don't think you want to use skb_clone() here as it "only" copies the sk_b=
uff=20
and not skb->data. That means all threads write on the same skb->data ...


> +struct neigh_entry {
> +	uint8_t addr[ETH_ALEN];
> +	uint8_t rq;
> +};

Again, this struct is not used and can be added later.

Checkpatch gives 2 errors ..


Cheers,
Marek
