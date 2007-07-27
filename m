From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
Date: Fri, 27 Jul 2007 16:07:24 +0200
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
In-Reply-To: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707271607.24544.lindner_marek@yahoo.de>
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


this question was a bit forgotten.  :-)

> how does batmand detect whether the internet connection is really connected
> to the internet or not. Or does batmand just relays on the -g parameter.
> Until now we let run a cron job that checks for the real working
> gateway. Because we can not relay on the presence of the default
> route. User may use a different
> router to connect to the internet and just add the default route this
> private router.
> The problem is that the node offering a internet connection (-g)
> should also be able to access other internet connection if its local
> connection is brocken.

First of all, "-g" is just flooded through the network. We also want some kind 
of "dyngw"-plugin but with a better approach: By using tunnels to the gateway 
batman is in a far better situation than OLSR. The "is internet really 
available" check can be done on the client side and is therefore much more 
reliable. With batman 0.3 all the packet flow towards and from the internet 
is going through batman. Batman just has to check whether traffic is coming 
back through the tunnel after sending packets to the internet. If this is not 
the case the batman node offering the internet is blacklisted and another 
gateway is chosen.
This has not been implemented yet but all the neccessary basics for that 
feature are completed by now. Expect this feature to come in the following 
weeks.

Regards,
Marek
