Return-Path: <gfree.wind@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6927862.BQ2m90es0t@sven-edge>
References: <1479740432-3721-1-git-send-email-fgao@ikuai8.com>
 <6927862.BQ2m90es0t@sven-edge>
From: Feng Gao <gfree.wind@gmail.com>
Date: Sat, 17 Dec 2016 10:17:24 +0800
Message-ID: <CA+6hz4qK26dP6vx9sC=nnCQGu5pFcHRg6ow9fXHrZ9bm6WMS-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] [PATCH net-next 1/2] net: batman-adv: Treat
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
To: Sven Eckelmann <sven@narfation.org>
Cc: mareklindner@neomailbox.ch, Linux Kernel Network Developers <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, "David S. Miller" <davem@davemloft.net>

On Fri, Dec 16, 2016 at 5:19 PM, Sven Eckelmann <sven@narfation.org> wrote:
> On Montag, 21. November 2016 23:00:32 CET fgao@ikuai8.com wrote:
>> From: Gao Feng <gfree.wind@gmail.com>
>>
>> The tc could return NET_XMIT_CN as one congestion notification, but
>> it does not mean the packet is lost. Other modules like ipvlan,
>> macvlan, and others treat NET_XMIT_CN as success too.
>>
>> So batman-adv should add the NET_XMIT_CN check.
>>
>> Signed-off-by: Gao Feng <gfree.wind@gmail.com>
>> ---
>>  net/batman-adv/distributed-arp-table.c |  2 +-
>>  net/batman-adv/fragmentation.c         |  2 +-
>>  net/batman-adv/routing.c               | 10 +++++-----
>>  net/batman-adv/soft-interface.c        |  2 +-
>>  net/batman-adv/tp_meter.c              |  2 +-
>>  5 files changed, 9 insertions(+), 9 deletions(-)
>
> David marked your patches as "derefered" after "under review" and did not
> apply them directly. Also Florian Westphal didn't continue the discussion
> about the direction you should choose.
>
> The patches were therefore queued up in the in batman-adv
> 671630d6aad0..eab7617142d2. They will be submitted later(tm) in a pull
> request to David.

I get it. Thanks Sven.

Regards
Feng

>
> Thanks,
>         Sven
