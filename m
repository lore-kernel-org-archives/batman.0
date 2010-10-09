Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  9 Oct 2010 02:19:42 +0200
Message-Id: <1286583582-13275-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <20101008093941.GH11681@bicker>
References: <20101008093941.GH11681@bicker>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't dereference unchecked
	incoming soft_iface
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
Cc: error27@gmail.com

send_packet derefenced forw_packet->if_incoming and checked if
forw_packet->if_incoming is NULL.

This cannot happen, but still makes irritates when reading through the
functions.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/send.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/batman-adv/send.c b/batman-adv/send.c
index 625a3ba..7097ff0 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -163,8 +163,8 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 static void send_packet(struct forw_packet *forw_packet)
 {
 	struct batman_if *batman_if;
-	struct net_device *soft_iface = forw_packet->if_incoming->soft_iface;
-	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	struct net_device *soft_iface;
+	struct bat_priv *bat_priv;
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->skb->data);
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
@@ -175,6 +175,9 @@ static void send_packet(struct forw_packet *forw_packet)
 		return;
 	}
 
+	soft_iface = forw_packet->if_incoming->soft_iface;
+	bat_priv = netdev_priv(soft_iface);
+
 	if (forw_packet->if_incoming->if_status != IF_ACTIVE)
 		return;
 
-- 
1.7.2.3

