From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
Date: Fri, 19 Oct 2007 12:32:24 +0200
References: <4717BE98.2010206@ddmesh.de>
	<200710190135.41117.axel@open-mesh.net>
In-Reply-To: <200710190135.41117.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710191232.24426.axel@open-mesh.net>
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

hi,

> > The laptop uses a proxy (squid) to only allow some URLs. Also the
> > firewall only allows some specific ip ranges. Does this have any
> > influence for the gateway detection? --------------------------

You definitely need to configure your firewall to accept port 4306 for GW and 
4307 for visualization support.


regards,
axel
