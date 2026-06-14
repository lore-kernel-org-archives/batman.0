Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C72CD98D2
	for <batman-adv@archiver.kernel.org>; Sun, 14 Jun 2026 10:32:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 349CF84554
	for <batman-adv@archiver.kernel.org>; Sun, 14 Jun 2026 12:32:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781433170;
 b=zlu6F2orGiLzZ2WwKLhC2tjBb99PN6qiutq1cT43UQ7+fv1Dd8wx8rANUXkB4n6VQZbvG
 xLs5Yz7gCA5m8dqdd0QAsBj+glQGt5FgKYxbKcsQLG7Xx+FnSo6Ws7gsH6wThjk28xbBFsu
 h9mm22CFgtWQtd9GyLLr3bXGWMI860s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781433170; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nX3YBoj9meNOhllxjdgmgseTe0VtzTHdI7zkvYYIcQo=;
 b=qAwor1GmlkSQvZxmrlKuJePQaWno5MCviAsTuqogIF7lDHz0EX4j1mJltK3ls3CNffiyQ
 jjGWt9UE9xIfjCigNQ+OpR7UHAYDg/+qwM8c5MihQAEaJ2nX/lSTnkxXHA6ZNh7LTP1YzK8
 VVsh0j1QVTl1SBk64EwXKJoj4zfl3K8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DB4ED84007
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 14 Jun 2026 12:30:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781433062;
	b=YR5wRy9Nsq9YdPQ+W/kNt8RNJq7obb41NPtkyA0Cy/GZl+wHH25BGS0IAiIpUjyMmqxK6t
	QwoUwFAa1EGnFqPo7xbymM7ZZWegru5+GlGRsSEenQ7qtMar/cVJEjwGO5A6Zz9KfNSmTs
	owq7z4LZMYuYmNMk08p7RXZyLlKYPM8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781433062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=nX3YBoj9meNOhllxjdgmgseTe0VtzTHdI7zkvYYIcQo=;
	b=L8sbTvkE7gM9Ti2HxZPAyT4i4IVMLJd6En7/nUHThNyF05VyRnKnYXNPPAj2Q/pbFfmxId
	Ab3B6ielFDZe6ItcF6zQCLo42IMTiebMRopVPUDvIxtmWeP9vvyZx/coGjT0eVUgf/Y8+8
	TKXdz6ypQYoyUcCVjbvTXk2BO1aQrV0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NgO1B4Gu;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DF3B81FDFF;
	Sun, 14 Jun 2026 10:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781433052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nX3YBoj9meNOhllxjdgmgseTe0VtzTHdI7zkvYYIcQo=;
	b=NgO1B4GuaiRkzM7dk7WJr8z/MBFpdbfN10q/oKszlFcW8pkrjIm3m3SyrbKF+5Z6D55EIF
	w8LAB6RW9HlJo8gx0+fIQB4F2bd/21rWbXl37Fsj3ijrjhBl1VidOxjrh8pfvsFNOzNSSJ
	9XMeGA73sSWUZjr1BquSeuNhvbBsdsI=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/2] batman-adv: tvlv: avoid race of cifsnotfound
 handler state
Date: Sun, 14 Jun 2026 12:30:39 +0200
Message-Id: <20260614-tvlv-non-const-flags-v1-0-251abea59176@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANCCLmoC/yWMQQrCMBAAv1L27EJSawW/Ih7SzaZGykayaRBK/
 96oxxmY2UA5R1a4dRtkrlFjkgb21AE9ncyM0TeG3vSjGe2ApS4VJQlSEi0YFjcrXs8XsuQ9BWO
 hpe/MIX5+2ztMrjhf4fH3uk4vpvJ9wr4fJvzi84AAAAA=
X-Change-ID: 20260614-tvlv-non-const-flags-735c1cddcf01
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=sven@narfation.org;
 h=from:subject:message-id; bh=CEy915IZLVpZuObdFsRQ12aEjG9A0eBr1+b90oj4bPc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl6Tdc/iPqKvP4k//r5F3XOORfYZVprruU+v+k+0V3a7
 sz8h9PVO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATyXRjZDiYdXZRbaTYzYRs
 pZMLWM9YiR5uXlH64Y7L3dNKxSpTZ0syMkw2fKYgz27a4hU1c8ffIrl26TMvdU7k8T3MzXllbBA
 lywYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NALOEOFEV5A2NJAKUDPECRAMMMXEWIOZ
X-Message-ID-Hash: NALOEOFEV5A2NJAKUDPECRAMMMXEWIOZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NALOEOFEV5A2NJAKUDPECRAMMMXEWIOZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

TVLV handlers can have the flag BATADV_TVLV_HANDLER_OGM_CIFNOTFND set to
signal that the OGM handler should be called (with NULL for data) when the
specific TVLV container was not found in the OGM. This is used by:

* DAT
* GW
* Multicast (OGM + Tracker)

The state whether the handler was executed was stored in the struct
batadv_tvlv_handler. But the TVLV processing is started without any lock.
Multiple parallel contexts processing TVLVs would therefore overwrite each
others BATADV_TVLV_HANDLER_OGM_CALLED flag in the shared
batadv_tvlv_handler.

Drop the shared BATADV_TVLV_HANDLER_OGM_CALLED flag and instead determine,
per TVLV buffer, whether a matching container was present by scanning the
packet's buffer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batman-adv: tvlv: avoid race of cifsnotfound handler state
      batman-adv: tvlv: extract tvlv header iterator

 net/batman-adv/tvlv.c  | 111 +++++++++++++++++++++++++++++++++++++++----------
 net/batman-adv/types.h |   7 ----
 2 files changed, 89 insertions(+), 29 deletions(-)
---
base-commit: a084a40e7529be89a94f843e8927e543df90a344
change-id: 20260614-tvlv-non-const-flags-735c1cddcf01

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

