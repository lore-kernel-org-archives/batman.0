From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] freifunk 1.6.8/1.6.9
Date: Tue, 16 Oct 2007 10:28:04 +0200
References: <20071016020242.GA4608@apoderado.ometepe.net>
	<11097.85.41.146.90.1192515839.squirrel@krisma.oltrelinux.com>
	<20071016072328.GC10100@apoderado.ometepe.net>
In-Reply-To: <20071016072328.GC10100@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710161028.04217.axel@open-mesh.net>
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

On Dienstag 16 Oktober 2007, Jan Hetges wrote:
> Hi
>
> On Tue, Oct 16, 2007 at 08:23:59AM +0200, a.anselmi@oltrelinux.com wrote:
> > > is anyone using this on wrt54g ?
> > > i just tried both and batmand_0.3-beta-rv674 gives a segmenation fault
> > > and batmand_0.2-rv502 doesn't start (probably segfault as well).
> > > can someone confirm/deny this?
> > > has someone a link for a working (with batmand)
> > > openwrt-g-freifunk-1.6.x-x.bin/trx ?
> >
> if one reboots the box after the batman installation everything
> is fine (i fell over that before... but didn't remember ;)
>
If you start the daemon with -r, -g, or -p (any GW functionality), then it
might be related to the tun module (kmod-tun). I remember that when installing 
that module it is not loaded automatically. But after the next restart its 
loaded. 

ciao, 
/ axel


> cheers
>
>   --Jan


