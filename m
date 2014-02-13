Return-Path: <russell@personaltelco.net>
References: <86r4775d8s.fsf@coulee.tdb.com> <86mwhv5cy8.fsf@coulee.tdb.com>
 <86iosj5cci.fsf_-_@coulee.tdb.com>
From: Russell Senior <russell@personaltelco.net>
Date: Thu, 13 Feb 2014 06:23:55 -0800
In-Reply-To: <86iosj5cci.fsf_-_@coulee.tdb.com> (Russell Senior's message of
 "Thu\, 13 Feb 2014 06\:14\:21 -0800")
Message-ID: <86eh375bwk.fsf_-_@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [B.A.T.M.A.N.] [PATCH 4/4] openwrt routing feed: batctl: remove
	apparently unused variables from make arguments
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Removes what appear to be unused and/or unnecessary environment
variables passed to make.

Signed-off-by: Russell Senior <russell@personaltelco.net>
---
 batctl/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/batctl/Makefile b/batctl/Makefile
index 7a34957..eef22ec 100644
--- a/batctl/Makefile
+++ b/batctl/Makefile
@@ -49,9 +49,7 @@ MAKE_BATCTL_ENV += \
 
 MAKE_BATCTL_ARGS += \
         REVISION="" \
-        CC="$(TARGET_CC)" \
-        DESTDIR="$(PKG_INSTALL_DIR)" \
-        batctl install
+        batctl
 
 
 define Build/compile
-- 
1.8.1.2



-- 
Russell Senior, President
russell@personaltelco.net
