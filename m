Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 17 Jul 2012 12:47:04 +0200
References: <1341782658-10978-1-git-send-email-martin@hundeboll.net>
 <1341784829-31559-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1341784829-31559-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201207171247.05177.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Add wrapper to look up
	neighbor and send skb
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

On Monday, July 09, 2012 00:00:29 Martin Hundeb=C3=B8ll wrote:
> +bool batadv_send_skb_to_orig(struct batadv_orig_node *orig_node,
> +                            struct sk_buff *skb,
> +                            struct batadv_hard_iface *recv_if)
> +{
> +       struct batadv_priv *bat_priv =3D orig_node->bat_priv;
> +       struct batadv_neigh_node *neigh_node;
> +
> +       /* batadv_find_router() increases neigh_nodes refcount if found. =
*/
> +       neigh_node =3D batadv_find_router(bat_priv, orig_node, recv_if);
> +       if (!neigh_node)
> +               return false;
> +
> +       /* route it */
> +       batadv_send_skb_packet(skb, neigh_node->if_incoming,
> neigh_node->addr); +
> +       batadv_neigh_node_free_ref(neigh_node);
> +
> +       return true;
> +}

Can we make the skb variable the first argument ? Something like this:

bool batadv_send_skb_to_orig(struct sk_buff *skb,
                             struct batadv_orig_node *orig_node,
                             struct batadv_hard_iface *recv_if)

Regards,
Marek
