Message-ID: <fe4fe3c70bcbdcf1ead4c86cc18349db.squirrel@wm.ddmesh.de>
In-Reply-To: <20081218131736.GM17616@terastar.local>
References: <20080912232420.GA9669@sven-desktop.lazhur.ath.cx>
	<200809171100.22178.axel@open-mesh.net>
	<11de18502b175436206cf97736ac12af.squirrel@wm.ddmesh.de>
	<200809211558.54635.axel@open-mesh.net>
	<fcd11f054a43f09a9bac569c394d0d85.squirrel@wm.ddmesh.de>
	<20081218131736.GM17616@terastar.local>
Date: Fri, 19 Dec 2008 11:08:16 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] policy-routing-script issues
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

> Please give an example: which dns server is n/a from which provider?
> (i think it's an urban legend...)
I have seen this here in dresden with telekom and arcor dns servers. I used the dns server
from telekom that we got while connecting via DSL. This is not working if the router that offers
internet connection is connected to VDSL or Alice. I could use DNS server of acor for the
router that was connected to the VDSL.
But as you can not predict which gateway is used, you must habe a different solution.
I therefore use a script that always set the dns server to the router ip that currently is used
as gateway. The router ensures that dns is working.

/Stephan

---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


