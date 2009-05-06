From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 6 May 2009 13:15:08 +0800
References: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
	<200905060006.19114.lindner_marek@yahoo.de>
	<bad82a80905051111t8acb76aoedb7d57c3d42141e@mail.gmail.com>
In-Reply-To: <bad82a80905051111t8acb76aoedb7d57c3d42141e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905061315.09151.lindner_marek@yahoo.de>
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

On Wednesday 06 May 2009 02:11:57 Arc Riley wrote:
> I haven't found any such video on the website.  Is the vis server setup for
> batman-adv or just the layer 3 batman?  Is the protocol used for nodes to
> announce their status documented?
>
> We're building a desktop/mobile app using OpenStreetMap data and Mapnik, we
> don't want to require Internet access to view available nodes from any
> user's connection to the mesh so that it can be used to view and diagnose
> the network in any situation.  If that software could listen to the node
> status announcements ("I have X quality link with node A, Y quality link
> with node B, Z quality link with node C"), along with nodes announcing
> other properties including long/lat, wifi protocol and signal, etc, this
> should be very easy to show colored links indicating their quality.
>
> Since we need local link status from nodes, and not the compiled quality to
> route to any node, listening to OGM frames is not enough.

What you want is the vis server that does all that for you. In the /proc 
filesystem you will find a file called "vis" which outputs all the data you want 
in the well-known dot draw format. You can use any dot draw parser to generate 
a map for your mesh.
Basically, this vis server is quite similar to the layer 3 vis server but it 
is integrated into the module (no additional programs needed - just activate 
it). 
Once your network grows you will appreciate the vis server sync feature.  :-)

The video can be downloaded here:
http://downloads.open-mesh.net/batman/misc/24C3-Wireless_Kernel_Tweaking.mkv
and other documentation can be found here:
http://open-mesh.net/wiki/UserDocs


> How about running this as a custom DHCP server which uses the above
> mentioned data to determine the "best" gateway on that network and return
> the relevant information (IP, netmask, gateway IP) to each client with a
> timeout sufficient for dealing with mobile users in a reasonable amount of
> time.

We thought about a modified client which would query the local module for the 
link quality information before accepting DHCP answers. Implementing a client 
might be easier than the server.


> Bonding as in when two nodes have multiple direct connections to each
> other, dividing frames accordingly rather than continually switching all
> traffic to the highest quality link.
>
> This would be very useful for multi-radio routers operating multiple links
> on different channels (or even 802.11G vs 802.11A) between the same set of
> nodes.  Standard ethernet bonding is not preferable since you'd want the
> mesh protocol to use lower TQ links (ie, channel 6 gets periodic high
> interferance) less than higher TQ links (ie, 802.11A often has little
> interferance).

Thats what we mean with "short distance" bonding. I agree with you - it could 
be very valuable.

Regards,
Marek

