From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] one-way / two-way tunnel (was: Memory leak)
Date: Mon, 7 Jan 2008 17:48:36 +0100
References: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
	<200801071045.10747.axel@open-mesh.net>
	<20080107135602.eigmai3tpko40c40@webmail.ddmesh.de>
In-Reply-To: <20080107135602.eigmai3tpko40c40@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801071748.36253.axel@open-mesh.net>
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

On Montag 07 Januar 2008, Freifunk Dresden wrote:
> Hi,
>
> The batmand is running on WRT54GL and WRT54GS. The firmware is
> whiterussian_rc6
> and the batmand was self-compiled from within whiterussian devel env.
> I have removed the "-static" LDFLAG and also removed the
> DEBUG/MEMORY... CFLAGS.
> As optimation I have used -Os to keep the batmand small which also produces
> a lot of warnings.
if you have 30k left, try -O1. Then there should be no warnings. 

playing with different optimization levels (all dynamically linked and 
stripped) :
194783 b  with -O1  -DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA
190675 b  with -O1
162019 b  with -O2
174247 b  with -O3

I once did some cpu-load experiments to estimate the benifits of -O1..-O3 and 
could not identify any significant differences between the different compiler 
optimizations.

By the way, at the 24c3 somebody managed to stip more useless data from the 
binaries than I achieved with the whiterussion sstrip. Does anybody know how 
this is possible and what's the difference between strip and sstrip ?

> I'm not at home to give you the correct CFLAGS.
>
> > one-way-tunnel are completely stateless. No assigned virtual IPs, no need
> > for SNAT,... Data is only tunnelled from the GW-Client to the GW-Node.
> > THere it is de-tunnelled and forwarded. We used this setup at the 24c3 to
> > let batman client nodes be accessible via global unique IPs.
>
> I'm still confused about the data traveling over the one/two way
> tunnels and what
> the differences are for data travel (request/answer).

an original packet, generated at the client node and forwarded into the bat0 
tunnel will be wrapped as UDP payload and send to the GW node. IP src and dst 
address of the inner (original packet) are not changed. The inner (original) 
packet does usually contain:
 - Any global unique IP address from a distant server
 - the GW-Client node primary batman interface as the src address. 
The outer IP header will contain: 
 - the GW-Nodes' primary batman interface as the dst address and 
 - the GW-Client nodes' primary batman interface as the src address. 
Once arrived at the GW-node the inner (original) packet is detunnelled ( 
unwrapped ) and forwarded to the destination address of the original packet.

Once a reply/answer to the original packet arrives at the GW node it'll 
contain the GW-Client node primary batman interface as the dst address and is 
forwarded. Thats it.


> What IP does the tunnel interface have for the one-way tunnel? Same as
> the main interface? 
- on the GW-Client node: Yes, same as the primary batman interface 
- on the GW-Node, depending of what you configured as the GW-tunnel range   

( --dangerous: )
       --gw-tunnel-network <ip-address/netmask> : set tunnel IP-address 
         range leased out by GW nodes.
         Only relevant for GW-nodes in two-way-tunnel mode
          default: 169.254.0.0/22, allowed netmask values: 20 <= value <= 30

If you only want to use one-way-tunnel and do not want to see an ip address 
here you can use --gw-tunnel-network 0.0.0.0/30 . 

> If a client creates a tcp connection then ACKs and answers 
> should come back through this one-way-tunnel, doesn't it?
no, answers are not tunnelled, see above.
> What dis/advantages does a two-way-tunnel have against the one-way-tunnel?
more cpu load (every downlink packet must be entunnelled and usually you have 
much more downlink traffic than uplink), less protocol overhead (no 
additional IP/UDP header), less need for SNAT. See also this thread:
https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2007-November/000407.html
> For the one-way-tunnel how many tunnel interfaces are created?
> For 
> each connecting client one interface or only one interface for all?
Always only one, no matter how many clients, secondary interfaces, one-way or 
two-way tunnel
> How does the GW
> route packets to a specific client if the GW has a route over the wlan
> interface and a route to the tunnel interface?
If you are talking about a batman GW-node which is participating in the mesh 
then it should have a host, HNA, or IF route to each other batman node. This 
will be used for forwarding the packet towards the client node. 

If you are talking about a non-batman GW, you must set a network route 
explicitly to the batman GW-node.

> Please let me know if there is already a documentation for this.
in progress... (i see, this answer gets boring)
>
> Currently I'm using the two-way-tunnel and this works find. the only
> "bad" thing is that the proxy running on the GW does display the 169er
> IP addresses and not
> the node main ip. But this is ok.
>
> Perhaps the one-way-tunnel would be better because the memory
> consumption on the GW. 
Memory consumption should usually not be an issue. 
> If you have some hints on that, please let me 
> know.
>
> /Stephan
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


