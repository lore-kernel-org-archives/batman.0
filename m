Return-Path: <keinepostnurmuell@gmail.com>
MIME-Version: 1.0
In-Reply-To: <3922831.NrCxltvcVr@sven-edge>
References: <CAKrZ8yfKQi8qBzmC7BrEA6Sfug9JB4hb5q_M6p20Ay-V35-F4A@mail.gmail.com>
 <1911165.iLNu9IsRoq@sven-edge>
 <CAKrZ8yffDYcr6UCw2Yv7hqUFEBNZQ+nTU09dovL=PO3+Zqy7ig@mail.gmail.com>
 <3922831.NrCxltvcVr@sven-edge>
Date: Mon, 21 Dec 2015 16:35:09 +0100
Message-ID: <CAKrZ8yeAuYRFvFxgXWALZKGmqRo7qC8hEnt2YSMEW7n3m7_NMw@mail.gmail.com>
From: no name <keinepostnurmuell@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Super high package loss and weak connection
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello
I continued with testing:
Raspberry Pi b+ with a LOGILINK WL0084B USB Stick on Jessie with
Kernel 4.1.13+, batman2015-0

I tested:

Batman + Ad-Hoc
Batman + 802.11s
only 802.11s

against each other. This lead to the following results:

All of the above configurations show basically the same behaviour:
When pinging, the reply times from directly connected nodes are really
stable (1-4ms, depends on the range).
When pinging via one hop in between, the network seems to take some
breaks. A burst of pings (5-10) are replied pretty accurate, but
always followed by a really long break of about 2-3 seconds

The problem is less intense when using the batman configurations
(->actually does rout better (: ).

Facing this results I think I might be staring at a driver's issue,
but still wanted to see if anyone here can help me with ideas.

Thanks everyone for the time and help!

Richard

On 18 December 2015 at 18:30, Sven Eckelmann <sven@narfation.org> wrote:
> On Friday 18 December 2015 18:22:40 no name wrote:
>> I made a little table were I tried wheezy against jessy and 802.11 as
>> someone suggested earlier in the mailing list to me. I placed the
>> raspberries next to each other on my table and tested through different
>> settings:
>>
>> ad-hoc+batman-2014.X@debian wheezy:          1m distance  .. 200 pings, 0%
>> paket loss, reply time -> (min,avg,max,mdev 1.2ms, 1.8ms, 6.4ms, 0.8ms)
>> ad-hoc+batman-2015.2@debian jessie:             1m distance  .. 200 pings,
>> 6% paket loss, reply time -> (min,avg,max,mdev 1.1ms, 170ms, 1400ms, 370ms)
>> 802.11s @debian jessie:                                  1m distance  ..
>> 200 pings, 0% paket loss, reply time -> (min,avg,max,mdev 1.05ms, 1.8ms,
>> 14ms, 1.5ms)
>
> Your "table" is incomplete. adhoc without batman-adv and meshpoint (802.11s
> without fwding+ttl=1)+batman-adv are missing. You also mixed two different
> batman-adv versions. Either you use the same batman-adv version everywhere or
> make sure that the kernel+wifi driver doesn't change. Changing multiple
> variables between two tests tests make the results more or less useless for
> comparisons.
>
> Kind regards,
>         Sven
