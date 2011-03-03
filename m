Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Mar 2011 14:17:28 +0100
References: <1299086321-25116-1-git-send-email-linus.luessing@ascom.ch>
	<1299086321-25116-8-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1299086321-25116-8-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201103031417.28906.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/12] batman-adv: Use packet lists for
	unicast packet sending
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

On Wednesday 02 March 2011 18:18:36 Linus L=C3=BCssing wrote:
> +       entry =3D kmalloc(sizeof(struct packet_list_entry), GFP_ATOMIC);
> +       if (!entry) {
> +               kfree_skb(skb);
> +               return;
> +       }
> +
> +       entry->skb =3D skb;
> +       entry->neigh_node =3D router;
> +       hlist_add_head(&entry->list, packet_list);

In the past weeks we worked very hard to reduce the batman-adv overhead to =
a=20
bare minimum (see the hash restructuring patches and the orig_hash spinlock=
=20
removal) and now you want to add a malloc() for each forwarded packet ??
Can't we find a less bloated way to achieve the same thing ?

Regards,
Marek
