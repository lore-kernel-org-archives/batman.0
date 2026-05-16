Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAE5CD4F21
	for <batman-adv@archiver.kernel.org>; Sat, 16 May 2026 07:16:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 26563846C3
	for <batman-adv@archiver.kernel.org>; Sat, 16 May 2026 09:16:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778915806;
 b=qvEOmrbIPbPrliuE5RAbLOXF7fwUnNvmlCM97JqdJy5jVpYfdyqoLMIAeG/3dPQF8vUDo
 T77jobA834xmMfsyDl7BGgJNuiZH2UtZrnKl9udO0uc2K2bePyCKcDHCHyZSZJ0IbSEaSXw
 ANQQe7PcY1TtHlzVnuS4jkS5wuYrxYw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778915806; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=z/Vb10HZZXM8xyQzvhVc2aaGuq+L0ejqfENniO1jjRE=;
 b=Id3rC03qrFMianhb7YB4MZcQnnKCTyxNNStaS0XbjSBbuHUKu3DMz3RbXd+vtNAYR8uV4
 PdC4jeF0Lf76Q/G70sZUcOj4Bohqad5qltnuMz928UzqQeMllzwC4rUzVXqZMutqjAsPcOd
 Uvtg4+71OSKSOlHJbNM5GEoq3NsbUn8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E7B6085D76
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 09:15:02 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778915712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=z/Vb10HZZXM8xyQzvhVc2aaGuq+L0ejqfENniO1jjRE=;
	b=dGlC1+Eu3K8pT7OnrhUYFmkob9sVlaky7+60H8SMIna6OEoSdNwPY3qVAkfCa+nTj1f2VD
	th6e71SQF3oeOIeVv49UIucrC8V/nYpQnrzTRcymm/F6aq/rL1FMsKuFVbhQRqLmJukfyT
	g44SNgcYNBaYbZDoK4r/Kvc6OdHBF78=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fSxZDMy3;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778915712;
	b=ml7Q6465dQmJtPz1EZhtMQeEUVjosFsfv275ibEswV9G4iYY4GJTfO6bghgN35P988mlew
	d9/IttlJaG5ZvK8VxSwdHNV+BVDviyARynLV9inNprSRD8qKSkg+JbJisezqMxLaunRBwy
	VlGx+7u3EeAi4FGRkBFbbyCWvMfKQnU=
Received: by dvalin.narfation.org (Postfix) id 235081FF78
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 07:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778915702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z/Vb10HZZXM8xyQzvhVc2aaGuq+L0ejqfENniO1jjRE=;
	b=fSxZDMy3S8ncB8bl3CmN0uQqSuxGhUIttacdhDD3ahYYIQDAo+/miv1K4T1HzsnK3EL/C4
	Xb6Mb9n3oou05223BYwqgigGSzW9pXrEhzpEU5+HI1UqfgyUseHI+cti+30YUHLyjoCZPa
	NTDNMSw5bzKzaPfrIBAk6eM34OKYDms=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v4 0/4] batman-adv: collected fixes (Yuan Tan)
Date: Sat, 16 May 2026 09:14:55 +0200
Message-Id: <20260516-yuantan098-bugfixes-v4-0-9b5743d147bd@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG8ZCGoC/23OwW7DIAwG4FepOJcJTGClp73HtINJTEoPpAKCV
 lV595HkUk05WTb29/NimVKgzK6nF0tUQw5TbE13PrH+hnEkHobWMxBghBaWP2eMBaOwF+7m0Yd
 fytyTM0YDrJW1y0ei7aEdfjOHBYfKfvZ5nt2d+rKS6+Yt5DKl5xZf5ba/J0l5mFQlF9zg4I012
 oNTXxGTx9J+/TGlcUup8O6oYweaczGKbI8IqD+PHPXu6GNHNUejRistdNrAf2dZlj+XakpqZAE
 AAA==
X-Change-ID: 20260509-yuantan098-bugfixes-feb66522feb6
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2822; i=sven@narfation.org;
 h=from:subject:message-id; bh=lAqp+Sgwa0CeNUfGLIlL5XiQ07QSFOuJPNzIyAT3dGc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkckkWJk4NnL6tcUiqTHTnv4rOa+f8fmOlf8refE77Iw
 FJGcYZsRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiE8IYGabejmjR4Dtw7FXx
 oyWf8mtcQpn/39vbdvwe23qL2Q8yJHMYGb4FXjxqN+u9icqrKr+zat1GbYp7ObqjFz4TS3kRKbn
 NlAsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AGPVBF4X35YSUQGMVZSF36RHHJ7EA26K
X-Message-ID-Hash: AGPVBF4X35YSUQGMVZSF36RHHJ7EA26K
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AGPVBF4X35YSUQGMVZSF36RHHJ7EA26K/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I was contacted by Yuan Tan regarding some of the problems which were found
by them. I've proposed to go through the list and prepare changes for
things which looked sensible. I've also prepared some PoC patches (lets
call it part2) - just so Antonio+Simon+Marek can discuss about them
internally.

The ones which don't need further discussion are shown in this patchset.
For the others, I am waiting on the results of the internal discussion.

It is more than likely that there will be updates to these patches because
the team around Yuan Tan need to verify that these are actually working.

Thanks to Yuan Tan, Yifan Wu, Juefei Pu, Xin Liu and all the other people
involved in finding + fixing these bugs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v4:
- always update length in batadv_tvlv_realloc_packet_buff()
- fix allocation size in batadv_tvlv_realloc_packet_buff()
- reorder TVLV fixes to first reject failed TVLV appends and only then
  handle check for oversized TVLVs
- fall back to non-TVLV version in case batadv_tvlv_container_ogm_append()
  failed for B.A.T.M.A.N. IV - see
  https://patch.msgid.link/20260515-bat_iv-own-fwd-failure-recover-v1-1-caa171e7d59e@narfation.org
  for an idea how to handle it differently
- Link to v3: https://patch.msgid.link/20260515-yuantan098-bugfixes-v3-0-5a5a91924562@narfation.org

Changes in v3:
- drop applied patches 1-3
- add patch to return errors in batadv_tvlv_container_ogm_append()
- add patch to avoid reallocating the ogm buffer for each send ogm (this is
  actually a feature and should not be added for net.git)
- Link to v2: https://patch.msgid.link/20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org

Changes in v2:
- add role checks in all tp_meter functions
- free skb in batadv_v_ogm_queue_on_if
- propagate bat_priv from batadv_v_ogm_queue_on_if to batadv_v_ogm_send_to_if
- Link to v1: https://patch.msgid.link/20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org

---
Sven Eckelmann (4):
      batman-adv: v: stop OGMv2 on disabled interface
      batman-adv: tvlv: abort OGM send on tvlv append failure
      batman-adv: tvlv: reject oversized TVLV packets
      batman-adv: tvlv: avoid unnecessary OGM buffer reallocations

 net/batman-adv/bat_iv_ogm.c | 47 ++++++++++++++----------
 net/batman-adv/bat_v_ogm.c  | 73 ++++++++++++++++++++-----------------
 net/batman-adv/tvlv.c       | 88 ++++++++++++++++++++++++++++-----------------
 net/batman-adv/tvlv.h       |  5 ++-
 net/batman-adv/types.h      | 31 ++++++++++------
 5 files changed, 149 insertions(+), 95 deletions(-)
---
base-commit: 724c381c1dcd0f0682ba36909ca6b843d11d3c2f
change-id: 20260509-yuantan098-bugfixes-feb66522feb6

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

