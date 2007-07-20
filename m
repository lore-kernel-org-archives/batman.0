From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] TTL-Interface specific
Date: Fri, 20 Jul 2007 17:58:22 +0200
References: <20070720172531.tjq2at48zqo048sk@webmail.ddmesh.de>
In-Reply-To: <20070720172531.tjq2at48zqo048sk@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707201758.22292.axel@open-mesh.net>
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

On Friday 20 July 2007 17:25, Freifunk Dresden wrote:
> Hello,
>
> In the documentation was written that a specific TTL can be assigned
> to each interface. How can I do this from command line?
> I have two interfaces eth1 (wlan) and bbs (a VPN tap tunnel used as
> backbone).
>
> Those interfaces are not bridged and have different ip ranges
> eth1: 10.12.x.x
> bbs: 172.16.x.x
>
> My aim is only to propagate the 10.12.x.x ip range and not the 172.16er.
> The 172.16 of any foreign router should not be listed in any routing
> table of any other router. Only the local interface address of bbs
> should be seen in the routing table.
> I have read that this can be solved by setting the TTL for bbs to a
> value of 1.
> I need to know how I can do this.

We removed this feature from the stable branch because many people were 
confused when using an interface with a small batman-ttl for outgoing 
traffic. In such case, the destination node of the traffic does not know 
where to reply.
In general, no problems occur if the (two-interface) node is not generating 
traffic itself

Currently a -t option is included in trunk/batman-experimental which allows to 
specify the ttl to be used for all interfaces. Applying different ttl-values 
for different interfaces conceptually works but setting these values with the 
command line is on the TODO list.

regards,
axel
