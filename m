Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 17 Apr 2012 10:19:32 +0200
References: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201204171019.32919.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add get_ethtool_stats()
	support
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

On Tuesday, April 17, 2012 01:24:55 Martin Hundeb=C3=B8ll wrote:
> Added additional counters in a bat_stats structure, which are exported
> through the ethtool api. The counters are specific to batman-adv and
> includes:
>  forwarded packets
>  management packets (OGMs at this point)
>  translation table packets
>  distributed arp table packets

Looks very good! A few questions though:


> @@ -869,6 +875,9 @@ static int route_unicast_packet(struct sk_buff *skb,
> struct hard_iface *recv_if) /* decrement ttl */
>  	unicast_packet->header.ttl--;
>=20
> +	/* Update stats counter */
> +	bat_priv->bat_stats.forward++;

Here we only count the number of packets. Would it be possible to also coun=
t=20
the number of bytes ? Similar to tx_packets and tx_bytes ?
Same for management tx/bytes.


> +struct bat_stats {
> +	uint64_t forward;
> +	uint64_t mgmt_tx;
> +	uint64_t mgmt_rx;
> +	uint64_t tt_request_tx;
> +	uint64_t tt_request_rx;
> +	uint64_t tt_response_tx;
> +	uint64_t tt_response_rx;
> +	uint64_t tt_roam_adv_tx;
> +	uint64_t tt_roam_adv_rx;
> +	uint64_t dat_request_tx;
> +	uint64_t dat_request_rx;
> +	uint64_t dat_reply_tx;
> +	uint64_t dat_reply_rx;
> +};

How do we handle code segments that are not compiled into the module ? We=20
simply leave this counters hanging around at 0 ?

Regards,
Marek
