Return-Path: <treffer@measite.de>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
References: <20190609101922.2366-1-treffer@measite.de>
 <3224708.U1DPrJmi8S@rousseau>
 <accc8852-ded3-188b-b72e-313d1b462d18@measite.de>
 <4907494.lMUJSmCnaO@rousseau>
From: =?UTF-8?Q?Ren=c3=a9_Treffer?= <treffer@measite.de>
Message-ID: <8c0c76dc-5c6b-da84-8e11-700222641db8@measite.de>
Date: Mon, 10 Jun 2019 12:06:23 +0200
MIME-Version: 1.0
In-Reply-To: <4907494.lMUJSmCnaO@rousseau>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, b.a.t.m.a.n@lists.open-mesh.org


On 10.06.19 05:31, Marek Lindner wrote:
> On Sunday, 9 June 2019 20:45:06 HKT Ren=E9 Treffer wrote:
>> I am testing this on devices with ath9k (2.4GHz) and ath10k (5GHz), so I
>> was looking at the estimates I get from ath9k. Here is a dump from my
>>
>> home network on 2.4GHz/ath9k and what rx/3 would give us:
>>> signal  tx     rx     expect  tx/3    min(tx/3,(rx+tx)/2/3)
>>> -77     13.0   43.3   6.682   4.333
>>> -57     130.0  117.0  44.677  43.333  41.166
>>> -53     117.0  130.0  42.388  39.0
>>> -82     43.3   6.5    13.366  14.433  8.3      (!!!)
>>> -63     52.0   86.7   26.733  17.333
>>> -58     130.0  173.3  29.21   43.333            !!!
>>> -82     6.5    43.3   2.197   2.166
>>> -48     104.0  65.0   40.191  34.666  28.166
>>> -69     57.8   13.0   20.49   19.266  11.8
>>> -58     86.7   52.0   33.507  28.9    23.116
>>> -58     52.0   1.0    37.994  17.333  8.833
>>> -56     115.6  144.4  29.21   38.533            !!!
>
> To confirm my understanding: What this table shows are raw tx/rx link est=
imated=20
> values ? None of these numbers compares to Minstrel HT expected throughpu=
t or=20
> actual throughput ?

Ah sorry, _expect_ is the current ath9k expected throughput and that
should be minstrel, right? I pulled data from my ath9k devices, e.g.

> # iw dev wlan1 station dump
> Station e8:de:27:70:0e:bd (on wlan1)
> =A0=A0=A0=A0=A0=A0=A0 [...]
> =A0=A0=A0=A0=A0=A0=A0 signal:=A0=A0=A0=A0=A0=A0=A0=A0 -56 [-59, -59, -80]=
 dBm
> =A0=A0=A0=A0=A0=A0=A0 tx bitrate:=A0=A0=A0=A0 117.0 MBit/s MCS 20
> =A0=A0=A0=A0=A0=A0=A0 rx bitrate:=A0=A0=A0=A0 144.4 MBit/s MCS 15 short GI
> =A0=A0=A0=A0=A0=A0=A0 expected throughput:=A0=A0=A0 42.388Mbps
> =A0=A0=A0=A0=A0=A0=A0 [...]
Those are the potential inputs (-56, 117, 144.4) and a desired output
(42.388), or as a table

> signal=A0 tx=A0=A0=A0=A0 rx=A0=A0=A0=A0 expect
> -56=A0=A0=A0=A0 117.0=A0 144.4=A0 42.388
I then computed manually the tx/3 (39.0) which is lower than
(rx+tx)/2/3. The full line would be

> signal=A0 tx=A0=A0=A0=A0 rx=A0=A0=A0=A0 expect=A0 tx/3=A0=A0=A0 min(tx/3,=
(rx+tx)/2/3)
> -56=A0=A0=A0=A0 117.0=A0 144.4=A0 42.388=A0 39.0
I hope this makes sense now. I wanted to get close to the current
throughput estimation with worse inputs.
I would be happy to check more inputs, but the tx/3 turned out to be
pretty close and usually slightly lower.

>
>
>> Cases where the rx/tx estimate would be higher are marked with !!!.
> I also don't quite understand what the '!!!' thing is trying to indicate.=
 What=20
> is being compared ? But it may be due to my misunderstandings above.=20

I haven't done an actual throughput test, and I would expect the outputs
of my heuristic to be worse.
So I wanted to give slightly lower values than the expected throughput.

The other way to think about it: if you were to replace the
expected_throughput input where would you over-estimate the link quality
now?

>
> In my small test setup with one ath10k device meshing with ath9k over 2.4=
GHz,=20
> your tx / 3 formula seems to be quite accurate (had removed the rx part).=
=20
>
> # batctl o (your magic formula)
> * ac:86:74:00:38:06    0.930s (       45.7)  ac:86:74:00:38:06 [    mesh2=
4]
>
> # batctl tp ac:86:74:00:38:06 (actual throughput)
> Test duration 10440ms.
> Sent 58393512 Bytes.
> Throughput: 5.33 MB/s (44.75 Mbps)
>
> What would be interesting is how the numbers produced by 'tx / 3' compare=
 to=20
> either the actual throughput (can easily be tested with the throughput me=
ter)=20
> or Minstrel expected throughput.=20

Comparing with actual throughput sounds like a good idea, I'll do that next.
Right now I don't know how well estimates on both radios hold and how
well they are comparable.

>
>
>> Why bother and look at rx at all? Asymmetric routing should already
>> work. I was bit concerned about highly asymmetric links, especially
>> those where the path back might not work. It might not be worth it thoug=
h.
> Generally, the return path might be entirely different. Batman-adv does n=
ot=20
> enforce or even endorse symetric paths. If there is better path for the r=
eturn=20
> route, batman-adv will choose the better path based on tx from the sender=
 and=20
> if only one return path exists, we don't care anyway ..
>
> Cheers,
> Marek
