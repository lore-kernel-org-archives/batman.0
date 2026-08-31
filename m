Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD56EC624A4
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:55:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4B05081DA6
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:55:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184522;
 b=tw2yUj2kLsfPk98O7BYsQxdPLz4Vn/bwz4Qiz+C0/DxFLMCB+r+ae+FNel4badxpG/mTp
 H/p6rkUhmTAdpc2UdNHL31bx3cMUM/6jgj3OufUWtU2Ax+GQQVbujf6zwveX7kR03I61Op1
 cHvYMfCt8ehZ1Tldxin1CN14YwPw+SU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184522; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aHJY+bFbF1EZ50G17p2P6mlzloCVfztDiB/kxIfRPg8=;
 b=q/m5zfreDFcRRUy1c+UF0K6W03/8kp+lFz0E+mo3djoSw6+eefxVXat8o3nJdJY1HHOac
 n2wSyRJax/1wdyXIEyWXxmZNU/5GDXSRqKZMebdgE7Tp2JtmY+9p/Yuyf0HzKXXWIi7/fIA
 eUbhPELnjJpAmzW4Hkc6SpGB17A0JTo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 096DA8195C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184301;
	b=BQJbVQrWd08dovMEn53dj8RDLghCuRgQNu0hJeEBfRCK9lcsQQddun7Gbe+UvdjpPr868Y
	37SU7TcoBnid7Pr5quSEPzMXjE5EYmsM4VpducxNQHsqFNx9w9cSmXeFFKzs9KUAgdfZvA
	t/oo3kGeYdbtSLHME55qdlU+mHhviNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aHJY+bFbF1EZ50G17p2P6mlzloCVfztDiB/kxIfRPg8=;
	b=g0tpSV/I8NEYdndFmm9opwOlokpy6KjhufBQyKSvgzzjQIUZOxujPjftJw0uO8lsoEsbdM
	cKKTb3NkwzYj0KIjDJYwd5SwZt3Zjgr+N2qp7nNY3tTr7jKkFh0H+urmAFZi3LGFrhci0W
	FK4OBS4erxv+dpvraoE0xigf/ZGBNp8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=YJRArrZG;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970eeDD85F51F1FAA919d7A5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id F2FD7FA66C;
	Mon, 31 Aug 2026 15:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHJY+bFbF1EZ50G17p2P6mlzloCVfztDiB/kxIfRPg8=;
	b=YJRArrZGzhBIB2JFIy9z522Wn8Skj9LqA/EK651yRInFhMpSWpAGY9GINKXOAT4OX7Dp6X
	2yCA/3QYcRiOWvQyK7n/rXwZfWTns45EuSVItewxrCom4vT9Q6emcAj9jmooiKVRxBcaV4
	D5EOqlCablATHs9iBdQH6ane3Atd/9Yc9pXex1L/EmsnwSojiC2JCjTQHl9O6xiO89XpGF
	80SueClxEF0UbzFJDfStykdkaaM1f/59q1aEzeTe5QieUVVjFd2EnYBS0a0Y6IR93A9qy8
	8zKSH7eVCVsInp6j99Fr2U9T+GicvtuwrN0wdKU19TKbWo/mrIoQg4+svYrPTA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 10/15] batman-adv: tt: simplify NEW flag transition
 code
Date: Mon, 31 Aug 2026 15:51:12 +0200
Message-ID: <20260831135117.574836-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: I4CMH4JH5GQIDEMPDR2QKP5OUKSNOCBM
X-Message-ID-Hash: I4CMH4JH5GQIDEMPDR2QKP5OUKSNOCBM
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/I4CMH4JH5GQIDEMPDR2QKP5OUKSNOCBM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The function batadv_tt_local_set_flags() implements support for various
flags and to set/unset them. It is also possible to decide whether this
change should increase the TT size or not.

But in reality, this function is only used to transition tt local entries
from the NEW state and count these entries. Remove the rest of the code to
simplify the function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 01c74d4a7e521..2f7951e4c3203 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3815,15 +3815,11 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_local_set_flags() - set or unset the specified flags on the local
- *  table and possibly count them in the TT size
+ * batadv_tt_local_transition_new() - unset the NEW flag on the local
+ *  table and count them in the TT size
  * @bat_priv: the bat priv with all the mesh interface information
- * @flags: the flag to switch
- * @enable: whether to set or unset the flag
- * @count: whether to increase the TT size by the number of changed entries
  */
-static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
-				      bool enable, bool count)
+static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
@@ -3839,19 +3835,11 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
-			if (enable) {
-				if ((tt_common_entry->flags & flags) == flags)
-					continue;
-				tt_common_entry->flags |= flags;
-			} else {
-				if (!(tt_common_entry->flags & flags))
-					continue;
-				tt_common_entry->flags &= ~flags;
-			}
-
-			if (!count)
+			if (!(tt_common_entry->flags & BATADV_TT_CLIENT_NEW))
 				continue;
 
+			tt_common_entry->flags &= ~BATADV_TT_CLIENT_NEW;
+
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
@@ -3924,7 +3912,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
+	batadv_tt_local_transition_new(bat_priv);
 
 	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);
-- 
2.47.3

