From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] strange default routes
Date: Tue, 16 Oct 2007 15:15:02 +0200
References: <BLU122-W10D014E29FA86CA3739C9AF6A30@phx.gbl>
	<6792.85.41.146.90.1192460098.squirrel@krisma.oltrelinux.com>
	<BLU122-W22ECF92C81BC9F2EB9400AF6A30@phx.gbl>
In-Reply-To: <BLU122-W22ECF92C81BC9F2EB9400AF6A30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710161515.02658.lindner_marek@yahoo.de>
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

> the problem semms to be found and very much trivial. the recent
> openWRT-release (or especially the ixp4xx-port ?!) as well as the rather
> old slackware10.2 comes _without_ policy-routing compiled into the kernel.
> figure this out ... an OS for embedded routers comes without advanced
> routing capabilities ... nothing i've expected. nevertheless batman should
> detect this and give a hint rather than trying to write to non-existent
> routing-tables.

this sounds odd. A check for policy routing seems to be a good idea but does 
anyone know how to check that ?

Regards,
Marek
