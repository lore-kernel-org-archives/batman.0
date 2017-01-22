Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 22 Jan 2017 21:40:42 +0100
Message-Id: <20170122204043.29668-3-linus.luessing@c0d3.blue>
In-Reply-To: <20170122204043.29668-1-linus.luessing@c0d3.blue>
References: <20170122204043.29668-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: compat: fix compile error
	for cfg80211_get_station on v3.15
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

station_info::expected_throughput is present since 3.16, not 3.15,
resulting in compile errors for 3.15. Fixing this by using the correct
kernel version in compat.h.

Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 compat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index 8628cf5..5397629 100644
--- a/compat.h
+++ b/compat.h
@@ -130,7 +130,7 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 10, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 15, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
 
 /* the expected behaviour of this function is to return 0 on success, therefore
  * it is possible to define it as 1 so that batman-adv thinks like something
@@ -149,7 +149,7 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif
 
-#endif /* < KERNEL_VERSION(3, 15, 0) */
+#endif /* < KERNEL_VERSION(3, 16, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
 
-- 
2.1.4

