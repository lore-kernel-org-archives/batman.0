From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
Date: Fri, 19 Oct 2007 19:52:10 +0200
References: <4717BE98.2010206@ddmesh.de>
	<200710191251.35340.lindner_marek@yahoo.de>
	<4718E6AC.9020100@ddmesh.de>
In-Reply-To: <4718E6AC.9020100@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710191952.10376.lindner_marek@yahoo.de>
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


Hi,

> First the problem was the firewall. As you have mentioned you have been an
> official port number 4305 assigned. Looking into the port list batman uses
> only port 4305. This is why I have assumed that all packages (at least OGMs
> and GW) are using this port.

true, we got 4305 assigned. Due to the internal programm design we could not 
multiplex the the batman originator messages and gateway tunneling over one 
port without a major rewrite. That is why we "hijacked" 4306 and 4307. This 
may change with future releases (after 0.3).
Let me mention that we clearly stated that fact (from the release 
announcement):
Pay attention to the fact that all ports used by B.A.T.M.A.N. are changing: 
4305 for OGMs, 4306 for the tunneling and 4307 for the vis server. Adjust 
your firewall settings if required.


> The second problem is that the documentation speeks about three routing
> tables 65,66,67 where table 67 is used for adding the gateway routes.
> I haven't added a rule to this table 68 (see ip rule below).
> 
> is the table 67 for?
> Are there now four routing tables?

Which documentation ? We should fix that.
Some time ago we had to redesign the policy routing because the kernel would 
parse the entries in the wrong order (which was our mistake). This layout 
change made another table neccessay. In table 67 you (normally) find the 
unreachable rule which you obviously deactivated. Just start batmand with 
full policy routing enabled and you will quickly understand the differences.


> For my understanding, when batman starts it collects packages to decide
> what gateway should be used. It then adds the default route via dev bat0
> and establishes the tunnel via UDP to port 4306.
> The connection should be independent of whether a client (pda connected to
> router or local process) tries to use to connect the internet. If no
> internet connection was used for weeks, batmand should always have the
> default route added. If batman removes this default route, because no
> traffic through the tunnel was present for a while, how does batman detect
> a client trying to make an internet connection later and add this default
> route again?

This happens:
1. batmand analyzes the OGMs, selects a gateway and sets a default route 
towards its tun device (batX/gateX)
2. batmand waits for traffic coming though the tun device
3. on the first packet batmand tries to connect to the gateway and demands an 
IP for the tun device
4. the tunnel is fully established and data can flow through
5. after a certain idle time the IP is removed from the tun device and batmand 
returns to step 2

The removal of the default route can only be triggered if the gateway does not 
hand out an IP or the blackhole detection is reacting. It also happens if you 
select -r 3 and a better gateway is found.


> This only can be batman privat data that are sent over the tunnel, because
> a local process needs the routing entry (default route to dev bat0). Right?

The default route must be always present so that every traffic can start this 
process. Otherwise batmand will never know about your requirement of an IP.


Regards,
Marek
