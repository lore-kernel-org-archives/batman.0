Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Mar 2011 14:48:37 +0100
References: <1299086321-25116-1-git-send-email-linus.luessing@ascom.ch>
	<1299086321-25116-10-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1299086321-25116-10-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201103031448.38450.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 09/12] batman-adv: Adding redundant
	bonding mode transmission
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

On Wednesday 02 March 2011 18:18:38 Linus L=C3=BCssing wrote:
> diff --git a/main.h b/main.h
> index a0059dd..c6d4848 100644
> --- a/main.h
> +++ b/main.h
> @@ -97,6 +97,11 @@
>   *  Vis
>   */
> =20
> +/* Bonding modes */
> +#define THROUGHPUT_BONDING     1
> +#define REDUNDANT_BONDING      2

Here you go into the right direction but ...


> @@ -347,6 +346,7 @@ void frag_packet_list(struct bat_priv *bat_priv,
> +       bonding_mode =3D atomic_read(&bat_priv->bonding) <<
> +                       atomic_read(&bat_priv->red_bonding);

here you resort to some magic. I believe that can be simplified (see my sys=
fs=20
reply).


> +static int unicast_to_unicast_safe(struct sk_buff *skb,
> +                                  struct bat_priv *bat_priv)
> [..]
> +       unicast_packet_safe->header =3D unicast_packet.header;
> +       memcpy(unicast_packet_safe->dest, unicast_packet.dest, ETH_ALEN);
> +       unicast_packet_safe->header.packet_type =3D BAT_UNICAST_SAFE;

I don't think "unicast_packet_safe->header =3D unicast_packet.header;" does=
 what=20
you want it to do.


> +static void red_bonding_copy(struct sk_buff *skb, struct list_head
> [..]
> +       list_for_each_entry_rcu(neigh_node, bond_list, bonding_list) {
> +               entry =3D kmalloc(sizeof(struct packet_list_entry),
> GFP_ATOMIC);
> +               if (!entry) {
> +                       kfree_skb(skb);
> +                       return;
> +               }
> +               if (!num_entries)
> +                       entry->skb =3D skb;
> +               else {
> +                       entry->skb =3D skb_copy(skb, GFP_ATOMIC);
> +                       if (!entry->skb) {
> +                               kfree_skb(skb);
> +                               kfree(entry);
> +                               return;
> +                       }
> +               }

Yet another malloc() followed by an skb_copy() ? Seems to be unnecessary=20
ballast.=20

Cheers,
Marek

