Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E03ACD3424
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 12:29:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 06C3F85B36
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 14:29:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777811381;
 b=1AVieofkSKxeqO28tzKWlGNA/GxPiD00URK+gwIkMI+BAlqN2tf7+uOdjDIiXUA1g4vWp
 2M/mvGgSLdBfhgDAfbttOaZvymcouiYzmDrdxW+JcwfJ54GQQSzF4Os4wlop+EPzq+EQ4m2
 4vtKSwJxfzfP2E1Xz6yVpHGey/qE2dw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777811381; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NU82pacaH/7nS3zsa5YdCbCT31Gr8zFCSqlWYU2hLoA=;
 b=S8ujQgc/mK6yxc+BnxBIwJDMy0LR8RbNBHFX/wYK2VCdzWhsWJgxnGZNWMTsBuTPJNHuz
 oTUPHp/p8DPmJ15AVIOVMYBU0TFHXgrJcs+HVfkJy0DX5OTjPtvBtrZQsryrEmnLyHOC6oM
 xsT8QhjS2RSq0g+EmQezBf7TFI9cCPc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CF3DF83D4C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 14:23:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777811014;
	b=VvOH8XuAM7FOujv4vua4BAvXb1kz7/lZJscfmZ3MseqFo5RSyswopGeTmtO37pupOC4EvE
	FbGkILfAjvnoU7D2EY+6PwCVDpdn8Cv7gtdRKQGaKTWTB9dCiIt4qFmHUUFr/sWLZnZd61
	rl8flecGz5/DzQzJaBWBG8PICvRfFxE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=a0P767NB;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777811014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=NU82pacaH/7nS3zsa5YdCbCT31Gr8zFCSqlWYU2hLoA=;
	b=oFf/sUPqkKBbOieIundETQwmitUYAiplpxVRxqDSFDKtKfI41IeK1v8pu7SvykZ8wK9Snw
	xKM34cs2UgVvfenrNKQduvWTRf98sK7jwH7CenVR8GPdxMsfJ6sNYLKDhcR4dyzdLP40Qz
	sh4ajWoSUGRD6gssCZaUPeREeP77sK8=
Received: by dvalin.narfation.org (Postfix) id 87254218D1;
	Sun, 03 May 2026 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777811014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU82pacaH/7nS3zsa5YdCbCT31Gr8zFCSqlWYU2hLoA=;
	b=a0P767NBTkE9pKzFy+muqyG47jDDe6mf5qjkaVNytPv471KQS1VG8HqWJqvlE92G5hJkZf
	aTZPZahoERrDqQHudqr4dXmyHtb/G5/zhZCErV4gYOUallQoRX5gzmtcIrEXbqJ2mTrgn+
	uSxX3eF34g8lF+CsSS/PTDpiNzkowEA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:40 +0200
Subject: [PATCH batadv 7/8] batman-adv: tt: avoid empty VLAN responses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-7-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=sven@narfation.org;
 h=from:subject:message-id; bh=n6n5jwvCz38+o0+vFsAJCBUr18DFK/HTdcm7jn6fflQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WTdUs3XVQpwhvsnhiy73HJDTjvl2If8pdJN01JYz
 qWLZFV2lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACYy5T7D/7RLSqkTT52xfdHu
 Iuj0saf8Qt366wsebZVlfhqmuf23FxfD/zjeKr26VRe2bNFuvbv5/rM7P5k3mxxcVqJe3utsyr/
 vKzsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: DIBUA5ZOOOTKFDNXHMQ3G3C6T7H6KINR
X-Message-ID-Hash: DIBUA5ZOOOTKFDNXHMQ3G3C6T7H6KINR
X-Mailman-Approved-At: Sun, 03 May 2026 14:24:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DIBUA5ZOOOTKFDNXHMQ3G3C6T7H6KINR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit 16116dac2339 ("batman-adv: prevent TT request storms by not
sending inconsistent TT TLVLs") added checks to the local (direct) TT
response code. But the response can also be done indirectly by another node
using the global TT state. To avoid such inconsistency states reported in
the original fix, also avoid sending empty VLANs for replies from the
global TT state.

Cc: stable@kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f5b9143c803a..5a005d4e6cc6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -797,24 +797,26 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 				   s32 *tt_len)
 {
 	u16 num_vlan = 0;
-	u16 num_entries = 0;
 	u16 tvlv_len = 0;
 	unsigned int change_offset;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
+	u16 total_entries = 0;
 	u8 *tt_change_ptr;
+	int vlan_entries;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		total_entries += vlan_entries;
 		num_vlan++;
-		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
 
 	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
-		*tt_len = batadv_tt_len(num_entries);
+		*tt_len = batadv_tt_len(total_entries);
 
 	if (change_offset > U16_MAX || *tt_len > U16_MAX - change_offset) {
 		*tt_len = 0;
@@ -832,17 +834,28 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 
 	(*tt_data)->flags = BATADV_NO_FLAGS;
 	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
-	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
+	num_vlan = 0;
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
 		tt_vlan->reserved = 0;
 
 		tt_vlan++;
+		num_vlan++;
 	}
 
+	/* recalculate in case number of VLANs reduced */
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
+	tvlv_len = *tt_len + change_offset;
+
+	(*tt_data)->num_vlan = htons(num_vlan);
+
 	tt_change_ptr = (u8 *)*tt_data + change_offset;
 	*tt_change = (struct batadv_tvlv_tt_change *)tt_change_ptr;
 

-- 
2.47.3

