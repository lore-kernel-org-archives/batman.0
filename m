Return-Path: <djb31st@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTik9JYyRM4UO2RLvm4NfhaDmnLEHamo8kKLV4RnB@mail.gmail.com>
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<201008121131.23425.lindner_marek@yahoo.de>
	<AANLkTim8cNH29kS=VM+m18OeexHaxwo19ug6Yu04Q6wx@mail.gmail.com>
	<201008121150.33820.sven.eckelmann@gmx.de>
	<AANLkTik9JYyRM4UO2RLvm4NfhaDmnLEHamo8kKLV4RnB@mail.gmail.com>
Date: Thu, 12 Aug 2010 13:16:29 +0300
Message-ID: <AANLkTimJ1u9ZrrOyD1k_nNzfq-H+AhbAFNm4w4dhnBy2@mail.gmail.com>
From: David Beaumont <djb31st@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Nat Question
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
To: b.a.t.m.a.n@lists.open-mesh.org

No luck :-(

root@Generic:/# cat /proc/net/batman-adv/originators
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nextho=
ps ..
. [B.A.T.M.A.N. Adv 0.1 rv1176, MainIF/MAC: ath0/00:0c:42:60:12:cf]
00:0c:42:3a:75:a2  (229) 00:0c:42:3a:75:a2 [      ath0]: 00:0c:42:3a:75:a2 =
(229)

root@Generic:/# ping google.com
PING google.com (74.125.39.105): 56 data bytes
64 bytes from 74.125.39.105: seq=3D0 ttl=3D53 time=3D124.425 ms
^C
--- google.com ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max =3D 124.425/124.425/124.425 ms
root@Generic:/# wget http://www.google.com
Connecting to www.google.com (209.85.135.147:80)

Pings work fine, a wget just pauses and waits indefinitely



On Thu, Aug 12, 2010 at 1:11 PM, David Beaumont <djb31st@gmail.com> wrote:
>> > The bat0 interface is currently bridged as follows
>> >
>> > On the router with internet going into the WAN port (ETH1), BAT0 is
>> > bridged with the LAN (ETH0) =A0Internet works correctly though the lan=
,
>> > so i would assume NAT routing to the WAN is setup correctly?
>>
>> so you have eth0 and bat0(ath0) in a bridge br0 -> eth1 uses nat to tran=
slate
>> packets for/from eth1?
>
> Yes this is correct, bat0 and eth0 are bridged to form br-lan, which
> uses nat to translate things over to eth1
>
>>
>> > On the router on the other end of the mesh, BAT0 is bridged with the
>> > WAN port (ETH1) so that the router will route WAN traffic though BAT0?
>>
>> What? Why a different internet gateway and why do you bridge the bat0(at=
h0)
>> interface with the wan interface instead of using nat here?
>>
>
> Not sure what you mean by a "a different internet gateway"
>
> The way openWRT is setup, the WAN network is actually a bridge of bat0
> and wifi0 (which is the card that bat0 is running on) Talking this
> though its looking like this might be the bit where the problem lies.
> Its setup currently like this as i was initially trying to run OLSR
> and BATMAN simultaneously (although have since simplified to just
> batman).
>
> My theory was that if bat0 is the WAN, the NAT rules built into
> openwrt would take control and internet would be routed though bat0.
>
> I have also attempted to setup nat myself at this end, but am so far
> unsuccessful and loose the ability to even ping the internet.
>
> I think i am close to the solution as i can ping things, there is just
> something missing.
>
> Will try un-bridging wifi0 and report on what happens.
>
>> Maybe there is a misunderstanding somewhere... At least I am extremely
>> confused about your setup.
>>
>> Best regards,
>> =A0 =A0 =A0 =A0Sven
>
