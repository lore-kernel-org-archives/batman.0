Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C1FCA0FFF
	for <batman-adv@archiver.kernel.org>; Mon,  1 Sep 2025 16:16:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 31A63840F4
	for <batman-adv@archiver.kernel.org>; Mon, 01 Sep 2025 18:16:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1756743384;
 b=zkBVkwuxfvYea52r3dbAMnb1BmZ9PPQnv+m/PCllbN3RA2YiVRY9M4S5ZOFfiWynWTf2J
 LxldrgLT7OU+42645dG7wIYTIiK7bPNSsh63UxJsgwzvfLWpWsbAYv52wN1IFXmnRc69MCV
 s9MnsM4aakQyba7tDAbGTs5+8RKY8z0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1756743384; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dHfMmgOay6SnJhUxCSVnUjSJVqKM4w+xTEq1XLRPUA8=;
 b=QVxpcubbHsbG0YlPmnnmYUAq+QCCaQHzS4W4m50a2CbGPdoJ9mGqRbKxfRxRoWJ7aebaC
 iSBvlk1kTIyap3cva313JZwVk4+03ob6Q2sGp1hSVdqSGm+bH3Enp0q7iAFAf0vKD3/k5Es
 KoBRHisixn/mpiolykEuu1eWpZe13fc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4C65082FA8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 01 Sep 2025 18:15:54 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1756743364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dHfMmgOay6SnJhUxCSVnUjSJVqKM4w+xTEq1XLRPUA8=;
	b=eo//PEgky4fZ7o5T3tsoh5Df78HWMEl8O+yF57Vb1SOCXYp6e9Ff3fOSTgmrkUjrF3pi6l
	xxOwTn++t5BzTYUIGqunEu6n8YKtn/Fbfj6f2qxW1V4qQPxMW+L59xBKIm/DwOu29dh/2C
	OODzIBKEpGhdKGXwwbnkdLrCiOj8SbU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1756743364; a=rsa-sha256;
	cv=none;
	b=x2W8w2EoJd2D8g1Rj/N0JKhaucdD/JmQwbibEBjXLqnO4CVNtXRdsLrPrzGZgIjG9HG6WC
	MZetwrfx7ZFnqxY19HpLqukhGcQJ2fCLEjl2ZtSiYvOvGtG294ewhENQjHrJ5SoPfkQS+C
	vYBhWNbzWIBRqPK5m0CJxKNdWmEJRsE=
Received: from kero.packetmixer.de
 (p200300c59705add84F8b09D1D73C2E85.dip0.t-ipconnect.de
 [IPv6:2003:c5:9705:add8:4f8b:9d1:d73c:2e85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 52666FA12C;
	Mon,  1 Sep 2025 18:15:52 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH net 0/1] pull request: batman-adv 2025-09-01
Date: Mon,  1 Sep 2025 18:15:45 +0200
Message-ID: <20250901161546.1463690-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MGWO37LZBMYTRDAV2ZO7FGJT6RACXVF5
X-Message-ID-Hash: MGWO37LZBMYTRDAV2ZO7FGJT6RACXVF5
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MGWO37LZBMYTRDAV2ZO7FGJT6RACXVF5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 6439a0e64c355d2e375bd094f365d56ce81faba3:

  Merge tag 'net-6.17-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-08-21 13:51:15 -0400)

are available in the Git repository at:

  git+ssh://git@open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250901

for you to fetch changes up to d77b6ff0ce35a6d0b0b7b9581bc3f76d041d4087:

  batman-adv: fix OOB read/write in network-coding decode (2025-08-31 17:01:35 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - fix OOB read/write in network-coding decode, by Stanislav Fort

----------------------------------------------------------------
Stanislav Fort (1):
      batman-adv: fix OOB read/write in network-coding decode

 net/batman-adv/network-coding.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
