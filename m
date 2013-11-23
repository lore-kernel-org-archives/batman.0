Return-Path: <bittorf@bluebottle.com>
Date: Sat, 23 Nov 2013 10:24:45 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20131123092445.GN886@medion.lan>
References: <20131101075558.GI6252@medion.lan>
 <20131101123610.GR970@neomailbox.net>
 <20131101143305.GO6252@medion.lan>
 <20131101143903.GX970@neomailbox.net>
 <20131101151626.GP6252@medion.lan>
 <5275F6CC.9080009@altermundi.net>
 <20131103091832.GR6252@medion.lan>
 <52761A86.5080106@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52761A86.5080106@altermundi.net>
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

* Gui Iribarren <gui@altermundi.net> [03.11.2013 20:37]:
> .....until then, ebtables WORKSFORME :D
> and all this doesn't make batman-adv any less awesome than what it
> was already ;)
> 
> btw, even with the ebtables rule, we had to turn off DAT in a
> scenario equivalent to yours, because the DAT cache was also acting
> funny (DUP arp replies from each node in the cloud)
> haven't got around to properly debug it / report it, but still, be warned :)

since a few days we have running those 2 ebtable-rules on all nodes:
ebtables -A FORWARD -j DROP -d "$mac_gateway"
ebtables -t nat -A POSTROUTING -o bat0 -j DROP -s "$mac_gateway"

it looks like this:
root@box:~ ebtables -L FORWARD --Lc
Bridge table: filter

Bridge chain: FORWARD, entries: 1, policy: ACCEPT
-d 2:0:c0:ca:c0:1a -j DROP , pcnt = 9581 -- bcnt = 1116077

root@box:~ ebtables -t nat -L POSTROUTING --Lc
Bridge table: nat

Bridge chain: POSTROUTING, entries: 1, policy: ACCEPT
-s 2:0:c0:ca:c0:1a -o bat0 -j DROP , pcnt = 4 -- bcnt = 352

so most of the time it is working fine. but we have seen another
issue, but i'am unsure where is it coming from:

"clients time out in translocal-table"

A laptop connected to always the same router / no roaming involved
times out in 'translocal-table' and so it also times out on the
other nodes in the 'transglobal-table', so it is not reachable anymore.

a bad translocal-table/dat-cache with this client looks like this:
(i have removed other clients, for better readablility)

root@box:~ batctl tl
Locally retrieved addresses (from bat0) announced via TT (TTVN: 2 CRC:
0x6023):
       Client        Flags   Last seen
 * 00:21:6a:32:7c:1c [....W]   0.010

root@box:~ batctl dc
Distributed ARP Table (bat0):
          IPv4             MAC           last-seen
 *  192.168.222.61 00:21:6a:32:7c:1c      3:50

after some seconds the client disappaers from DAT-cache:

root@box:~ batctl tl
Locally retrieved addresses (from bat0) announced via TT (TTVN: 2 CRC:
0x6023):
       Client        Flags   Last seen 
 * 00:21:6a:32:7c:1c [....W]   0.010

root@box:~ batctl dc
Distributed ARP Table (bat0):
          IPv4             MAC           last-seen

after some time even the 'translocal-table' is empty, although with
'iw dev wlan0 station dump' i can see the active client. i'm
normally connected, can ping/ssh the node itself but not further.
(only hop by hop)

how does batman detect, if a client is active? (can i trigger is somehow?)
what can i do tho debug further?

thanks & bye, bastian

