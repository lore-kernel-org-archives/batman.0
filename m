Message-ID: <59864.212.147.148.167.1217448919.squirrel@www.rivertowermail.com>
Date: Wed, 30 Jul 2008 21:15:19 +0100 (IST)
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Multi-card MESH
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
To: b.a.t.m.a.n@open-mesh.net


Hi,

Is it possible to use BATMAN with two backbone network cards?

I am hoping to make nodes with three radio cards - two at 5Ghz and one
2Ghz card for customer access.

I have been playing around with openwrt on gateworks boards (4 miniPCI
slots) and three radio cards.  In my testing I've only been using typical
AP / STA setups on the "backbone" radio cards and I'm using OSPF to handle
dynamic routing.  I'm handing my MESH "intelligence" (making one node's
STA card associate to a close-by strong signal node's AP card) with Perl
scripts.

I've got problems with my test system not avoiding circular loops and
ignoring the bandwidth supply node(s).  I think I've gone on the wrong
path trying to re-invent the MESH wheel so I'm now looking into BATMAN as
a possibility.

thanks for any information!

Derek




-- 
Derek C

