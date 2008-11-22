From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN routing (via gate0)
Date: Sun, 23 Nov 2008 00:35:05 +0800
References: <57356.149.5.32.200.1227370855.squirrel@www.rivertowermail.com>
In-Reply-To: <57356.149.5.32.200.1227370855.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811230035.05534.lindner_marek@yahoo.de>
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

On Sunday 23 November 2008 00:20:55 Derek C wrote:
> I see that BATMAN makes a tunnel to the gateway and then routes traffic
> via the 169.254 gate0 subnet
>
> Does this mean that all outgoing from the node should be NATed?  or is it
> possible for the upstream node(s) to ping the node via its true IP address
> (5.255.XXX.XXX) ?

The tunnel is used for internet traffic only. Within the mesh you can use the 
mesh ip addresses.

Regards,
Marek

