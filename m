Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21A4C02183
	for <batman@archiver.kernel.org>; Fri, 17 Jan 2025 08:53:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C40F483FB3
	for <batman@archiver.kernel.org>; Fri, 17 Jan 2025 09:53:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737104015;
 b=v/fNghe0iUv0fPsIg2MpYxWiUwSaviu5Wf1Qpm7XGequvR9D/2j8RuLcHdJ1FrV79faHp
 ntD3oNLiK8h6/ZlEDQT+5JDk/jWwpg8zNY6fpBONXYgaXhyrNrfeJTzJAfodN+IT4fKOmdI
 OWp/BeOs0J0F1FfNI9ETiQPPH4LtSj4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737104015; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=j9VZJVaj3CSNOw0um4appWJUladN+aj1pXmGX7QlxSg=;
 b=H5b/QUgwhEUzPfMTp75c9uLbc/VDMS4u9HiFfCMFjuv06ls3ig6AUht1yhij8UfzSlYSr
 pdRckYIo3wS3AhkPpwVuxFOx7ievN9v93EEWcz+UhQu3Aun5yTMmigymr3YIzdGmI30S25+
 WnPqA4dDpKOdyfUG6hoE3ERR+8vUWA4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A1D0281415
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 09:53:21 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737104002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j9VZJVaj3CSNOw0um4appWJUladN+aj1pXmGX7QlxSg=;
	b=lg3pVvEYHBm3uIDGFRPTk2LUIaeHmj8ktonlUotTbRD/jxNi/pfl/9GAmNOA5A88E69rOy
	rU2+d0wdjSShGXKwrsie5XYIhRVbMeJ8kUmrlTy+WNAYaiaPMHe+E8W2sgoZH3ycGARhGR
	Oos9/RmR/2CXZ1g9Xu57rqSzR6g3Puw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737104002; a=rsa-sha256;
	cv=none;
	b=1xAiEYWdVhbuullecZR92X9rZx6xX/bkISGRe/5n1vmJcYsKjNOWLyUSSrmoLRhcxQj333
	84XCCH6g7dAyCAXxk2Jfc9cW+Y/S1Bb6OEk+k2aEsLSIZi8AcdN7ty1S8A4U5ICycN1hU9
	MKdGpUPPkvb7OOr+iMIDSivvv7LcATg=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E48E954C215
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 09:53:19 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH v4 0/3] add dynamic, bridged-in TT VID detection support
Date: Fri, 17 Jan 2025 09:39:12 +0100
Message-ID: <20250117085317.3426-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: WUCSBQSARN7U655D5LKYM3RLUJADRNBC
X-Message-ID-Hash: WUCSBQSARN7U655D5LKYM3RLUJADRNBC
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WUCSBQSARN7U655D5LKYM3RLUJADRNBC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

For one thing the following patchest is supposed to mitigate the
regression of extra OGM overhead that we accidentally introduced with
the introduction of the compatibility version 15, the TVLV support it
provided, together with TT VLAN support. The addition of these TVLVs
roughly doubled the OGM overhead back then, also/mainly because the
8021q and Linux bridge modules would add TT VLAN IDs 0 and 1, even if
no one is actually using them. While the 8021q VLAN 0 ID addition was
addressed in upstream already, PATCH 3/3 tries to avoid unnecessary
VLAN additions from the bridge and only adds such VLANs if they were
detected on actual traffic.

In preparation of this the internal VLAN creation was overhauled in
PATCH 1/3. This also in theory allows detecting new VLAN IDs dynamically
from traffic from bridged-in traffic. So far, VLAN IDs could only be
used which were anticipated and configured on top of bat0 by the
administrator.

However the detection of VLANs from bridged-in clients is by default
disabled for now through PATCH 2/3. This patch adds a configurable limit
for such snooped VLAN IDs, defaulting to zero for now. The issue is that
each added VLAN still increases the OGM size considerably in the current
protocol, so it is not advised to add many VLANs at the moment, without
a bigger upgrade of the protocol. Also there is still an outstanding
issue with temporarily broken broadcast traffic upon adding a new VLAN if
BLA is enabled at the same time. Therefore defaulting to zero snooped
VLANs from bridged-in clients for now.

Regards, Linus

---

v4:
* reworking PATCH 3/3:
  * removing the added exception for VID 0 again, addressed upstream now
  * replacing the specific VID 1 exception for the bridge default PVID
    with a more generic solution: a user might change the PVID or add
    other, untagged VLANs on an access port which we should also ignore;
    instead always avoid such kernel event additions if a bridge is on
    top of bat0

v3:
* fixing refcounting, removing an unnecessary kref_get() in PATCH 1/3
* adding PATCH 2/3 + PATCH 3/3
* resubmitting without the RFC tag

v2: fix a typo, a missing "to" in the commit message
