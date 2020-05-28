Return-Path: <srn@coolheads.com>
Reply-To: srn@coolheads.com
Subject: Re: Network stops passing traffic randomly
References: <20200525083512.832.13419@diktynna.open-mesh.org>
 <32459667.Id32LJz2i1@bentobox>
 <cf75d66e-b0ac-632d-34e6-681ed9c6769d@coolheads.com>
 <3401202.5RrQZ6mRRn@sven-edge>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <cc2df026-9a41-f8f7-fd05-f66f71ca87fe@coolheads.com>
Date: Thu, 28 May 2020 17:17:05 -0400
MIME-Version: 1.0
In-Reply-To: <3401202.5RrQZ6mRRn@sven-edge>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Thanks very much for the advice and clues.=A0 I'll report what happens.

By the way, the problem *never* occurs when all devices are inside my=20
house.=A0 It only happens in the field.=A0 It will take a long time to do=20
this test, because I'll have to set one device up, first, in a remote=20
location, wait for the problem to occur, and then perform the test.=A0 If=20
the problem doesn't occur, I assume that would be significant, too.

On 5/28/20 3:31 PM, Sven Eckelmann wrote:
> [please don't send me private mails about batman-adv - unless you have a
>   really good reason to do so. And if not stated otherwise, I must assume
>   that you actually wanted to send you message to the mailing list]
I did.=A0 Oops.
>
> On Thursday, 28 May 2020 21:18:36 CEST Steve Newcomb wrote:
>>> My first guess is that the underlying interfaces (mesh0) stopped to tra=
nsport
>>> unicast frames. Did you check this by setting an IP on mesh0 and ping b=
etween
>>> these devices using the IPv4 ping?
>> Not sure what the phrase "to set an IP on mesh0" means, if not simply to
>> endow the corresponding bridge with a static IP.  Which is what I'm doin=
g.
>>
>> Not sure what "IPv4 ping" means.  I've disabled IPv6, so I'm not using
>> anything but IPv4.
> I am assuming that mesh0 is the device which was added to bat0 as slave.
> Please replace this with whatever you are using
>
>      # on device 1
>      ip addr add 192.168.23.1/24 dev mesh0
>
>      # on device 2
>      ip addr add 192.168.23.2/24 dev mesh0
>
>
>> If "IPv4 ping" means "the ordinary Linux ping command", then, yes, I've
>> tried that.
> The IPv4 ping was just a placeholder for "not batman-adv ping packets". S=
o you
> can also use ICMPv6 if you prefer. Just make sure to send it over the
> underlying ("slave") interface of batman-adv. And not on bat0 or any high=
er
> layer bridge/vlan/... interface.
>
> With the addresses mentioned earlier:
>
>      # on device 1
>      ping 192.168.23.2
>
>      # on device 2
>      ping 192.168.23.1
>
> And also observe with tcpdump what is received by the other end.
>
>> 100% packet loss when the offline condition occurs.  Batctl
>> o, on the other hand, looks just fine.
> Sounds to me like "mesh0" is still able to transport broadcast frames (wh=
ich
> are used for the OGMs - which "create" the originator lists in `batctl o`=
).
> And if you cannot send unicast frames anymore on mesh0 then something is =
wrong
> with the unicast part.
>
> For example, when you are using encryption for the mesh0 link, maybe the =
group
> key is still set correctly but something happened with the pairwise key a=
nd it
> is now "corrupted".
>
> Kind regards,
> 	Sven

