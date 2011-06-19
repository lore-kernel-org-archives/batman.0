Return-Path: <plettpc@gmail.com>
MIME-Version: 1.0
Date: Sun, 19 Jun 2011 08:13:39 +0200
Message-ID: <BANLkTi=1-+rypSNN-GJvi1rCh_W_SCVH0w@mail.gmail.com>
From: wayne abroue <plettpc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Vis server
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

Hi All

I'm trying to interogate vis on a bat-adv server node, Can anybody
point me in the right direction, It's for use with this
http://villagetelco.org/2011/06/spud-simple-unified-dashboard-for-mesh-networks/
It works with batman, but not with bat-adv.

Wayne


On 17 June 2011 20:54, wayne abroue <plettpc@gmail.com> wrote:
> Hi All
>
> I am trying out spud, looks very good, I'm just needing some info ,
> google fu is not up to it I'm afraid.
> The php scrip interrogates a vis server, I do not have Afrimesh setup,

You do need a VIS server but Afrimesh is not required to make Spud work.

> Vis is running on my bat-adv network, Gateway node set as vis server
> on node and it's accepting info from rest of the network.

We haven't actually tried Spud with the batman-adv VIS server so we'd
need to check that it was giving the same output as the batman VIS
server.

> However, It seems I need a external vis server for the script to
> interrogate. Or is there a way to interrogate the vis server node from
> this machine?

In theory, as long as you can see the IP address of the node running
the VIS server, that should be sufficient.  It may be an
incompatibility with the batman-adv VIS output.

Cheers... Steve

>
> Wayne
