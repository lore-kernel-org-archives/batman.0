Return-Path: <gfree.wind@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1926952.1nDu9mPud9@bentobox>
References: <1479688779-1328-1-git-send-email-fgao@ikuai8.com>
 <1926952.1nDu9mPud9@bentobox>
From: Feng Gao <gfree.wind@gmail.com>
Date: Mon, 21 Nov 2016 16:21:52 +0800
Message-ID: <CA+6hz4rZyacN_jg74JLg8EWkno2aJEnwJSTwRaw558uE-zAaxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Sven Eckelmann <sven@narfation.org>
Cc: mareklindner@neomailbox.ch, Linux Kernel Network Developers <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, "David S. Miller" <davem@davemloft.net>

Hi Sven,

On Mon, Nov 21, 2016 at 4:16 PM, Sven Eckelmann <sven@narfation.org> wrote:
> On Montag, 21. November 2016 08:39:39 CET fgao@ikuai8.com wrote:
>> From: Gao Feng <fgao@ikuai8.com>
>>
>> The tc could return NET_XMIT_CN as one congestion notification, but
>> it does not mean the packe is lost. Other modules like ipvlan,
>
> s/packe/packet/

What's this mean?

>
>> macvlan, and others treat NET_XMIT_CN as success too.
>>
>> So batman-adv should add the NET_XMIT_CN check.
>>
>> Signed-off-by: Gao Feng <fgao@ikuai8.com>
>> ---
>>  net/batman-adv/distributed-arp-table.c | 2 +-
>>  net/batman-adv/fragmentation.c         | 2 +-
>>  net/batman-adv/routing.c               | 2 +-
>>  net/batman-adv/tp_meter.c              | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
> [...]
>
> Not sure how the batman-adv maintainers see this - but this patch needs
> an additional patch for net-next to also add it to the parts which were
> rewritten.
>
> Kind regards,
>         Sven

Ok. I would commit another patch to net-next.

Best Regards
Feng
