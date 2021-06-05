Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [RFC PATCH 1/2] batctl: Combine command section attributes
Date: Sat,  5 Jun 2021 14:45:10 +0200
Message-Id: <20210605124511.92537-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The __used__ and __section__ attribute for the batctl commands can be
combined together to simplify the COMMAND_NAMED macro.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.h b/main.h
index d1bea23..00b2ab3 100644
--- a/main.h
+++ b/main.h
@@ -112,7 +112,7 @@ struct command {
 		.usage = (_usage), \
 	}; \
 	static const struct command *__command_ ## _name ## _ ## _type \
-	__attribute__((__used__)) __attribute__ ((__section__ ("__command"))) = &command_ ## _name ## _ ## _type
+	__attribute__((__used__,__section__ ("__command"))) = &command_ ## _name ## _ ## _type
 
 #define COMMAND(_type, _handler, _abbr, _flags, _arg, _usage) \
 	COMMAND_NAMED(_type, _handler, _abbr, _handler, _flags, _arg, _usage)
-- 
2.30.2

