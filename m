From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
Date: Fri, 27 Jul 2007 17:31:27 +0200
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
	<200707271607.24544.lindner_marek@yahoo.de>
	<002201c7d05e$d1382790$3363a8c0@bluebox>
In-Reply-To: <002201c7d05e$d1382790$3363a8c0@bluebox>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707271731.27248.lindner_marek@yahoo.de>
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


> it's about the gateway himself (not a client-of-the-gateway).
> A gateway router (has to/)should check his default route and change
> his role to 'ordinary-client' => switch working state from -g to
> -r/-p Mode. May think about NATed LAN-clients, too...

this is quite difficult to implement. The dyngw plugin tries to do exactly the 
same thing. Various approaches were already tested and they all had their 
problems. How do you want to find out whether internet is available or not ? 
Ping, traceroute or dns ? As far as I remember we always had situations where 
this detection failed.
The latest example: Run OLSR with the dyngw plugin on a batman host which is 
searching for internet (-r). The plugin will find out that internet is 
available via batman and happily announces a default route in the OLSR 
network ...

I think the difficult part are the endless scenarios we would have to cover. 
But if someone has a good idea I certainly will implement it.  :-)

Regards,
Marek
