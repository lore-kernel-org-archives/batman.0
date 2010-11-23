Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 23 Nov 2010 13:13:20 +0100
Message-Id: <1290514400-6887-4-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201011230044.58352.lindner_marek@yahoo.de>
References: <201011230044.58352.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 3/3] batctl: Fix substitution of mac
	addresses with a following ')'
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

So far, mac addresses which had a following closing bracket and not a
comma were ignored for the bat-hosts substitutions. This commit allows
the substitution of such mac addresses, too.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 functions.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/functions.c b/functions.c
index 9b1e22b..52cfe4b 100644
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
-- 
1.7.1

