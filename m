Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 26 Jan 2010 08:20:58 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
In-Reply-To: <201001242303.56730.sven.eckelmann@gmx.de>
Message-ID: <20100126072058.181620@gmx.net>
MIME-Version: 1.0
References: <20100124211718.37790@gmx.net>
	<201001242303.56730.sven.eckelmann@gmx.de>
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] batman-adv mujlticast [WAS: Re: batman-adv on
 different archs]
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


-------- Original-Nachricht --------
> Datum: Sun, 24 Jan 2010 23:03:48 +0100
> Von: Sven Eckelmann <sven.eckelmann@gmx.de>
>
> Ok, so we have a real simple example here. We see that we have a "large" 
> ethernet frame (unlike batman-adv) and a "unnormal" ethernet type. So
> maybe 
> you could forward rawsend.log and rawsend.c to the driver developers. They
> should be able to find and fix the problem with such a real small example.
> Or 
> does anyone see a related problem in rawsend.c?

Thanks for the analysis, I'll try to get this solved with the driver.
 
> What is the batmand stuff for?

I'm evaluating the batmand for routing multicast audiostream in a mesh. Batmand seems to be doing the routing better than olsr, but the lack of multicast is a problem, hence batman-adv.

I tried batman-adv and multicast routing with couple of laptops, but it did not work quite well. Some packages seemed to be left ping-ponging in the mesh, while others disappeared completely. Is batman-adv multicast being actively used somewhere?

-Juha
-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/chbrowser
