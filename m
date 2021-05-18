Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: WARNING in batadv_iv_send_outstanding_bat_ogm_packet
Message-ID: <04896d08-4bc0-019b-966e-41064effdef6@i-love.sakura.ne.jp>
Date: Tue, 18 May 2021 23:54:48 +0900
MIME-Version: 1.0
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

at batadv_iv_ogm_emit() [1].

This WARN_ON() was added by commit ef0a937f7a1450d3 ("batman-adv: consider
outgoing interface in OGM sending") but it is unclear why it needs to use
WARN_ON(). Is this fatal error worth crashing the kernel?

Please consider replacing with pr_err() etc. like commit b4142fc4d52d051d
("drm/vkms: fix misuse of WARN_ON") does if this is not a kernel bug.

[1] https://syzkaller.appspot.com/bug?id=9dc0c4cd70ad72df352243e887fd7e18901e7cee
