Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/7] batman-adv: Strip dots from variable macro kerneldoc
Date: Tue, 14 Jan 2020 15:23:46 +0100
Message-Id: <20200114142351.26622-3-sw@simonwunderlich.de>
In-Reply-To: <20200114142351.26622-1-sw@simonwunderlich.de>
References: <20200114142351.26622-1-sw@simonwunderlich.de>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The commit 43756e347f21 ("scripts/kernel-doc: Add support for named
variable macro arguments") changed the handling of variable macro
parameters. The three dots of the argument must no longer be added to the
kernel doc. The support for the old format is scheduled to be removed in
the future.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/log.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 741cfa3719ff..41fd900121c5 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -74,7 +74,7 @@ __printf(2, 3);
  * @bat_priv: the bat priv with all the soft interface information
  * @ratelimited: whether output should be rate limited
  * @fmt: format string
- * @arg...: variable arguments
+ * @arg: variable arguments
  */
 #define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)		\
 	do {								\
@@ -98,7 +98,7 @@ static inline void _batadv_dbg(int type __always_unused,
  * batadv_dbg() - Store debug output without ratelimiting
  * @type: type of debug message
  * @bat_priv: the bat priv with all the soft interface information
- * @arg...: format string and variable arguments
+ * @arg: format string and variable arguments
  */
 #define batadv_dbg(type, bat_priv, arg...) \
 	_batadv_dbg(type, bat_priv, 0, ## arg)
@@ -107,7 +107,7 @@ static inline void _batadv_dbg(int type __always_unused,
  * batadv_dbg_ratelimited() - Store debug output with ratelimiting
  * @type: type of debug message
  * @bat_priv: the bat priv with all the soft interface information
- * @arg...: format string and variable arguments
+ * @arg: format string and variable arguments
  */
 #define batadv_dbg_ratelimited(type, bat_priv, arg...) \
 	_batadv_dbg(type, bat_priv, 1, ## arg)
@@ -116,7 +116,7 @@ static inline void _batadv_dbg(int type __always_unused,
  * batadv_info() - Store message in debug buffer and print it to kmsg buffer
  * @net_dev: the soft interface net device
  * @fmt: format string
- * @arg...: variable arguments
+ * @arg: variable arguments
  */
 #define batadv_info(net_dev, fmt, arg...)				\
 	do {								\
@@ -130,7 +130,7 @@ static inline void _batadv_dbg(int type __always_unused,
  * batadv_err() - Store error in debug buffer and print it to kmsg buffer
  * @net_dev: the soft interface net device
  * @fmt: format string
- * @arg...: variable arguments
+ * @arg: variable arguments
  */
 #define batadv_err(net_dev, fmt, arg...)				\
 	do {								\
-- 
2.20.1

