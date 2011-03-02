Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 2 Mar 2011 18:36:28 +0100
References: <1299086321-25116-1-git-send-email-linus.luessing@ascom.ch>
	<1299086321-25116-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1299086321-25116-2-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Message-Id: <201103021836.28766.lindner_marek@yahoo.de>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/12] batman-adv: Remove unused hdr_size
	variable in route_unicast_packet()
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

On Wednesday 02 March 2011 18:18:30 Linus L=C3=BCssing wrote:
> @@ -1263,8 +1263,7 @@ static int check_unicast_packet(struct sk_buff *skb,
> int hdr_size) return 0;
>  }
> =20
> -int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if,
> -                        int hdr_size)
> +int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
>  {
>         struct bat_priv *bat_priv =3D netdev_priv(recv_if->soft_iface);
>         struct orig_node *orig_node =3D NULL;

Applied in revision 1953.

Thanks,
Marek
