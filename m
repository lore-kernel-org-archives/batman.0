Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A8BE732D8
	for <batman@archiver.kernel.org>; Thu, 28 Sep 2023 13:51:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E9CF08346C
	for <batman@archiver.kernel.org>; Thu, 28 Sep 2023 15:51:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1695909065;
 b=CQwLEBirBXvP2dJYqXkmopscv3FeccG3j0K2L0B1v3sR4PyuqxYyzVFGkId+ewaFvTpVF
 O9ylapn8B+cjCQJqH6q9Mfm7clcpWIyApeZSzhzSM07iHPzyCdi5aqxlWpVo/xaGUG8sZ6I
 lQYxG2XAejlHX5547sCY37t+8SS2U4g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1695909065; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lASFs4zY0ymHcdby6OYbrSsD23GnpsgM/rWKz+9A7LQ=;
 b=sy8NDXTxV3I1G1NT635SsKMheNxSuvhLnTAfk6dO8Xi4oITIL5P08oVE9zf1oEYe73SNB
 na5WbYv2KSjDgaQFar5sVt1qZf/6+t6rcpn9fxgccwhn8Kt3FQo+ZYHAqwRySMuj5wJsdKu
 HW/7GtvhHs4Ij7J3EI2mP79ODS/mmGE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 865268015A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 Sep 2023 14:40:37 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1695904837; a=rsa-sha256;
	cv=none;
	b=E5cmC/qdiFAO9xQm+aQcQzckregP4DaAav9K2noAiWR2L4fWIwdCcVxlF/UPgu4Xb9PiLZ
	1ODyTjc6icrqgeL9nNyyA6r1zRnR2DVHiOR6vXiUK6+qfcmS34mKC6k2XpjQpZqPAbvZoX
	TmFjXQPTkfUItUlfKKVg+2VEw+62Pxs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 217.70.183.197 as permitted sender) smtp.mailfrom=repk@triplefau.lt
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1695904837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lASFs4zY0ymHcdby6OYbrSsD23GnpsgM/rWKz+9A7LQ=;
	b=mcsGyLb5JGu4wSfChO9eT5G2vXuBonZjDd4i5/cOxzCbmMDqYJeYhHjmOfLvahUn4cXQof
	bAkEV2ublyOj6meIa7TD9ej0SHHHn7cDTyPPtnCUYUeCpZ3CYa2fC+2x90nEwPVcKGcGKT
	bSX8TlpizNGEH+E6DITf4aYlZpoNi3Q=
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5EC81C0005;
	Thu, 28 Sep 2023 12:40:36 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH RFC 0/2] Better throughput estimation on half duplex
 interfaces
Date: Thu, 28 Sep 2023 14:39:34 +0200
Message-Id: <cover.1695904299.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: repk@triplefau.lt
X-MailFrom: repk@triplefau.lt
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: FMBYOYOOUU7PTXUX2UVWJWCJQ4JORLK4
X-Message-ID-Hash: FMBYOYOOUU7PTXUX2UVWJWCJQ4JORLK4
X-Mailman-Approved-At: Thu, 28 Sep 2023 15:50:50 +0200
CC: Remi Pommarel <repk@triplefau.lt>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FMBYOYOOUU7PTXUX2UVWJWCJQ4JORLK4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Currently BATMAN_V path throughput computation algorithm takes into account
store & forward WiFi characteristics. When an originator forwards an OGM on the
same interface it received it, the path throughput is divided by two.

Let's consider the topology below

+-------+         +-------+         +-------+
| Orig0 | <------ | Orig1 | <------ | Orig2 |
+-------+   T01   +-------+   T12   +-------+

Where Orig0's OGM is received on same WiFi (non full duplex) interface as the
one used to forward it to Orig2. And where T01 is the estimated throughput
for link between Orig0 and Orig1 and T12 is the one between Orig1 and Orig2.
Let's note PT02 the B.A.T.M.A.N-Adv estimated throughput for the end-to-end
path between Orig2 and Orig0.

In this case Orig0 broadcasts its own OGM initialized with
BATADV_THROUGHPUT_MAX_VALUE. Orig1 receives it and compares it with the
estimated link throughput T01. Thus Orig1 considers the path to reach Orig0 has
an end-to-end throughput of T01, so far so good.

Then Orig1 first adapts the Orig0 OGM throughput to T01/2 then forwards it on
same interface it received it. Orig2 receives it and first thing Orig2 does is
checking if T12 is lower than the received OGM throughput (i.e. T01/2), and if
that is the case T12 is considered to be the new end-to-end path throughput.

The first issue I see here is that Orig2 does not know the path to reach Orig0
has to get half duplex penalty because it is forwarded on same WiFi interface on
Orig1, only Orig1 knows that. Thus if T12 is lower that T01/2, T12 will be
chosen as the Orig2 to Orig0 path throughput (i.e PT02) and the half duplex
penalty is lost.

The first patch of this series aims to fix that by adding a flag in OGM packets
to inform Orig2 the path to reach Orig0 shares the same half duplex interface
and that it has to apply the dividing by two penalty on its link throughput.

The other thing I think can be improved, is this dividing by 2 penalty. This
penalty seems a bit off the expected estimation most of the time. The way I
approach this half duplex penalty is by trying to compute the maximum number of
bytes that can go from Orig0 to Orig2 passing through Orig1 in one second.

And because of half duplex characteristic of WiFi you can't transfer bytes from
Orig0 to Orig1 and Orig1 to Orig2 simultaneously. So at the end it comes down to
finding the maximum number of bytes (x) that can go from Orig0 to Orig1 and then
from Orig1 to reach Orig2 within one second as below:

x / T01 + x / T12 = TotalTripTime

With x/T01 and x/T12 being the time x bytes takes to go from Orig0 to Orig1 and
Orig1 to Orig2 respectfully.

So by solving the above for x with TotalTripTime being 1second:
x = T01 * T12 / (T01 + T12)

Thus if T01 == T12 Orig1 takes the same time to receive bytes from Orig2 than to
forward them to Orig1 then dividing by two makes sense.

But if let says Orig1 forwards data to Orig0 twice as fast as it receives it
from Orig2 (e.g. T12 = 3MB/s and T01 = 6MB/s), throughput can reach up to two
third of T12 throughput (e.g. Orig2 sends 2 MB to Orig1 taking 2/3 of a second
which is then forward to Orig0 taking the remaining 1/3 of a second reaching an
overall throughput of 2MB/s).

Reasoning by recurrence the following formula can be applied to find estimated
path throughput for any half duplex chain between OrigX to OrigY through OrigZ:

PTzx = PTyx * Tzy / (PTyx + Tzy)

Where PTzx and PTyx are estimated throughput for end-to-end path between OrigZ
and OrigX, and OrigY and OrigX respectively. And where Tzy is the estimated
throughput for link between OrigZ and OrigY.

The second patch from this series moves from the divided by two forward penalty
to the one above.


Remi Pommarel (2):
  batman-adv: Keep half duplex penalty on OGM receiving side also
  batman-adv: Better half duplex penalty estimation

 include/uapi/linux/batadv_packet.h |  8 ++++++
 net/batman-adv/bat_v_ogm.c         | 44 ++++++++++++++++++++++++++----
 net/batman-adv/types.h             |  3 ++
 3 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.40.0

