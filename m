Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120725203425.GB11999@pandem0nium>
References: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
 <20120708100956.GA10210@pandem0nium>
 <CAHD-aq+wSvBc56KGJ6RFDMgnP_sir5TXx83EYPw_WWh8=Geqag@mail.gmail.com>
 <20120725203425.GB11999@pandem0nium>
From: Gui Iribarren <gui@altermundi.net>
Date: Sat, 28 Jul 2012 15:34:29 -0300
Message-ID: <CAHD-aqK68-74CHsL4FUhAXdxJcbJjvdJcGEh6z9XQt5zXvvFGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] 2012.2 OGMs over ethernet issue?
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

On Wed, Jul 25, 2012 at 5:34 PM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hey Gui,
>
>> Funny thing is, the only workaround i found for the bug is to
>> *include* the interface in a bridge, and add that bridge to bat0
>> as in:
>> brctl delif br-lan eth0
>> batctl if add eth0
>> # doesn't work
>>
>> brctl delif br-lan eth0
>> brctl addbr blah
>> brctl addif blah eth0
>> batctl if add blah
>> # works fine, OGMs pass through perfectly
>>
>
> OK, so you say that it doesn't work when you simply add eth0 batctl, but it works
> with the bridge?
Exactly.
With a caveat: turns out adding plain eth0 (no vlans involved) works
fine as expected, the problem arises when using vlans.

> What is the minimal setup which is not working, two routers
> and one cable?
I just reproduced it minimally: two routers, one cable, no adhoc, no
bla2, no gw_mode, identical setup in both routers.
enabling bla2 makes no difference.

http://pastebin.com/y1JwMaDM

A=f8:d1:11:54:50:f9
B=f8:d1:11:3b:78:df

"A" batctl td shows incoming OGMs from neighbour "B",
but batctl ll doesn't react.

viceversa for "B".

ping6 works fine over eth0.2 between A and B

adding a simple "option type 'bridge'" on both routers solves the OGM
issue, like so:

config interface 'eth0_2'
	option type 'bridge'
	option ifname 'eth0.2'
	option proto 'none'
	option mtu '1528'

with this, eth0.2 is included in br-eth0_2, and bat0 manages
br-eth0_2... OGMs do come through correctly, and "batctl o" shows
neighbour on both sides.

all in all, workaround is not complicated (in fact a one-liner) but i
find it curious that without the bridge thingy, batctl td catches the
OGMs, yet batman doesn't recognize them.
I haven't tinkered with vlans before, so i might be misunderstanding
how they should work.

>
> I'm sorry but you lost me somewhere, would be nice to get the smallest reproducable
> setup. :)

Sorry for the intrincate descriptions,
HTH!
