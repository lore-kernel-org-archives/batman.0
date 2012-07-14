Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAHD-aqJE9U44t15xPzDKgzZGjnKDU-p2QG8+UFbcdvW2fvSr=Q@mail.gmail.com>
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
	<CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
	<CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
	<4FDA40A5.1050008@inti.gob.ar> <20120615095525.GA32707@pandem0nium>
	<4FDF7780.1040704@inti.gob.ar> <50008B97.5010403@inti.gob.ar>
	<CAHD-aqJE9U44t15xPzDKgzZGjnKDU-p2QG8+UFbcdvW2fvSr=Q@mail.gmail.com>
Date: Sat, 14 Jul 2012 18:35:23 -0300
Message-ID: <CAHD-aqLcxNfP_CM8+4rB8h4cVwt_beQPxW3jy+c4-tAo=UZ7Gg@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] link alternation when radios are not on
	batman-adv router?
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

Ah, i missed this sentence
"In the normal configuration with batman managing eth0 it doesn't work."
why? How was the setup? Which batman version?
I came across something like this (reported in a previous thread) but
so far i haven't had spare time to reproduce it again to debug it.

On 7/14/12, Guido Iribarren <guidoiribarren@buenosaireslibre.org> wrote:
> You can try taking eth0 out of the bridge and adding it to bat0
> that way you wouldn't need to mess with ebtables?
> As there would be no bridged interfaces, batman would be the only one
> forwarding packets between eth0 and wlan0. With hop penalty.
>
> On 7/13/12, gtolon@inti.gob.ar <gtolon@inti.gob.ar> wrote:
>> Hi.
>>
>> We've been trying two different configurations to use link alternation
>> with two routers conected via ethernet. In both cases in each pair of
>> routers one runs batman and the other only forwards traffic between
>> ethernet and wifi, as Simon suggested:
>>
>> 1) First in the forwarding routers we configured an AP and a station,
>> both using wds. The idea was to form a chain of pairs of routers, where
>> each forwarding router were connected to the previous and the next
>> forwarder using those sta and AP interfaces, as can be seen in
>> conf_1.png. Unfortunately we found that with this configuration the
>> broadcast batman packets were forwarded through all the chain without
>> any batman processing. For example, Batman 1 sends an Originator which
>> goes out through its ad hoc interface, and also through ethernet, then
>> Forward 1 sends it through its sta to Forward 2. In Forward 2 the sta,
>> ap and ethernet interfaces are bridged, so the Originator goes to Batman
>> 2 via ethernet (that's ok) but also goes directly to Forward 3 without
>> the hop penalty applied. As a result Batman 3 sees the ethernet
>> interface of Batman 1 as a direct neighbour with a good quality. In a
>> longer chain the result would be the same.
>>
>> 2) A solution to the first configuration could be use some ebtables
>> rules, but using ebtables we directly tried with normal ad hoc
>> interfaces. So we used the configuration seen in conf_2.png. We cloned
>> the MACs of the Batman ethernet interfaces to the ad hoc interfaces.
>> That way the packets destined by Batman to the ethernet interfaces of
>> their neighbours enter through the wireless interfaces because they have
>> the same MAC. Once inside the Forwarding routers we use this rule:
>>
>>   ebtables -t broute -A BROUTING -i wlan0 -d <MAC1> -j dnat --to-dst
>> <MACX> --dnat-target ACCEPT
>>
>> So changing the dst MAC the packets are forwarded through ethernet. In
>> the BATMAN routers we used this rule to change again the dst MAC:
>>
>>   ebtables -t broute -A BROUTING -i eth0 -d <MACX> -j dnat --to-dst
>> <MAC1> --dnat-target ACCEPT
>>
>> For using ebtables with Batman we had to attach eth0 to a bridge, and
>> add that bridge to batman. In the normal configuration with batman
>> managing eth0 it doesn't work.
>> For the reverse path, packets entering to Forwarding routers from Batman
>> routers it wasn't necessary to use any rule, we just saw many warnings
>> advicing that packets with own address as source address were received.
>>
>> We had read in openwrt forum that ebtables could cause performance
>> issues on routers, but we didn't notice a great difference in the tests
>> we've made with iperf up to now.
>>
>> The problem that we are facing now is the impossibility of increasing
>> the MTU of ethernet interfaces in the routers. We saw this patch:
>>
>> http://permalink.gmane.org/gmane.comp.embedded.openwrt.devel/14678
>>
>> and thought that maybe we could increase a bit more the MTU, but we
>> couldn't. So the other possibility is to decrease all the other
>> interfaces MTU to 1470 and let the ethernet to 1500 right? We guess that
>> could cause IP fragmentation in some cases.
>>
>> I hope my explanations are understandable.
>>
>> Best regards!
>>
>> Gabriel
>>
>> El 18/06/2012 03:46 p.m., gtolon@inti.gob.ar escribi=C3=B3:
>>> Hi Simon, thanks for your reply!
>>>
>>>
>>> El 15/06/2012 06:55 a.m., Simon Wunderlich escribi=C3=B3:
>>>> On Thu, Jun 14, 2012 at 04:51:01PM -0300, gtolon@inti.gob.ar wrote:
>>>>> Hi,
>>>>>
>>>>>      we are interested too in interface alternating, so we made some
>>>>> tests to understand how it works. As you can see on the attached
>>>>> sketch.png, we connected two pair of routers using their ethernet
>>>>> interfaces, E6 with E7, and E8 with E9. All of them have eth0, and
>>>>> an ad hoc interface, wlan0-1, managed by batman. E6 and E8 are in
>>>>> channel 11, whereas E7 and E9 are in channel 1. Besides we used two
>>>>> other routers, E12 and E13, both in channel 11, with their tx power
>>>>> set to just 0 dbm, to avoid a direct sight between them.
>>>>>
>>>>>      Then we sent traffic from E12 to E13. We expected that packets
>>>>> travelled from E12 to E6, and that E6 forwarded them to his eth0 to
>>>>> use the interface alternating feature, making traffic flow to E7,
>>>>> then E9, E8 and finally E13. But instead, we observed that the
>>>>> actual path was E12--E6--E8--E13. The resulting routes for each
>>>>> router are attached in a text file, and also the graph from the
>>>>> batctl vd dot command.
>>>>>
>>>>>      After this result, we read again the thread mentioned by Guido,
>>>>> specially in this part:
>>>>>
>>>>> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-March/006344.h=
tml
>>>>>
>>>>>
>>>>>
>>>>>     And if we understand correctly, the alternation feature works
>>>>> after the batman path has been selected. So in our case, E12 looks
>>>>> at his table to know where to send a packet to E13, and finds E6.
>>>>> Then E6 receives the packet and looks in his own table, finding that
>>>>> the best path to reach E13 is E8. At this point, the alternating
>>>>> should work, but there's only one interface directly connected to
>>>>> E8, so the packet goes there, and so on. We think that if E6 and E7
>>>>> were not two different routers running batman-adv but they were two
>>>>> radios of the same batman-adv router, and the same for E8 and E9,
>>>>> the alternating would work, because the unique router would choose
>>>>> the best path, and then would find two possible interfaces to the
>>>>> same next-hop, changing the interface.
>>>> This is entirely correct - batman-adv has only one link to choose from
>>>> (E6 ->  E8) to reach its best nexthop E8, so there is no way to
>>>> "alternate" the interfaces.
>>>>
>>>>>      We'd like to know if this interpretation is correct, and in that
>>>>> case, if it were possible to use interface alternating in a case
>>>>> like this, with two routers connected to work together. Thanks!
>>>> Mhm, with the current implementation - no, unfortunately not. We would
>>>> need some kind of multipath routing to select between routes, this is
>>>> much more complex.
>>>
>>> Ok, i understand.
>>>
>>>>
>>>> An alternative might be to use the routers E7/E9 as secondary routers
>>>> without batman, but only forwarding traffic between Ethernet and
>>>> WiFi. Then the "primary" routers (E6 ->  E8) would think they have
>>>> an alternative route via Ethernet (because they don't see the
>>>> intermediate hops E7/E9). This comes with some caveats however, e.g.
>>>> 4-addr mode in Ad-Hoc, you need some very simple ethernet forwarder,
>>>> and most probably other things I forgot.
>>>
>>> We had tried with something like that using ap and sta modes in E7 and
>>> E9, and it hadn't worked. Thanks to your suggestion we noticed the
>>> necessity of the 4-address mode, so we are now trying with wds:
>>>
>>> http://wiki.openwrt.org/doc/recipes/atheroswds
>>>
>>> Unfortunately, we haven't found yet a way to use 4-address mode in ad
>>> hoc. Apparentrly, it's not possible:
>>>
>>> http://linuxwireless.org/en/users/Documentation/iw#Using_4-address_for_=
AP_and_client_mode
>>>
>>>
>>>
>>> Best Regards
>>>
>>> Gabriel
>>
>
