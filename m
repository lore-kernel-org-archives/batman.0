Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39221C36014
	for <batman@archiver.kernel.org>; Tue,  1 Apr 2025 08:44:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7D0548402A
	for <batman@archiver.kernel.org>; Tue,  1 Apr 2025 10:44:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1743497095;
 b=vLPg2HHN+FgSqpVUi+NZbqIw/HWWqXPWKxSisqb75BOGI6eUzWaX8A+eo4GnyaPxyrhjR
 z15qM0rJGuCc0Jc7KxH5j4y1aPAZxKWS9AGjTd4PeVktmHEP8hkvVqZr7sbHGQoEAqbws9i
 cJJkvyIT8K5VIziUEEb91KvNM/cd0/A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1743497095; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=A6wXBAj2WuBmmKGR90I0iVTSPHWbqOoIW4e01PI8x+U=;
 b=JCkDoA9UAWmaJYUL6Ay/ORVL+xlaY43j3yBmLX0jAV6sXIuZRXeTlkgb8k12yNRRCqwPw
 szAOgGOEnlt7cyy86xJBSEicpVm0VD8Jh8L8KLBhmkq04lLnnkYUyxlR4OK/lpGWmB1KMZF
 Q99sSdrLkWzGTDSyfsqlkhgPoPa6D98=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E44B2809EC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  1 Apr 2025 10:39:39 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1743496783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A6wXBAj2WuBmmKGR90I0iVTSPHWbqOoIW4e01PI8x+U=;
	b=eOAwIF5sETiLwgpwSDa3nUypy68YRPm4MQLG283wUZroqYgt+otmfgS+jGA2o6LJJTIPBu
	EFkv/36V6y69GtJfkhU8kHxzQvaZ6DD7slF3aXjBAMd+FhFGCuUjlrXaZn8Ey/yfOdfmTs
	WZbeBWZfW6mNS1tqtJJA9zxQTD6pEZo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of vulab@iscas.ac.cn designates
 159.226.251.21 as permitted sender) smtp.mailfrom=vulab@iscas.ac.cn;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1743496783; a=rsa-sha256;
	cv=none;
	b=rqDIIu+1/mC5uaXF6efdwDEsuANA6F0vOJSog75K3BnzcbnjSF6nbBLxtKzwKXqeAmKGft
	9fejD+i9cvHIf3pn9MA6FOL+eYbUoZq01Cn6x8h3aKGfTBoT0VGlg9EKyCi4kxq1NuJEzS
	JjNJBNZNIP2HPrgAqMRqnuND1uw4qlg=
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAA33f1AputnQ5eqBA--.451S2;
	Tue, 01 Apr 2025 16:39:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mareklindner@neomailbox.ch,
	sw@simonwunderlich.de,
	a@unstable.cc,
	sven@narfation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] batman-adv: batman-adv: handle tvlv unicast send errors
Date: Tue,  1 Apr 2025 16:39:00 +0800
Message-ID: <20250401083901.2261-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAA33f1AputnQ5eqBA--.451S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1rGF1DCrW8XrWUuw13CFg_yoW8XF17pF
	Z5Gr15Gw1DJa1SqFyjq345Zr4Yyws7KrWj9FZ7A3W3ZFsxKrySgay8Z34jyF4rXay2ka1D
	Xr4qgF9xAa4DCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8TA2frlbhKlQAAso
X-MailFrom: vulab@iscas.ac.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 4SL2YREUIEZ4F2SRHOKDY3UNHEX7HCM7
X-Message-ID-Hash: 4SL2YREUIEZ4F2SRHOKDY3UNHEX7HCM7
X-Mailman-Approved-At: Tue, 01 Apr 2025 10:44:40 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4SL2YREUIEZ4F2SRHOKDY3UNHEX7HCM7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In batadv_tvlv_unicast_send(), the return value of
batadv_send_skb_to_orig() is ignored. This could silently
drop send failures, making it difficult to detect connectivity
issues.

Add error checking for batadv_send_skb_to_orig() and log failures
via batadv_dbg() to improve error visibility.

Fixes: 1ad5bcb2a032 ("batman-adv: Consume skb in batadv_send_skb_to_orig")
Cc: stable@vger.kernel.org # 4.10+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/batman-adv/tvlv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 2a583215d439..f081136cc5b7 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -625,6 +625,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, const u8 *src,
 	unsigned char *tvlv_buff;
 	unsigned int tvlv_len;
 	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
+	int r;
 
 	orig_node = batadv_orig_hash_find(bat_priv, dst);
 	if (!orig_node)
@@ -657,7 +658,10 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, const u8 *src,
 	tvlv_buff += sizeof(*tvlv_hdr);
 	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
 
-	batadv_send_skb_to_orig(skb, orig_node, NULL);
+	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (r != NET_XMIT_SUCCESS)
+		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
+			   "Fail to send the ack.");
 out:
 	batadv_orig_node_put(orig_node);
 }
-- 
2.42.0.windows.2

