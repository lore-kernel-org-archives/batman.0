Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 2 Feb 2011 20:49:17 +0100
References: <1296352379-1546-2-git-send-email-sven@narfation.org>
	<1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201102022049.18069.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Re: batman-adv: Correct rcu refcounting
	for gw_node
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

On Wednesday 02 February 2011 18:37:18 Linus L=C3=BCssing wrote:
> So after some more discussions with Marek and Sven, it looks like we
> have to use the rcu protected macros rcu_dereference() and
> rcu_assign_pointer() for the bat_priv->curr_gw and curr_gw->orig_node.
>=20
> Changes here also include moving the kref_get() from unicast_send_skb()
> into gw_get_selected(). The orig_node could have been freed already at
> the time the kref_get() was called in unicast_send_skb().

I'd suggest you make a standalone patch because the patches address differe=
nt=20
problems.

Thanks,
Marek
