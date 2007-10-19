From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
Date: Fri, 19 Oct 2007 12:51:35 +0200
References: <4717BE98.2010206@ddmesh.de>
	<200710190135.41117.axel@open-mesh.net>
In-Reply-To: <200710190135.41117.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710191251.35340.lindner_marek@yahoo.de>
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

> > The laptop uses a proxy (squid) to only allow some URLs. Also the
> > firewall only allows some specific ip ranges. Does this have any
> > influence for the gateway detection? --------------------------
>
> I dont know!

No. The gateway detection itself is only influenced by the batman originator 
packets.


> > Oct 18 21:54:53 0-1 batmand[13603]: Error - can't create tun device
> > (TUNSETIFF): Device or resource busy Oct 18 21:54:53 0-1 batmand[13603]:
> > Trying to name tunnel to bat2 ... Oct 18 21:54:53 0-1 kernel: bat2:
>
> This is usual as well, batmand is searching for an unused tunnel name.

But unnecessary and confusing. These errors can be avoided.


> >      Gateway              Router (#/128)
> > => 10.12.0.1             10.12.0.1 (123), gw_class 33 - 1024KBit/256KBit,
> > reliability: 0
>
> In the first place, this just indicated that the local batmand has decided
> for one of the available GWs. It does not necessarily mean, that the
> connection to that GW was successfull

Correct. The connection to the gateway itself is triggered as soon as you 
begin to use the tunnel. This output shows you to which gateway the 
connection will be established (assuming that the gateway responds).


> > But the ip route list table bat_default contains only a throw entry and
> > not the default route.
>
> There is no default route until the client has decided for a GW. After the
> startup, the daemon waits a while before it decides for a GW. This is done
> to gather some statistics about the available GWs.

But his output shows that the client has selected a gateway. Therefore a 
default route should exist. I guess you just looked into the wrong table. I 
assume that "bat_default" is table 67 ?! The batman default route can be 
found in table 68. 



> > :kern.err batmand[6649]: Error - can't receive ip from gateway: number of
> >
> > maximum retries reached
> >
> > The manually added default route is removed after a while by batmand.
>
> It really sounds your GW is not reachable. Check your ip rules and if
> ping 10.12.0.1
> works.

This indicates that port 4306 is blocked at the gateway side. The client will 
ask for an IP an that port.

Regards,
Marek
