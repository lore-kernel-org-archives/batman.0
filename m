Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED580C02183
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 03:48:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2CB0083C42
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 04:48:26 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737258506;
 b=x2Fgc+K4l6ffIBU+5z7XKAJPTsgM6AmIIjOFj3deOiHWas2Os1oDmZCdfZPWvt5mN8UEw
 D1VBFGdi9K+dt4B4s+Iirm846xn16LxpK1jrIE5toVq8o1GwMJjLGW71sALy0Ktkn5lTpMS
 8n4NMeVwM40g38UhOsgDo/AEQD21YMs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737258506; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xArbvQL+GEMTYUVtgiyzk3vHZx9iB7BSfTAHHyMpqgU=;
 b=s5RlQGkh/iLQzdVMZ3z3WqqDP8e4Z1I6EAORk98XHtB5U1KVmmPybyic8UblddkyF4Di9
 n9VwQgTK/BfHM+T4w5SSqp8eCnv8qorHsBOQWs75qD4JnTyNYCTH/uNxK2wZxGft1cZPHSq
 +n/JKlfd6+ZNJSj9C+sNp1xRVMjsgmQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mailbox.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=mailbox.org
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=mailbox.org policy.dmarc=reject
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6B2DE81747
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 19 Jan 2025 04:48:18 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737258498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xArbvQL+GEMTYUVtgiyzk3vHZx9iB7BSfTAHHyMpqgU=;
	b=pQuHf3GTAemGTLP6VYxb9PSgyCfJJ7Jziro4N+omwcU0GGBijs4+/uG5l563Bwg1j5yT+8
	gB+/svUet57nxMdib+aBQk1BwSNkHlTsZ3lsKG7RZrHacSllH0Y35RzClOdPTjL+DJtMg1
	lG1MCQ9cupwZQ0iC4h7x9pM18RcqVxI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LljdRnlj;
	spf=pass (diktynna.open-mesh.org: domain of marek.lindner@mailbox.org
 designates 80.241.56.152 as permitted sender)
 smtp.mailfrom=marek.lindner@mailbox.org;
	dmarc=pass (policy=reject) header.from=mailbox.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737258498; a=rsa-sha256;
	cv=none;
	b=ZTNvwJU4p0jnz4+ts93F/GnbMA6oHFdzYeBjvc5rKzLbIjSJTewCwGamBAasffs+RuNA3l
	9yssqcTn+57U5coP7DDU3GqKLCoCN50kqOKCtSVHbZ3Ip/zaCecJHGU8wQRRtmuhLhWoY6
	cU4cq6PIVYVg5KnQ1dPrWrnS72TBl1o=
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YbKFC3Xfdz9sjJ;
	Sun, 19 Jan 2025 04:48:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1737258495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xArbvQL+GEMTYUVtgiyzk3vHZx9iB7BSfTAHHyMpqgU=;
	b=LljdRnljdJZeudOF6Qcp6upDJxxlwtNocrURacro7bfw7QAKJjo1BXgtdLxmtG6t/7/bXr
	hEhExn7JzXwyYJXqJcfjVFtSVm5Mq26hToHs6E9Ni5Ilfj4gUd4v/6PbYT9L6IZZoQIlY6
	aiM3ylViHi+C2iV6++UmErcH9bfSuo4REcfSNRanteNsMYkcWBVxeiWQlXmBRcWdPicR4l
	iKj3EuhMj/CQXIFxMdbbdRpNMtETLe0oSjybC6bhcoIYFuTuTXndUEFbB+1ULBvbirgNZJ
	kl/6RrhNnrQcJQ7WAPPMsdx4E+88ZZ7wi5wmhYg3XSW7pbSq1trwPQyUuB7m4Q==
From: Marek Lindner <marek.lindner@mailbox.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
 b.a.t.m.a.n@lists.open-mesh.org,
 =?ISO-8859-1?Q?Ren=E9?= Treffer <treffer@measite.de>,
 Andrew Strohman <andrew@andrewstrohman.com>
Subject: 
 Re: [PATCH RFC] batman-adv: BATMAN V: use/prefer 11s airtime link metric
Date: Sun, 19 Jan 2025 04:48:09 +0100
Message-ID: <6101869.CFs8Y8CuNP@rousseau>
In-Reply-To: 
 <CAA8ajJnwrAidkea_tVDvRxJy6T_bJ9VQDKq2FW4SSdJfZxYKqQ@mail.gmail.com>
References: 
 <20250118003528.6843-1-linus.luessing@c0d3.blue>
 <6131569.pqZb4hCDXM@rousseau>
 <CAA8ajJnwrAidkea_tVDvRxJy6T_bJ9VQDKq2FW4SSdJfZxYKqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-MBO-RS-ID: ddecd4d39228215acc8
X-MBO-RS-META: dapj7qixt34e7ecbsnb7h9q6deis8bx9
Message-ID-Hash: LKCPMH5BMS3N6YZV4IQWLGIYXV3K6LFF
X-Message-ID-Hash: LKCPMH5BMS3N6YZV4IQWLGIYXV3K6LFF
X-MailFrom: marek.lindner@mailbox.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LKCPMH5BMS3N6YZV4IQWLGIYXV3K6LFF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sunday, 19 January 2025 04:20:46 CET Andrew Strohman wrote:
> In my case, my 2.4ghz radio driver uses minstrel for rate control,
> so throughput estimates are derived using sta_get_expected_throughput().
> For me, this estimation is chronically an over estimate. The 5ghz radio
> does rate control in hardware, so we cannot use the
> sta_get_expected_throughput() method for it.
>
. [..]
> I'm suggesting that we make an effort to make the throughput
> calculation method consistent across radios. 

That's certainly an interesting observation but seems irrelevant to the patch 
proposal you are responding to. Feel free to propose a code change that aims 
to unify the chosen metric source across all radios on the same AP. With the 
current implementation, this is left to the administrator.


> After this patch, it means that the throughput estimation for 5ghz
> stas/neighbors in my network will be derived by examining an exponentially
> weighted average of tx rate with consideration of tx failures. 

After this patch, the 11s throughput estimation is available as a metric 
source. That's all. The patch does not even attempt to address your concern.


> If this new fallback method results in in more similar results to
> sta_get_expected_throughput(), then my problem will be lessened, possibly to
> the point of my network preferring 5ghz (as should be done).

Even if the 11s metric source accidentally provides a similar metric in your 
test setup, there is no guarantee it always will. Again, your are conflating 
your desired outcome with a random patch which isn't trying to do what you 
want it to do.


> OK, thanks. If you're confident that sta_get_expected_throughput()
> returns a result that reflects the recent or likely external contention on
> the operating frequency, that's good to know.

Feel free to read up on how minstrel arrives at the expected throughput. 


> Like I noted in my original message, I was seeing the estimated throughput
> as 150Mb/s for the sta_get_expected_throughput() method, while really
> only able to tx at ~25Mb/s.

Am I right assuming this '~25Mb/s' was measured using iperf or some other 
speed test? The numbers minstrel provides are in a completely different ball 
park and can not be compared to WiFi throughput numbers. You are also not 
taking into account what I have already explained why getting 'accurate' 
throughput numbers is meaningless.


> I'll now be debugging under the assumption that something else causes
> overestimation in my case.

You are still stuck on over / under estimation. In this email alone you are 
mentioning it 6 times. Whether there is over or under estimation is 
irrelevant. Consistency is relevant. 

Cheers,
Marek



