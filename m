Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/3] batctl: tcpdump: Add support to identify missing packets
Date: Sun,  9 Jun 2019 18:56:49 +0200
Message-Id: <20190609165652.12841-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

when running batctl's tcpdump today on a normal batman-adv slave interface,
you will see warnings like:

  Warning - packet contains unknown batman packet type: 0x41
  Warning - packet contains unknown batman packet type: 0x02

This is caused by missing dumping routinges in the tcpdump implementation.
Since these packets (coded, fragmented) cannot be decoded/reassembled
easily these packets are only identified and some basic header informations
are shown.

Also not all TVLVs in the header were shown. The mcast part was dropped and
thus the debugging of the new mcast feature flags was not possible with
batctl.

Kind regards,
	Sven

Sven Eckelmann (3):
  batctl: tcpdump: Add support for MCAST TVLV
  batctl: tcpdump: Add support for unicast fragmentation
  batctl: tcpdump: Add support for coded packets

 tcpdump.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tcpdump.h |   1 +
 2 files changed, 110 insertions(+), 1 deletion(-)

-- 
2.20.1

