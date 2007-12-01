From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Date: Sat, 1 Dec 2007 21:41:59 +0100
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<200712011834.54327.lindner_marek@yahoo.de>
In-Reply-To: <200712011834.54327.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712012141.59334.axel@open-mesh.net>
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

perhaps this has something to do with the reduced maximum-transfer-unit (mtu) 
which ist left for the tunnel interfaces. Since the one-way-tunnel do only 
tunnel the upling-traffic but NOT tunnel the downlink traffic this is not a 
problem when trying to connect to a intractable www server.

Did I understand you correct, that these problems only occurs when surfing to 
a few webservers, but not to all webservers?

Can you try what happens if you reduce the mtu of the outgoing interface at 
the upstream gateway (e.g. ifconfig ethX mtu 1400). I think there might be 3 
possible results:
 1) everything remains as before, there is another reason
 2) the hotmai/msn/live.com or pop services are not reachable anymore from the 
upstream gw. Then we have at least a hint. 
 3) Now these services also work inside the mesh. Maybe the icmp messages 
which are supposed to communicate the path-mtu-problem were not correctly 
transmitted from the tunnel interface but succeed from the upstream gw 
interface to the server. 

ciao,
axel


On Samstag 01 Dezember 2007, Marek Lindner wrote:
> > now i found an issue which i didn't relate with batman
> > first. I got several reports of users, hotmail/msn/live.com
> > not being accessible anymore...
> > Yesterday i found out theres also problems with some pop server
> > not beeing accessible, but everything works fine directly at the
> > upstream gw, without any batmand involved.
>
> Unfortunately, it is too few information to do anything about it. Could you
> describe your experiences in more detail. Here some questions on the way:
>
> - When did you notice the problem for the first time ?
> - Which revision was used ?
> - What exactely is your problem ?
> - Can you describe it in way that i can reproduce it ?
>
> Greetings,
> Marek
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


