Return-Path: <xbing6@gmail.com>
References: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
 <1626579.VOjpoqf3Fa@prime> <e7d58eab-dfaf-bd5f-945e-1ebb1cac90af@gmail.com>
 <1558277.kIpDkU8F5M@prime>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <4881e277-7de1-64e3-1e87-9f53a00bd21f@gmail.com>
Date: Sat, 22 Apr 2017 20:49:58 +0800
MIME-Version: 1.0
In-Reply-To: <1558277.kIpDkU8F5M@prime>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Does batman-adv works perfectly?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Simon,

Thank you very much. Sven pointed to me this key cache corruption 
before, but I did not take it because it is a bit complicated. I did 
take deaf and 0xdeadbeef patches. Sven, thank you.

I am doing simple change to use software encryption (int 
ath9k_modparam_nohwcrypt = 1). It seems working ok for my simple test. 
Throughput is down about 2Mbps, which is acceptable. CPU usage is now 
60% (on ar9331) for max throughput scp, it is acceptable for my application.

I will put this software encryption in field test, at least it will show 
if my issue is related to key cache corruption or not.

Thanks again.
Xuebing Wang

On 2017年04月22日 16:35, Simon Wunderlich wrote:
> Hi Xuebing,
>
> actually, ath9k is the most used hardware platform used with batman-adv, at
> least as far as I'm aware. It is used commercially as well on some hundred
> thousand devices. I would assume that it's very hard (or impossible) to find a
> "perfect" running hardware platform and drivers. On other drivers, you will
> have trouble to even get IBSS/11s mode running.
>
> The question is, how do you handle faults - usually, there are workarounds
> applied which happen automatically like the ones we have referenced in this
> thread. They don't happen very often (i.e. less than once a day), and many of
> them can be fixed quite fast (except for the deaf problem, which may take ~30
> seconds to recover).
>
> However, there are also some problems which happen more often in certain
> environments or on certain hardware (maybe due to bad choices in RF design
> ...). There also may be problems in certain driver versions (i.e.
> regressions). And of course, there can be issues which have not yet been
> addressed.
>
> BTW, I've just seen that you use psk2-ccmp. There is a known problem with key
> cache corruption. I'm not sure if it was already solved and merged in Chaos
> Calmer [1]. You may want to try if the problem appears without encryption.
>
> Cheers,
>        Simon
>
> [1] https://patchwork.kernel.org/patch/9381651/
>
> On Saturday, April 22, 2017 3:12:54 PM CEST Xuebing Wang wrote:
>> Hi Simon / Sven,
>>
>> Do you know any hardware platform on which batman-adv (or batmand) work
>> perfectly and field-proven? Thanks.
>>
>> Xuebing Wang
>>
>> On 2017年04月06日 15:04, Simon Wunderlich wrote:
>>> Hello Xuebing,
>>>
>>> it sounds like you have WiFi driver issues. There are some effects like
>>> key
>>> cache corruption, deafness, and other effects known for the AR93xx series.
>>> To confirm, you can try to use IPv6 link local ping (ping6
>>> fe80:...%wlan0) to your neighbors. If you can ping but batman can't (e.g.
>>> use batctl) it's a batman issue. If both pings don't get through, it's
>>> most likely a WiFi driver issue. In this case, a master or something
>>> doesn't help. :)
>>>
>>> Cheers,
>>>
>>>        Simon
>>>
>>> On Thursday, April 6, 2017 10:32:29 AM CEST Xuebing Wang wrote:
>>>> Hi community,
>>>>
>>>> We have batman-adv working on OpenWRT Chaos Calmer.
>>>> - Atheros ar9331 MIPS platform + built-in ath9k WiFi
>>>> - batman-adv version 2016.1
>>>> - routing_algos = BATMAN_IV
>>>> - Wireless interface MTU = 1532, adhoc network encryption "psk2-ccmp"
>>>> - bat0 interface MTU = 1500
>>>>
>>>> We have batman-adv running on 10+ sites. For each site, there are 10-20
>>>> nodes in the mesh network.
>>>>
>>>> batman-adv runs almost perfectly (*almost*). Occasionally (occurrence
>>>> rate is low), node drops off the batman-adv / adhoc mesh.
>>>> - Sometimes, node can recover (re-joins the mesh network automatically),
>>>> but not always.
>>>>
>>>> Any suggestions? Does batman-adv works perfectly in the field (i.e.
>>>> running for 1 year with 100+ nodes without any issues)?
>>>>
>>>> What about I use one node as Master, and other nodes ping this Master
>>>> every 10s (or 30 seconds) (to keep mesh from inactivity)? Does this help?
>>>>
>>>> Thanks.
>>>> Xuebing Wang

