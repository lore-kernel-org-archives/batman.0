From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Can't build a mesh network
Date: Thu, 18 Dec 2008 14:32:45 +0800
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<5dfe3cd98da52153d44b79b834280707.squirrel@unimail.uni-dortmund.de>
	<48e8355278083c6883a51b059432df08.squirrel@unimail.uni-dortmund.de>
In-Reply-To: <48e8355278083c6883a51b059432df08.squirrel@unimail.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812181432.58146.lindner_marek@yahoo.de>
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

> its me again...
> I fixed my problem, that I mentioned in the previous message. I choosed
> the wrong interface, this was the mistake...

ok, thanks for letting us know.


> But I have still a problem...
>
> After maybe 10 minutes, the connection is broken between the Laptop and
> the Routers...
>
> Has anybody experience with this issue...

As Elektra mentioned this problem might be related to the wifi layer itself and 
not to batman. You can try to connect to your routers with your notebook 
without using batman (configuring the IPs and set the routing table entries 
manually). If the connection still brakes its a wifi problem.

Btw, you should consider upgrading to batman 0.3 (0.2 is quite outdated). 
Version 0.3 is our current stable. Also, expect the 0.3.1 release soon.


Marek

