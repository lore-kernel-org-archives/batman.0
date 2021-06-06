Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] batman-adv: don't warn when enslaving hard interface failed
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <04896d08-4bc0-019b-966e-41064effdef6@i-love.sakura.ne.jp>
Message-ID: <99650324-734d-54ed-cd9a-e7b55b8f3630@i-love.sakura.ne.jp>
Date: Sun, 6 Jun 2021 23:28:17 +0900
MIME-Version: 1.0
In-Reply-To: <04896d08-4bc0-019b-966e-41064effdef6@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

syzbot is hitting

  WARN_ON(forw_packet->if_outgoing->soft_iface != soft_iface)

at batadv_iv_ogm_emit() [1], for forw_packet->if_outgoing->soft_iface
can remain NULL if batadv_hardif_enable_interface() failed due to e.g.
memory allocation fault injection.

Link: https://syzkaller.appspot.com/bug?id=9dc0c4cd70ad72df352243e887fd7e18901e7cee [1]
Reported-by: syzbot <syzbot+c0b807de416427ff3dd1@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+c0b807de416427ff3dd1@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: ef0a937f7a1450d3 ("batman-adv: consider outgoing interface in OGM sending")
---
 net/batman-adv/bat_iv_ogm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 789f257be24f..d24853c16ea5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -409,6 +409,9 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 	if (WARN_ON(!forw_packet->if_outgoing))
 		return;
 
+	if (!forw_packet->if_outgoing->soft_iface)
+		return;
+
 	if (WARN_ON(forw_packet->if_outgoing->soft_iface != soft_iface))
 		return;
 
-- 
2.18.4


