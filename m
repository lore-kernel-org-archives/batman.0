Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479F606A31E
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=fki98Gh1
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9DEB5802E6
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 11:37:07 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794739027;
 b=tQqA73DX8w8LAmAwbgEgy+xrrNLmGAT86DRFQNBPR2r1gEuj2ta/rAqaX+VtT+mQfauWc
 RbvQiHRiHzqKUjad5rNSe2RzCCfOU7C406vNUUDWXYjOgcySAkoa2NcYHSAfdlijziclEnl
 7406HDAnQQPUCrPd2dZm06aeunuIQNg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794739027; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JspNObAYmdUHZlTcfGGvB+tJ2laRO74OdREwRhO5WQw=;
 b=dVlYz9ByoyxDhlai9n3wXh4wmj6113PtUe14XYctsgaTD6PhOuURdkNczG+A2I3JSwnc9
 ppAgqK8FdaHP8O5bC8m9Eni3YWh9yNQMHHCzHKNKCo7g2poAGntQyAsMBfmNog74P6+l60w
 +4KvdO4POaTITfktf4ylY6Zc4VBdQZQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6968D82759
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 15 Nov 2026 11:36:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794739004;
	b=E13frlQirHElDaWaYZk6CaP5OCODvjvPftgEVShw2zUHwVQLECu/6KfF/OFoRlk+z36r5h
	apdeZTaG84Iqsz1xXo6XvcrMHi5GlmyQC7jRqkYu8/MDnoWlp8ZMwgWvoFAh+XrTSAJjDU
	JN4GU/k1ej1rZuChX/jCG5dnhSCM4RI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794739004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=JspNObAYmdUHZlTcfGGvB+tJ2laRO74OdREwRhO5WQw=;
	b=kJRSX9VOvXmkjc1J4ko0ccfmoDKl71W1xYheZLXA5vOebEhamqSBbKlziYrXlgjvTSkkwy
	L4zgTx7zyTnXEPOERacw54erolslV6SKYPSOtUGV96CXlvMTSv9yoxIh4Q0ORCcKdpS7po
	+h3FzNATJeHAWIKkDS5IOhzWesO50i8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fki98Gh1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id ABCF1206AD;
	Sun, 15 Nov 2026 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794738993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JspNObAYmdUHZlTcfGGvB+tJ2laRO74OdREwRhO5WQw=;
	b=fki98Gh1D7YfIDeTKbCljHWjd/cxBiz0fqybR0LOShl65X1Hug0olCElMmlWFlg/aG+5zV
	mCitihhu3RBh2kIVR/ItsCDNqYjNOOgkZoVh+l35h61kVm2oZXe8HdfAtEkzqjMrkPgf2q
	QuuXe6Omb2fCFzpDwbSmLHe2kPtuw2o=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 Nov 2026 11:36:30 +0100
Subject: [PATCH batadv] batman-adv: bla: register own backbone gw when
 claiming for local node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-bla-late-claim-add-v1-1-74aa2359f0f5@narfation.org>
X-B4-Tracking: v=1; b=H4sIAC2L+WoC/yWMwQrCMBAFf6W8swtNwdD6K+Jhs1l1JVZJYhFK/
 92oxxmYWVE0mxYcuhVZFyv2mBu4XQe58nxRstgYQz9459yeQmJKXJUksd2JYyQZp0l6FvajRwu
 fWc/2/k2PCFw5Ljj9fXmFm0r9HrFtH9JmIcl+AAAA
X-Change-ID: 20261115-bla-late-claim-add-c899c0aca686
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2630; i=sven@narfation.org;
 h=from:subject:message-id; bh=g2FbRWrqDHwI+F6Plh3wNnPwE4Fe7azuvnS3o/ww+3g=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk/u/UD2hJ/rLiXLn56vQPLMvZIz2ZpQXVJTb6AnY9P/
 nsZZ7a4o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRO+cZGRrms577VBxydf+i
 T+IfV/FeOcAoyGNdtDVGde9mw3MeT1cyMjRqffy3WfW35y4TC8EqJp7Uf1ZvI186lL27JNjxWlQ
 lhwcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RJOVWQ4QUXGMAKPJJH24TMJYCZSRU24Q
X-Message-ID-Hash: RJOVWQ4QUXGMAKPJJH24TMJYCZSRU24Q
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RJOVWQ4QUXGMAKPJJH24TMJYCZSRU24Q/>
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

batadv_bla_rx() claims an unclaimed client (or a client which migrated to
the local node) by calling batadv_handle_claim() with the address of the
primary interface as backbone address. batadv_handle_claim() then registers
the backbone gateway via batadv_bla_get_backbone_gw() - but always with
own_backbone set to false.

When no backbone gateway entry for the local node exists yet on this VLAN
(for example due to an earlier error), the entry is therefore created like
a foreign backbone gateway. No initial announcement is sent and the entry
doesn't enter the BATADV_BLA_BACKBONE_GW_UNSYNCED state with the startup
grace period (wait_periods and bla.num_requests). The following call of
batadv_bla_update_own_backbone_gw() finds the already existing entry and
returns early without fixing this up.

As a result, the first announcement is delayed by up to one BLA period and
multicast traffic is not held back while the local claim table isn't
synced yet.

Pass the correct own_backbone value to batadv_bla_get_backbone_gw() by
checking whether the backbone address is the address of the primary
interface.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-dba9d95d-5eeb-40fd-abf4-e054aee1f735
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 68ff2f94..3da070a0 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -986,18 +986,22 @@ static bool batadv_handle_claim(struct batadv_priv *bat_priv,
 				unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
+	bool own_backbone;
+
+	own_backbone = batadv_compare_eth(backbone_addr,
+					  primary_if->net_dev->dev_addr);
 
 	/* register the gateway if not yet available, and add the claim. */
 
 	backbone_gw = batadv_bla_get_backbone_gw(bat_priv, backbone_addr, vid,
-						 false);
+						 own_backbone);
 
 	if (unlikely(!backbone_gw))
 		return true;
 
 	/* this must be a CLAIM frame */
 	batadv_bla_add_claim(bat_priv, claim_addr, vid, backbone_gw);
-	if (batadv_compare_eth(backbone_addr, primary_if->net_dev->dev_addr))
+	if (own_backbone)
 		batadv_bla_send_claim(bat_priv, claim_addr, vid,
 				      BATADV_CLAIM_TYPE_CLAIM);
 

---
base-commit: a793cf82308e57a0e21c97e889c143cdbba67e5f
change-id: 20261115-bla-late-claim-add-c899c0aca686

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

