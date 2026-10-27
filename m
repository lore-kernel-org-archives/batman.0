Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E62606A323
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=eyNenwS2
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 48E1C8452C
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 14:30:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793107837;
 b=OHwFmmj7Y2x9152EjDim4YdH++9q5fziHcTsO5eNxmL+XsL/at8OYwcXP/ZJKG5D7/Ocu
 Jykn/HOkSmZYjjsM7zub/WWHmYQ0/Jc1NW885TG1uxsYwQTRjuL7HfWispqeWPx9RMQm0Te
 QA09mZqhZl82pm+vYHRZJHhvmGCjx70=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793107837; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=r8xHc5QZAbY7w3dhkCAxHNRc5KfuavGcRlEVDxK6d9E=;
 b=gcYpyeg8fOeRAg0xHVJ9r+ijZ+NqnPxRoCIcWs9GFpko+C6wTlp0+MXBZ5xSwvU9PbIX7
 IK0vuZS6Wtr6gi1T8QrV1gWPbeRH/Or9PRI+tVioA48J6lswVsBckZhbQd2rwyhD7V7A1CQ
 7yq8fxjcalSMAMMJI47qf34X6b9HzZM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E6565807DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 27 Oct 2026 14:30:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793107824;
	b=CJ/hp2mK7L0+fsF7R+umgV9AvO8vyPMn+zcH67vpnvNosXZD52yn5tCJoHcaC0z0tkq52f
	7Q2pc+CUexaMqoKPtVDe5nEkRvOP0m1Qb/Q+gaYd6wt2ENdQwdM0cmBqdlTQen0wZGzntJ
	cBkflw9A9qfOk6jvcigbk75ppTyZmEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793107824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=r8xHc5QZAbY7w3dhkCAxHNRc5KfuavGcRlEVDxK6d9E=;
	b=HFrU93U3JOBsOSnwLju3L3SXz9u1PYM0Kh3JwOsGXWIJu05kSgap2xd4OyPoBlAqRe5Tl5
	B2o4vWo6QLNI6uDByGLRJJ6dVInR6/TbX1GUxmz4UTMleRmoFE2swgzthdeqAavGqr3ML2
	t/M6L8WCaJzKtmt7hplGs8riT6aMQE4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eyNenwS2;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 97B7F2057A;
	Tue, 27 Oct 2026 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793107822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r8xHc5QZAbY7w3dhkCAxHNRc5KfuavGcRlEVDxK6d9E=;
	b=eyNenwS2RncjitYAleQ7AHZSFk0vT+0JRAGWrEX8E9k0QHlw+LWF02B1E2cvwB07jtcyzy
	0ywX3SrZWCR8HHVxQtqe5hV6yM7Pq9AXept+S84ED9lyUuki1zYaKeJXQTzsNuKStDiW83
	+b4/P+76FX4mBsTA33jElESx+pmsptY=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 27 Oct 2026 14:30:15 +0100
Subject: [PATCH batadv] batman-adv: tt: avoid stale changeset after TVLV
 allocation failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-tt-tvlv-alloc-fail-v1-1-02058bcc4595@narfation.org>
X-B4-Tracking: v=1; b=H4sIAGan4GoC/yWM0QrCMAwAf2Xk2UBX0A5/RXxIu0QjZZM2FmHs3
 636eAd3G1QuyhXOwwaFm1Zdlw7jYYB0p+XGqHNn8M6fRucDmqG13JByXhMKacZjFI5B3BRkgh4
 +C4u+f9MLRDKaG1z/vr7ig5N9j7DvH7HUsL9+AAAA
X-Change-ID: 20261027-tt-tvlv-alloc-fail-5bfeb7f087f8
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=sven@narfation.org;
 h=from:subject:message-id; bh=WOmiKicp5BAohlyKtlBCB4YwV4ujw7osY0N7Mw+1A4E=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkPlmeu+hnhIq7verJzyasvn5etiNZf8/3kFWO+U58ux
 Md+Upt6s6OUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwEdk8RobWc8Eh9/TrW9I9
 +QrrHVcbmtazLmybd1PATNL9HhtrsCkjw433svEvZsqtuzW70mGF1z+uidv+bUnw7WFM7jlUX2S
 8mRsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: L3D2GFYRGT3U5LQDPE35P2HMYHFOK2QC
X-Message-ID-Hash: L3D2GFYRGT3U5LQDPE35P2HMYHFOK2QC
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/L3D2GFYRGT3U5LQDPE35P2HMYHFOK2QC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When batadv_tt_prepare_tvlv_local_data() fails in
batadv_tt_tvlv_container_update(), the new TTVN and CRCs were already
committed. Still no new diff container would have been registered.

When no new local changes are queued, the new TTVN is only announced after
ogm_append_cnt reached 0 (after BATADV_TT_OGM_APPEND_MAX OGM intervals).
Nodes which are at the previous TTVN then send a diff TT request instead of
a full table request. This request was answered with the still stored
last_changeset of the previous TTVN. The requesting node applied these
outdated changes under the new TTVN and only noticed the problem via a CRC
mismatch on a later OGM.

Drop the last changeset in this error path. TT requests for the new TTVN
are then answered with the full table - independent of the request type.
Also reset ogm_append_cnt to retry the TT container update in the next OGM
interval.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026085309.1074911-1-sw%40simonwunderlich.de?part=9
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8102d719..446a6838 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1435,13 +1435,25 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
 						     &tt_change, &tt_diff_len);
 	if (!tvlv_len) {
-		/* the TTVN of the changes is lost and the other nodes will
-		 * have to request the full table anyway
+		/* the changes are lost and the other nodes have to request the
+		 * full table. Don't answer TT requests for the new TTVN with
+		 * the stale changeset of the previous TTVN
 		 */
 		list_for_each_entry_safe(entry, safe, &changes_list, list) {
 			list_del(&entry->list);
 			kmem_cache_free(batadv_tt_change_cache, entry);
 		}
+
+		spin_lock_bh(&bat_priv->tt.last_changeset_lock);
+		kfree(bat_priv->tt.last_changeset);
+		bat_priv->tt.last_changeset = NULL;
+		bat_priv->tt.last_changeset_len = 0;
+		spin_unlock_bh(&bat_priv->tt.last_changeset_lock);
+
+		/* announce the already committed TTVN in the next OGM interval
+		 * instead of waiting for BATADV_TT_OGM_APPEND_MAX idle rounds
+		 */
+		atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
 		return;
 	}
 

---
base-commit: 08b79268afb43880f861c12ec9a34d1ccb85ab2f
change-id: 20261027-tt-tvlv-alloc-fail-5bfeb7f087f8

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

