Return-Path: <fgao@ikuai8.com>
MIME-Version: 1.0
In-Reply-To: <20161121110915.GB22120@breakpoint.cc>
References: <1479725922-5112-1-git-send-email-fgao@ikuai8.com>
 <20161121110915.GB22120@breakpoint.cc>
From: Gao Feng <fgao@ikuai8.com>
Date: Mon, 21 Nov 2016 21:24:37 +0800
Message-ID: <CA+6hz4rVCL2oxeQUojcqptNfcZdtLZdgEA2_j7iU1-B=s12SHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] [PATCH net v2 1/1] net: batman-adv: Treat
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
To: Florian Westphal <fw@strlen.de>
Cc: mareklindner@neomailbox.ch, Linux Kernel Network Developers <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, "David S. Miller" <davem@davemloft.net>

Hi Florian,

On Mon, Nov 21, 2016 at 7:09 PM, Florian Westphal <fw@strlen.de> wrote:
> fgao@ikuai8.com <fgao@ikuai8.com> wrote:
>> From: Gao Feng <fgao@ikuai8.com>
>>
>> The tc could return NET_XMIT_CN as one congestion notification, but
>> it does not mean the packet is lost. Other modules like ipvlan,
>> macvlan, and others treat NET_XMIT_CN as success too.
>>
>> So batman-adv should add the NET_XMIT_CN check.
>
> "The tc could return NET_XMIT_CN as one congestion notification, but
> it means another packet got dropped. Other modules like batman do not
> treat NET_XMIT_CN as success, so modules like ipvlan, macvlan, ..
> should ignore it as well."
>
> What I am asking is:
> Are you sure adding NET_XMIT_CN handling everywhere is the right way to
> resolve the inconsistency?

Or create one new macro to handle this case like net_xmit_eval.
For example,
#define net_xmit_ok(ret)    (ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)

Is it ok? But it should be done for net-next.

Best Regards
Feng


