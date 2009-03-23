From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 24 Mar 2009 00:55:59 +0800
References: <49C40762.3050109@java-system.com>
	<200903211634.46493.lindner_marek@yahoo.de>
	<20090321085336.GL32483@amd>
In-Reply-To: <20090321085336.GL32483@amd>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903240056.41797.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] What do you think of this result?
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

On Saturday 21 March 2009 16:53:36 Bastian Bittorf wrote:
> in OLSR networks we change the multicast-rate, to allow only links
> with "reasonable" bandwith to be used. Maybe this is also a good
> idea for batman. In a dense network, set you multicast-rate to
> 12mbit on all nodes, in a "normal" network you can use e.g. 5.5 mbit.
> (this helps the routing daemon and does nearly not change the
> normal network behavior)

Basically I agree here. Setting the transfer rate helps stabilizing the 
network. Not so sure why you say "in OLSR networks" as this is more a wifi 
setting rather than a mesh protocol thing. Is that integrated into OLSR ?


> important question:
> are batman-adv-packets transfered in multicast-rate?

batman-adv-packets are ethernet broadcast packets and follow the same 
broadcast mechanisms as IP broadcasts.

Regards,
Marek

