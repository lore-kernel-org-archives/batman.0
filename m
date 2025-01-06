Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F9CE77188
	for <batman@archiver.kernel.org>; Mon,  6 Jan 2025 13:52:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1502B83F88
	for <batman@archiver.kernel.org>; Mon,  6 Jan 2025 14:52:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736171556;
 b=PrTnCI88RQaovIpViKCmEiIq2jhTjmr6+C/v4+2+cGm6hIffwa1JfPKjE8MwCITRwHl6B
 cLvsx7/29w8NZKIfx8OBHNJgswcV8v0Z4BeIkKkprouVL7kDN7QdXmVdgF8lGwE6MI/foAh
 NvtMiTztLVwdFGMb5V5fkqFUNTc3YYc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736171556; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fq12ErXZJDe4DTnUSzakPIkj8Y8HYTjh69RuupMaUl4=;
 b=wmvRTfcB8p7NczmMYL1VzrPnXmE5yTo1Yu6POkMQDdxCGF23YmPbH98IvL6oGBNqkY5ZT
 CGf0mUXpZJZ/vCwG02zmwP4l963ver9OmP+e3B7RbJmD6DQxKtG5u4tkJM0sL2HZX7orqnH
 4EnkKPv4mXENZbEMlJss/yUyYORQhp4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=smtpservice.net header.i=@smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org;
 dkim=pass header.d=smtpservice.net header.i=@smtpservice.net; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Received: from e3i165.smtp2go.com (e3i165.smtp2go.com [158.120.84.165])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 677EE81534
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  6 Jan 2025 14:52:17 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736171537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fq12ErXZJDe4DTnUSzakPIkj8Y8HYTjh69RuupMaUl4=;
	b=vzrclIUk/mHkteDzAC0EKGTgAuqUM4KMJwGIIm8Y/fLppLFQdd0nN9bb7ppALNZiBRoE9w
	VRr5hSrqJR9VDfyvHtiiS59VMGZPnb4ZG7ck42U3ehVemAX2aC3dcZ4f6PNrtdJyVOg4d5
	DzNA02fMmn5pXrrWJnBO6M/kjqiEMQg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=smtpservice.net header.s=a1-4 header.b=mU4LkLmF;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b="njzAAam/";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bounce.58veepawbj5elm0=vpdq683serjh=99rr9othi7h4zq@em510616.triplefau.lt"
 designates 158.120.84.165 as permitted sender)
 smtp.mailfrom="bounce.58veepawbj5elm0=vpdq683serjh=99rr9othi7h4zq@em510616.triplefau.lt"
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736171537; a=rsa-sha256;
	cv=none;
	b=dWFyrx+vXWwE4DWuigSwUHIPh++3dKwxlSa7H+CcAKpTnFu0QnJQn5IqDDWY+4gA/zDCm4
	hsJqAWqwWJ8bj6qIovV7tkElzfjISX0BTUOeTUioi/qaqOeeat5i3htIdb8EOX3RvcAFXV
	Kih6jQQYXZEaYZjcBEav15AgV77NhXU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1736171536; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=fq12ErXZJDe4DTnUSzakPIkj8Y8HYTjh69RuupMaUl4=;
 b=mU4LkLmFFZGfGXl+Td8hVANVjm6noVOw44Laq2A75W25lK8NIqkvn0e5EeaIoHsbhWWjZ
 XlAKLHISYZgHMnQ2rbMBclm7SVqmc+pBodjP89KndG8I5Wpdk06TFP/FUba9XOj+CNAT83K
 KegYfWAw83FxfOh2yKTZ2IdBmyeY7iUv+6WLmqQumEURiILMQ+krbx8pcd736jUofjxMxCU
 Rdyjf5EfYzcakqj5lGKffBBQPlhh77ALJIC92WBR7zNjqb4DGzBBxRjAnLMhjRCOY45LsNG
 02AAgNe0OEHqqiNGLqaKU8mVliYTuH95Bcoz1CV+6b36TXV26TsZ7xc/Oe2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1736171536; h=from : subject
 : to : message-id : date;
 bh=fq12ErXZJDe4DTnUSzakPIkj8Y8HYTjh69RuupMaUl4=;
 b=njzAAam/KEb3tpZiSOOZpaFDGvgCB9KyM6jwv2U+4NiIevbNxHbEtjdRp8IRsoZx1Ckvk
 I+MIIzPSLCojk+r0gNMvcGp8UX4a0X1EEBW0kR8yu6+tjZaloNdTQT3LwEqCfS0XEuLcL7q
 dEnWr4SdPVoHobUIEvBi+H3NvjwP9LcvUIw4DUTkijMMXBAAhmyRPICM0AKJqSFQulH7d98
 iL00aZkAHNxao0K66DUY/dE4wdSqHtlUArSBygyRFKtmOQpZCX6wDhsjeSAf+PYfRz6dof1
 vl17eBSVCGBmIS1muRmLYsXn0nUHZ7xtsFO8TGgdGNh9YkOgNvU95Epvk5hw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tUnWg-4o5NDgrrCc5-sIks;
	Mon, 06 Jan 2025 13:52:14 +0000
Date: Mon, 6 Jan 2025 14:49:23 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Noah Peterson <noahbpeterson1997@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v5 1/1] batctl: ping: Add subsecond precision to ping
 interval
Message-ID: <Z3vfYxPPM79TO3gB@pilgrim>
References: <20250105000908.66343-1-NoahBPeterson1997@gmail.com>
 <20250105000908.66343-2-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105000908.66343-2-NoahBPeterson1997@gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sMMagZk8xg
X-smtpcorp-track: 4NANqkkOQPHt.FSfzQZXJI7u6.x7tD1gwSyFM
Message-ID-Hash: BKCXHBBKRYPV26THOHR4L5VZJK3V7RPP
X-Message-ID-Hash: BKCXHBBKRYPV26THOHR4L5VZJK3V7RPP
X-MailFrom: 
 bounce.58veepawbj5elm0=vpdq683serjh=99rr9othi7h4zq@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BKCXHBBKRYPV26THOHR4L5VZJK3V7RPP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

On Sat, Jan 04, 2025 at 06:09:08PM -0600, Noah Peterson wrote:
> Modify the batctl ping utility to accept both integer and floating-point
> values for the interval between sending pings. This enhancement allows
> specifying intervals with subsecond precision.
> 
> For example:
> `sudo batctl ping aa:bb:cc:dd:ee:ff -i 0.5`
> 
> Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
> ---
> v5: Fixing whitespace misalignment, correcting changelogs, removing old
> variable declaration, as noted by Sven <sven@narfation.org>
> v4: Rebasing on latest commit, reformatting into reverse X-mas tree order based
> on feedback from Sven <sven@narfation.org>
> v3: Reformatting code based on comments by Sven
> <sven@narfation.org>
> v2: Fixing use-after-free, adding a missing header file, noted by Sven
> <sven@narfation.org>
> ---
>  ping.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/ping.c b/ping.c
> index 14d9c21..6fd11b2 100644
> --- a/ping.c
> +++ b/ping.c
> @@ -19,6 +19,7 @@
>  #include <stdint.h>
>  #include <sys/select.h>
>  #include <sys/time.h>
> +#include <time.h>
>  #include <netinet/if_ether.h>
>  
>  #include "batadv_packet_compat.h"
> @@ -58,18 +59,21 @@ static int ping(struct state *state, int argc, char **argv)
>  	struct batadv_icmp_packet_rr icmp_packet_out;
>  	struct batadv_icmp_packet_rr icmp_packet_in;
>  	uint8_t last_rr[BATADV_RR_LEN][ETH_ALEN];
> +	struct timespec loop_interval = {0, 0};
>  	struct ether_addr *dst_mac = NULL;
>  	struct ether_addr *rr_mac = NULL;
>  	int disable_translate_mac = 0;
> +	double fractional_part = 0.0;
>  	unsigned int seq_counter = 0;
>  	unsigned int packets_out = 0;
>  	unsigned int packets_in = 0;
> +	double ping_interval = 0.0;
> +	double integral_part = 0.0;
>  	unsigned int packets_loss;
>  	struct bat_host *bat_host;
>  	struct bat_host *rr_host;
>  	uint8_t last_rr_cur = 0;
>  	int ret = EXIT_FAILURE;
> -	int loop_interval = 0;
>  	int loop_count = -1;
>  	int found_args = 1;
>  	size_t packet_len;
> @@ -86,6 +90,7 @@ static int ping(struct state *state, int argc, char **argv)
>  	int timeout = 1;
>  	int optchar;
>  	int rr = 0;
> +	char *end;
>  	int res;
>  	int i;
>  
> @@ -101,9 +106,17 @@ static int ping(struct state *state, int argc, char **argv)
>  			ping_usage();
>  			return EXIT_SUCCESS;
>  		case 'i':
> -			loop_interval = strtol(optarg, NULL, 10);
> -			if (loop_interval < 1)
> -				loop_interval = 1;
> +			errno = 0;
> +			ping_interval = strtod(optarg, &end);
> +			if (errno) {
> +				fprintf(stderr, "Error - invalid ping interval '%s'\n", optarg);
> +				goto out;
> +			} else {
> +				ping_interval = fmax(ping_interval, 0.001);
> +			}

If you are going to floor to 1 millisecond anyway why didn't you use
msleep() (or fsleep() if you needed precision) then ? This would avoid
the conversion to timespec and hence the use of modf().

Regards,

-- 
Remi
