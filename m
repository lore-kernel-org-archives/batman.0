Date: Sun, 16 Nov 2008 19:12:52 +0200
From: Jan Groenewald <jan@aims.ac.za>
Subject: Re: [B.A.T.M.A.N.] ipkg install batman over ssh: postinst failsi
Message-ID: <20081116171252.GC27634@aims.ac.za>
References: <20081116154159.GC26177@aims.ac.za>
	<200811170046.24693.lindner_marek@yahoo.de>
	<20081116165312.GB27634@aims.ac.za>
	<200811170105.56871.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200811170105.56871.lindner_marek@yahoo.de>
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

Hi

On Mon, Nov 17, 2008 at 01:05:56AM +0800, Marek Lindner wrote:
>  The ipk files from our servers are plain batmand binaries and come without any 
> start skript. How it runs is up to you. I suggest you create a very simple 
> start script for your own needs:
> 
> 1. create an ip alias for batman (ifconfig eth1:bat x.,x.x.x)
> 2. start batmand using that interface (batmand eth1:bat)

OK, they seem to be running due to the nvram settings from the previous batmand.
I do want them to last over flashes.
 
> Another idea: Simply reuse the IPs from your OLSR network - just change the 
> first byte. It will be easier to recognize the nodes.

This is done from the previous freifunk-batman network migration.
 
> Yes, uninstall would be best. There is no other web interface I know of. If 
> you update the current webif many people would be happy about it.  :-)

OK, now where is the main config file please? Or is it only nvram, and is it still
reading those? So I'm down to the command line only? It is fine, I just want to 
understand. I won't be doing the webif soon, but maybe later... still learning.

regards,
Jan
