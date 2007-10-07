From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batmand terminates silently
Date: Sun, 7 Oct 2007 22:26:41 +0200
References: <20070925091716.ummlm5rfkgs8000o@webmail.ddmesh.de>
	<200709251200.21204.axel@open-mesh.net>
In-Reply-To: <200709251200.21204.axel@open-mesh.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200710072226.41589.axel@open-mesh.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Hi Stephan,


you can use rv 687 with
--resist-blocking-send 
which lets daemon survive if firewall blocks outgoing OGMs

regards
axel


> > few weeks agoe I had sometimes the problem that batmand (experimental)
> > exits silently. Today I found maybe one reason for this.
> > When you have batman running and insert the iptable rule
> >
> > iptables -I OUTPUT -o eth1 -j DROP
> >
> >
> > batmand exits. This also happen for additional interfaces controlled
> > by batmand.
>
> Ah sure,
> its not a bug, its a feature :-)
> Batman checks if packets generated on its behaf are blocked by a firewall
> and exits if this is the case.
> The assumption when implementing this was, that usually the firewall is
> configured before batmand is started and not touched later on.
>
> In the assumed case the immediate exit helps to directly indicate the
> problem to the maintainer of the node. Actually debuglevel 3 should report
> this.
>
> Of course in your fancy setups this might be undesirable and having an
> option to disable this feature is a good idea. Put this on the todo list.
>
> ciao,
> axel
