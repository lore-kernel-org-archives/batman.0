Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri,  2 Dec 2011 15:39:07 +0100
Message-Id: <1322836747-25204-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1322835344-23077-1-git-send-email-martin@hundeboll.net>
References: <1322835344-23077-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Rm trailing whitespace from
	is_my_mac() in main.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 main.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/main.c b/main.c
index fb87bdc..71b56cf 100644
--- a/main.c
+++ b/main.c
@@ -170,7 +170,6 @@ int is_my_mac(const uint8_t *addr)
 	}
 	rcu_read_unlock();
 	return 0;
-
 }
 
 module_init(batman_init);
-- 
1.7.7.4

