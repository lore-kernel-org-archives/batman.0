Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:31 +0200
Message-Id: <1273177132-8792-6-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 05/26] staging:batman-adv: Update copyright
	years
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/Makefile            |    2 +-
 drivers/staging/batman-adv/aggregation.c       |    2 +-
 drivers/staging/batman-adv/aggregation.h       |    2 +-
 drivers/staging/batman-adv/bitarray.c          |    2 +-
 drivers/staging/batman-adv/bitarray.h          |    2 +-
 drivers/staging/batman-adv/device.c            |    2 +-
 drivers/staging/batman-adv/device.h            |    2 +-
 drivers/staging/batman-adv/hard-interface.c    |    2 +-
 drivers/staging/batman-adv/hard-interface.h    |    2 +-
 drivers/staging/batman-adv/hash.c              |    2 +-
 drivers/staging/batman-adv/hash.h              |    2 +-
 drivers/staging/batman-adv/main.c              |    2 +-
 drivers/staging/batman-adv/main.h              |    2 +-
 drivers/staging/batman-adv/originator.c        |    2 +-
 drivers/staging/batman-adv/originator.h        |    2 +-
 drivers/staging/batman-adv/packet.h            |    2 +-
 drivers/staging/batman-adv/proc.c              |    2 +-
 drivers/staging/batman-adv/proc.h              |    2 +-
 drivers/staging/batman-adv/ring_buffer.c       |    2 +-
 drivers/staging/batman-adv/ring_buffer.h       |    2 +-
 drivers/staging/batman-adv/routing.c           |    2 +-
 drivers/staging/batman-adv/routing.h           |    2 +-
 drivers/staging/batman-adv/send.c              |    2 +-
 drivers/staging/batman-adv/send.h              |    2 +-
 drivers/staging/batman-adv/soft-interface.c    |    2 +-
 drivers/staging/batman-adv/soft-interface.h    |    2 +-
 drivers/staging/batman-adv/translation-table.c |    2 +-
 drivers/staging/batman-adv/translation-table.h |    2 +-
 drivers/staging/batman-adv/types.h             |    2 +-
 drivers/staging/batman-adv/vis.c               |    2 +-
 drivers/staging/batman-adv/vis.h               |    2 +-
 31 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/batman-adv/Makefile b/drivers/staging/batman-adv/Makefile
index 42b4e63..cf2915d 100644
--- a/drivers/staging/batman-adv/Makefile
+++ b/drivers/staging/batman-adv/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index e1bd321..b8338ce 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/aggregation.h b/drivers/staging/batman-adv/aggregation.h
index 6da8df9..bcd32c1 100644
--- a/drivers/staging/batman-adv/aggregation.h
+++ b/drivers/staging/batman-adv/aggregation.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/bitarray.c b/drivers/staging/batman-adv/bitarray.c
index 212eef9..7848305 100644
--- a/drivers/staging/batman-adv/bitarray.c
+++ b/drivers/staging/batman-adv/bitarray.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2010 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/drivers/staging/batman-adv/bitarray.h b/drivers/staging/batman-adv/bitarray.h
index ec72dd7..76ad24c 100644
--- a/drivers/staging/batman-adv/bitarray.h
+++ b/drivers/staging/batman-adv/bitarray.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2010 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/drivers/staging/batman-adv/device.c b/drivers/staging/batman-adv/device.c
index 2f61500..c82a5af 100644
--- a/drivers/staging/batman-adv/device.c
+++ b/drivers/staging/batman-adv/device.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/drivers/staging/batman-adv/device.h b/drivers/staging/batman-adv/device.h
index 46c0f44..eb14b37 100644
--- a/drivers/staging/batman-adv/device.h
+++ b/drivers/staging/batman-adv/device.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index befd488..cb9e927 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/hard-interface.h b/drivers/staging/batman-adv/hard-interface.h
index 97c6ecb..4100a27 100644
--- a/drivers/staging/batman-adv/hard-interface.h
+++ b/drivers/staging/batman-adv/hard-interface.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/hash.c b/drivers/staging/batman-adv/hash.c
index 5a2018d..d4a4adc 100644
--- a/drivers/staging/batman-adv/hash.c
+++ b/drivers/staging/batman-adv/hash.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2010 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/drivers/staging/batman-adv/hash.h b/drivers/staging/batman-adv/hash.h
index a70d6d6..ea6d21e 100644
--- a/drivers/staging/batman-adv/hash.h
+++ b/drivers/staging/batman-adv/hash.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2010 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 2e0b482..a051568 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 2e9bb89..c943e89 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 29c2411..2ce1349 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/originator.h b/drivers/staging/batman-adv/originator.h
index 6ef7a05..8acebc1 100644
--- a/drivers/staging/batman-adv/originator.h
+++ b/drivers/staging/batman-adv/originator.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/packet.h b/drivers/staging/batman-adv/packet.h
index ad006ce..152f57b 100644
--- a/drivers/staging/batman-adv/packet.h
+++ b/drivers/staging/batman-adv/packet.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index c9366bc..dfa85c4 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/proc.h b/drivers/staging/batman-adv/proc.h
index cd690e0..cf71264 100644
--- a/drivers/staging/batman-adv/proc.h
+++ b/drivers/staging/batman-adv/proc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/ring_buffer.c b/drivers/staging/batman-adv/ring_buffer.c
index 751c899..defd37c 100644
--- a/drivers/staging/batman-adv/ring_buffer.c
+++ b/drivers/staging/batman-adv/ring_buffer.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/drivers/staging/batman-adv/ring_buffer.h b/drivers/staging/batman-adv/ring_buffer.h
index 6839ba9..b8c9456 100644
--- a/drivers/staging/batman-adv/ring_buffer.h
+++ b/drivers/staging/batman-adv/ring_buffer.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 39dd093..b83e5cb 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/routing.h b/drivers/staging/batman-adv/routing.h
index 939b8d4..8288dec 100644
--- a/drivers/staging/batman-adv/routing.h
+++ b/drivers/staging/batman-adv/routing.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index d356ce7..88ecb5c 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/send.h b/drivers/staging/batman-adv/send.h
index 5fc6f34..b2ddf63 100644
--- a/drivers/staging/batman-adv/send.h
+++ b/drivers/staging/batman-adv/send.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index a42b21f..0dff959 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/soft-interface.h b/drivers/staging/batman-adv/soft-interface.h
index c0cad81..e7f59af 100644
--- a/drivers/staging/batman-adv/soft-interface.h
+++ b/drivers/staging/batman-adv/soft-interface.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index d56f665..e446d90 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/translation-table.h b/drivers/staging/batman-adv/translation-table.h
index 281125b..8568d80 100644
--- a/drivers/staging/batman-adv/translation-table.h
+++ b/drivers/staging/batman-adv/translation-table.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index dec1b54..4e77141 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 28eac7e..0bfc083 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2008-2010 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/drivers/staging/batman-adv/vis.h b/drivers/staging/batman-adv/vis.h
index a1f92a4..98d8972 100644
--- a/drivers/staging/batman-adv/vis.h
+++ b/drivers/staging/batman-adv/vis.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008-2009 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2008-2010 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
-- 
1.7.1

