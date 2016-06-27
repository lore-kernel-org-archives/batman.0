Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 27 Jun 2016 05:55:45 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160627035545.GO4407@otheros>
References: <1466982121-3504-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1466982121-3504-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Remove orig_node
 reference handling from send_skb_unicast
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

On Mon, Jun 27, 2016 at 01:02:01AM +0200, Sven Eckelmann wrote:
> The function batadv_send_skb_unicast is not acquiring a reference for an
> orig_node nor removing it from any datastructure. It still reduces the
> reference counter for an object which is still in the hands of the caller.
> 
> This is confusing and can lead to problems in the reference handling in the
> caller function.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

I like it, indeed easier to read, especially for the multicast
part.

Maybe make it a "This is confusing and could lead to ... in the future." to
avoid people misreading it as a fix?


> diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
> index 729deec..44be408 100644
> --- a/net/batman-adv/send.c
> +++ b/net/batman-adv/send.c
> @@ -362,8 +362,6 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,

The kernel doc of batadv_send_skb_unicast seems to need an update,
too ("s/ and release a reference to this orig_node//").
