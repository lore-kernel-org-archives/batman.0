Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 Dec 2010 14:59:34 +0100
References: <1292320696-11983-6-git-send-email-linus.luessing@ascom.ch>
	<1292432969-7313-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1292432969-7313-2-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201012281459.34952.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 05/10] batman-adv: Creating neighbor
	structures, updating LQs
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?utf-8?q?L=C3=BCssing?= <linus.luessing@ascom.ch>

On Wednesday 15 December 2010 18:09:29 Linus L=C3=BCssing wrote:
> It will now be checked if a neighbor discovery packet from a new
> neighbor on a certain interface has been received. If so,
> structures in memory will be allocated for further seqno-tracking
> and RQ calculations, and TQ reception, which will be updated
> frequently from this commit on.

Checkpatch found 8 errors - please make all your patches "checkpatch clean".
I also noticed that the new ndp files ndp.c / ndp.h lack a proper licence=20
header.


> @@ -1,6 +1,8 @@
>  #include "main.h"
>  #include "send.h"
>  #include "ndp.h"
> +#include "soft-interface.h"

This include is not necessary as far as I can tell.


> +int ndp_update_neighbor(uint8_t my_tq, uint32_t seqno,
> +			struct batman_if *batman_if, uint8_t *neigh_addr)
> +{
> +	struct bat_priv *bat_priv =3D netdev_priv(batman_if->soft_iface);
> +	struct neigh_node *neigh_node =3D NULL, *tmp_neigh_node =3D NULL;
> +	int ret =3D 1;
> +
> +	spin_lock_bh(&batman_if->neigh_list_lock);
> +	// old neighbor?
> +	list_for_each_entry(tmp_neigh_node, &batman_if->neigh_list, list) {
> +		if (!compare_orig(tmp_neigh_node->addr, neigh_addr))
> +			continue;
> +
> +		neigh_node =3D tmp_neigh_node;

A "break" could be added here.


> +	}
> +
> +	// new neighbor?
> +	if (!neigh_node) {
> +		neigh_node =3D ndp_create_neighbor(my_tq, seqno, neigh_addr,
> +						 bat_priv);
> +		if (!neigh_node)
> +			goto ret;
> +
> +		list_add_tail(&neigh_node->list, &batman_if->neigh_list);
> +	}
> +
> +	ndp_update_neighbor_lq(my_tq, seqno, neigh_node, bat_priv);
> +
> +	ret =3D 0;
> +
> +ret:
> +	spin_unlock_bh(&batman_if->neigh_list_lock);
> +	return ret;
> +}

Instead of holding a spinlock all the time to protect a single neigh_node=20
pointer you should protect the NDP neighbor list with RCU locks and the=20
pointers with refcounting.


> +	ret =3D ndp_update_neighbor(my_tq, ntohl(packet->seqno),
> +					batman_if, ethhdr->h_source);
> +	if (ret)
> +		return NET_RX_DROP;
> +
> +	kfree_skb(skb);
> +	return NET_RX_SUCCESS;

Why not simply returning NET_RX_DROP ?


> +	struct list_head neigh_list;
> +	spinlock_t neigh_list_lock;

We already have a neigh_list and a neigh_list_lock. Either the old one gets=
=20
removed or we should pick another name to avoid confusion.


> +	TYPE_OF_WORD rq_real_bits[NUM_WORDS];

rq_real_bits is not a very good name. I know, the current OGM code uses the=
=20
same bad name but I believe we can safely break with the tradition here. Ho=
w=20
about something more descriptive like "rq_ndp_window"  ?

Cheers,
Marek
