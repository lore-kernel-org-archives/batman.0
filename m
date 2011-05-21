Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 14:28:05 +0200
Message-Id: <1305980898-30494-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/14] batctl: Remove optimisation and
	debugging options
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

Distributions like Gentoo or Debian have to strip the options regarding
the optimisation levels and debugging information to fulfil their
policies. There is currently no valid reason why the Makefile should
override it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 217a00a..3b9e853 100644
--- a/Makefile
+++ b/Makefile
@@ -26,7 +26,7 @@ endif
 endif
 
 CC = gcc
-CFLAGS += -pedantic -Wall -W -g3 -std=gnu99 -Os -fno-strict-aliasing
+CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing
 EXTRA_CFLAGS = -DREVISION_VERSION=$(REVISION_VERSION)
 LDFLAGS += -lm
 
-- 
1.7.5.1

