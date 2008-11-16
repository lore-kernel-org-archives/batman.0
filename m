From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] ipkg install batman over ssh: postinst failsi
Date: Mon, 17 Nov 2008 01:05:56 +0800
References: <20081116154159.GC26177@aims.ac.za>
	<200811170046.24693.lindner_marek@yahoo.de>
	<20081116165312.GB27634@aims.ac.za>
In-Reply-To: <20081116165312.GB27634@aims.ac.za>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811170105.56871.lindner_marek@yahoo.de>
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

On Monday 17 November 2008 00:53:12 Jan Groenewald wrote:
> Thanks. Will this still run in test mode next to OLSR? Can I leave the
> nvram settings as is? 

The ipk files from our servers are plain batmand binaries and come without any 
start skript. How it runs is up to you. I suggest you create a very simple 
start script for your own needs:

1. create an ip alias for batman (ifconfig eth1:bat x.,x.x.x)
2. start batmand using that interface (batmand eth1:bat)

Another idea: Simply reuse the IPs from your OLSR network - just change the 
first byte. It will be easier to recognize the nodes.


> Should I uninstall freifunk-batman (is that the
> webif?). Is there any other webif?

Yes, uninstall would be best. There is no other web interface I know of. If 
you update the current webif many people would be happy about it.  :-)

Regards,
Marek

