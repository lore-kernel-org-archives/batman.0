Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:49 +0200
Message-Id: <1273177132-8792-24-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 23/26] staging:batman-adv: Update TODO file
	to reflect current state.
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

Not much left to do on the TODO list :-)

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/TODO |   23 +++--------------------
 1 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index 2f15136..518db7f 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,23 +1,6 @@
-=> proc interface
-* implement new interface to add/delete interfaces and setting options
-* /proc/sys/net/batman-adv/ as main folder
-* in interfaces/ list every available interface of the host
-* each interfaces/$iface/ contains the following files:
--> enable (def: 0) [add/remove this interface to batman-adv]
--> ogm_interval (def: 1000) [ogm interval of that interface]
--> context (def: bat0) [later we want to support multiple mesh instances via
--> bat0/bat1/bat2/..]
--> status (read-only) [outputs the interface status from batman's
--> perspective]
-* in mesh/batX/ list every available mesh subnet
--> vis_server (def: 0) [enable/disable vis server for that mesh]
--> vis_data (read-only) [outputs the vis data in a raw format]
--> aggregate_ogm (def: 1) [enable/disable ogm aggregation for that mesh]
--> originators (read-only) [outputs the originator table]
--> transtable_global (read-only) [outputs the global translation table]
--> transtable_local (read-only) [outputs the local translation table]
-
-=> fix checkpatch.pl errors
+Request a review.
+Process the comments from the review.
+Move into mainline proper.
 
 Please send all patches to:
 	Marek Lindner <lindner_marek@yahoo.de>
-- 
1.7.1

