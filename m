Return-Path: <gfree.wind@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1807277.5c8tsCoh5a@bentobox>
References: <1479688779-1328-1-git-send-email-fgao@ikuai8.com>
 <1926952.1nDu9mPud9@bentobox>
 <CA+6hz4rZyacN_jg74JLg8EWkno2aJEnwJSTwRaw558uE-zAaxA@mail.gmail.com>
 <1807277.5c8tsCoh5a@bentobox>
From: Feng Gao <gfree.wind@gmail.com>
Date: Mon, 21 Nov 2016 16:47:09 +0800
Message-ID: <CA+6hz4rkhhAvDn7e3QtV=-5OTV97ABAsE2yy8o+RnD5GvpuByA@mail.gmail.com>
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

On Mon, Nov 21, 2016 at 4:31 PM, Sven Eckelmann <sven@narfation.org> wrote:
> On Montag, 21. November 2016 16:21:52 CET Feng Gao wrote:
>> Hi Sven,
>>
>> On Mon, Nov 21, 2016 at 4:16 PM, Sven Eckelmann <sven@narfation.org> wrote:
>> > On Montag, 21. November 2016 08:39:39 CET fgao@ikuai8.com wrote:
>> >> From: Gao Feng <fgao@ikuai8.com>
>> >>
>> >> The tc could return NET_XMIT_CN as one congestion notification, but
>> >> it does not mean the packe is lost. Other modules like ipvlan,
>> >
>> > s/packe/packet/
>>
>> What's this mean?
>
> That there is a minor typo (*t* is missing) and this sed statement (when
> applied only to the commit message) would fix it.

Thanks. I didn't thought it was sed statement.

>
> David already marked this patch as "Under Review" in his patchwork. So I would
> guess that he will accept this patch and not the batman-adv maintainers. And
> maybe he will fix this small typo - or maybe not.
>
> Kind regards,
>         Sven

I would correct the typo in the patch for net-next.

Best Regards
Feng
