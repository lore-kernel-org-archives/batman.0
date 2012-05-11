Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 11 May 2012 14:21:32 +0200
Message-Id: <1336738892-7401-16-git-send-email-ordex@autistici.org>
In-Reply-To: <1336738892-7401-1-git-send-email-ordex@autistici.org>
References: <1336738892-7401-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 15/15] batman-adv: add contributor name
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

translation_table.{c,h} have been heavily modified by another contributor and
for legal purposes it is better to include his name into the contributor list

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/translation-table.c |    2 +-
 net/batman-adv/translation-table.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index a38d315..2cb46f0 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
- * Marek Lindner, Simon Wunderlich
+ * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index bfebe26..593d1b3 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
- * Marek Lindner, Simon Wunderlich
+ * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
-- 
1.7.9.4

