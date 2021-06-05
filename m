Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [RFC PATCH 2/2] batctl: Fix build with lld-13 or ld 2.37 start-stop-gc
Date: Sat,  5 Jun 2021 14:45:49 +0200
Message-Id: <20210605124549.94021-1-sven@narfation.org>
In-Reply-To: <20210605124511.92537-1-sven@narfation.org>
References: <20210605124511.92537-1-sven@narfation.org>
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

If ld 2.37 with -Wl,-z,start-stop-gc -Wl,--gc-sections or lld-13 with
-Wl,--gc-sections, the build with either fail with

  ld.lld: error: undefined symbol: __start___command
  >>> referenced by main.c
  >>>               main.o:(main)
  >>> referenced by main.c
  >>>               main.o:(main)
  >>> referenced by main.c
  >>>               main.o:(print_usage)
  >>> referenced 1 more time

Or in case of ld 2.37 just show a single command (aggregation). A new
attribute retain was introduced which is then emitting the ELF flag
SHF_GNU_RETAIN. This will cause the garbage collector to retain this
section.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/main.h b/main.h
index 00b2ab3..6b11acc 100644
--- a/main.h
+++ b/main.h
@@ -101,6 +101,12 @@ struct command {
 	const char *usage;
 };
 
+#if defined(__has_attribute) && __has_attribute(retain)
+#define start_stop_retain __attribute__((retain))
+#else
+#define start_stop_retain
+#endif
+
 #define COMMAND_NAMED(_type, _name, _abbr, _handler, _flags, _arg, _usage) \
 	static const struct command command_ ## _name ## _ ## _type = { \
 		.type = (_type), \
@@ -112,7 +118,7 @@ struct command {
 		.usage = (_usage), \
 	}; \
 	static const struct command *__command_ ## _name ## _ ## _type \
-	__attribute__((__used__,__section__ ("__command"))) = &command_ ## _name ## _ ## _type
+	__attribute__((__used__,__section__ ("__command"))) start_stop_retain = &command_ ## _name ## _ ## _type
 
 #define COMMAND(_type, _handler, _abbr, _flags, _arg, _usage) \
 	COMMAND_NAMED(_type, _handler, _abbr, _handler, _flags, _arg, _usage)
-- 
2.30.2

