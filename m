Return-Path: <corbet@lwn.net>
Date: Sat, 30 Jun 2012 10:49:13 -0600
From: Jonathan Corbet <corbet@lwn.net>
Message-ID: <20120630104913.30e059ea@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove a misleading comment
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
To: Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

As much as I'm happy to see LWN links sprinkled through the kernel by the
dozen, this one in particular reflects a very old state of reality; the 
associated comment is now incorrect.  So just delete it.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 083a299..c91f35b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -57,9 +57,6 @@ static int __init batman_init(void)
 	recv_handler_init();
 
 	bat_iv_init();
-
-	/* the name should not be longer than 10 chars - see
-	 * http://lwn.net/Articles/23634/ */
 	bat_event_workqueue = create_singlethread_workqueue("bat_events");
 
 	if (!bat_event_workqueue)
