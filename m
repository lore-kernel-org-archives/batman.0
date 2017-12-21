Return-Path: <davem@davemloft.net>
Date: Thu, 21 Dec 2017 15:40:13 -0500 (EST)
Message-Id: <20171221.154013.465159930243668403.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171221091742.8020-1-sven.eckelmann@openmesh.com>
References: <20171221091742.8020-1-sven.eckelmann@openmesh.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 0/5] flow_dissector: Provide basic
 batman-adv unicast handling
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven.eckelmann@openmesh.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, tom@herbertland.com, jiri@mellanox.com, linux-kernel@vger.kernel.org, edumazet@google.com

From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 21 Dec 2017 10:17:37 +0100

> we are currently starting to use batman-adv as mesh protocol on multicore
> embedded devices. These usually don't have a lot of CPU power per core but
> are reasonable fast when using multiple cores.
> 
> It was noticed that sending was working very well but receiving was
> basically only using on CPU core per neighbor. The reason for that is
> format of the (normal) incoming packet:
> 
>   +--------------------+
>   | ip(v6)hdr          |
>   +--------------------+
>   | inner ethhdr       |
>   +--------------------+
>   | batadv unicast hdr |
>   +--------------------+
>   | outer ethhdr       |
>   +--------------------+
> 
> The flow dissector will therefore stop after parsing the outer ethernet
> header and will not parse the actual ipv(4|6)/... header of the packet. Our
> assumption was now that it would help us to add minimal support to the flow
> dissector to jump over the batman-adv unicast and inner ethernet header
> (like in gre ETH_P_TEB). The patch was implemented in a slightly hacky
> way [1] and the results looked quite promising.
> 
> I didn't get any feedback how the files should actually be named. So I am
> now just using the names from RFC v3
> 
> The discussion of the RFC v3 can be found in the related patches of
> https://patchwork.ozlabs.org/cover/849345/
> 
> The discussion of the RFC v2 can be found in the related patches of
> https://patchwork.ozlabs.org/cover/844783/

Series applied, thanks!
