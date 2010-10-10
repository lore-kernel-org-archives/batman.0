Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Oct 2010 14:49:51 +0200
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
	<1286685001-15227-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286685001-15227-3-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010101449.52124.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Make hop_penalty
	configurable via sysfs
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

On Sunday 10 October 2010 06:29:59 Linus L=C3=BCssing wrote:
> When having a mixed topology of both very mobile and rather static
> nodes, you are usually best advised to set the originator interval on
> all nodes to a level best suited for the most mobile node.
>=20
> However, if most of the nodes are rather static, this can create a lot
> of undesired overhead as a trade-off then. If setting the interval too
> low on the static nodes, a mobile node might be chosen as a router for
> too long, not switching away from it fast enough because of its
> mobility and the low frequency of ogms of static nodes.

Any good reason for all these "originator interval" explanations here ?


> @@ -592,6 +592,7 @@ struct net_device *softif_create(char *name)
>  	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
>  	atomic_set(&bat_priv->gw_class, 0);
>  	atomic_set(&bat_priv->orig_interval, 1000);
> +	atomic_set(&bat_priv->hop_penalty, 30);

Either you initialize the value with TQ_HOP_PENALTY or you remove the defin=
e=20
from the main.h file.

Regards,
Marek
