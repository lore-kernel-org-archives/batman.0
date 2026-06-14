Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7926BCD98D2
	for <batman-adv@archiver.kernel.org>; Sun, 14 Jun 2026 08:20:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B05E78423C
	for <batman-adv@archiver.kernel.org>; Sun, 14 Jun 2026 10:20:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781425223;
 b=d5bXvYKvllEtHEzoc+eoojp+E1wyhmks0X1Xvo2ULS/QyPUi63TpzG+JeBWws/RIpXJE3
 6KUNoW329mNThSudlKvl00EcxYCdsNfei3HDlYEfeiyfENLkLc4ovsXsZDl8h2370ncGakV
 x3EL8yGLbZ2wl4lgGUYoqXvjWMgDr/s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781425223; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2OtuiQFFSJYR0JT/1hi4JRUdAk7i70hFVEMbdAo29HQ=;
 b=g1FXSUrN5K46vVndW+BeAnEA54sXFcfFktoHjmc+x50B4HLo7893XWCeb8NR8u8naV7XL
 RZEYBbEvfqUJeGg8snvCDd+9/h+M6cY48vW1OZbGTImGFhK7P3EOsFIAZOfiY6FR2MI+kOp
 +UxgBvwNo5SDRFEE8Kzd9qS8Rr57rHk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0012F808FE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 14 Jun 2026 10:19:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781425200;
	b=Me4mGSZmp/KY3s/06XxCn4DpErirduu3aiAJWOht0LfYSrR0atg4KTLNx6Tow5K/llx/VS
	fR2bh1k36dM4wHvrNXpMaXDzfSwgx5vLWlgXElF4th5D9KAEPVczNmVa2WDekXmzwhFgnM
	M29Oy8nTuyXzUiXR5ehOmn4rUNb61ZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781425200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=2OtuiQFFSJYR0JT/1hi4JRUdAk7i70hFVEMbdAo29HQ=;
	b=2qShSUB0jD8YDNBp4h9Y0JhN6uBQCjmT6vFCeR3uW9S2apY3YI9qNPLPDkIhIYU2Fk/dH+
	00JSbPczZyOSCvYjky7Lf5QHdPiVNAFMTGbHUFVlRf2CgLHux1IzCNrfzxzpF4ZbTIIYDl
	kmBEk1P626RvpvUmA/aXYpfOJJVupR4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Mu7z1TEu;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8C32420296;
	Sun, 14 Jun 2026 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781425198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2OtuiQFFSJYR0JT/1hi4JRUdAk7i70hFVEMbdAo29HQ=;
	b=Mu7z1TEu1GQIc8wNNhgCPvIN93y+g8hPKrmeFn7YXazyk1Th7JCeyJrO3/y+eQLMztPehM
	0gZ1CDd1JeP3GIuj/I9gPV/6yS37t6/Nv8um5sOMyWxdXAQTP6qs9IYmPvtMIyeD6H6yNq
	yc4akjSZolMo8IBPZhAH98EJObCLdrM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 14 Jun 2026 10:19:54 +0200
Subject: [PATCH RFC batadv] batman-adv: tvlv: enforce 2-byte alignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-tvlv-2b-align-v1-1-6e21383cd287@narfation.org>
X-B4-Tracking: v=1; b=H4sIAClkLmoC/yWMQQqDMBBFryKz7oAZQxbdFnoAt8VFEkc7RVJJY
 iiId29sl+9/3tshcRROcG12iFwkyTtUUJcG/NOGmVHGykAtmdYojbksBcmhXWQOOCnlvCbTdZq
 gOmvkST6/3gP6++3cnM12LDD877S5F/t8NuE4vhGL3a+AAAAA
X-Change-ID: 20260614-tvlv-2b-align-f11bc4263342
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3371; i=sven@narfation.org;
 h=from:subject:message-id; bh=vGPIcQQ/LMVuVBNC+dx/V9SnrGEQZ9DUQ2m5AExfU0Y=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl6KVrdUpvkmve8W3rnZulMPpbPwalu3ZneBRor2pSNb
 jq9aV3bUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhIkRcjw7Hja079dTn5X1TV
 qmqC8pErchbWXUuXyjm+jUmrbVy+ehXDH75vhztelwTft94/N5WtQUPN+lTsFP/iT7lu7q+cXwr
 /4gYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DRIGY6B6SLXPRJOSNU27VSLYPRYM2ULS
X-Message-ID-Hash: DRIGY6B6SLXPRJOSNU27VSLYPRYM2ULS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DRIGY6B6SLXPRJOSNU27VSLYPRYM2ULS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The fields of an aggregated OGM(v2) are accessed assuming (at least) 2-byte
alignment, so a following OGM must start at an even offset. As the header
length is even, an odd tvlv_len would misalign it and trigger unaligned
accesses on strict-alignment architectures.

Such a misaligned TVLV/OGM/OGMv2 is not created by a normal participant in
the mesh. Therefore, reject such malformed packets.

Fixes: 0b6aa0d43767 ("batman-adv: tvlv - basic infrastructure")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 11 ++++++++++-
 net/batman-adv/bat_v_ogm.c  | 11 ++++++++++-
 net/batman-adv/tvlv.c       |  6 ++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 7588e64e..bb2f012b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -316,14 +316,23 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 			  const struct batadv_ogm_packet *ogm_packet)
 {
 	int next_buff_pos = 0;
+	u16 tvlv_len;
 
 	/* check if there is enough space for the header */
 	next_buff_pos += buff_pos + sizeof(*ogm_packet);
 	if (next_buff_pos > packet_len)
 		return false;
 
+	tvlv_len = ntohs(ogm_packet->tvlv_len);
+
+	/* the fields of an aggregated OGM are accessed assuming (at least)
+	 * 2-byte alignment, so a following OGM must start at an even offset.
+	 */
+	if (tvlv_len & 1)
+		return false;
+
 	/* check if there is enough space for the optional TVLV */
-	next_buff_pos += ntohs(ogm_packet->tvlv_len);
+	next_buff_pos += tvlv_len;
 
 	return next_buff_pos <= packet_len;
 }
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 95efd8a4..037921aa 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -849,14 +849,23 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 			 const struct batadv_ogm2_packet *ogm2_packet)
 {
 	int next_buff_pos = 0;
+	u16 tvlv_len;
 
 	/* check if there is enough space for the header */
 	next_buff_pos += buff_pos + sizeof(*ogm2_packet);
 	if (next_buff_pos > packet_len)
 		return false;
 
+	tvlv_len = ntohs(ogm2_packet->tvlv_len);
+
+	/* the fields of an aggregated OGMv2 are accessed assuming (at least)
+	 * 2-byte alignment, so a following OGMv2 must start at an even offset.
+	 */
+	if (tvlv_len & 1)
+		return false;
+
 	/* check if there is enough space for the optional TVLV */
-	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
+	next_buff_pos += tvlv_len;
 
 	return next_buff_pos <= packet_len;
 }
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 403c8545..a957555d 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -477,6 +477,12 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 		if (tvlv_value_cont_len > tvlv_value_len)
 			break;
 
+		/* the next tvlv header is accessed assuming (at least) 2-byte
+		 * alignment, so it must start at an even offset.
+		 */
+		if (tvlv_value_cont_len & 1)
+			break;
+
 		tvlv_handler = batadv_tvlv_handler_get(bat_priv,
 						       tvlv_hdr->type,
 						       tvlv_hdr->version);

---
base-commit: c7518adb8b6ebdc481f6ed1fc42c7f45099806af
change-id: 20260614-tvlv-2b-align-f11bc4263342

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

