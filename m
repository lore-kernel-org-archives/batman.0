Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  1 Jan 2012 00:41:39 +0100
Message-Id: <1325374901-1620-3-git-send-email-sven@narfation.org>
In-Reply-To: <1325374901-1620-1-git-send-email-sven@narfation.org>
References: <1325374901-1620-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batmand: Update copyright years
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile            |    2 +-
 allocate.c          |    2 +-
 allocate.h          |    2 +-
 batman.c            |    2 +-
 batman.h            |    2 +-
 bitarray.c          |    2 +-
 bitarray.h          |    2 +-
 hash.c              |    2 +-
 hash.h              |    2 +-
 hna.c               |    2 +-
 hna.h               |    2 +-
 linux/kernel.c      |    2 +-
 linux/route.c       |    2 +-
 linux/tun.c         |    2 +-
 list-batman.c       |    2 +-
 list-batman.h       |    2 +-
 originator.c        |    2 +-
 originator.h        |    2 +-
 os.h                |    2 +-
 packet.h            |    2 +-
 posix/init.c        |    2 +-
 posix/posix.c       |    2 +-
 posix/tunnel.c      |    2 +-
 posix/unix_socket.c |    2 +-
 profile.c           |    2 +-
 profile.h           |    2 +-
 ring_buffer.c       |    2 +-
 ring_buffer.h       |    2 +-
 schedule.c          |    2 +-
 schedule.h          |    2 +-
 types.h             |    2 +-
 31 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Makefile b/Makefile
index 9aafbc8..fe1f094 100755
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2006-2009 B.A.T.M.A.N. contributors
+# Copyright (C) 2006-2012 B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/allocate.c b/allocate.c
index 5e28c71..9d79d87 100644
--- a/allocate.c
+++ b/allocate.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Thomas Lopatic, Corinna 'Elektra' Aichele, Axel Neumann, Marek Lindner
  *
diff --git a/allocate.h b/allocate.h
index c3fe7df..167ab33 100644
--- a/allocate.h
+++ b/allocate.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Thomas Lopatic, Corinna 'Elektra' Aichele, Axel Neumann, Marek Lindner
  *
diff --git a/batman.c b/batman.c
index ab689b2..a1e387c 100644
--- a/batman.c
+++ b/batman.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Thomas Lopatic, Corinna 'Elektra' Aichele, Axel Neumann,
  * Felix Fietkau, Marek Lindner
diff --git a/batman.h b/batman.h
index ae51c22..c8e35f1 100644
--- a/batman.h
+++ b/batman.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Thomas Lopatic, Corinna 'Elektra' Aichele, Axel Neumann, Marek Lindner
  *
diff --git a/bitarray.c b/bitarray.c
index 5afcb18..234f8a8 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  * 
  * Simon Wunderlich, Axel Neumann, Marek Lindner
  *
diff --git a/bitarray.h b/bitarray.h
index 0bb0710..9a1f80d 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Axel Neumann, Marek Lindner
  *
diff --git a/hash.c b/hash.c
index e8c822f..2a9f557 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index 443ef28..91ee7d8 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hna.c b/hna.c
index 3ad5fb8..4c90dd3 100644
--- a/hna.c
+++ b/hna.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hna.h b/hna.h
index a046857..5af9317 100644
--- a/hna.h
+++ b/hna.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/linux/kernel.c b/linux/kernel.c
index b421f51..fa8882c 100644
--- a/linux/kernel.c
+++ b/linux/kernel.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Thomas Lopatic
  *
diff --git a/linux/route.c b/linux/route.c
index 0c7b932..119ebb2 100644
--- a/linux/route.c
+++ b/linux/route.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/linux/tun.c b/linux/tun.c
index d98b509..afb0447 100644
--- a/linux/tun.c
+++ b/linux/tun.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/list-batman.c b/list-batman.c
index 356c1eb..a0c2ad8 100644
--- a/list-batman.c
+++ b/list-batman.c
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/list-batman.h b/list-batman.h
index 7780c9a..cb97bf5 100644
--- a/list-batman.h
+++ b/list-batman.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/originator.c b/originator.c
index a96c3d4..f58bbcf 100644
--- a/originator.c
+++ b/originator.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/originator.h b/originator.h
index fdc2bdb..fb5e063 100644
--- a/originator.h
+++ b/originator.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/os.h b/os.h
index 2b15e21..ab02497 100644
--- a/os.h
+++ b/os.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Thomas Lopatic, Marek Lindner
  *
diff --git a/packet.h b/packet.h
index 76aa776..7d7e5b4 100644
--- a/packet.h
+++ b/packet.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/posix/init.c b/posix/init.c
index a102431..9cefe73 100644
--- a/posix/init.c
+++ b/posix/init.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 BATMAN contributors:
+ * Copyright (C) 2006-2012 BATMAN contributors:
  *
  * Thomas Lopatic, Marek Lindner
  *
diff --git a/posix/posix.c b/posix/posix.c
index 2455690..ae1cef0 100644
--- a/posix/posix.c
+++ b/posix/posix.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 BATMAN contributors:
+ * Copyright (C) 2006-2012 BATMAN contributors:
  *
  * Thomas Lopatic, Marek Lindner
  *
diff --git a/posix/tunnel.c b/posix/tunnel.c
index cbbdea1..3290eaa 100644
--- a/posix/tunnel.c
+++ b/posix/tunnel.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 BATMAN contributors:
+ * Copyright (C) 2006-2012 BATMAN contributors:
  *
  * Marek Lindner
  *
diff --git a/posix/unix_socket.c b/posix/unix_socket.c
index 5929dde..5bed217 100644
--- a/posix/unix_socket.c
+++ b/posix/unix_socket.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 BATMAN contributors:
+ * Copyright (C) 2006-2012 BATMAN contributors:
  *
  * Marek Lindner
  *
diff --git a/profile.c b/profile.c
index 1b09b3f..e691f5d 100644
--- a/profile.c
+++ b/profile.c
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/profile.h b/profile.h
index 2b036cc..a4afde0 100644
--- a/profile.h
+++ b/profile.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/ring_buffer.c b/ring_buffer.c
index 7bf43f6..7a0c8c8 100644
--- a/ring_buffer.c
+++ b/ring_buffer.c
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/ring_buffer.h b/ring_buffer.h
index f60840e..78d8f9e 100644
--- a/ring_buffer.h
+++ b/ring_buffer.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/schedule.c b/schedule.c
index 3e0b5ce..83576c8 100644
--- a/schedule.c
+++ b/schedule.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/schedule.h b/schedule.h
index 9af3a8e..50fd5aa 100644
--- a/schedule.h
+++ b/schedule.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/types.h b/types.h
index 9f10e0a..7aa4884 100644
--- a/types.h
+++ b/types.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
-- 
1.7.7.3

