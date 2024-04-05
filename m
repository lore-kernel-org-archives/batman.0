Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80825C67861
	for <batman-adv@archiver.kernel.org>; Fri,  5 Apr 2024 08:07:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 90DA3819CA
	for <batman-adv@archiver.kernel.org>; Fri,  5 Apr 2024 10:07:04 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712304424;
 b=mNGY0OCxMZTuoZ19ijsNFpfDLUYtz5/KTO39KDzf3iMsAhBvnpgv/amLnbCnfDjc8c8wo
 /Bo1uQZ1tcLF4ArcK+8PtvJ3AFbTrfmblJJuN8MXBZtmtB9/4NWBjx+I/9n+tO1CnrLJrg6
 F+ZbqAiarCfqdPglZlGD8ydGQW9o1VQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712304424; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hwOytiU4ObppMM63nG3fpGrMuoxu8TuHFNzh08DIuds=;
 b=lS/wm2Jcbi1WlMgOXcGQhh+PQ02pOlVxGJe5pXwkujwORJC9qlzJdP9MPzCe7Y7mLuYLL
 v5iTvvxI5YAB/VzCBeCGvZDPEHvBatWOrInnRXxFq3lyrfMt8i+tl+4S5weCH5H+MXouutS
 91ryKuyqUBJxAG4wyrqipa91CoanXyA=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=protonmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=protonmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3A2CC80BF1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  5 Apr 2024 10:06:56 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: About Throughput in BATMAN_V
From: berkay.demirci@protonmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Fri, 05 Apr 2024 08:06:56 -0000
Message-ID: <171230441622.1066.17238774576163032219@diktynna.open-mesh.org>
In-Reply-To: <3327582.AxlXzFCzgd@rousseau>
References: <3327582.AxlXzFCzgd@rousseau>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: 5LBDFIIDGGVN33BP7QXO34ONIJCWIE3D
X-Message-ID-Hash: 5LBDFIIDGGVN33BP7QXO34ONIJCWIE3D
X-MailFrom: berkay.demirci@protonmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5LBDFIIDGGVN33BP7QXO34ONIJCWIE3D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I mean batman is getting the right calculation from ethtool but the problem is the value from ethtool is not preferable as throughput can drop as two nodes move away from each other. After checking the batman code, I have a better understanding. Batman's throughput calculation for wifi interfaces is probably desirable because it is using cfg80211's expected_throughput. But we are connecting custom modems to ethernet interfaces so they aren't wlan interfaces so it is using the speed value from ethtool, which isn't always accurate. 

We also did tests in virtual environment and according to this commit https://git.open-mesh.org/batman-adv.git/commit/6e860b3d5e4147bafcda32bf9b3e769926f232c5, ethtool link speed detection used to be disabled for such cases but got reverted since automatic measurements aren't implemented. So, is throughput_meter fallback method that is being worked on right now supposed to be the automatic measurement for cases like this? Whatever the method is, dynamically calculating throughput is a must because like I said, one of our modems have a shorter distance range so it is faster when two nodes are close but as nodes move away, there is lots of packet loss so the real throughput drops as well, but with overriden throughput value stays the same.

BATMAN_IV doesn't have that problem due to considering packet loss but it is worse due to not taking throughput into account so we can't use that neither. If there is any way to take packet loss into account on BATMAN_V that I'm not aware of I would like to learn that, but I'm guessing probably not.

I see that the last patch for tp fallback was written in 2018, has there been no more progress since then? And what are the problems with it?
