Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Tue, 3 Jul 2012 17:07:17 -0300
Message-ID: <CAHD-aqKoP3NDSWNHv=vOUCF_ANTRkVWGyXq-v=WC8iRPHJkdhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] BLAII + gw_mode, DHCP sometimes gets dropped
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello there again,
I have observed a problem since updating to 2012.2 and enabled BLAII

I'm compiling logs to understand what's happening, but as always,
reading logs only gets me more lost :(
So here i am again begging for help

the setup is the same I described in yesterday's attachment, but
what's not pictured is an ethernet cable between colmena-casa and
f8d11504758.
f8d11504758 is the only router that connects to the internet (through
WAN cable), and it's also the only one that has dnsmasq running and
gw_mode=server.
All the other nodes have gw_mode=client

All of the nodes have bridge_loop_avoidance=1
(even though there are no other utp connections, so it could in fact
be enabled only on colmena-casa and f8d11504758)

with this setup, dhcp requests from the mesh sometimes get "lost",
either they don't reach f8d11504758 or the reply doesn't get out

this didn't happen with batman 2012.1 , setup as indicated by the BLAI
wiki page (batctl if add br-lan)
furthermore, with batman 2012.2 , BLAII activated, but gw_mode=off in
all nodes, DHCP also works fine.

So, a few questions arise:
is it a problem to activate bridge_loop_avoidance=1 in all nodes,
regardless of the fact that they "need" it or not? (that is, it is
activated on nodes that don't have any ethernet cables connected and
couldn't possibly create a bridge loop)

would it make a difference, if I add br-lan to bat0 (batctl if add
br-lan) the way I used to do with batman 2012.1 ?

any other thoughts or ideas?

thanks as always!

Gui
