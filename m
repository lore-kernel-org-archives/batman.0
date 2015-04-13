Return-Path: <hideaki.yoshifuji@miraclelinux.com>
Message-ID: <552B6DA8.10500@miraclelinux.com>
Date: Mon, 13 Apr 2015 16:18:00 +0900
From: =?UTF-8?B?WU9TSElGVUpJIEhpZGVha2kv5ZCJ6Jek6Iux5piO?=
 <hideaki.yoshifuji@miraclelinux.com>
MIME-Version: 1.0
References: <1428687999-18428-1-git-send-email-linus.luessing@c0d3.blue>
 <1428687999-18428-2-git-send-email-linus.luessing@c0d3.blue>
 <20150411014645.GA20155@odroid>
In-Reply-To: <20150411014645.GA20155@odroid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] net: Export IGMP/MLD message
	validation code
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
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@c0d3.blue>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Stephen Hemminger <stephen@networkplumber.org>, Herbert Xu <herbert@gondor.apana.org.au>, Tom Herbert <therbert@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: hideaki.yoshifuji@miraclelinux.com

Linus Lüssing wrote:
> On Fri, Apr 10, 2015 at 07:46:39PM +0200, Linus Lüssing wrote:
>> diff --git a/net/ipv6/mcast_snoop.c b/net/ipv6/mcast_snoop.c
>> new file mode 100644
>> index 0000000..95b34c0
>> --- /dev/null
>> +++ b/net/ipv6/mcast_snoop.c
>> @@ -0,0 +1,198 @@
>> +/* Copyright (C) 2015: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> PS: I'm a little uncertain how this is usually done. If I should
> add someone (maybe Hideaki YOSHIFUJI, the original author of the
> bridge IPv6/MLD support?), then please let me know.

If you want to claim copyright, add myself (2010,
yoshfuji@linux-ipv6.org).  You may have Authors: lines for both.
Also, you could have description like "Based on MLD support by
...".

--yoshfuji
