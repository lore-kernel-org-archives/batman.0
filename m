From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] running batman as non-root
Date: Fri, 14 Sep 2007 16:55:16 +0200
References: <46EA5834.6030703@ddmesh.de>
In-Reply-To: <46EA5834.6030703@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709141655.16137.lindner_marek@yahoo.de>
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

> I'm running batman (experimental) on a debian linux as root but want to
> access the debug levels (batmand -c -b -d 1) from within a apache that
> is not running as root.

indeed a problem. As quick fix you could use sudo and allow www-data to access 
batmand.


> batman actually checks the user id and does not allow to run as non-root
> users. also when I disable the check, batman can not access the
> /var/run/batman.socket except when I change the access modes from
> command line.

That is why batman checks the user id ...


> Is it possible to also support non root access for batmand -c -b -d 1?

The question is: Do we really want that ? I understand your case but your 
solutions implies that other non-privileged could access the daemon. 
The "batmand -c" command can do much more than giving you the debug output as 
changing the gateway_class / routing_class / preferred gateway and may be 
more in the future.


Regards,
Marek
