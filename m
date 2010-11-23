Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 23 Nov 2010 13:13:19 +0100
Message-Id: <1290514400-6887-3-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201011230044.58352.lindner_marek@yahoo.de>
References: <201011230044.58352.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 2/3] batctl: Fix skipped substitutions of
	mac addresses with a following ', '
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

When batctl does not find a matching name for a given mac address in the
bat-hosts file, then it unfortunately removes the following ',' instead
of leaving the string unmodified. batctl bisect is then not able to find
the mac address anymore. This commit fixes this issue.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 functions.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/functions.c b/functions.c
index ce046ba..9b1e22b 100644
--- a/functions.c
+++ b/functions.c
@@ -201,16 +201,16 @@ read:
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

