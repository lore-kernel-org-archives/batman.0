Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B20FED9E7
	for <batman-adv@archiver.kernel.org>; Tue, 17 Mar 2026 16:00:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 94E4B854FA
	for <batman-adv@archiver.kernel.org>; Tue, 17 Mar 2026 17:00:42 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1773763242;
 b=TAO5kdARjj7NULePE6fF1rnRb+xfHp6xs6qr5jmbgF0qhG2p17wuChUFLK4GLCIKy8sNm
 k17NMCAkzyKLQNim6ClUcvSODeP67TM2k6wQ1jLdJjP0cLInNep70ZppLsrID7j6li6n7CP
 XiLH5xmmHztOZYjkHzpsF9RX0J/tv5U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1773763242; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HOtUHslmgMBnfqhbb3TaLA6XQwEWCd77fBUOyuR84VI=;
 b=tzp14hrnGoGlUkdFe1j4e+ewSy9jgkJgmAV+fbv3s8lUD+hCVSwxOkiFXtcDdFlmd4bO0
 ey4eYPusrJpfbraQ8dpDJ0xKcN+jK3yZ9QHEpQJZ7ge3lSgQxMOwuVhTfzhUvhpRtZh/mfm
 OB1q7s1IrNrtl1P9OUP6gHz5r3JA0Hg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A591383BFE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 17 Mar 2026 17:00:05 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1773763215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=HOtUHslmgMBnfqhbb3TaLA6XQwEWCd77fBUOyuR84VI=;
	b=Tj9Tv4eGqp3ZisNoPiCE/s7fy0LRLJE75dCYdOVCWkypCsJ6HDLzjMiOcWmuh13enDDNJu
	msxQ2N5CvtEKuPdSz2f7U/V8XF/EkV5NVTug1TcSHF2StnbvVIkQ032eiZr1W1LGOwxYxO
	UoWUAa7Yct6vucN09scro0NB3Ll+60A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=wo3ImZl8;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1773763215;
	b=LUgKw0/RFIeVKfLiqLSSd9QlPBwQrEopuM3DCchsvBMrX4tM3eujsMOjTzLkE26VjEvEvP
	MKw0aqhPkklSjZpBnlU83e/ri4m0nJGvhHufGdDlMyadjFdubIcDCPbDCu8W4S37I3bhp4
	Xcljx4eBIeQ8Cd86y3jN4lNoCG27fUY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1773763203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HOtUHslmgMBnfqhbb3TaLA6XQwEWCd77fBUOyuR84VI=;
	b=wo3ImZl8L5m0tnjl90e3gGe5fbZsOFbqqRjfBZhvxFzx7nOdE9E35FY+PL9DD/JHjLVeOK
	GCBAAYCnx0nG0nSNR0SlzHa7gQukcg8q2cdS2zBPnw8XfkmGnYWMcifi4w5tDxcsFaQFnd
	w+bHe1jQd4GbPA1HBOyggu0pq1Z1NMx9ZLL/pk+ac4QSYyzYD4obiHsM4zl0ko3fRcJban
	s3e+fKHS/k7+Z63trGnfGtmEYKQyr9U52ZK3SSRTpFB+aVCGJctMrSEVx++6wmSTP4KlbX
	P4lFwYziZNAeRqJACzP0x9ctBLzpnySqOGVzUu4Aqr4f0L5UkooCb3Pa5fA8mw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] pull request: batman-adv 2026-03-17
Date: Tue, 17 Mar 2026 17:00:01 +0100
Message-ID: <20260317160002.1869478-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZEZDCO7Q56GEOZU2Q54CXQRWPMYAQZW7
X-Message-ID-Hash: ZEZDCO7Q56GEOZU2Q54CXQRWPMYAQZW7
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZEZDCO7Q56GEOZU2Q54CXQRWPMYAQZW7/>
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

The following changes since commit cfc83a3c71517b59c1047db57da31e26a9dc2f33:

  batman-adv: Avoid double-rtnl_lock ELP metric worker (2026-02-21 13:01:55 +0100)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20260317

for you to fetch changes up to 0d4aef630be9d5f9c1227d07669c26c4383b5ad0:

  batman-adv: avoid OGM aggregation when skb tailroom is insufficient (2026-03-14 08:29:47 +0100)

----------------------------------------------------------------
Here is a batman-adv bugfix:

- avoid OGM aggregation when skb tailroom is insufficient, by Yang Yang

----------------------------------------------------------------
Yang Yang (1):
      batman-adv: avoid OGM aggregation when skb tailroom is insufficient

 net/batman-adv/bat_iv_ogm.c | 3 +++
 1 file changed, 3 insertions(+)
