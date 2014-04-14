Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 14 Apr 2014 16:03:21 +0200
Message-Id: <1397484205-20905-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1397484205-20905-1-git-send-email-antonio@meshcoding.com>
References: <1397484205-20905-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] mac80211: add new RC API to retrieve
	expected throughput
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

In order to make mac80211 export the expected throughput,
a new API which extracts such information from any mac80211
SW RC algorithm is needed.
Therefore add the new get_expected_throughput() member
to the rate_control_ops structure.

The exported value is expressed in Mbps/100. Such unit has
been chosen because it is the highest precision that
MinstrelHT can return.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 include/net/mac80211.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0efe37c..47b891a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4480,6 +4480,9 @@ struct rate_control_ops {
 	void (*add_sta_debugfs)(void *priv, void *priv_sta,
 				struct dentry *dir);
 	void (*remove_sta_debugfs)(void *priv, void *priv_sta);
+
+	u32 (*get_expected_throughput)(void *priv, void *priv_sta,
+				       struct ieee80211_supported_band *sband);
 };
 
 static inline int rate_supported(struct ieee80211_sta *sta,
-- 
1.8.3.2

