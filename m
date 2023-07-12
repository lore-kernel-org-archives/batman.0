Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CC1EB64D9
	for <batman@archiver.kernel.org>; Wed, 12 Jul 2023 04:30:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7E4F7822A7
	for <batman@archiver.kernel.org>; Wed, 12 Jul 2023 06:30:18 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1689136218;
 b=ExpUmD8B51Hv51oD177FRS0y4cSDIAP8cCKFF87JqBjw7UDut3/R+yO1YGKTehjP0xP9h
 V5cc2dzaLkxz2SNIz4huddoS7K2p84K2YKxxMyDPZnGoQYZpAK3nfhylce+nPlgo7FoJnx0
 zB5AQv2uRyNOUTkhCUIbnAPfSWBcrgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1689136218; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hrmIUsLSmJ3EGrPmMJsqsgdOrO7k9/BnNICuFSwsKKI=;
 b=tbUi9DfZTCe2vsL/LlD7C2jxmpees07vl+vLih7LLdKZ6+jpYgbja/4c+dgh1FaNzau+f
 flvNcqlwzU0G3dQksJxuv7W4KURX5wxjgQ27VmEIiJ39g9XUfGsD78/Mie8DKizes8DKEAv
 zciPvELmo5OBhReGU2u7I86AU7PjCdQ=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3EC0980BF6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jul 2023 06:29:50 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Using BATMAN over ppp interfaces.
From: petermilani80@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 12 Jul 2023 04:29:50 -0000
Message-ID: <168913619024.1040.2149557919065248797@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: CE3B5YPFBCYLMFBCRVRRZR5ES6PEB3LX
X-Message-ID-Hash: CE3B5YPFBCYLMFBCRVRRZR5ES6PEB3LX
X-MailFrom: petermilani80@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CE3B5YPFBCYLMFBCRVRRZR5ES6PEB3LX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi All,

I've just started using batman and was trying to see if I could get it to work over a serial radio link such as the simple serial devices commonly used in cheap drone telemetry. The goal here is to enable low bandwidth but adhoc ip networking. 

I had set up a pair of radios to connect using pppd and I was wondering if I could utilise batman to try and create a mesh. An example of setting up the serial ports as ppp interfaces:

$ sudo pppd /dev/ttyUSB0 57600 noauth nodetach 10.42.5.5:

That works fine but applying batman to that interface was unsuccessful. I think that was due to limitations in the ppp and interfaces created by pppd:
e.g.

$ sudo batctl if add ppp0
Error - failed to add interface ppp0: Invalid argument

The interface ppp0 was specified as POINTTOPOINT e.g.

$ ip link
$  ppp0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN mode DEFAULT group default qlen 3

I'm not an expert in this so don't have full visibility of all the tools available.  I was wondering if there were better ways to set this up, possibly not using pppd? Any guidance would be appreciated.

cheers
Peter
