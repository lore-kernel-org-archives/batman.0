Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Mon, 22 Nov 2010 22:45:54 +0100
Message-Id: <1290462354-17246-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1290462354-17246-1-git-send-email-linus.luessing@ascom.ch>
References: <1290462354-17246-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Fix (skipped) substitutions of
	mac addresses
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

This patch fixes two parts: For one thing "batctl l" won't remove commas
anymore if it cannot find the mac address in the bat-hosts file.
For another, it now allows the correct substitution of mac addresses
which have the suffix ')'.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 functions.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/functions.c b/functions.c
index ce046ba..52cfe4b 100644
--- a/functions.c
+++ b/functions.c
@@ -177,9 +177,17 @@ read:
 			*space_ptr = '\0';
 			extra_char = '\0';
 
-			if ((strlen(buff_ptr) == ETH_STR_LEN + 1) && (buff_ptr[ETH_STR_LEN] == ',')) {
-				extra_char = ',';
-				buff_ptr[ETH_STR_LEN] = '\0';
+			if (strlen(buff_ptr) == ETH_STR_LEN + 1) {
+				extra_char = buff_ptr[ETH_STR_LEN]; 
+				switch (extra_char) {
+				case ',':
+				case ')':
+					buff_ptr[ETH_STR_LEN] = '\0';
+					break;
+				default:
+					extra_char = '\0';
+					break;
+				}
 			}
 
 			if (strlen(buff_ptr) != ETH_STR_LEN)
@@ -201,16 +209,16 @@ read:
 				/* keep table format */
 				printf("%17s", bat_host->name);
 
-			if (extra_char != '\0')
-				printf("%c", extra_char);
-
-			printf(" ");
 			goto written;
 
 print_plain_buff:
-			printf("%s ", buff_ptr);
+			printf("%s", buff_ptr);
 
 written:
+			if (extra_char != '\0')
+				printf("%c", extra_char);
+
+			printf(" ");
 			buff_ptr = space_ptr + 1;
 		}
 
-- 
1.7.1

