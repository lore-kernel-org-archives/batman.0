Return-Path: <trizonelabs@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <4F994681.9040300@inti.gob.ar>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF3@saturn3.aculab.com>
	<20120425.140904.935584797119761625.davem@davemloft.net>
	<4F985E17.8030309@inti.gob.ar>
	<27822870.WoBxtuRSLo@sven-laptop.home.narfation.org>
	<4F994681.9040300@inti.gob.ar>
Date: Thu, 26 Apr 2012 17:49:24 +0300
Message-ID: <CAJuY50ygkeQgr=CXUpZGJdR8AXQMq3gtEs0WvM5cQeE=ARf3MQ@mail.gmail.com>
From: 3zl Trizonelabs <trizonelabs@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Traffic Control in batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

maybe pic this will help

http://www.bild.me/bild.php?file=3D9951400Batman-CPE-config.png

regards
3zl

2012/4/26  <gtolon@inti.gob.ar>:
> Hi Sven, thanks for replying.
>
> El 25/04/2012 05:51 p.m., Sven Eckelmann escribi=F3:
>>
>> On Wednesday 25 April 2012 17:27:03 gtolon@inti.gob.ar wrote:
>>>
>>> Hi,
>>
>> First thing: Don't reply to random messages when you actually want to
>> start a
>> new topic.
>
>
> Ok.
>
>>> We are doing some tests with Traffic Control (tc) in routers with
>>> Openwrt running batman-adv, want to be able to share the bandwidth with
>>> some degree of fairness between users, so we think that SFQ could help,
>>> differentiating the flows depending on ip addresses and ports.
>>>
>>> The problem is that when adding the SFQ qdisc to the wireless interface
>>> managed by batman it doesn't work as expected. We tested the SFQ in
>>> other configurations and it worked fine, in full queues, the dropped
>>> packets affected the big flows, allowing the others to pass, but in the
>>> interface managed by batman-adv when packets are dropped, the result
>>> affects all flows almost equally. We thought this could be related with
>>> the bridge we use to connect the batman with the non-batman interfaces,
>>> but in a wireless Acces Point bridged to bat0 it also worked fine. Mayb=
e
>>> it's related with the way bat0 works with it's managed interface? We'd
>>> appreciate any advices. Thanks in advance!
>>
>> Why do you add the sfq qdisc to the wireless device instead to the bat0
>> device? It doesn't really makes sense to me.
>
> I also tryed with bat0, but the packets continued to dropp on the wireles=
s
> device, not in bat0, so i thought that the qdisc of bat0 was not being us=
ed.
> Anyway, i'll try again.
>
>
>> Also your statement about "batman-adv bridged with non-batman-adv" doesn=
't
>> work, but "batman-adv bridged with non-batman-adv interface" works
>> statement
>> is slightly irritating. Please explain it a little bit more verbose to
>> help us
>> understand what is the difference.
>
> Sorry for the bad explanation,what i wanted to say is:
>
> We have a bridge with bat0, eth0 and wlan0 attached. wlan0 is in ap mode.
> There's another wireless interface, wlan0-1 in ad-hoc mode, managed by ba=
t0.
> When SFQ qdisc is applied to wlan0, it works as expected. When it's aplie=
d
> to wlan0-1, it doesn't. In both cases there's a bridge involved, that=B4s=
 what
> i was trying to point. I hope now it's more clear.
>
> Best regards
>
> Gabriel
