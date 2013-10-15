Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue, 15 Oct 2013 12:29:07 +0200
Message-Id: <1381832947-25980-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Fix warning about comparing signed
	vs. unsigned
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
Cc: Sven Eckelmann <sven@open-mesh.com>

The macros NLMSG_OK and NLMSG_NEXT operate on the parameter len as if it would
be a variable from the type size_t. Using ssize_t (signed size_t) can cause
warnings about comparing a signed with an unsigned variable.

It is ok to store the signed len variable in an unsigned variable because an
check is used to stop processing when it was negative.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 functions.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/functions.c b/functions.c
index d8d86ce..9e03e72 100644
--- a/functions.c
+++ b/functions.c
@@ -637,7 +637,7 @@ static struct ether_addr *resolve_mac_from_cache(int ai_family,
 	size_t buflen;
 	struct nlmsghdr *nh;
 	ssize_t len;
-	size_t l3_len;
+	size_t l3_len, mlen;
 	int socknl;
 	int parsed;
 	int finished = 0;
@@ -667,8 +667,9 @@ static struct ether_addr *resolve_mac_from_cache(int ai_family,
 		len = resolve_mac_from_cache_dump(socknl, &buf, &buflen);
 		if (len < 0)
 			goto err_sock;
+		mlen = len;
 
-		for (nh = buf; NLMSG_OK(nh, len); nh = NLMSG_NEXT(nh, len)) {
+		for (nh = buf; NLMSG_OK(nh, mlen); nh = NLMSG_NEXT(nh, mlen)) {
 			if (nh->nlmsg_type == NLMSG_DONE) {
 				finished = 1;
 				break;
-- 
1.8.4.rc3

