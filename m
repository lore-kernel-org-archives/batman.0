Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAA_JP8VjODMM-znsQLM-GyxWjXDJ70Y5yjh_EhgokEY3O+iKAg@mail.gmail.com>
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<20120331204322.GA31423@ritirata.org>
	<CAA_JP8VjODMM-znsQLM-GyxWjXDJ70Y5yjh_EhgokEY3O+iKAg@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sat, 31 Mar 2012 23:39:05 -0300
Message-ID: <CAHD-aqJEvYHpiMBZE5Sp8QzcHJfLVuwzK9Wh4Bf0rN6BA6t0OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] any throughput mechanism or plans?
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

On Sat, Mar 31, 2012 at 11:02 PM, dan <dandenson@gmail.com> wrote:
>>
>> Hello Dan,
>>
>> there is not such mechanism in batman-adv right now. It is a really good=
 idea
>> and we already started to think about that during WBMv5. Personally, I'm
>> applying to the GSOC2012 and I'm proposing something similar.
>>
>> I also think that packet loss is not the correct way to go.
>>
>> Regarding your idea, how would you measure the maximum throughput?
>
> An easy way might be to just pull the info from ifconfig on a timer:
>
> eth0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:2841699391 (2.6 GiB) =C2=A0TX =
bytes:2681928474 (2.4 GiB)
> + 5 seconds
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:2842069649 (2.6 GiB) =C2=A0TX =
bytes:2682282969 (2.4 GiB)
>
> =3DRX of 361.5Kb, TX of 346.2Kb
>
> just update a value for the MAX of both as they change
>
> Compare the stored value to the last 5 second interval so see what
> amount of the connection is available. =C2=A0In my case, I have a 20Mb/10=
Mb
> connection so I have 19.3Mb/9.3Mb available.

That sounds like a nice start!
I'm not sure, though, if that number includes retransmissions and/or
unacknowledged frames.
IIRC i think i've seen that TX number grow in an interface with such a
lossy link that was just sending traffic (trying to reach the distant
ap) but getting nothing in return (ap couldn't hear me)

So far, with openwrt and ath9k / ath9k_htc, i've found the "tx
bitrate" (or MCS level) a fair indicator of the link capacity.
if it says "65.0 MBit/s MCS 7" i cannot tell exactly how much goodput
it will have, but i can be pretty confident that it will be better
than when it says "6.5 MBit/s MCS 1"
