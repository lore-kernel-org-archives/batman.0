Return-Path: <sergei.shtylyov@cogentembedded.com>
References: <1479688779-1328-1-git-send-email-fgao@ikuai8.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <850ff61e-8f94-9316-ed1f-c7d3e8faf95b@cogentembedded.com>
Date: Mon, 21 Nov 2016 13:44:47 +0300
MIME-Version: 1.0
In-Reply-To: <1479688779-1328-1-git-send-email-fgao@ikuai8.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH net 1/1] net: batman-adv: Treat
 NET_XMIT_CN as transmit successfully
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: fgao@ikuai8.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, gfree.wind@gmail.com

Hello.

On 11/21/2016 3:39 AM, fgao@ikuai8.com wrote:

> From: Gao Feng <fgao@ikuai8.com>
>
> The tc could return NET_XMIT_CN as one congestion notification, but
> it does not mean the packe is lost. Other modules like ipvlan,

    Packet.

> macvlan, and others treat NET_XMIT_CN as success too.
>
> So batman-adv should add the NET_XMIT_CN check.
>
> Signed-off-by: Gao Feng <fgao@ikuai8.com>

[...]

> diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> index 7e8dc64..8edd324 100644
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -706,7 +706,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
>  		goto out;
>
>  	/* translate transmit result into receive result */
> -	if (res == NET_XMIT_SUCCESS) {
> +	if (res == NET_XMIT_SUCCESS || ret == NET_XMIT_CN) {

    Not 'res == NET_XMIT_CN'?

>  		/* skb was transmitted and consumed */
>  		batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
>  		batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
[...]

MBR, Sergei

