Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C1FD6C2B4
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 22:15:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D07388426E
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 23:15:55 +0100 (CET)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732054555;
 b=jkbZjYUeTNUkBgObvX+giJivOAN9RdALDBztlmevuiowhXXc08kxG/TJ+unjoB0Y/xR3K
 48pIMfBBMWzOZmmSOVJ29cISViI1E78uD7Y3RG413EUv5HlgzqGYKzDzG5ncd8EcPx/Jabk
 9sAxbul9rAEd4uy2HpzTRqF/XXN95ls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732054555; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5TBc4RE1cc2bBTLnPgSEkCiV6cJ/U6xhQH7O3OxBWEg=;
 b=cXc5dvEKMZJ4QVADey9JYbzEy5oS8ngid5bUMRllt3SgxF8DiH3GBpSWU2ERaGWtgq+yt
 d5WxY08Fxxytxhd4DtMsJ5ZWIkggmJArBhZh3BIkzGfmkjkdiZuwAlSKR0zRQIFE7ihQK6o
 UuljBacop8d1voUQ4fDfi0zzUji7xEQ=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 573A482600
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Nov 2024 22:58:23 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: IP connectivity issue at openwrt nodes
From: soanican@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Tue, 19 Nov 2024 21:58:23 -0000
Message-ID: <173205350334.676947.1092357942194170513@diktynna.open-mesh.org>
In-Reply-To: <2631894.Lt9SDvczpP@ripper>
References: <2631894.Lt9SDvczpP@ripper>
User-Agent: HyperKitty on https://lists.open-mesh.org/
X-MailFrom: soanican@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: ZCTSKZTTCINY3OPVBFXRSY2CPAYEVZYE
X-Message-ID-Hash: ZCTSKZTTCINY3OPVBFXRSY2CPAYEVZYE
X-Mailman-Approved-At: Tue, 19 Nov 2024 23:15:30 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZCTSKZTTCINY3OPVBFXRSY2CPAYEVZYE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

ok, thanks for the hint.
mystery resolved:
my AP and STA were both on WDS mode, looks like batman is having issues with 4-address mac frame format.
Taking them to standard mode resolved the issue.

But then Im having many tcp out-of-order, dup-ack issues, making streaming almost impossible. Not sure if these are related to MTU stuff.
Will need to spend time on this.
If any threads regarding this may help a lot.

Best regards
