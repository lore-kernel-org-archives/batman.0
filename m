Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE10C3ABC9
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 09:14:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 723F78453D
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 11:14:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746782088;
 b=rVnRx5Pg1Yv2tac2RZbNGpueDkFyl0JMUzSdS4kWI6jLgNXP9dIpMnVtqUDPsdQ4EwxvX
 zSeiBqMTnVowTLXPtG4m+rEfiyiK64LX2JRllJ+e3U931bnI+tNXN4RBVOuhWpqHQbLjG08
 QkrxQ83VfaouMzfoQ+xPz9mgS1dbZAo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746782088; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gDQihycJBI32ZDHhA0WO2HLLdRucBnoDqt/jSMdSdNs=;
 b=Rp/4QLHp++Kti5mM0qyOyL0XCiWyDMKOvnKkLTV4C7iybcGePjM/h5ZtfExHBtd6RuXd9
 6mAmSNZrEyEbWjS8TJpaIuQlY8obj8eXU/pXN69lzUxmSP4mo731V5rXg8JlVPVrJ0oeSag
 FPqnMgmaXoIKZrffVTwh4jxURpOXN9o=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E27E284745
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  9 May 2025 11:10:46 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746781846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDQihycJBI32ZDHhA0WO2HLLdRucBnoDqt/jSMdSdNs=;
	b=P3QlbaSjsSewtTDrvrY18KqmdgOqM4vefCVORxX4s/5iH8IIrxE0Pf8zLCgopdhqMQslBQ
	Fj5lm7A8Rwq+GK0lThK/ugjhPDfDzPcQVWIl95TGXRnwvgQzhSKLJDzNxao3YFhucBx3G0
	aBVfsvkrw/4N+Ev/x7J0MPkr4j4SUE8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746781846; a=rsa-sha256;
	cv=none;
	b=fVuFW7hWW/RipS0/zctVDx+3hvL9GQzwwAgY15/anE0EtIihe7oEzu3psStRr9xO1qQPHl
	z3LaCzeYaIKGEglf+qD87mqZqOQE+Ghzvw2nkSu3EkvX2cTJsitA6LM7HDg4b3hz4ROkKc
	/3QiUk+RXSVJ9kRmm2Q4jlkgZTgoevk=
Received: from kero.packetmixer.de
 (p200300C59736C7D829705D90aB67a755.dip0.t-ipconnect.de
 [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 4FA14FA374;
	Fri,  9 May 2025 11:10:46 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 5/5] batman-adv: Drop unused net_namespace.h include
Date: Fri,  9 May 2025 11:10:41 +0200
Message-Id: <20250509091041.108416-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509091041.108416-1-sw@simonwunderlich.de>
References: <20250509091041.108416-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ADKTMZ6ENRO5ANJWLL5QZZIBBIYBUFL7
X-Message-ID-Hash: ADKTMZ6ENRO5ANJWLL5QZZIBBIYBUFL7
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ADKTMZ6ENRO5ANJWLL5QZZIBBIYBUFL7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Since commit 69c7be1b903f ("rtnetlink: Pack newlink() params into struct"),
.newlink() doesn't use the struct net parameter. A type definition from
net_namespace.h is no longer needed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e48b683a033f..5bbc366f974d 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -36,7 +36,6 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <net/net_namespace.h>
 #include <net/netlink.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
-- 
2.39.5

