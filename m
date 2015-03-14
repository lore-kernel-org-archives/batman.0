Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:50 +0100
Message-Id: <1426333379-17777-6-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/14] alfred: Remove trailing whitespace at
	end of line
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README | 6 +++---
 hash.h | 2 +-
 list.h | 2 +-
 send.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/README b/README
index 2bb4f9b..7cef9f6 100644
--- a/README
+++ b/README
@@ -44,13 +44,13 @@ This will compile alfred, batadv-vis & alfred-gpsd. To install, use
 
 If you don't want to compile batadv-vis, add the directive CONFIG_ALFRED_VIS=n:
 
- $ make CONFIG_ALFRED_VIS=n 
+ $ make CONFIG_ALFRED_VIS=n
  $ make CONFIG_ALFRED_VIS=n install
 
 If you don't want to compile alfred-gpsd, add the directive
 CONFIG_ALFRED_GPSD=n:
 
- $ make CONFIG_ALFRED_GPSD=n 
+ $ make CONFIG_ALFRED_GPSD=n
  $ make CONFIG_ALFRED_GPSD=n install
 
 
@@ -254,7 +254,7 @@ To get JSON formatted output, use:
   { "source" : "8e:4c:77:b3:65:b4", "tpv" : {"class":"TPV","device":"command line","time":"2013-10-01T10:43:05.129Z","lat":48.858222,"lon":2.2945,"alt":358.000000,"mode":3} }
 ]
 
-See gpsd_json(5) for documentation of the tpv object. 
+See gpsd_json(5) for documentation of the tpv object.
 
 Running alfred as non-root user
 -------------------------------
diff --git a/hash.h b/hash.h
index aa27f25..c7259c1 100644
--- a/hash.h
+++ b/hash.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/list.h b/list.h
index 4cfbfc6..2ac2c87 100644
--- a/list.h
+++ b/list.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 1991-2013 linux kernel contributors
- * 
+ *
  * Linus Torvalds, ...
  *
  * This program is free software; you can redistribute it and/or
diff --git a/send.c b/send.c
index f1843fe..7e0f416 100644
--- a/send.c
+++ b/send.c
@@ -110,7 +110,7 @@ int push_data(struct globals *globals, struct interface *interface,
 	}
 
 	/* send transaction txend packet */
-	if (seqno > 0 || type_filter != NO_FILTER) { 
+	if (seqno > 0 || type_filter != NO_FILTER) {
 		status_end.header.type = ALFRED_STATUS_TXEND;
 		status_end.header.version = ALFRED_VERSION;
 		length = sizeof(status_end) - sizeof(status_end.header);
-- 
2.1.4

