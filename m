Return-Path: <hannes.harms@tu-bs.de>
From: Hannes Harms <hannes.harms@tu-bs.de>
Message-ID: <5732316F.7020209@tu-bs.de>
Date: Tue, 10 May 2016 21:07:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Unable to ping interface in ap mode / client mode
	with IP4 addr
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

I want to set up bat0 on top of a wifi interface in ap mode
and another machine with bat0 on top of a wifi interface in client mode.

Via iw dev wlan0 station dump I can seen that both are connected.
Via batctl o I see the connected node.
Via batct ping mac addr  I can ping each other.

But I can not ping with an IP4 addr.

bat0 was added to a bridge interface with a static IP on both machines.
No DHCP server is running, because only static IPS are needed.

Did I miss something?

Regrads
Hannes


