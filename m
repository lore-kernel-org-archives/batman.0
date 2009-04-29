From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 29 Apr 2009 10:59:45 +0800
References: <209743CECB91EB4F84169A51F300410D1F3137C3F9@MAIL02.ug.kth.se>
In-Reply-To: <209743CECB91EB4F84169A51F300410D1F3137C3F9@MAIL02.ug.kth.se>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904291059.45857.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Masters thesis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,

> On your homepage you stated that you have a lot of ideas but you don't have
> the time to implement them all. My question is, do you have any ideas that
> would fit to be done as a masters thesis in communication networks? It
> could be anything from an issue related to the protocol itself or it could
> be porting an already deployed technology on other types of networks to the
> B.A.T.M.A.N.

welcome on board.  :-)

I'm very happy that you ask. Elektra already suggested a few things. I'm going 
to extend this list and group it a bit to outline the focus of the 
corresponding tasks. That should give you a good starting point. 
I suggest you choose your candidates out of these before we dive into the 
details. Then you will have an idea what to expect and you can make a decision 
whether you want to do it. :-)

one afternoon of work (at maximum):
*  Modify Batman-0.3.X code so we have an option to compile it without 
policy routing support
*  Modify the way that Batman-Advanced (Layer 2) deals with 
broadcast/multicast payload packages (on multihop wireless routes there 
is always packet loss, protocols like DHCP use broadcast or multicast 
messages which are not send redundantly and not acknowledged, so these 
protocols which are not designed to deal with a high level of packetloss 
have difficulties to work on a Layer 2 mesh as the number of hops and 
packet loss on the media increases)

several weeks of coding effort (including tests):
*  Modify Batman-0.3.X  in order to support IPv6
*  Get support for other operating systems working (so far it only works 
with Linux) -> depends on your knowledge of "other" systems
* merge batman adv userspace & kernelland code to reduce the maintenance 
overhead
* automatic interface bonding for better throughput (layer 2)

requires in depth knowlegde about batman:
*  Improve Batman with regards to protocol overhead and convergence speed

mt. everest:
*  Implement a minimalistic and power saving Batman client version for 
embedded mobile devices (requires extensive knowledge of 802.11 power saving 
mechanisms and how to bring them into the mesh)
* multipath routing (as it always appears over and over again: 
http://en.wikipedia.org/wiki/Multipath_routing)

Regards,
Marek

