Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9033FC02196
	for <batman-adv@archiver.kernel.org>; Fri,  7 Feb 2025 09:58:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C1A4983FA0
	for <batman-adv@archiver.kernel.org>; Fri,  7 Feb 2025 10:58:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738922317;
 b=4Gme0jS0phqciTwsc04Sk0k/xSZ6cpe6ihmBtj0/WB6OIwpWSTE8sS7hIm4dxrJAr2eLr
 ykb6Ouj/DD3VUgsREHkZDeJ8rE3Ch1ir0l5i+jz96t1vZQOCtgCAmzqqz+eZRnalvIF5+3N
 oUf5qpQ5xFEhKaUsy5v932HcWxwTV6I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738922317; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jS7Nwe5NIqFh50fAUbuu8+/QcO/mkwxVrIibeurXQ6Y=;
 b=ahmFzKEKDq1Qn7t0BeGs6Ju1CyJJ/XXOJyELFLzkIofPMImhQqJ71F2emvqI6OsrVmDtx
 OQOsrOhZ0dCDJYmgmhLZa9GyugYeAWXbHfm9A+Xbp8Qp+tHxEuxAn40eT+zuz42j1/9nO8E
 jTXUR2AdLdOo2B1dIfCu/NvgJTllcu0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 743E6810D2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  7 Feb 2025 10:58:29 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738922309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jS7Nwe5NIqFh50fAUbuu8+/QcO/mkwxVrIibeurXQ6Y=;
	b=1wJ+WiJtFQ6VL7wXNZOH07luB9d2e0qDiARJRpNsviL5Y1ZKN2QV2a7PtYqQC8tWqGcsei
	2phvfahfx/c/9VW0y74+LBEVAfcLIu6WuUEJdJRdFRq1JUjiGR/l6fde04ODfs92NdISgw
	MIlzQMFHe4zRTMK0fjfWgx53xabR4Fo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738922309; a=rsa-sha256;
	cv=none;
	b=3huQLwNZObxTABsO5jTsmF1ltchYG2vDV9T9AdC2ED5lTB2eaOK0l+z7kyvv1tZwNH+IDF
	MUhx0I6Cgbo4rz5Fuk3qOagTMMx973WNmHGilghqE6/ITeKwgvRaqbYZlmorMKq/aD2Srj
	gaT44saFwz2zlgLVLgdDqeB84BVKUp8=
Received: from kero.packetmixer.de
 (p200300C59725EFD8c202009b11b64500.dip0.t-ipconnect.de
 [IPv6:2003:c5:9725:efd8:c202:9b:11b6:4500])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id EBBB8FA132;
	Fri,  7 Feb 2025 10:58:28 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net: batman-adv 2025-02-07
Date: Fri,  7 Feb 2025 10:58:19 +0100
Message-Id: <20250207095823.26043-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JEDZ5V5GPVS7WIPVGRDO3DICYGMNCVQ2
X-Message-ID-Hash: JEDZ5V5GPVS7WIPVGRDO3DICYGMNCVQ2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JEDZ5V5GPVS7WIPVGRDO3DICYGMNCVQ2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi David, hi Jakub,

here are a few bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit fff8f17c1a6fc802ca23bbd3a276abfde8cc58e6:

  batman-adv: Do not let TT changes list grows indefinitely (2024-12-05 22:38:26 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250207

for you to fetch changes up to f4c9c2cc827d803159730b1da813a0c595969831:

  batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1() (2025-01-28 22:06:56 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Fix panic during interface removal in BATMAN V, by Andy Strohman

 - Cleanup BATMAN V/ELP metric handling, by Sven Eckelmann (2 patches)

 - Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1(),
   by Remi Pommarel

----------------------------------------------------------------
Andy Strohman (1):
      batman-adv: fix panic during interface removal

Remi Pommarel (1):
      batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1()

Sven Eckelmann (2):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker

 net/batman-adv/bat_v.c             |   2 -
 net/batman-adv/bat_v_elp.c         | 122 ++++++++++++++++++++++++++-----------
 net/batman-adv/bat_v_elp.h         |   2 -
 net/batman-adv/translation-table.c |  12 ++--
 net/batman-adv/types.h             |   3 -
 5 files changed, 91 insertions(+), 50 deletions(-)
