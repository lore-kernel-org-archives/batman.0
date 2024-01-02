Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14C8C46CD2
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 11:15:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0B7F383DEF
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 12:15:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1704194111;
 b=rzv2R2tE0moH8rGI3TZt4CRMl3r+NbugRni07Lnnt87QS6JaOx+fkiJznUNlbHAw7lmQo
 JYscMucsl0eZ+Lkel+MwVuj4JOI7UvqTBxY5gAzX0SrQInohA5xuShMn8QXaKvORPVMi3Hb
 TQ4luIM9V7xRY88UtXm8Fkxi9p4uLH4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1704194111; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=oyPjEeuxtDBFVkY9Nbx9Eq3tKS1DtSN7Rv8LqOcvj9s=;
 b=2rb+tEU0iF21+BlU89qtKelHOBa7LLItVF8fsNFug2aY7mf90SenqHgXPPPQ7kPkmtg66
 UQvCJpYMNGqMqG2jpPd+nODpYCEKPDJWECdW8pa+ONZ6DHHjXXzk9Fiw7rpU035NI7vvMdC
 etN2GooYNFYEHHFXQAx/pda623rIbFI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=web.de header.i=markus.elfring@web.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=web.de
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org;
 dkim=pass header.d=web.de header.i=markus.elfring@web.de; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=web.de
 policy.dmarc=quarantine
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 36CCF806C9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  2 Jan 2024 08:10:44 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1704179444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=oyPjEeuxtDBFVkY9Nbx9Eq3tKS1DtSN7Rv8LqOcvj9s=;
	b=0z7WqRZ8CMmg6dRR8DFPHl9Ln/WyWO3Cy4vkPdMy/ufyT7xuhKZBdvYZizqtMvzickd4r7
	iFyvDyKSQGbcHvn59HZjH/STu2SdBMTXN2cNycP5XfGls4PvT/ufTYGyzq5CyDkgzkKupQ
	sB0ExvbHCgOIXOsk/mBinky32gd/57c=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1704179444; a=rsa-sha256;
	cv=none;
	b=3ONgoYf/BzE1PjoI3pbga1x7Iv35rKpzV5wiaevJsm9XMMjOXHEW4mara8lXUKdpmJbHtg
	+YggAgmirOJg3sFA00BhUtKUh+Hof6neaTzrpc0I9kEqLrn/NACKaHDY0tPH9TWiLWBygI
	QKX+H+JO0fXV8IYCyMgRzfrCrscnGf0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=web.de header.s=s29768273 header.b="oU7/h1Ts";
	spf=pass (diktynna.open-mesh.org: domain of Markus.Elfring@web.de designates
 212.227.15.3 as permitted sender) smtp.mailfrom=Markus.Elfring@web.de;
	dmarc=pass (policy=quarantine) header.from=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704179423; x=1704784223; i=markus.elfring@web.de;
	bh=+oOe7aQXVFDEA8GxbsOClVRjPhvOe9G1UBb6+O2NWYw=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=oU7/h1TspkEFOW8+Hod9XKSOJtApfMPSHOv7GUHOkpswCKJk+VsJ8jaKFepDxDlU
	 1hoUzei7YYIaMtE+xhGXfjjT34Leps4XjAzsM2I+a0ujb3vKvp565S4Tj93T4lynD
	 8JXBL178Brqh4ULtsXlzO3+ghtCoJ4uHxFwkUGEsyXnqZ2kGftR+kC0D+Pawa46q0
	 s07FWRmsC7kHCBJWJM8xZlnHrAEE5xiybogUxIdSbSHYdH1azOdYI6WEemEXWloeu
	 9sSFAv3vUGJgjYKn5Cl0885SJ9G7xhvNXafx8j/K+tDS+UMFegi/3He0VLQDn7sYb
	 WmOnBhPZBq59D30GSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1qpqP22139-00o628; Tue, 02
 Jan 2024 08:10:23 +0100
Message-ID: <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
Date: Tue, 2 Jan 2024 08:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marek Lindner
 <mareklindner@neomailbox.ch>, Paolo Abeni <pabeni@redhat.com>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] batman-adv: Adjustments for two function implementations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pe43pbVj+FZe008alYHs/UTidvEHq4TOe9TdlOrp0SDV1gHoWHb
 gHcT9bU34jYd9R6LGyABnsvrY7utTKEw58pCebzS56R39SLef1N53v8wJIFe1XdbOrqVgc0
 MF513B13BaPakCYUjoAbH6kuLoo3lPzUYOgWzd9Oyc30a6uX+4kBeNpPbZrHeodQE2OwT4G
 PQtprNkYACrrAAU9wQ1xQ==
UI-OutboundReport: notjunk:1;M01:P0:4i8QK8fmuMA=;hwwufTI10zuOfk9lJDHrRPRXSdi
 FnD4xoPtN1iznXnnhKx5qjz1NfwC6xqnBId3wNs5tpC6XzpAMTU7KAu9z+gb1sE4C4vwK5QIP
 JVv+Brqo29wsLW9w+tw0Y289llLAzuUhGfmNblyTOjCv9hFgpWpliAYlweZPBq1Chg6i8Y6I0
 dUt0aPeZC4O88OK5mI0p3DH5klcCaoApA7ZxWwFOIxUA6q2016gJq5rbRJC3xSZ/lHRs/4fM+
 uoSTWMUR8wkdF9Op1aF1IYRR0inZxgCTdOQC9z9T/J5hd2E6MkwlYeVxjjflZYxKqd9yYdVva
 luZ1fZLPFMUCWb6zk1HrQD/kRdaqZ7IH9OTwGEZDFpeJo3uMCTkBAlINIx0Vogq+YQztBO/fm
 PwWgi/mRpAR+jwBW8auPXdL6u5QQc9vT8SsYSa4fMJtLSdpK+ONdXcZSex3FGTivJ3MOt4SCK
 h9BKL5exM0d2MNSelmnRSuOGfMREoZCt7Ht8rttKf1JgyLEUp3+be37UMoYDd+qcffEzooA9P
 Q65OOuKs8IwZ3G1c0fx68gVsMP7rR9Yz+tGlRp8+9qjQIBOavAqW1FGzpkV9QfP6NNegewkVS
 exc3mDJjYf6oL4/35Fn/7hZf66/ZUZ/L6EBPepioYI4bFrYRTv6sUfN1IarPB7qoinX3QxwBN
 LYHiYjYhHcKe6j/K9QWN7UBMAWwt1v2p4EV7YqEKPDzH72/bVjxJrg3UuiyYyM3wOwnaEAkLi
 3OJ1mNlHmfclWJ1Da3MwsIgPHmR3s/OGDBBG0iL6UKJeaakzF4DdjjZXoCgskRe+H6H2DBnE2
 c0M6rd6C02YCmCjdvx87rCfrAPJhZnROUHmX8gvX0GqE35ptBiX9a4j3UoYDlOgZCaImh6eHJ
 0kAB3uJLh63aQJlNOTPyi5V6Q4wC0Pnpta0aP9hOB4wQCB43Kj2ZV+XeLdhnhDlBV1PiVKB3f
 saAdRQ==
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 5BV5SJGMYQPX3BTKJMPMSA2EW3XFJQND
X-Message-ID-Hash: 5BV5SJGMYQPX3BTKJMPMSA2EW3XFJQND
X-Mailman-Approved-At: Tue, 02 Jan 2024 12:14:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5BV5SJGMYQPX3BTKJMPMSA2EW3XFJQND/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jan 2024 08:02:01 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Return directly after a failed batadv_dat_select_candidates()
    in batadv_dat_forward_data()
  Improve exception handling in batadv_throw_uevent()

 net/batman-adv/distributed-arp-table.c |  3 +--
 net/batman-adv/main.c                  | 14 ++++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

=2D-
2.43.0

