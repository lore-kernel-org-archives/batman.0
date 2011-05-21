Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 14:28:11 +0200
Message-Id: <1305980898-30494-7-git-send-email-sven@narfation.org>
In-Reply-To: <1305980898-30494-1-git-send-email-sven@narfation.org>
References: <1305980898-30494-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 07/14] batctl: Only define CC when not
	already specified
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

It is possible that a build environment specifies the CC different than
gcc (for example gcc-4.6). The Makefile should only set it when the
compiler wasn't explicitely set.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index f95a9d2..a06177d 100755
--- a/Makefile
+++ b/Makefile
@@ -27,7 +27,7 @@ ifndef V
 endif
 endif
 
-CC = gcc
+CC ?= gcc
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing
 EXTRA_CFLAGS = -DREVISION_VERSION=$(REVISION_VERSION)
 LDFLAGS += -lm
-- 
1.7.5.1

