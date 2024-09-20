Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4D8CF9C5E
	for <batman-adv@archiver.kernel.org>; Fri, 20 Sep 2024 17:19:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8771883BB4
	for <batman-adv@archiver.kernel.org>; Fri, 20 Sep 2024 19:19:09 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1726852749;
 b=qaTmXAoIqvq68oIwB/JqHwoaggJWGelpdMbVh7FYUFpaS66rESIAfToqXzbNpackk04Ht
 pE6WVL2Px6iJO3bDhKL6EnEAKiKCWtV/zASsnMj5G3Ukl9dMIRrjTqC6KMO9KxzRWqj08PE
 C6lMjo22PwFEcHk7fy45T93T2QxY5pw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1726852749; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZWgodwRWWnxa1CQLLAisuSlbUyDEr722EM+uHFe8GV8=;
 b=Hq8WKdX+3j//Y5Xr4lkIuT/ZbXjHG236pRc/dqhDrvaIoNB7DZVz9cCmUJj2A7uPkjO2a
 KSFqGpP1ujnSHovNEAtDADQvqaCiYhDp1eqe0J2KUQwF5b0ryAk9wHi6ijuva9hAQ5y9LMB
 nrAVcHWoHaFYtINO3IdVqnGI9Th+OAY=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 114DF81C57
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 20 Sep 2024 19:19:02 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] batctl: Dynamically select header format in
 netlink_print_neighbors
From: noahbpeterson1997@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Fri, 20 Sep 2024 17:19:02 -0000
Message-ID: <172685274205.1027.7839019086506414168@diktynna.open-mesh.org>
In-Reply-To: <2622720.Lt9SDvczpP@ripper>
References: <2622720.Lt9SDvczpP@ripper>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: FWOGMNN7UREGQCQGBXSX5LQH2WG3FW6K
X-Message-ID-Hash: FWOGMNN7UREGQCQGBXSX5LQH2WG3FW6K
X-MailFrom: noahbpeterson1997@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FWOGMNN7UREGQCQGBXSX5LQH2WG3FW6K/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello!

I have submitted a v3 of this patch, I believe this time with all of the necessary parts, testing with the proper diff and patching tools, and submitting using git send-email. Let me know if this one is up to the expected standard.

These are my very first kernel patches. I thank you for your patience and handholding :)
