Return-Path: <gui@altermundi.net>
Message-ID: <52761A86.5080106@altermundi.net>
Date: Sun, 03 Nov 2013 10:42:30 +0100
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <20131101075558.GI6252@medion.lan>
 <20131101123610.GR970@neomailbox.net> <20131101143305.GO6252@medion.lan>
 <20131101143903.GX970@neomailbox.net> <20131101151626.GP6252@medion.lan>
 <5275F6CC.9080009@altermundi.net> <20131103091832.GR6252@medion.lan>
In-Reply-To: <20131103091832.GR6252@medion.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] lost connection to a client / Q:
	transglobal-table
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

On 11/03/2013 10:18 AM, Bastian Bittorf wrote:
> * Gui Iribarren <gui@altermundi.net> [03.11.2013 09:52]:
>>> Each node has a macvlan called 'gateway0' which has the IP 192.168.0.1/32
>>> This is just an IP which every DHCP-Client gets for "default-gateway".
>>> (so the gateway is the node itself and not the internet-offering-node).
>>> This looks like this:
>>>
>>> root@node222hybrid:~ ip address show dev gateway0
>>> 15: gateway0@br-mybridge: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
>>> qdisc noqueue state UNKNOWN group default
>>>      link/ether 02:00:c0:ca:c0:1a brd ff:ff:ff:ff:ff:ff
>>
>> if this mac (02:00:c0:ca:c0:1a) exists on several different nodes
>> that are not connected by a real ethernet backbone (and BLA2 enabled)
>> then batman goes mushroom tripping, since it 'sees' that MAC as a
>> non-mesh-client that is everywhere at the same time, and tries to
>> roam it around, creating funny symptoms (like DUPs and such)
>
> BINGO! thank you Gui - if i read the old mails, i can even see it
> i the transglobal table. if i look into the mesh, it pop's up on
> random nodes with random originators. yes: mushroom tripping 8-)
>
> i will try the ebtables approach, but i dont like it.
> IMHO it's more elegant to just 'ignore' this mac by the
> daemon itself:

According to the (misleading, by definition :P) docs

http://www.open-mesh.org/projects/open-mesh/wiki/Connecting-Batman-adv-clouds

it shouldn't quite ignore it, but instead properly support this 
"anycast" MAC, taking advantage of the "Bridge Loop Avoidance II 
component" even when there's no physical backbone between nodes.

meanwhile, at the batcave... (2013/10/14)

     d0tslash: guii: we don't have anycast support
     d0tslash: yet
     guii: ...?
     d0tslash: if you have the same mac address on multiple nodes 
(without bla), it will roam
     guii: oh!
     d0tslash: hm, it might work if you have bla enabled and the nodes 
are connected via the same ethernet
     d0tslash: but otherweise it won't work
     d0tslash: because it is supposed to roam :)

     d0tslash: so you won't have that feature for now, i'm afraid
     d0tslash: it is still on our "feature todo" list


so, given there will be MACs that roam (laptops, phones...) and MACs 
that don't (anycast), i can imagine some kind of regexp matching that 
will say "don't roam these kind of MACs, instead, consider them anycast 
macs and use bla2 magic"

  # batctl anycast EE:C4:57:00:00:00/32


...until then, ebtables WORKSFORME :D
and all this doesn't make batman-adv any less awesome than what it was 
already ;)

btw, even with the ebtables rule, we had to turn off DAT in a scenario 
equivalent to yours, because the DAT cache was also acting funny (DUP 
arp replies from each node in the cloud)
haven't got around to properly debug it / report it, but still, be warned :)

>
> To the devs: is this possible?
>
> bye, bastian
>
