Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 0/2] batctl: Add generic JSON interface
Date: Thu, 13 May 2021 16:02:32 +0200
Message-Id: <20210513140234.1624460-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>

For the missing JSON debug print a generic JSON print interface is
proposed.
A specific nla_policy is describing (a) the key name of the entry and
(b) the corresponding callback function for printing the value.
If the netlink attribute is not at disposal no entry for that will be
printed.

This patch reffering to following patches:

[1] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/SAQYUZQ7I7H7VWHFPVLBUDYCFX7HNWLO/
[2] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/IV2OFJ2KJX52K4ARZ5MIWZ2A42WOKJRO/
[3] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/EYQBFU5O7E3KKRG2YVPLRGHHN3OFIPYP/
[4] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/WKIBP64G27O23MBAPHECSKNJMUESWFAG/
[5] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/Y3XXIYCJWME4CQNWRBIRYJ6ZOL4MI2FT/
[6] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/LYMU5ZA3I6YVHHRZVY3RJJR4KDHF76QI/

Alexander Sarmanow (2):
  batctl: netlink: Make netlink_query_common non-static
  batctl: genl_json: Add generic JSON interface

 Makefile    |   1 +
 genl_json.c | 359 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 genl_json.h |  24 ++++
 netlink.c   |  12 +-
 netlink.h   |  14 ++
 5 files changed, 402 insertions(+), 8 deletions(-)
 create mode 100644 genl_json.c
 create mode 100644 genl_json.h

-- 
2.25.1

