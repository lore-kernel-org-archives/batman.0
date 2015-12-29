Return-Path: <keinepostnurmuell@gmail.com>
MIME-Version: 1.0
Date: Tue, 29 Dec 2015 13:42:55 +0100
Message-ID: <CAKrZ8yfc5ok4v-p=5k4YgkNb+ceYRLaSxqNt8wchH3YeeavPng@mail.gmail.com>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I once again tried some settings and I want to use this message as a
bump. I am close to certain, that the RT5370 (rt2800usb) drivers are
to blame, but I hope some of you guys have some input for me:

Here is the output from batctl td -x 1 bat0 when my client is being
pinged with a hop node in between:

21:24:36.769860 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 5, length 64
21:24:36.770399 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 5, length 64
21:24:37.266371 IP 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP,
Request from b2:d5:c7:9e:49:96, length 331
21:24:37.461997 IP6 fe80::c489:38ff:fe52:b84b >
fe80::b0d5:c7ff:fe9e:4996 ICMP6 neighbor solicitation, who has
fe80::b0d5:c7ff:fe9e:4996, length 72
21:24:37.465750 IP6 fe80::b0d5:c7ff:fe9e:4996 >
fe80::c489:38ff:fe52:b84b ICMP6 neighbor advertisement, tgt is
fe80::b0d5:c7ff:fe9e:4996, length 64
21:24:37.769275 ARP, Request who-has 192.168.2.213 tell 192.168.2.1
(b2:d5:c7:9e:49:96), length 28
21:24:37.769834 ARP, Reply 192.168.2.213 is-at c6:89:38:52:b8:4b, length 28
21:24:37.770174 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 6, length 64
21:24:37.770398 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 6, length 64
21:24:38.770444 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 7, length 64
21:24:38.770959 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 7, length 64
21:24:39.772064 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 8, length 64
21:24:39.772547 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 8, length 64
21:24:40.774724 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 9, length 64
21:24:40.775103 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 9, length 64
21:24:41.778532 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 10, length 64
21:24:41.778937 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 10, length 64
21:24:42.205531 IP6 fe80::1cbf:71ff:fe42:cc98 > ff02::1:ff9e:4996
ICMP6 neighbor solicitation, who has fe80::b0d5:c7ff:fe9e:4996, length
72
21:24:42.287275 IP6 fe80::b0d5:c7ff:fe9e:4996.16962 > ff02::1.16962:
UDP, length 4
21:24:42.456688 IP6 fe80::c489:38ff:fe52:b84b.16962 >
fe80::b0d5:c7ff:fe9e:4996.16962: UDP, length 64
21:24:42.457072 IP6 fe80::c489:38ff:fe52:b84b.16962 >
fe80::b0d5:c7ff:fe9e:4996.16962: UDP, length 8
21:24:42.771977 ARP, Request who-has 192.168.2.1 tell 192.168.2.213
(c6:89:38:52:b8:4b), length 28
21:24:43.771977 ARP, Request who-has 192.168.2.1 tell 192.168.2.213
(c6:89:38:52:b8:4b), length 28
21:24:43.779838 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 12, length 64
21:24:43.780191 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 12, length 64
21:24:44.771969 ARP, Request who-has 192.168.2.1 tell 192.168.2.213
(c6:89:38:52:b8:4b), length 28
21:24:48.319048 IP 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP,
Request from c6:89:38:52:b8:4b, length 332
21:24:51.165017 ARP, Request who-has 192.168.2.1 tell 192.168.2.212
(1e:bf:71:42:cc:98), length 28
21:24:52.165044 ARP, Request who-has 192.168.2.1 tell 192.168.2.212
(1e:bf:71:42:cc:98), length 28
21:24:52.212253 IP6 fe80::b0d5:c7ff:fe9e:4996.16962 > ff02::1.16962:
UDP, length 4
21:24:52.456960 IP6 fe80::c489:38ff:fe52:b84b.16962 >
fe80::b0d5:c7ff:fe9e:4996.16962: UDP, length 64
21:24:52.457448 IP6 fe80::c489:38ff:fe52:b84b.16962 >
fe80::b0d5:c7ff:fe9e:4996.16962: UDP, length 8
21:24:55.421775 ARP, Request who-has 192.168.2.1 tell 192.168.2.213
(c6:89:38:52:b8:4b), length 28
21:24:55.445452 ARP, Reply 192.168.2.1 is-at b2:d5:c7:9e:49:96, length 28
21:24:55.446159 IP 192.168.2.213.44353 > 79.140.41.209.1883: TCP,
Flags [...PA.], length 2
21:24:55.780191 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 24, length 64
21:24:55.780571 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 24, length 64
21:24:56.783649 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 25, length 64
21:24:56.784025 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 25, length 64
21:24:57.788219 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 26, length 64
21:24:57.788734 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 26, length 64
21:24:58.788459 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 27, length 64
21:24:58.788969 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 27, length 64
21:24:59.788102 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
1326, seq 28, length 64
21:24:59.788613 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
1326, seq 28, length 64

As you can see, I get a lot of ARP requests, indicating, that my
clients are loosing the connection farily often, resulting exactly in
the observed behavior. I really would appreciate some help, or even a
hinch in some direction what could lead further ...

Has ever someone tried to use 20+ raspberries in a meshed network as
nodes and hops?

Thanks
Richard

On 28 December 2015 at 23:43, no name <keinepostnurmuell@gmail.com> wrote:
> I once again tried some settings and I want to use this message as a
> bump. I am close to certain, that the RT5370 (rt2800usb) drivers are
> to blame, but I hope some of you guys have some input for me:
>
> Here is the output from batctl td -x 1 bat0 when my client is being
> pinged with a hop node in between:
>
> 21:24:36.769860 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 5, length 64
> 21:24:36.770399 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 5, length 64
> 21:24:37.266371 IP 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP,
> Request from b2:d5:c7:9e:49:96, length 331
> 21:24:37.461997 IP6 fe80::c489:38ff:fe52:b84b >
> fe80::b0d5:c7ff:fe9e:4996 ICMP6 neighbor solicitation, who has
> fe80::b0d5:c7ff:fe9e:4996, length 72
> 21:24:37.465750 IP6 fe80::b0d5:c7ff:fe9e:4996 >
> fe80::c489:38ff:fe52:b84b ICMP6 neighbor advertisement, tgt is
> fe80::b0d5:c7ff:fe9e:4996, length 64
> 21:24:37.769275 ARP, Request who-has 192.168.2.213 tell 192.168.2.1
> (b2:d5:c7:9e:49:96), length 28
> 21:24:37.769834 ARP, Reply 192.168.2.213 is-at c6:89:38:52:b8:4b, length 28
> 21:24:37.770174 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 6, length 64
> 21:24:37.770398 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 6, length 64
> 21:24:38.770444 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 7, length 64
> 21:24:38.770959 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 7, length 64
> 21:24:39.772064 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 8, length 64
> 21:24:39.772547 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 8, length 64
> 21:24:40.774724 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 9, length 64
> 21:24:40.775103 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 9, length 64
> 21:24:41.778532 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 10, length 64
> 21:24:41.778937 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 10, length 64
> 21:24:42.205531 IP6 fe80::1cbf:71ff:fe42:cc98 > ff02::1:ff9e:4996
> ICMP6 neighbor solicitation, who has fe80::b0d5:c7ff:fe9e:4996, length
> 72
> 21:24:42.287275 IP6 fe80::b0d5:c7ff:fe9e:4996.16962 > ff02::1.16962:
> UDP, length 4
> 21:24:42.456688 IP6 fe80::c489:38ff:fe52:b84b.16962 >
> fe80::b0d5:c7ff:fe9e:4996.16962: UDP, length 64
> 21:24:42.457072 IP6 fe80::c489:38ff:fe52:b84b.16962 >
> fe80::b0d5:c7ff:fe9e:4996.16962: UDP, length 8
> 21:24:42.771977 ARP, Request who-has 192.168.2.1 tell 192.168.2.213
> (c6:89:38:52:b8:4b), length 28
> 21:24:43.771977 ARP, Request who-has 192.168.2.1 tell 192.168.2.213
> (c6:89:38:52:b8:4b), length 28
> 21:24:43.779838 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 12, length 64
> 21:24:43.780191 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 12, length 64
> 21:24:44.771969 ARP, Request who-has 192.168.2.1 tell 192.168.2.213
> (c6:89:38:52:b8:4b), length 28
> 21:24:48.319048 IP 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP,
> Request from c6:89:38:52:b8:4b, length 332
> 21:24:51.165017 ARP, Request who-has 192.168.2.1 tell 192.168.2.212
> (1e:bf:71:42:cc:98), length 28
> 21:24:52.165044 ARP, Request who-has 192.168.2.1 tell 192.168.2.212
> (1e:bf:71:42:cc:98), length 28
> 21:24:52.212253 IP6 fe80::b0d5:c7ff:fe9e:4996.16962 > ff02::1.16962:
> UDP, length 4
> 21:24:52.456960 IP6 fe80::c489:38ff:fe52:b84b.16962 >
> fe80::b0d5:c7ff:fe9e:4996.16962: UDP, length 64
> 21:24:52.457448 IP6 fe80::c489:38ff:fe52:b84b.16962 >
> fe80::b0d5:c7ff:fe9e:4996.16962: UDP, length 8
> 21:24:55.421775 ARP, Request who-has 192.168.2.1 tell 192.168.2.213
> (c6:89:38:52:b8:4b), length 28
> 21:24:55.445452 ARP, Reply 192.168.2.1 is-at b2:d5:c7:9e:49:96, length 28
> 21:24:55.446159 IP 192.168.2.213.44353 > 79.140.41.209.1883: TCP,
> Flags [...PA.], length 2
> 21:24:55.780191 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 24, length 64
> 21:24:55.780571 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 24, length 64
> 21:24:56.783649 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 25, length 64
> 21:24:56.784025 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 25, length 64
> 21:24:57.788219 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 26, length 64
> 21:24:57.788734 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 26, length 64
> 21:24:58.788459 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 27, length 64
> 21:24:58.788969 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 27, length 64
> 21:24:59.788102 IP 192.168.2.1 > 192.168.2.213: ICMP echo request, id
> 1326, seq 28, length 64
> 21:24:59.788613 IP 192.168.2.213 > 192.168.2.1: ICMP echo reply, id
> 1326, seq 28, length 64
>
> As you can see, I get a lot of ARP requests, indicating, that my
> clients are loosing the connection farily often, resulting exactly in
> the observed behavior. I really would appreciate some help, or even a
> hinch in some direction what could lead further ...
>
> Has ever someone tried to use 20+ raspberries in a meshed network as
> nodes and hops?
>
> Thanks
> Richard
>
> On 21 December 2015 at 16:32,  <b.a.t.m.a.n-owner@lists.open-mesh.org> wrote:
>> Message rejected by filter rule match
>>
>>
>>
>> ---------- Forwarded message ----------
>> From: no name <keinepostnurmuell@gmail.com>
>> To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
>> Cc:
>> Date: Mon, 21 Dec 2015 16:32:36 +0100
>> Subject: Re: [B.A.T.M.A.N.] Super high package loss and weak connection
>> Right now I am working on a new set of measurements with the basis as follows:
>>
>> Raspberry Pi b+ with a LOGILINK WL0084B USB Stick on Jessie with Kernel 4.1.13+, batman2015-0
>>
>> I tested:
>>
>> Batman + Ad-Hoc
>> Batman + 802.11s
>> only 802.11s
>>
>> against each other. This lead to the following results:
>>
>> All of the above configurations show basically the same behaviour:
>> When pinging, the reply times from directly connected nodes are really stable (1-4ms, depends on the range).
>> When pinging via one hop in between, the network seems to take some breaks. A burst of pings (5-10) are replied pretty accurate, but always followed by a really long break of about 2-3 seconds
>>
>> The problem is less intense when using the batman configurations (->actually does rout better (: ).
>>
>> Facing this results I think I might be staring at a driver's issue, but still wanted to see if anyone here can help me with ideas.
>>
>> Thanks everyone for the time and help!
>>
>> Richard
>>
>>
>>> ---------- Forwarded message ----------
>>> From: Sven Eckelmann <sven@narfation.org>
>>> Date: 18 December 2015 at 18:30
>>> Subject: Re: [B.A.T.M.A.N.] Super high package loss and weak connection
>>> To: no name <keinepostnurmuell@gmail.com>
>>> Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
>>>
>>>
>>> On Friday 18 December 2015 18:22:40 no name wrote:
>>> > I made a little table were I tried wheezy against jessy and 802.11 as
>>> > someone suggested earlier in the mailing list to me. I placed the
>>> > raspberries next to each other on my table and tested through different
>>> > settings:
>>> >
>>> > ad-hoc+batman-2014.X@debian wheezy:          1m distance  .. 200 pings, 0%
>>> > paket loss, reply time -> (min,avg,max,mdev 1.2ms, 1.8ms, 6.4ms, 0.8ms)
>>> > ad-hoc+batman-2015.2@debian jessie:             1m distance  .. 200 pings,
>>> > 6% paket loss, reply time -> (min,avg,max,mdev 1.1ms, 170ms, 1400ms, 370ms)
>>> > 802.11s @debian jessie:                                  1m distance  ..
>>> > 200 pings, 0% paket loss, reply time -> (min,avg,max,mdev 1.05ms, 1.8ms,
>>> > 14ms, 1.5ms)
>>>
>>> Your "table" is incomplete. adhoc without batman-adv and meshpoint (802.11s
>>> without fwding+ttl=1)+batman-adv are missing. You also mixed two different
>>> batman-adv versions. Either you use the same batman-adv version everywhere or
>>> make sure that the kernel+wifi driver doesn't change. Changing multiple
>>> variables between two tests tests make the results more or less useless for
>>> comparisons.
>>>
>>> Kind regards,
>>>         Sven
>>>
>>
>>
