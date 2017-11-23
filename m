Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:43 +0100
Message-Id: <20171123140444.17119-10-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 09/10] batctl: tcpdump: Fix types for for TT
 v1
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

The num_entry and num_vlan variables are accessed (printed) as u16
variables and not like integers. They should therefore also be stored like
that.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 tcpdump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index 5eb99cf..a1b057b 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -158,7 +158,8 @@ static void batctl_tvlv_parse_tt_v1(void *buff, ssize_t buff_len)
 {
 	struct batadv_tvlv_tt_data *tvlv = buff;
 	struct batadv_tvlv_tt_vlan_data *vlan;
-	int i, num_vlan, num_entry;
+	int i;
+	unsigned short num_vlan, num_entry;
 	const char *type;
 	size_t vlan_len;
 
-- 
2.11.0

