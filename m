From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Multiple connections / prioritiy
Date: Mon, 3 Sep 2007 18:21:57 +0200
References: <20070723140744.ozvor890jy5cockg@webmail.ddmesh.de>
	<46A591C0.8090009@poelzi.org>
In-Reply-To: <46A591C0.8090009@poelzi.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709031821.57448.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello,

On Dienstag 24 Juli 2007, Daniel Poelzleithner wrote:
> Freifunk Dresden wrote:
> > If I have multiple connections between two nodes, is there a way to
> > setup the quality or
> > priority of those connection?

you can experiment with that using batman-experimental  rv555. Try

--send-clones ( /c <value> ) which can be used to increase or decrease the 
quality of a link by specifying a probability how often a received OGM should 
be rebroadcasted. The default value for this parameter is 100, saying each 
OGM will be (re-)broadcasted with a probability of 100%. Applying a value 
less than 100 will let the links to a node appear worse than they actually 
are. A value larger than 100 will clone packets and send them multiple times 
(retending better connectivity to the node than there actually is).
For example:
180 results in 80 % of the OGM to be (re-)broadcasted twice.
30 results in 70% of the OGMs not being (re-)broadcasted at all.
Since --send-clones will change the default value (affecting all interfaces of 
a node) there is also an interface-specific variant of this feature: "/c 
<value>", which must be applied after the interface name and will only affect 
the broadcast-probability  for a specific interface.

Another thing is the problem with the bidirectional link check. This check by 
default allows a maximum of one OGM from my neighboring link peer to be lost 
before the link is temporary considered non-bidirectional or invalid. So, if 
70% of the to-be-broadcasted OGMs are intentional not send at all (because 
of /c 30) the bidirectinal link check will fail very often. This has the 
side-effect that many OGMs from distant nodes will be ignored even more.  
This problem can be resolved by also applying the /b <value> (the 
interface-specific variant of the --bi-link-timeout) switch to the dropping 
interface and giving it a higher value that the default value of two.

So if you have a dsl-vpn-fallback-link (which you only want to use in case of 
terrible wireless connectivity) called dsl0. And you have the wireless 
interface wlan0, then try: $batmand wlan0 dsl0 /c 40 /b 6
This will suspend 60% of the OGMs from being broadcasted via interface dsl0 
and relieves the bidirectional link check at this interface from two to five.

greetings,
axel









and
--bi-link-timeout <value> ( /b <value> )

There are interface-specific switches called /c and /b which must be applied 
behind an interface name

>
> Same goes for Leipzig, we have our vpn[1,2].leipzig.freifunk.net nodes.
> I thought about this problem a lot and the simplest solution would be to
> simply drop like 9 of 10 batman packets on the outgoing vpn interface.
> this is like a olsr multiplicator of 10 with the advantage that it saves
> bandwith.
>
> short anecdote about dropping olsr packets:
> so, we now have this huge vpn that connects most edges of the mesh to
> central olsr nodes. because this are just backup routes, we have to
> increase the etx value, no problem with the olsr multiplier option. on
> the vpn a packetloss of 0% ist relative normal, so you pump out 5kb/s of
> olsr traffic just to say: mmhh, ok, very good connection but i think its
> bad anyway. so, if olsr messures the packet loss rate, i could simply
> drop 9 of 10 packets and with 0.5kb/s i would have the same effect. if
> that is what olsr is supposed to do.
>
> by the way, we have arround 400 GB per month olsr overhead alone, which
> is just creazy for a routing protocol overhead.
>
> i ran a couple of tests.
> there is a iptables match called nth, so i tested to allow only every
> tenth packet. i got a etx of 0.0
> strange: i allowed 50% -> etx 0.0
> stranger: i allowed 90% -> etx 0.0
> there is a percent match. i combined them, i tried percent alone, etc.
> olsr depends a lot about which packets get dropped.
> you simply can't just drop packets without getting etx 0.0 for at least
> periods of 20-30 seconds, which drives you nuts.
>
> batman should work very well with that approach.
>
> kindly regards
>  Daniel
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


