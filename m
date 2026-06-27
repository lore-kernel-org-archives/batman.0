Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61BEC43458
	for <batman-adv@archiver.kernel.org>; Sat, 27 Jun 2026 04:56:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0801F83C52
	for <batman-adv@archiver.kernel.org>; Sat, 27 Jun 2026 06:56:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782536218;
 b=nPkoPHKTyoDOCvc8Tf/lqTzZyRZI/6uQRSsMNNgC8gbX+Gg1/ZniBSGzDJE8lpqxw3zVU
 1pvGcJmph+cBHwJdjsHdWhnsVlP7Rnp0Ro11vqFCHMNIYSYyxHLKUmgNsDbqTy5m9m18Y2v
 NCKPGAMjldbEcSIKzMaB5ZRhycgeFu4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782536218; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nxRoRIto3gE2Gxx3YATfGiBfO/7WU2IvS77pRGagKzw=;
 b=HhMKytPK3LNcdNJ28zrgtLDg6v5D0iB3gUBWuQkO6bceOxGemyzoq0Z7R8zhIE5aU9fqj
 ARGGucsUe4bSl+tuX6Zci11/CU7JeZpVAfD81YUo6fQxmCRtJr4UULL3Fb08d39sEZH9PDX
 rMpsZivonrvUz1jYqxpf7taukTZk+Zw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0E19B817C3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jun 2026 05:46:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782532018;
	b=1l2DVbyiUV7kbx5XZFHK35TbjeuA3Kv2YOyWq7nfctYFo+otOV0HK76eTvpAMUpWysi3Mf
	1ShMiatFsG/yBKuW+aYym3P4cmsnDRfKvfq8xDehavOamxUIgldW7X+qYNTX6LqyteJo5B
	HwWmdVL00qpd87kV9UVMCmhbIzzj0Cg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782532018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nxRoRIto3gE2Gxx3YATfGiBfO/7WU2IvS77pRGagKzw=;
	b=1Zr3Fe5XcvEFpQL0Fjz2KrA/HVxo6SvCkEtzYYSkvseyUxhGHgqcJ880qLREh54mImiP/V
	9ONV9FLKioAyHjmOQT2LVcfOxbDowu7zRIyLDZs6VMzocqh3okKlhvZPumig+jzmj6tkKK
	FlUzrtoYK44UlKADleM1DL2yHj8+z+k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of vulab@iscas.ac.cn designates
 159.226.251.21 as permitted sender) smtp.mailfrom=vulab@iscas.ac.cn;
	dmarc=none
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAD3mtOeRz9qhH+BAw--.22948S2;
	Sat, 27 Jun 2026 11:46:39 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: net/batman-adv: batadv_interface_kill_vid: extra
 batadv_meshif_vlan_put after destroy
Date: Sat, 27 Jun 2026 11:46:36 +0800
Message-Id: <20260627034636.59693-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3mtOeRz9qhH+BAw--.22948S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1rGr4xXw4fGrW3uryfJFb_yoWkKrc_Wr
	n7ua4kGa4I9F4v93W8ZrW3Arn7KFs7Xwn7Z397Kry7t3WjvFZ5ZrZ7X3Z8C3yxur4kAw1U
	Gr12vF1Fyw1rWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5dgADUUUU
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgILA2o-DDp59AAAsi
X-MailFrom: vulab@iscas.ac.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: CMVLMBVQNNATVLG7F44WM5O2P26VLLSP
X-Message-ID-Hash: CMVLMBVQNNATVLG7F44WM5O2P26VLLSP
X-Mailman-Approved-At: Sat, 27 Jun 2026 06:56:38 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CMVLMBVQNNATVLG7F44WM5O2P26VLLSP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In batadv_interface_kill_vid(), batadv_meshif_vlan_get() acquires a
reference on the vlan object. batadv_meshif_destroy_vlan() internally
calls batadv_meshif_vlan_put() which balances that reference. However, an
additional batadv_meshif_vlan_put(vlan) is called after
batadv_meshif_destroy_vlan(), causing a refcount underflow and potential
use-after-free of the vlan object.

Remove the extra batadv_meshif_vlan_put(vlan) call.

Cc: stable@vger.kernel.org
Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute framework")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/batman-adv/mesh-interface.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e7aa45bc6b7a..cc974f243200 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -691,9 +691,6 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 
 	batadv_meshif_destroy_vlan(bat_priv, vlan);
 
-	/* finally free the vlan object */
-	batadv_meshif_vlan_put(vlan);
-
 	return 0;
 }
 
-- 
2.39.5 (Apple Git-154)

