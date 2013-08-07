Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  8 Aug 2013 00:21:31 +0200
Message-Id: <1375914091-2808-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: make the TT CRC logic VLAN specific
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

This change allows nodes to handle the TT table on a
per-VLAN basis. This is needed because nodes may have to
store only some of the global entries advertised by another
node.

In this scenario such nodes would re-create only a partial
global table and would not be able to compute a correct CRC
anymore.

This patch splits the logic and introduces one CRC per VLAN.
In this way a node fetching only some entries belonging to
some VLANs is still able to compute the needed CRCs and
still check the table correctness.

With this patch the shape of the TVLV-TT is changed too
because now a node needs to advertise all the CRCs of all
the VLANs that it is wired to.

The debug output of the local Translation Table now shows
the CRC along with each entry since there is not a common
value for the entire table anymore.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 packet.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/packet.h b/packet.h
index 08e175a..f4bbb05 100644
--- a/packet.h
+++ b/packet.h
@@ -391,14 +391,26 @@ struct batadv_tvlv_gateway_data {
  * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
  * @flags: translation table flags (see batadv_tt_data_flags)
  * @ttvn: translation table version number
- * @reserved: field reserved for future use
- * @crc: crc32 checksum of the local translation table
+ * @vlan_num: number of announced VLANs. In the TVLV this struct is followed by
+ *  one batadv_tvlv_tt_vlan_data object per announced vlan
  */
 struct batadv_tvlv_tt_data {
 	uint8_t flags;
 	uint8_t ttvn;
+	__be16  num_vlan;
+};
+
+/**
+ * struct batadv_tvlv_tt_vlan_data - vlan specific tt data propagated through
+ *  the tt tvlv container
+ * @crc: crc32 checksum of the entries belonging to this vlan
+ * @vid: vlan identifier
+ * @reserved: unused, useful for alignment purposes
+ */
+struct batadv_tvlv_tt_vlan_data {
+	__be32	crc;
+	__be16	vid;
 	uint16_t reserved;
-	__be32  crc;
 };
 
 /**
-- 
1.8.1.5

