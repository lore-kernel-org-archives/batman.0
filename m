From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batmand 0.3 + freifunkfirmware
Date: Mon, 2 Jun 2008 10:17:53 +0800
References: <50872.209.206.168.53.1212239575.squirrel@webmail.reglue.org>
In-Reply-To: <50872.209.206.168.53.1212239575.squirrel@webmail.reglue.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806021017.53260.lindner_marek@yahoo.de>
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

On Saturday, 31. May 2008 21:12:55 dondavis@reglue.org wrote:
> freifunk-batman is incompatible with batmand 0.3
> I tried installing freifunk and the batman 0.3 package from
> http://downloads.open-mesh.net/batman/stable/wrt-freifunk/batmand_0.3-rv105
>7_mipsel-wr-elf-32-lsb-dynamic.ipk (no freifunk batman) on the commandline. 
> Package is installed.  I start batmand br0 (which worked quite well in
> batman 0.2)
> I can no longer log into the router via ssh or web.
> Is using the bridge to be avoided in 0.3?  Is it because I'm not
> specifying all interfaces?

One of the 0.3 features is advanced policy routing which probably is your 
problem. Please have a look at our documentation:
http://open-mesh.net/batman/doc/RoutingVodoo

Greetings,
Marek
