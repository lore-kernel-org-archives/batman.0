Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAHD-aqJEvYHpiMBZE5Sp8QzcHJfLVuwzK9Wh4Bf0rN6BA6t0OQ@mail.gmail.com>
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<20120331204322.GA31423@ritirata.org>
	<CAA_JP8VjODMM-znsQLM-GyxWjXDJ70Y5yjh_EhgokEY3O+iKAg@mail.gmail.com>
	<CAHD-aqJEvYHpiMBZE5Sp8QzcHJfLVuwzK9Wh4Bf0rN6BA6t0OQ@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sat, 31 Mar 2012 23:53:25 -0300
Message-ID: <CAHD-aqKUcct29FBwi+fTqH66=S7ehQZABjwjo6VuhMknxUtw9g@mail.gmail.com>
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

On Sat, Mar 31, 2012 at 11:39 PM, Guido Iribarren
<guidoiribarren@buenosaireslibre.org> wrote:
> On Sat, Mar 31, 2012 at 11:02 PM, dan <dandenson@gmail.com> wrote:
>>>
>>> Regarding your idea, how would you measure the maximum throughput?
>>
>> An easy way might be to just pull the info from ifconfig on a timer:
>>
>> eth0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:2841699391 (2.6 GiB) =C2=A0TX=
 bytes:2681928474 (2.4 GiB)
>> + 5 seconds
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:2842069649 (2.6 GiB) =C2=A0TX=
 bytes:2682282969 (2.4 GiB)
>>
>> =3DRX of 361.5Kb, TX of 346.2Kb
>>
>> just update a value for the MAX of both as they change
>>
>> Compare the stored value to the last 5 second interval so see what
>> amount of the connection is available. =C2=A0In my case, I have a 20Mb/1=
0Mb
>> connection so I have 19.3Mb/9.3Mb available.
>
> That sounds like a nice start!
> I'm not sure, though, if that number includes retransmissions and/or
> unacknowledged frames.

Oh, i forgot to add, iw does discriminate between succesfully sent
packets, and unsuccessfull retries or failed packets.
For example


# batctl o -n
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: wlan0-1/56:e6:fc:be:29:d3 (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
56:e6:fc:be:26:13    0.270s   (145) 56:e6:fc:b9:b6:48 [     wlan1]:
56:e6:fc:b9:b6:47 (134) 56:e6:fc:b9:b6:48 (145)
### Let's find out how good looks that Nexthop 56:e6:fc:b9:b6:48 on wlan1

# iw wlan1 station get 56:e6:fc:b9:b6:48
Station 56:e6:fc:b9:b6:48 (on wlan1)
	inactive time:	20 ms
	rx bytes:	3593056580
	rx packets:	2728661
	tx bytes:	915427424
	tx packets:	1677330
	tx retries:	0
	tx failed:	0
	signal:  	-71 dBm
	signal avg:	-70 dBm
	tx bitrate:	72.2 MBit/s MCS 7 short GI
	rx bitrate:	72.2 MBit/s MCS 7 short GI

Those "tx bytes" do not include retries or failed transmissions, only
ACKed packets (AFAIK)

of course, making batman peek into this would definitely deviate from
the bat-idea of "i don't care if physical is wired, wifi, wimax or
avian carriers"

my 2c
