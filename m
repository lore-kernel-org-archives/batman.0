Return-Path: <an.langer@gmx.de>
From: Andreas Langer <an.langer@gmx.de>
Date: Fri, 17 Sep 2010 01:10:01 +0200
Message-Id: <1284678602-27347-2-git-send-email-an.langer@gmx.de>
In-Reply-To: <20100917010913.719fcab2@rechenknecht>
References: <20100917010913.719fcab2@rechenknecht>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: change email
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

Signed-off-by: Andreas Langer <an.langer at gmx.de>
---
 batctl/bat-hosts.c  |    2 +-
 batctl/functions.c  |    2 +-
 batctl/functions.h  |    2 +-
 batctl/main.h       |    2 +-
 batctl/man/batctl.8 |    2 +-
 batctl/ping.c       |    2 +-
 batctl/tcpdump.c    |    2 +-
 batctl/tcpdump.h    |    2 +-
 batctl/traceroute.c |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/batctl/bat-hosts.c b/batctl/bat-hosts.c
index 8948892..25a57a6 100644
--- a/batctl/bat-hosts.c
+++ b/batctl/bat-hosts.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
diff --git a/batctl/functions.c b/batctl/functions.c
index 497e166..cff8b52 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
diff --git a/batctl/functions.h b/batctl/functions.h
index 6aa9487..1b1c350 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
diff --git a/batctl/main.h b/batctl/main.h
index 793d282..8689d67 100644
--- a/batctl/main.h
+++ b/batctl/main.h
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 4ffb412..f98e6ad 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -201,7 +201,7 @@ remember than MAC addresses.
 .BR dmesg (1),
 .BR dot (1)
 .SH AUTHOR
-batctl was written by Andreas Langer <a.langer@q-dsl.de> and Marek
+batctl was written by Andreas Langer <an.langer@gmx.de> and Marek
 Lindner <lindner_marek@yahoo.de>.
 .PP
 This manual page was written by Simon Wunderlich
diff --git a/batctl/ping.c b/batctl/ping.c
index affd6ad..288bd01 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index 6994b1e..0f62e65 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <a.langer@q-dsl.de>
+ * Andreas Langer <an.langer@gmx.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
diff --git a/batctl/tcpdump.h b/batctl/tcpdump.h
index 19b0585..f98d63f 100644
--- a/batctl/tcpdump.h
+++ b/batctl/tcpdump.h
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
diff --git a/batctl/traceroute.c b/batctl/traceroute.c
index 63de7e6..dc97a01 100644
--- a/batctl/traceroute.c
+++ b/batctl/traceroute.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
- * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
-- 
1.7.0.4

