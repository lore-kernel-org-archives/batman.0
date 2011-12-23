Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Dec 2011 21:53:26 +0100
Message-Id: <1324673607-13741-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove date from README
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

The date has to be updated when a patch touches the README. Therefore, nearly
every feature will modify this date. It can happens quite often that not only
one feature is currently in development or waiting on the mailinglist. This
creates merge conflicts when applying a patchset.

The date itself doesn't provide any additional information when this file is
only available in a release tarball or as part of a SCM repository.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/README b/README
index ddc9569..58d3473 100644
--- a/README
+++ b/README
@@ -1,5 +1,3 @@
-[state: 13-11-2011]
-
 BATMAN-ADV
 ----------
 
-- 
1.7.7.3

