Message-ID: <bc65394302b4195028587d4c09b43fba.squirrel@wm.ddmesh.de>
In-Reply-To: <200812191115.20610.neumann@cgws.de>
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812172114.43427.neumann@cgws.de>
	<3f7879383457743711ac3341637ff601.squirrel@wm.ddmesh.de>
	<200812191115.20610.neumann@cgws.de>
Date: Fri, 19 Dec 2008 12:06:40 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] dublicate HNAs / certificates
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

> I like brainstorming like this.
me too.

> We wanted batmand (and especially its core routing algorithm) to be decentral
> and simple. So no central point of control/failure and therefore also no HNA
> server.
Perhaps there is a different solution. What if everybody may broadcast their HNA
like batman is currently working and batmand get a list of router ip from which
HNA is accepted?
The bad-guy has normally no way to modify the firmware of other routers and can not
tell the batmand to accept its faulty HNA.
In this case batman can be updated requlary by cron-job and needs only check HNA against
it list.
A positiv and negativ list should be possible. Perhaps the list may contain network ranges.
(hcl = hna control list)

the firmware of the router may request the list from a server.
In case a non accepted hna is received, batmand may completely ignore the node, that is injecting
invalid HNA. When I understand you right, batmand currently ignores nodes completely that
are sending the same HNA?

/stephan

---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


