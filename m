From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 6 May 2009 00:05:55 +0800
References: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
In-Reply-To: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905060006.19114.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv use in Manchester NH
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

On Tuesday 05 May 2009 22:08:44 Arc Riley wrote:
> We're setting up batman-adv on open-mesh.com OM1P routers and
> unidirectional antennas to connect homes and businesses across the city.

Cool ! May I ask who "we" is and how you would describe the current status ?


> Is there currently a multicast protocol or method for a node on the network
> to get local link stats from every other node on the network?  We're
> looking at this for a GUI desktop diagnostics tool which shows the current
> 1-hop link states for all nodes on the network

If you want to assemble a view of the whole topology the built-in vis server 
might be what you are looking for. I think the 24C3 video that you can find on 
our website describes how it works.


> Is there a layer 3 solution for routing each end user to the nearest IP
> gateway that works well on top of a batman-adv network?

Actually, this gateway question puzzles us as well. We did not find a very good 
solution for this problem yet. Batman-adv knows the best route towards the 
gateway - no problem here. But how can we propate that upwards ? Setting a 
route (which would be layer 3) ? We could even create an API that allows other 
processes to retrieve the best gateway but we "just" have a mac address no IP 
address.


> Does batman-adv currently support "bonding"; ie, will it route all packets
> through the best connection until it's saturated, or will it spread packets
> across connections (especially that are near the same quality) for optimal
> speed?

As soon as a link is used its link quality will go down as well but I think 
you are referring to a feature known as "Multipath Routing" 
(http://en.wikipedia.org/wiki/Multipath_routing) ?! Currently, batman does not 
have this feature. I'm not aware of any implementation that does as it is 
quite tricky. If you know some let me know.  :-)

On the other hand Simon is working on "short distance" bonding (which 
simplifies the task a lot). So far we have no working code.


> What kind of traffic throughput is the kernel module capable of?  Does the
> module multithread properly for multicore utilization?  Would a FPGA
> variant be needed to have a "mesh switch" or would a high-end multicore ARM
> be reasonably able to handle say an 8-port gigabit mesh switch?

I'm not the right guy to answer the "how much power do we need for an 8-port 
gigabit switch". This is not directly related to batman. I hope someone else 
can jump in.

Batman-adv is fully multithreaded as every reasonable linux module should be. 
Thats one of the main reasons that make it quite time consuming to debug - 
every little race condition leads to crashes and then you look for the needle 
in the haystack. :-)


> These questions are less to evaluate batman-adv for our uses than looking
> forward at what we'll need to develop as we expand.

Sounds great - we are looking forward to all kind of feedback / contributions. 
Let us know if you have more questions.

Regards,
Marek



