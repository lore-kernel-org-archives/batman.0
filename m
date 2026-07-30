Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C46C5516E
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:19:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6B50580347
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:19:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785439174;
 b=z1yKb3boxRqocISZ3Mrc8btAKDTyZ9HURZ+vE3QBwtipU9+4+Xpx4yViZ6Yq3+AntJPYs
 yTEvUH92lkFokx7d+Hdm3a00os6bI0dyUoGjoQdqLDRGSLSN3OwVi6pl+6RVyMrvFxC4wPl
 XjCuebTlf/s83miZtyrD8dRPQcc2bVY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785439174; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dJfsgsjttHoqyUOOJ8KgHY4L1JnFaZGPrtgWcVAH5Mc=;
 b=ITaNHjQ2KGeIFMWH4Bbga3rgo/0bAyNETzSW/EZ7kItcp75xNXIW2jKR1Nb6UyIoYptlD
 FptUiUpeZWEwbu+AgL5ZB4CMjtieX5OKRsqN6Bc2dQgX4PtVlfiqMFS6TnhlUcjjxVoI/ai
 38K1FkHdmhTyZBJ+W/YeuxxGbVRqr3k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 305978082C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:19:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785439154;
	b=ICoalp0iF9yzV8EBIvEtBFn/w01QlibmPIn52aigKfO4UgiMo2w5xoGLKSosG886BEGhWN
	3de25UA9Zzxshk+vRfGEqtMPXtj730T6ohoy27wURqxnO3QcKQrUA9EXw96lLiNX5G3ID2
	QuQhb+zgP5N5RutFCafEuIDVJQQzwIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785439154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=dJfsgsjttHoqyUOOJ8KgHY4L1JnFaZGPrtgWcVAH5Mc=;
	b=3GcVtaZ+YWiSeQBC7BmfmkRD173n/eyxFCfBOWQGPKap69trgkUBquwhQUSPx9tAORELeu
	M5Y6KNxMTphluCDktovodFsAOoTvkAP7qLhYyCZ0v4hyuWueWAiw0h5OLTBj/rTXu/HnAB
	QvFmJmlwtttojmsAhODrTSnUVtFjwsU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=IkbCzUVV;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DB2B320CD9;
	Thu, 30 Jul 2026 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785439139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dJfsgsjttHoqyUOOJ8KgHY4L1JnFaZGPrtgWcVAH5Mc=;
	b=IkbCzUVVUZ4kjxGSK9jUZ6KfjoB8gkpAoeE7JIc7JuNp3FHI+qfN+xVJiGufWoQ5A2YXlF
	J9TkAkWiyWlJlqP0CHtdy1moxGkolf4bhSkEQGajPDKgdeyiOVhGD4HRbafFutYiuO93aM
	9YnazGK1zjwAaOia1DCW4GHNNs7SEi8=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/2] alfred: notifications: random fixes
Date: Thu, 30 Jul 2026 21:18:54 +0200
Message-Id: <20260730-bugfixes-notification-v1-0-d7cf675220e2@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+ja2oC/yXMSwqEMBBF0a1IjQ1EbeJnK9IDTUotB1FSSSOIe
 +9ShwfefScwBkKGLjsh4I+YNi8o8gzsMvgZFTkxlLo0uq60GtM80YGs/BZpIjtEKdRHN6ZxxtV
 ta0HaPeCzkrT/vuY0rmjjfQbX9Qc/Z0vfeQAAAA==
X-Change-ID: 20260730-bugfixes-notification-40868d6d799c
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=sven@narfation.org;
 h=from:subject:message-id; bh=K2CpXLG01ebO8OqUbkYpKt/VBm4jPWqKKbYe0c4X6m8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZixd03Z5+bRbj60d+h7MObfhx7Fypa6SVBsNhp4mSV
 jzrHJSNOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT0ddl+J+Urnh4h12sdCiX
 /L03r+3sl2yy9lJ9lcGt/EH5XPKT3FJGhiPOBTcrn32R1Jz3hllJO3ei9cbE/GNn3B23v03jL2d
 bzwwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: M2BGTRUCQRAJQXZLAR33PMVVSMB75WD6
X-Message-ID-Hash: M2BGTRUCQRAJQXZLAR33PMVVSMB75WD6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M2BGTRUCQRAJQXZLAR33PMVVSMB75WD6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Similar to the batctl fixes, I have now compiled a list of potential fixes
for alfred. Instead of posting everything at once, I will be posted in
smaller chunks. They are just various (mostly minor) problems which should
be tackled at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      alfred: Use _exit() in the update command child process
      alfred: Announce changed data only after it was stored

 recv.c      | 41 +++++++++++++++++++++++++----------------
 server.c    |  2 +-
 unix_sock.c | 43 ++++++++++++++++++++++++++++---------------
 3 files changed, 54 insertions(+), 32 deletions(-)
---
base-commit: 462a0cf40615f62e0912c36d72a75accbb26f5ee
change-id: 20260730-bugfixes-notification-40868d6d799c

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

