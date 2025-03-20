Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89B1C28B30
	for <batman@archiver.kernel.org>; Thu, 20 Mar 2025 16:29:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 23E1283E82
	for <batman@archiver.kernel.org>; Thu, 20 Mar 2025 17:29:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742488176;
 b=RoMxwKaVdGV8HTbeWMmT8bwzCJgBbvOx3SopS94lzFJd7sGdCVo7x4BaXkp8VSmpWv1pF
 IXdHMAt4ez0hkDn7zP0wEnz1JZeEH5iwSBDYD84E7ZE4verUvaDOsQ5aDdS0AgDnJQgfQ3i
 ASsLlz6/y8VPZPnAayoZgddVWV307Jk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742488176; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uPLX2O5zKgNshMmqeCxxoMXKwAZcjJ61ij2mF22vjJ4=;
 b=ZL6qmkBHag5A/hl/vzi6cabI2ZUwHcJlkjLVlsjHKh2ZGXzarZDjGiLt7FPP6ctK4C83n
 2fWOmkyphjlZgQ+QA99u4P4OYsKy/4Asrmi2xBnx9eoew/qmxhN4oY3DVdoG42eHE57Y4hK
 vBM7Hc2a2wuV8pecs4C5ImsL/0+Hd8Q=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 940EC80F86
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 20 Mar 2025 15:39:59 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742481609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uPLX2O5zKgNshMmqeCxxoMXKwAZcjJ61ij2mF22vjJ4=;
	b=vPR7J9N1dDhCZe3CT2GkrKU7oUrbKr32iLoCuLrj5Aiwvuppkou3vB7TVAxlBJkLVD04pN
	xkqA0MqmSi/Z/vwb5cnIt75yAD5HfFh3RrJIARfEXHFk+Kr8DQcEmzbF+zAVPmAyFOmVVp
	j6lssjR5WP5P4sDPhoIG3TZP30XTn4M=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=OzZQOp73;
	spf=pass (diktynna.open-mesh.org: domain of
 patchwork-bot+netdevbpf@kernel.org designates 172.105.4.254 as permitted
 sender) smtp.mailfrom=patchwork-bot+netdevbpf@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742481609; a=rsa-sha256;
	cv=none;
	b=K5F1PacSOhcyhKzWJwYiJ7KkqKzwbdl2s2m/OsTA9g/fMdZSYTB37eIck0Jsz0DlCvk1lv
	8ioHgAUmC0a3/IjfvFccN0s+duyvW6q+9fno7m7w8NFi4tOyAIyMRU5X5UK/LFUobJ9Pk2
	i52gCa/iDzRRXR47eIKeGqeEkexp9zk=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 502766115E;
	Thu, 20 Mar 2025 14:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DDAC4CEED;
	Thu, 20 Mar 2025 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742481596;
	bh=oVQojLeLWiozl0E/5VrnXjJuDZpnqy9tjthf9fqPAEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OzZQOp73hasAgu0NBkmj6knatSW70kMR70mPUGqkd+WBRrDnvFjCuPRpl6+0Ezrrs
	 arZo2gIUtNhuOFjCANOfg8VuKUGaWgCXfiQ2bSksz62DpZH7/aHGGwzJz30zoLzCgW
	 xldy8+lHwwEV8hue0zAppb0PO6o0MA3G4FQ8iDg86zJhb1hQLo3+M7Ts7YPQX8DT2k
	 lWXClKH10lcFP+bBiMhpSCbGXTejOFl/C9Y48BpLLctZaKWyIerVtwOWjK38keAwd1
	 +WcUYlkMWMHuj8qrRtvNPrGZd8oAakV8V4wDeOs9sjR7C1T0VhbOCM1DdVK+ksiUvd
	 8XV+ZvEoNjJnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADDD33806654;
	Thu, 20 Mar 2025 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: Ignore own maximum aggregation size
 during RX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174248163252.1791127.9515297719544787878.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 14:40:32 +0000
References: <20250318150035.35356-2-sw@simonwunderlich.de>
In-Reply-To: <20250318150035.35356-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org,
 stable@vger.kernel.org
X-MailFrom: patchwork-bot+netdevbpf@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: L2FRG26PYSLLKQI4ZWF7467TJVAFGZPQ
X-Message-ID-Hash: L2FRG26PYSLLKQI4ZWF7467TJVAFGZPQ
X-Mailman-Approved-At: Thu, 20 Mar 2025 17:29:19 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/B4X7BDHVTEMYLVH6TNAUWL46CU2PRLIQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Tue, 18 Mar 2025 16:00:35 +0100 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> An OGMv1 and OGMv2 packet receive processing were not only limited by the
> number of bytes in the received packet but also by the nodes maximum
> aggregation packet size limit. But this limit is relevant for TX and not
> for RX. It must not be enforced by batadv_(i)v_ogm_aggr_packet to avoid
> loss of information in case of a different limit for sender and receiver.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: Ignore own maximum aggregation size during RX
    https://git.kernel.org/netdev/net/c/548b0c5de761

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


