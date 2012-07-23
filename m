Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120708100956.GA10210@pandem0nium>
References: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
 <20120708100956.GA10210@pandem0nium>
From: Gui Iribarren <gui@altermundi.net>
Date: Mon, 23 Jul 2012 04:20:39 -0300
Message-ID: <CAHD-aq+wSvBc56KGJ6RFDMgnP_sir5TXx83EYPw_WWh8=Geqag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] 2012.2 OGMs over ethernet issue?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Sun, Jul 8, 2012 at 7:09 AM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hey Guido,
>
> On Sat, Jul 07, 2012 at 12:37:24AM -0300, Guido Iribarren wrote:
>> Hello again nice folks,
>> I updated today another segment of the network with just 4 nodes, to
>> batman-adv 2012.2 (the one i compiled yesterday with simon patches for
>> blaII, marek stability fixes, and debug log enabled , yikes!)
>> and i couldn't get batman to work over wired ethernet?? (?)
>>
>> P -(50mts wlan)- D -----(ubnt transparent bridge) 2km -- C
>>  \----eth-------------------/
>>
>> Node P and D connected by ethernet on eth0 but close enough that could
>> also see each other through adhoc wlan, with bla enabled, correctly
>> preferred ethernet connection to communicate between them (iperf
>> yielded 92mbps), so far so good.
>
> As seen on the dump, you only use eth0 in batman? Is the Ad-Hoc connection
> still active (on wlan0 or wlan-1)?

For this initial setup, i didn't add eth0 to batman, only ad-hoc
interfaces, classic setup.
representation:
http://www.open-mesh.org/attachments/download/131
works as expected.

When it doesn't work is when the ad-hoc connection is severed.
which makes the thing look like
http://www.open-mesh.org/attachments/download/128
that is, there are two gateways that can only talk to each other
through ethernet (although it's not "batctl if add"ed) don't get each
other OGMs
after careful re-reading of BLAII docs in the wiki, and extensive
chats with NicoEchaniz, i understood this is the planned behaviour (no
OGMs on lan)

>
>> now, node D and C, too far away from each other to communicate over
>> wlan, but connected by a "loooong eth cable" (mediated by a wds
>> transparent bridge) wouldn't find each other batman originator.
>> C originator table was empty, and D only showed P.
>> I thought the transparent bridge was misbehaving, so I tried in a
>> simpler setup using P and D, with the wifi off:
>> but after disabling wlan0 (batctl if del wlan0-2) and adding eth0
>> (batctl if add eth0) on both nodes, batman could not see each other
>> anymore :(
>> i thought i was doing something wrong, so i tried in different ways,
>> but could not get it to work.
>> batctl td eth0 shows both outgoing OGMs from local , and incoming OGMs
>> from remote,
>> but batctl l only reported outgoing OGMs.
>>
>> http://pastebin.com/7DDUaXu1
>
> Mhm, that's weird indeed. Is eth0 really not included in any other bridge?
> It looks like the incoming packets don't reach BATMAN for some reason.
Definitely not included in any bridge.
Funny thing is, the only workaround i found for the bug is to
*include* the interface in a bridge, and add that bridge to bat0
as in:
brctl delif br-lan eth0
batctl if add eth0
# doesn't work

brctl delif br-lan eth0
brctl addbr blah
brctl addif blah eth0
batctl if add blah
# works fine, OGMs pass through perfectly

>
> Also have you checked that the WDS bridge works via IP?
As I wasn't confident about the WDS bridge, I simply tried with two
routers connected by a single physical ethernet cable. So the results
reported didn't include a WDS bridge at all.

> You could first set
> up some IP addresses and ping each other, confirm traffic with tcpdump, and
> then activate batman-adv to see if the OGMs go through.
Confirmed.
