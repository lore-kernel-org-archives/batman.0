Return-Path: <gui@altermundi.net>
Message-ID: <51C77678.1040904@altermundi.net>
Date: Sun, 23 Jun 2013 19:28:08 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <51C76DDE.20903@altermundi.net>
In-Reply-To: <51C76DDE.20903@altermundi.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Possible bad interaction between BLA2 and TT?
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

On 06/23/2013 06:51 PM, Gui Iribarren wrote:
> Hey everyone!
> fiiinally got back home, a week ago, and got time to debug a strange
> issue here. The report i had from a few users was "intermittent
> connectivity", with "waves" of traffic, with random pauses lasting from
> a few seconds to a minute or so.
>
> I initially dismissed as interference, or even OS problems, but turns
> out they were right! and sadly, batman seems to be in the way
>
>  From what i've seen, watching "batctl tg -w" on every node along the
> way, i could determine the window of time where the traffic gets lost:
> from the moment when there's a TT change on one side of the network,
> to the moment that change is propagated to the other side.
>
> By ordex's advice, i ran some "batctl ll tt ; batctl l" along the way
> and i'm sending the pastebin results at the end of this mail.
>
> Some (hopefully) useful context follows, and a batctl vd graph is attached
>
> The IPv6 of tdorado is pinged (to rule out DAT interactions) from
> labanda-este (works fine always) and from labanda-oeste (suffers the
> issue, as well as all nodes "behind" it, i.e. casapuente & alfredo).
> both labandas are tl-wdr3500 connected by 2.4ghz, 5ghz, and an ethernet
> cable. The ethernet carries only batadv packets (eth0.1 is added to
> bat0); there's no "lan backbone" (the eth0.2 that appears under br-lan
> is not connected to anything)
>
> root@tdorado:~# opkg list kmod-batman-adv # same in all nodes
> kmod-batman-adv - 3.8.3+2013.2.0-2
> root@tdorado:~# ip a s br-lan
> 6: br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
> state UP
>      link/ether 64:70:02:3d:a0:f7 brd ff:ff:ff:ff:ff:ff
>      inet6 2a00:1508:1:f004:6670:2ff:fe3d:a0f7/64 scope global dynamic
>         valid_lft 6985sec preferred_lft 6985sec
> root@tdorado:~# batctl tl -n |grep f7
>   * 64:70:02:3d:a0:f7 [.....]   1.140
> root@tdorado:~# batctl o |head -n 1
> [B.A.T.M.A.N. adv 2013.2.0, MainIF/MAC: wlan0-1/66:70:02:3d:a0:f9 (bat0)]
>
> labanda-este
> http://pastebin.com/R1kHQCQG
>
> labanda-oeste
> http://pastebin.com/b1Uc23VZ
>
> Both ping6s were started at the same time, so the seq numbers are
> synchronized, and can be used as timestamps.
>
> the "gap" in labanda-oeste is between seq=73 and seq=89
> in labanda-oeste there were no messages or traffic for 25secs, and then
> the "TT inconsistency" came up, resolved, and seq=89 succeded, traffic
> restored.
> at that time, seq=74, labanda-este got a TT update:
> [  23161800] Deleting tdorado from global tt entry 44:d8:84:b0:d2:f5: tt
> removed by changes
> and (AFAIU) dropped traffic coming from labanda-oeste until
> labanda-oeste finally got the TT update and increased the ttvn to 129

To clarify, what i mean is that during the time window that packets from 
labanda-oeste get lost, i see this

root@labanda-este:~# batctl tg |grep tdorado_eth0
  *      tdorado_eth0  (  0) via           tdorado     ( 77)   (0xe574) 
[...]

root@labanda-oeste:~# batctl tg|grep tdorado_eth0
  *      tdorado_eth0  ( 75) via           tdorado     ( 76)   (0x03db) 
[...]

and traffic is restored the instant oeste gets ttvn=77 / crc=0xe574

finally, i must add that running a "batctl ping tdorado" from 
labanda-oeste in parallel shows no loss during the whole scenario.

>
> does any of this make sense? I imagine a tcpdump would help, so i'll try
> getting one, but maybe this debug was enough to get an insight?
>
> As you can imagine, any further pointer will be greatly appreciated,
>
> I hope you're having a great week, ...and that i'm not ruining it as
> always :D
>
> Gui
