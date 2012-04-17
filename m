Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 17 Apr 2012 14:29:13 +0200
Message-Id: <1334665753-347-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix types in README.external
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 README.external |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.external b/README.external
index 874ee7f..787172e 100644
--- a/README.external
+++ b/README.external
@@ -21,7 +21,7 @@ if you want to compile against some other kernel, use:
 
 # make KERNELPATH=/path/to/kernel
 
-if you wont to install this module:
+if you want to install this module:
 
 # sudo make install
 
@@ -29,7 +29,7 @@ CONFIGURATION
 -------------
 
 The     in-kernel    module    can    be    configured    through
-menuconfig.   When  compiling outside  of the kernel,  tree it is
+menuconfig.   When  compiling outside  of the kernel tree,  it is
 necessary  to  configure  it  using    the   make  options.  Each
 option  can be set to to y (enabled), n (disabled) or m (build as
 module).  Available  options  and  their    possible   values are
-- 
1.7.9.1

