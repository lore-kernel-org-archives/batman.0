Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 1 Mar 2011 03:24:31 +0100
References: <4D668F3F.4080700@orxrail.com>
	<201102262349.52282.lindner_marek@yahoo.de>
	<4D6BF3B3.8040509@orxrail.com>
In-Reply-To: <4D6BF3B3.8040509@orxrail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201103010324.32398.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv mesh slows down wired clients
	(bridge-loop-avoidance)
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


Hi,

> I think the List had issues with all of us getting multiple emails for
> some reason. I wanted to update you on this status and let others know
> about my solution.

yes, mailman was standing still due to a deadlock. Sven had to restart mailman 
before all the sent mails were processed. Seems some people were getting 
impatient ..  ;-)


> I had to enable STP on the lan-switches.  STP type: STP and Mode: Root
> Protection. This can be enabled on all ports safely without causing
> disruption to the clients plugged into the switch.
> 
> After this step was done, bridge-loop-avoidance worked properly and if
> more than 1 router in a mesh was plugged in, all the routers would pick
> one as a gateway.

I don't know much about STP (root protection does not tell my anything) but 
using STP seems like a very bad idea. STP does not know a thing about your 
mesh network and the qualities of the links. To avoid the loop it will simply 
turn off "ports" in the router which certainly is not what you want. At some 
point in time it might decide to turn off a port you are using ...

I re-read all the mails but I still can't understand your logic: You have 2 
batman-adv gateways that announce the wired clients via HNA. This happens to 
allow wireless clients connected to the mesh to communicated with your wired 
clients. No problem here. Why do you think the packets go through the mesh ?


> If more than one is plugged in, the higher MAC router will drop all lan
> packets which will result in slower throughput to clients to that router
> because it is hopping to another router via wireless and neglecting the
> fact that it's own wired link would take it faster to the intended
> destination.

Are you talking about the bridge-loop-avoidance ? What makes you think they 
are using the wireless interface to forward the traffic to the other gateway ?


> My "solution" to this was to enable STP in the router too.

Again, using STP on top of batman-adv will create more problems than it 
solves.

Regards,
Marek
