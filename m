Return-Path: <keinepostnurmuell@gmail.com>
MIME-Version: 1.0
In-Reply-To: <C3123DAF-BBD2-4477-81B6-B3F57169DE3C@vfn-nrw.de>
References: <CAKrZ8yfKQi8qBzmC7BrEA6Sfug9JB4hb5q_M6p20Ay-V35-F4A@mail.gmail.com>
 <C3123DAF-BBD2-4477-81B6-B3F57169DE3C@vfn-nrw.de>
Date: Fri, 18 Dec 2015 14:23:24 +0100
Message-ID: <CAKrZ8yd4vy36ZXuEa4iN80mvuE92Pa1inG6BQwXsL+2gUBsgqQ@mail.gmail.com>
From: no name <keinepostnurmuell@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Hello Ruben thanks for your help!

root@BASE2:~# batctl o
[B.A.T.M.A.N. adv 2015.2, MainIF/MAC: wlan0/40:a5:ef:06:8d:74 (bat0 BATMAN_=
IV)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
7c:dd:90:79:e6:19    7.700s   (107) 7c:dd:90:79:e6:19 [     wlan0]:
7c:dd:90:79:b5:f2 ( 33) 00:23:54:b4:c4:6f ( 27) 7c:dd:90:79:e6:19
(107)
7c:dd:90:79:b5:f2    6.840s   (104) 7c:dd:90:79:b5:f2 [     wlan0]:
00:23:54:b4:c4:6f ( 15) 7c:dd:90:79:e6:19 ( 46) 7c:dd:90:79:b5:f2
(104)
00:23:54:b4:c4:6f    4.580s   ( 66) 7c:dd:90:79:e6:19 [     wlan0]:
7c:dd:90:79:b5:f2 ( 31) 7c:dd:90:79:e6:19 ( 66) 00:23:54:b4:c4:6f (
45)

This is the output from batctl o

I actually tried other USB sticks aswell, but did not get rid of the
issue. I am using the Ad-Hoc modus to answer your question.

Thanks for your help so far, do you have other suggestions for me?
Richard


On 18 December 2015 at 00:02, Ruben Kelevra <ruben@vfn-nrw.de> wrote:
> VDid you double-check for hardware-issues? Might be a compatibility issue=
 with you wifi hardware.
>
> What are you link values between each peers? (batctl o where row 1 is equ=
al row 2)
>
> Which wifi-mode do you use? Did you tried 802.11s instead of adhoc or vic=
e versa?
>
> Did you tried batman L2 pings instead of icmp-ones?
>
> Best regards
>
> Ruben
>
>> Am 17.12.2015 um 21:52 schrieb no name <keinepostnurmuell@gmail.com>:
>>
>> Hello there
>>
>> Hallo (deutsche Version unten)
>>
>>
>> I have  a simple batman setup that does behave odd:
>>
>>
>> Raspberry b+, jessie, batman-adv2015.2 witha single LOGILINK WL0084B
>> USB wifi stick attached
>>
>>
>> I have 5 rasperries that can see each other via wifi (one of them is a
>> gw(BASE2), one of them (SHELF_1) is not directly reachable by the gw,
>> because they are in a line from one room to another and has to be
>> reached via one single hop in between)
>>
>>
>> digraph {
>>
>> {
>>                "BASE_2"
>>        }
>>        "BASE_2" -> "SHELF_3 @ ra" [label=3D"1.689"]
>>        "BASE_2" -> "SHELF_5 @ Bar" [label=3D"1.689"]
>>        "BASE_2" -> "SHELF_2 @ CD Regal" [label=3D"2.161"]
>>        "BASE_2" -> "SHELF_4 @ Toaster" [label=3D"2.161"]
>>        "BASE_2" -> "SHELF_1 @ Chris" [label=3D"2.040"]
>>        subgraph "cluster_SHELF_3 @ ra" {
>>                "SHELF_3 @ ra"
>>        }
>>        "SHELF_3 @ ra" -> "SHELF_5 @ Bar" [label=3D"1.192"]
>>        "SHELF_3 @ ra" -> "SHELF_4 @ Toaster" [label=3D"1.328"]
>>        "SHELF_3 @ ra" -> "BASE_2" [label=3D"2.277"]
>>        subgraph "cluster_SHELF_4 @ Toaster" {
>>                "SHELF_4 @ Toaster"
>>        }
>>        "SHELF_4 @ Toaster" -> "SHELF_3 @ ra" [label=3D"1.037"]
>>        "SHELF_4 @ Toaster" -> "SHELF_2 @ CD Regal" [label=3D"1.483"]
>>        "SHELF_4 @ Toaster" -> "SHELF_5 @ Bar" [label=3D"1.175"]
>>        "SHELF_4 @ Toaster" -> "SHELF_1 @ Chris" [label=3D"1.371"]
>>        "SHELF_4 @ Toaster" -> "BASE_2" [label=3D"3.446"]
>>        subgraph "cluster_SHELF_1 @ Chris" {
>>                "SHELF_1 @ Chris"
>>        }
>>        "SHELF_1 @ Chris" -> "SHELF_3 @ ra" [label=3D"1.170"]
>>        "SHELF_1 @ Chris" -> "SHELF_5 @ Bar" [label=3D"1.020"]
>>        subgraph "cluster_SHELF_5 @ Bar" {
>>                "SHELF_5 @ Bar"
>>        }
>>        "SHELF_5 @ Bar" -> "SHELF_3 @ ra" [label=3D"1.045"]
>>        "SHELF_5 @ Bar" -> "SHELF_2 @ CD Regal" [label=3D"1.393"]
>>        "SHELF_5 @ Bar" -> "SHELF_4 @ Toaster" [label=3D"1.203"]
>>        "SHELF_5 @ Bar" -> "SHELF_1 @ Chris" [label=3D"1.226"]
>>        "SHELF_5 @ Bar" -> "BASE_2" [label=3D"2.898"]
>>
>> =EF=BB=BF}
>>
>> The problem is, when pinging ANY of the clients from the base (or any
>> client from any other client) I always have a package loss of roughly
>> 50% with a ping reply time up to 10ms sometimes (BASE2 -> SHELF_1, the
>> closer ones are faster). To make things worse, the connection is so
>> weak, even a ssh login may bring it down.
>>
>>
>> I tried quite a few different settings and already updated to the new
>> version and used multiple USB sticks - the result always stays the
>> same. Now I am out of ideas and I would appreciate some new ideas.
>>
>> =EF=BB=BF
>>
>>
>> GERMAN:
>>
>>
>> Ich habe hier 5 Raspberries die sich gegenseitig sehen k=C3=B6nnen (eine=
r
>> ist eine BASIS (BASE2), einer davon (SHELF_1) kann von der Basis nicht
>> direkt gesehen werden, weil sie von einem raum zum n=C3=A4chsten immer
>> gr=C3=B6=C3=9Fere Distanzen =C3=BCberwinden m=C3=BCssen).
>>
>>
>> Das Problem ist nun, dass wenn ich irgend einen client von der Basis
>> aus pinge, oder irgend einen client von einem anderen client pinge,
>> dass ich rund 50% package loss mit bis zu 10ms antwortzeit habe. Die
>> die sich n=C3=A4her sind funktionieren besser (2ms) die weiter weg sind
>> schlechter. Ich kann nicht mal mit einer ssh konsole von BASE2 auf
>> SHELF_1 so dass ich da sinnvoll was eingeben kann.
>>
>>
>> Ich habe schon einige verschiedene Optionen durchprobiert, wie
>> Beispielsweise Update von 2015.0 auf 2015.2, sogar zwei USB Sticks pro
>> Raspberry PI, aber das Problem bleibt. Nun w=C3=BCrde ich um Input bitte=
n,
>> mir sind die Ideen ausgegangen.
>>
>>
>> Danke
>>
>> Thanks a lot!
>>
>> Richard
