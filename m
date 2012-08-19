Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Aug 2012 00:08:44 +0200
Message-Id: <1345414124-25938-1-git-send-email-sven@narfation.org>
In-Reply-To: <1345413182-25515-1-git-send-email-sven@narfation.org>
References: <1345413182-25515-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: Clear screen using ANSI escape
	codes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

It is not necessary to call an external binary to clear the screen of a default
unix terminal emulator. The external call using system("clear") may be used by
an attacker to get untrusted code called with an higher privilege because
batctl has to be run as using uid 0.

Reported-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Add comment

 functions.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/functions.c b/functions.c
index c78e408..e095fd0 100644
--- a/functions.c
+++ b/functions.c
@@ -184,7 +184,8 @@ open:
 	}
 
 	if (read_opt & CLR_CONT_READ)
-		system("clear");
+		/* clear screen, set cursor back to 0,0 */
+		printf("\033[2J\033[0;0f");
 
 read:
 	while (getline(&line_ptr, &len, fp) != -1) {
-- 
1.7.10.4

