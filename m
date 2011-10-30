Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 30 Oct 2011 22:27:53 +0100
Message-Id: <1320010073-29681-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: retrieve compat version from version
	field in case of parameter problem
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 ping.c       |    4 ++--
 traceroute.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ping.c b/ping.c
index 1003ab1..91b733a 100644
--- a/ping.c
+++ b/ping.c
@@ -283,8 +283,8 @@ int ping(char *mesh_iface, int argc, char **argv)
 			break;
 		case PARAMETER_PROBLEM:
 			printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
-					icmp_packet_in.ttl, COMPAT_VERSION);
-			printf("Please make sure to compatible versions!\n");
+					icmp_packet_in.version, COMPAT_VERSION);
+			printf("Please make sure to use compatible versions!\n");
 			goto out;
 		default:
 			printf("Unknown message type %d len %zd received\n", icmp_packet_in.msg_type, read_len);
diff --git a/traceroute.c b/traceroute.c
index ea43331..d120311 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -188,8 +188,8 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 				goto out;
 			case PARAMETER_PROBLEM:
 				printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
-						icmp_packet_in.ttl, COMPAT_VERSION);
-				printf("Please make sure to compatible versions!\n");
+						icmp_packet_in.version, COMPAT_VERSION);
+				printf("Please make sure to use compatible versions!\n");
 				goto out;
 			default:
 				printf("Unknown message type %d len %zd received\n", icmp_packet_in.msg_type, read_len);
-- 
1.7.5.4

