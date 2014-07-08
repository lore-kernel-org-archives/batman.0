Return-Path: <cwang@twopensource.com>
MIME-Version: 1.0
In-Reply-To: <1404704477-19448-2-git-send-email-linus.luessing@web.de>
References: <1404704477-19448-1-git-send-email-linus.luessing@web.de>
 <1404704477-19448-2-git-send-email-linus.luessing@web.de>
Date: Tue, 8 Jul 2014 11:41:59 -0700
Message-ID: <CAHA+R7NjR4yovAskx3yym_wyXCOZRqSd81=+mnF_1wwUfPEn1Q@mail.gmail.com>
From: Cong Wang <cwang@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH net-next 1/2] bridge: adding stubs for
	multicast exports
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
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>

On Sun, Jul 6, 2014 at 8:41 PM, Linus L=C3=BCssing <linus.luessing@web.de> =
wrote:
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index fd22789..e0c575c 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -36,8 +36,22 @@ extern void brioctl_set(int (*ioctl_hook)(struct net *=
, unsigned int, void __use
>
>  typedef int br_should_route_hook_t(struct sk_buff *skb);
>  extern br_should_route_hook_t __rcu *br_should_route_hook;
> +
> +#if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)

Nit: CONFIG_BRIDGE_IGMP_SNOOPING depends CONFIG_BRIDGE,
so you can just check CONFIG_BRIDGE_IGMP_SNOOPING.
