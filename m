Return-Path: <SRS0=9/gF=XT=goodmis.org=rostedt@kernel.org>
Message-ID: <20220714164331.060725040@goodmis.org>
Date: Thu, 14 Jul 2022 12:43:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 17/23] batman-adv: tracing: Use the new __vstring()
 helper
References: <20220714164256.403842845@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Instead of open coding a __dynamic_array() with a fixed length (which
defeats the purpose of the dynamic array in the first place). Use the new
__vstring() helper that will use a va_list and only write enough of the
string into the ring buffer that is needed.

Link: https://lkml.kernel.org/r/20220705224751.080390002@goodmis.org

Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 net/batman-adv/trace.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index d673ebdd0426..67d2a8a0196c 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -40,16 +40,13 @@ TRACE_EVENT(batadv_dbg,
 	    TP_STRUCT__entry(
 		    __string(device, bat_priv->soft_iface->name)
 		    __string(driver, KBUILD_MODNAME)
-		    __dynamic_array(char, msg, BATADV_MAX_MSG_LEN)
+		    __vstring(msg, vaf->fmt, vaf->va)
 	    ),
 
 	    TP_fast_assign(
 		    __assign_str(device, bat_priv->soft_iface->name);
 		    __assign_str(driver, KBUILD_MODNAME);
-		    WARN_ON_ONCE(vsnprintf(__get_dynamic_array(msg),
-					   BATADV_MAX_MSG_LEN,
-					   vaf->fmt,
-					   *vaf->va) >= BATADV_MAX_MSG_LEN);
+		    __assign_vstr(msg, vaf->fmt, vaf->va);
 	    ),
 
 	    TP_printk(
-- 
2.35.1
