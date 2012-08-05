Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
From: Gui Iribarren <gui@altermundi.net>
Date: Sun, 5 Aug 2012 03:26:43 -0300
Message-ID: <CAHD-aqJubnMBSuyjyS+aOXnS8FSQe=w8Aj2-SnaohNqXSs_xJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] propagate gw_mode over two mesh linked by ethernet
	with bla2
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Here i am again,
the involuntary stress-tester of gw_mode + bla2
and mailing-list readers' headache ;)

Given the setup described here
http://www.open-mesh.org/attachments/download/128

let's say one node in mesh1 sets gw_mode=server
any node in mesh1 will list it in "batctl gwl"

but nodes in mesh2 won't get it, since backbone gateways (BGs) of
mesh2 only get claims from BGs of mesh1, which do not include gw_mode
status

with bla1 setup, OGMs did flood the ethernet backbone, carrying
gw_mode information, and both mesh1 and mesh2 would get to know
gateways
I miss that functionality! :(

so, as Simon himself suggests [0] in the wiki' shortest-ever FAQ ;),
having full control of the ethernet backbone, I batctl-if-added an
ethernet vlan on BGs of both sides of the ethernet cable.

OGMs flood the ethernet backbone again as expected; running "batctl o"
in mesh1 nodes show nodes from mesh2, and viceversa; i smiled!
unfortunately, trying to get a DHCP lease while connected to a mesh
node was again malfunctioning :(
a couple of quick "batctl td", and i thiiiink that looked like dhcp
request packets were being dropped at the backbone gateway, kinda like
the "check incoming type for bla" bug, but i didn't try to narrow it
down
instead reverted configs back to gw_mode=off and things started working again

i won't dig much into that since it's quite possible i entangled up my
configs yet again, so i'll focus on the original question:
are there any plans (or is it even feasible) to propagate gw_mode
status through the ethernet backbone (assuming not sending OGMs)?
maybe including/appending it in claim frames?

what i understand so far is that with current blaII, meshes connected
solely by ethernet backbone (which can't overhear each other OGMs
through wifi) only know which macs are "on the other side of the eth
backbone" so as to keep the single broadcast domain united, but are
fragmented in terms of VIS data, gw, TT, and orig table.

sorry if i'm asking obvious questions, the blaII wiki explains notably
clear the model, but is missing gw_mode interactions, and it wasn't
evident to me how would that work - in fact, coming from bla1, i
wrongly assumed it would be similar. if it's relevant, i can try to
add validated snippets from this thread to the wiki[0]

[0] http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-II
