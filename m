Return-Path: <me@irrelefant.net>
From: =?UTF-8?q?Leonardo=20M=C3=B6rlein?= <me@irrelefant.net>
Subject: [PATCH] batctl: Exit code is now EXIT_FAILURE when throughputmeter
 fails
Date: Wed,  8 Apr 2020 23:49:03 +0200
Message-Id: <20200408214903.23134-1-me@irrelefant.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Leonardo=20M=C3=B6rlein?= <me@irrelefant.net>

Before this commit, this command completed indicating success:

[lemoer@orange batctl]$ (sudo batctl tp 77:77:77:77:77:77 && echo true) || echo false
Destination unreachable
true

After this commit, this command expectedly indicates failure:

[lemoer@orange batctl]$ (sudo ./batctl tp 77:77:77:77:77:77 && echo true) || echo false
Destination unreachable
false

Signed-off-by: Leonardo Mörlein <me@irrelefant.net>
---
 throughputmeter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/throughputmeter.c b/throughputmeter.c
index 27f1346..0ec5c31 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -465,6 +465,7 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 		goto out;
 	}
 
+	ret = EXIT_FAILURE;
 	switch (result.return_value) {
 	case BATADV_TP_REASON_DST_UNREACHABLE:
 		fprintf(stderr, "Destination unreachable\n");
-- 
2.24.1

