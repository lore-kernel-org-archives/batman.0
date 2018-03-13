Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 13 Mar 2018 11:41:11 +0100
Message-Id: <20180313104113.19654-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v3 0/2] batman-adv: netlink support for DAT
 and MCAST
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

This patchset adds netlink support for dumping DAT cache and multicast
flags tables.


Changes in v3:
==============
- renamed netlink attributes:
  - BATADV_ATTR_DC_ADDRESS   -> BATADV_ATTR_DAT_CACHE_IP4ADDRESS
  - BATADV_ATTR_DC_HWADDRESS -> BATADV_ATTR_DAT_CACHE_HWADDRESS
  - BATADV_ATTR_DC_VID       -> BATADV_ATTR_DAT_CACHE_VID

Changes in v2:
==============

- Added missing includes, "#include <linux/netlink.h>" and
  "#include <uapi/linux/batman_adv.h>", to distributed-arp-table.c
- Added missing forward declaration for "struct netlink_callback" to
  distributed-arp-table.h
- Changed nla_put_u32() to nla_put_in_addr() for BATADV_ATTR_DC_ADDRESS,
  removed the then obsolete ntohl() conversion
- Added missing include, "#include <linux/netlink.h>", to multicast.c
- Changed nla_put_u8() to nla_put_u32() for BATADV_ATTR_MCAST_FLAGS and
  BATADV_ATTR_MCAST_FLAGS_PRIV to enhance extensibility

