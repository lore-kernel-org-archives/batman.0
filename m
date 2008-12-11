From: Axel Neumann <neumann@cgws.de>
Subject: Re: [B.A.T.M.A.N.] Want to count the number of nodes connecting to a
	batman gateway
Date: Thu, 11 Dec 2008 10:50:53 +0100
References: <1228438302.11385.65.camel@desiree>
In-Reply-To: <1228438302.11385.65.camel@desiree>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812111050.54047.neumann@cgws.de>
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
To: david.lloyd.johnson@gmail.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,

Currently this information is not provided by bmx. 
In two-way-tunnel mode this information is knwon by the daemon but not 
accessible with any debug output. I've also casually recognized the need for 
this information (including timeout and last request timestamps) in order to 
better understand and debug various gw scenarios.  So for the two-way-tunnel 
its not a big issue, I have it on my todo list. 
But for one-way-tunnel it would mean additional overhead and introducing some 
stateful functions&datastructures into a currently stateless gw mechanism.

Theoretically, the connected gw-clients could be identified by the different 
source addresses passing the bat0 interface of the gateway node (using 
tcpdump, iptables,...).  But honestly, I am not aware of any elegant way to 
catch these addresses.

ciao,
axel



On Freitag 05 Dezember 2008, david johnson wrote:
> Hi
>
> I'm busy trying to adapt batman-exp to do some fair bandwidth allocation
> and to do this I need each tunnel from a client to be shown as a
> seperate vpn.  Or I need a way to count the number of nodes connecting
> to the gateway
>
> Do you know how I could  do this?
>
> David
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


