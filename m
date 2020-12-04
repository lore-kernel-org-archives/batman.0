Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 8/8] batman-adv: Drop unused soft-interface.h include in fragmentation.c
Date: Fri,  4 Dec 2020 16:46:31 +0100
Message-Id: <20201204154631.21063-9-sw@simonwunderlich.de>
In-Reply-To: <20201204154631.21063-1-sw@simonwunderlich.de>
References: <20201204154631.21063-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

The commit 992b03b88e36 ("batman-adv: Don't always reallocate the
fragmentation skb head") removed the last user of functions from
soft-interface.h.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentatio=
n.c
index 59ebd73125bf..e522f1fcfd9a 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -27,7 +27,6 @@
 #include "originator.h"
 #include "routing.h"
 #include "send.h"
-#include "soft-interface.h"
=20
 /**
  * batadv_frag_clear_chain() - delete entries in the fragment buffer cha=
in
--=20
2.20.1
