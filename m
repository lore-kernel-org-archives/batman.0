Return-Path: <jmh8@nhfn.net>
Date: Sat, 4 Aug 2018 10:39:50 -0400 (EDT)
From: jmh8@nhfn.net
In-Reply-To: <2791173.mX5NbDZpiX@sven-edge>
Message-ID: <alpine.DEB.2.00.1808041038340.8742@nhfn.net>
References: <2791173.mX5NbDZpiX@sven-edge>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [B.A.T.M.A.N.] Paper "Performance Evaluation of BATMAN-adv
 Wireless Mesh Network Routing Algorithms "
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
Cc: ligang.liu@mail.sim.ac.cn, liujp@mail.sim.ac.cn, qianhw@mail.sim.ac.cn, zhuj@mail.sim.ac.cn, kekegai@smart-com.org


Hi All,

    I HATE dealing with ieee.org. Please login. Pay LOTS of money. MAYBE we 
will get around to you eventually.

    I USED to be a member. Waste of $$.

    Bitchingly yours,
    John


On Sat, 4 Aug 2018, Sven Eckelmann wrote:

> Hi,
>
> Just saw your paper "Performance Evaluation of BATMAN-adv Wireless
> Mesh Network Routing Algorithms" [1]. Some small questions:
>
> * What is OpenWrt 1703? (you've referenced a batman-adv config tutorial here
>  and there is no such version as OpenWrt 1703)
> * When did you want to contact the authors of the B.A.T.M.A.N. V
>  implementation in batman-adv about your findings?
> * How did you solve the cfg80211 bug which returns uninitialized (random)
>  data when asked for the expected throughput of a station? Maybe you remember
>  that the expected throughput is *the value* which B.A.T.M.A.N. V needs to
>  calculate routes.
> * What batman-adv version was used?
> * Did you use the openwrt-routing feed (which exact version) for
>  batctl+batman-adv or how did you build it?
> * Did you generate graphs for the chosen best next hop and how it changes
>  over time in comparison to B.A.T.M.A.N. IV?
>
> Kind regards,
> 	Sven
>
> [1] https://ieeexplore.ieee.org/document/8421863/
