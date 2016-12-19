Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 19 Dec 2016 12:25:29 +0100
Message-Id: <20161219112535.9446-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC PATCH 0/6] batman-adv: broadcast packet
	aggregation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

Here is a first patchset to reintroduce aggregation support for BATMAN V, too.
And while at it, for BATMAN VI, VII... etc, as well - in fact, it allows
aggregating any batman packet with a broadcast destination ;).

I am sending it as an RFC for now as compat code is still missing. And although
it was tested in VMs, I still need to do some stress testing on some
embedded routers.

Regards, Linus

PS: Requires: "batman-adv: Introduce packet type independent TVLV handler API"
(1ddd189528fc, available on patchwork or linus/aggregation branch)

