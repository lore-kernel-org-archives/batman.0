Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6CBCD5BAB
	for <batman-adv@archiver.kernel.org>; Thu, 21 May 2026 20:33:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D9D8C8418F
	for <batman-adv@archiver.kernel.org>; Thu, 21 May 2026 22:33:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779395592;
 b=iL3GrbDyjwF2ZSStmje2gkQAw4qHgKYkFZTISd9428rF5OPkdHph+YCsfovGE0D+uokYb
 YqLkWu2JCs/r2coyZ/XKT/b5eo+GE+WZOjNqiONHy7xv4r6MFJAOAGFghvAlho86uhEWSU1
 e/YJnjBERaxZvKfhDLZ60q8LxVY5g/c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779395592; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0U/YcUrMYD+APH56VK2mV/pIlTaPposQZDImNmTXHe8=;
 b=o/fEsVzByJHHvrdASWOmimH5+ZOMa/PPle0Bap2wvL1PGEdaoUAcdF6VnrH+gSweBkA92
 APYHUj0lJofB3JJnilItqAoNDViA+gjCYA/MBsIaPyjluqC2x0IhoqNmzgRlNbcEexcl3T4
 4F2+9ffKNguChcd/kY51IsWhN522jIE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 27D1B82285
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 May 2026 22:32:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779395562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=0U/YcUrMYD+APH56VK2mV/pIlTaPposQZDImNmTXHe8=;
	b=E01NNsXvP+L3xSY9GFkeQaw2sjnNWIY+nvRERK2524OZNDZf99KyRTUyIBV+PibwIeenjr
	dvQBqBsc8l6PgspBB6MlPKwM7ANQRjkRDm9UTHAcBvgkvqJlhcgYjUMBNeZDCTNKjWHMf9
	YchF+MZqbnmmndLNriO+qeOnpj95/bk=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779395562;
	b=d3N5q6TKheRNcTCEOn1bgAMyMBwpC2w/jS8j20oQSrEhVGUHv0CW9/cmwVC1ifgsVv3w3D
	Q9ZQVpV4BPQP/MfCl5dilIzYgGiTsDgJ0pcHaMW+JxOr2EShn8WKKKtVf95Nqg5fqj0Yac
	XsCOCY5U9i/lpBUDmAuk58eUjli3TUM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ajqohFMy;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0351F1FF83;
	Thu, 21 May 2026 20:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779395560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0U/YcUrMYD+APH56VK2mV/pIlTaPposQZDImNmTXHe8=;
	b=ajqohFMyw2AtPrbGhBayaxWcWv9rjTzjn/OKaTyl57lyC3dBRRvty+9Bei3Il+U734ZC9u
	edo8URV0d5061R0EzU5WR9917cXYw7rixHxahWf2VzMx7VQWDcjS5LJq7QlDUxrdAdZFFC
	k3otgtF0IYaIVA+QRxjEuTLE1k8iOMU=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v3 0/2] batman-adv: tp_meter: post fixes cleanups
Date: Thu, 21 May 2026 22:32:35 +0200
Message-Id: <20260521-tp-reason-missing-v3-0-26855460087a@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAONrD2oC/32Oyw6CMBBFf4V07RjaUkBX/odxMfQBNbGQtjYaw
 r8LdWOMcXkn954zMwnaWx3IsZiJ18kGO7o18F1B5ICu12DVmgkrWV0KyiFO4DWG0cHNhmBdD4Y
 iCmq44U1F1t3ktbGPzDyTDiOqRC7ve7h3Vy3jBtyagw1x9M8sTzT3/3gSBQqNYNi2rFM1xZNDb
 zCuH+9H32dHYp+Uwy8KgxIOUkhFW1Zp3n1TlmV5ATv6fFMWAQAA
X-Change-ID: 20260513-tp-reason-missing-f1aa51f3f374
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=sven@narfation.org;
 h=from:subject:message-id; bh=+8Q37+wmJiZ+f5x9r0oCb0N3m/CgPXw0O5q1lcQdar8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFn82U/qLfQ0w9vOfDMrazjSIX98p/Lx/1qMM0/l5+5d4
 rbBZD9/RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiU18zMjypOHth3ZcVG+Rv
 /hK+onheS7GzuajZJe4G9w5JsU0bp51h+J/clZgsUfu121b0gbhfwZP9An8mc5ZXzw6conryT0r
 ZbHYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MONNBNYMM4OQP2SATCYOJ22TDFEU7FNX
X-Message-ID-Hash: MONNBNYMM4OQP2SATCYOJ22TDFEU7FNX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MONNBNYMM4OQP2SATCYOJ22TDFEU7FNX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

After most of the problems regarding the role confusion were fixed, we
should use the opportunity to split the variables completly. This can
prevent some of the confusions and at the same time reduce the memory
consumption significantly.

Since the sender variables are separated from the rest, also clean up the
congestion control code. Make sure that everything is in short blocks which
ensure that the reader is aware of the locking and the results of the
calculation. Which also means that the actions (sending) are extracted from
the congestion control code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v3:
- rebase patches
- fix receiver cleanup "put"
- add patch to cleanup the congestion control locking
- Link to v2: https://patch.msgid.link/20260519-tp-reason-missing-v2-0-9c5cd1824e3b@narfation.org

Changes in v2:
- fix send_result kernel-doc
- rebase patch
- add patch to avoid role mixup in search functions
- add patch to split sender and receiver sessions
- Link to v1: https://patch.msgid.link/20260513-tp-reason-missing-v1-1-752a882bd61a@narfation.org

---
Sven Eckelmann (2):
      batman-adv: tp_meter: split vars into sender and receiver types
      batman-adv: tp_meter: consolidate congestion control variables

 net/batman-adv/main.c     |   3 +-
 net/batman-adv/tp_meter.c | 721 +++++++++++++++++++++++++++-------------------
 net/batman-adv/types.h    | 145 +++++-----
 3 files changed, 501 insertions(+), 368 deletions(-)
---
base-commit: ec9f686b42917e9b67725d7245b50de72f59fa9e
change-id: 20260513-tp-reason-missing-f1aa51f3f374

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

