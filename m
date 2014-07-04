Return-Path: <locborgtus@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53B3A519.6000400@meshcoding.com>
References: <CAHxBzxWTprWsPASmNNGXQqj58LRuAHUkNVtXcWHc1PdoD_4+KA@mail.gmail.com>
 <20140701085027.GA2341@Linus-Debian>
 <53B29AFF.2070405@meshcoding.com>
 <CAHxBzxW7PCytsQKk-RyuaXVkAz4oqEJGvJE-HFBh=sn56UQP-g@mail.gmail.com>
 <53B39F7D.6050001@meshcoding.com> <53B3A519.6000400@meshcoding.com>
Date: Fri, 4 Jul 2014 00:36:09 -0700
Message-ID: <CAHxBzxU-Ly7f3avbANrDw-WJ3dxh4TdW78f1qX+zmpoTg0wu3g@mail.gmail.com>
From: Simon Wong <locborgtus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Roaming issues in basic network
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

Antonio,

I haven't tried monitoring for deauths yet, but I have tried another
device for the AP interface (a USB stick using ath9k_htc, on wlan2). I
am able to repeat the same inter-AP roaming problem.

I was thinking this could have been a problem with the ath5k drivers,
but that seems less likely.

Another observation:
Let's say I'm roaming client 2 is attached to node A. I am monitoring
client 2 on node A via `iw wlan1 station dump`. If I turned off client
2 WiFi or switched SSID, client 2 disappears from the station list as
expected - a deauth probably got sent. I am guessing roaming might not
trigger a deauth on the client. In any case, we can't count on deauth
being received anyways.

Hypothesis:
It seems as if the wireless driver/hardware has an internal forwarding
rule. If the AP interface thinks it's got the client, it'll forward
data internally to it and batman never sees the data and thus can't
route it. But since the roam happened and another node has picked up
the roaming client, translation tables updates are still triggered and
states are still synchronized.

What do you think?

Thanks,
- Simon


On Tue, Jul 1, 2014 at 11:22 PM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
>
>
> On 02/07/14 07:58, Antonio Quartulli wrote:
>> Simon,
>>
>> On 02/07/14 03:24, Simon Wong wrote:
>>>
>>> - Even more strange with 'iw station get' during the problem:
>>> interacting with the Telnet connection from Client 2 to Node A will
>>> also reset the inactive time count for Client 2, and this is while
>>> Client 2 is roamed to node B. On node A, only the tx {bytes, packets}
>>> counters will increase. rx counts do not. On node B, the tx/rx counts
>>> increase as expected.
>>
>>
>> very stupid question: but the two nodes have different MAC addresses for
>> wlan1, right ?
>
> ehm, here I meant wlan0 (the AP interface where client connect to).
>
> --
> Antonio Quartulli
>
