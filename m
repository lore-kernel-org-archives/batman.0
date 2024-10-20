Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489CED3C927
	for <batman@archiver.kernel.org>; Sun, 20 Oct 2024 09:07:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 22C888148C
	for <batman@archiver.kernel.org>; Sun, 20 Oct 2024 11:07:30 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1729415250;
 b=spSb++UcVgtRoX9qDx4XqaPd8vYT+4vZGoFYVxNBpgwBnrd2n0qcxyrRRQ8bOiAGYmtcO
 T+xzU7TqA3o5f+TGW6LXAdhbdae8U2uvPYlFxalt9TOENODSgF/xqJDBB7vVkgHatbaaQ/c
 YULOwZ2abAIkoFU35VZNB6rONUpruAU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1729415250; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qI/lZvMyZlFeHd1wNQVuytoaogTuCh8/Fw/YRVTrrB4=;
 b=ZiriHprWLluG53OxvP4s0jT4EQiFQp2GNcbScAMPIOJ7lrBqvRKPLtlwPIyehNZOmq7q9
 AYo+HlsOWGbtEFuTEvQ4F21/zhp93ZKVWJE7Mx3oJwotFI0S6LCMkHdD2DACpf0lprEP8Qd
 KFx4BV3+dy/DNYnQySRVaiGTxV/f1Xw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3C8718165A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 20 Oct 2024 11:07:25 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1729415246; a=rsa-sha256;
	cv=none;
	b=HgG3TcHinwIVmzgorID84nMmA9LJLw8u4SWjJYWMBaPgELjVuL1ESgadxT/emeMskrEvmV
	3Z8mW2l2i+xb2pF8GZdnEv5HiBhfgSuqOGkvIxovlBhJwoznQ4i6K9PVbEZuyFwG0cGp8q
	4YsSz+R6N22BuOna7xy5Tbc1FX3pQk0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0625tNKR;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1729415246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qI/lZvMyZlFeHd1wNQVuytoaogTuCh8/Fw/YRVTrrB4=;
	b=VDMQQyvRnfSERUCy8fAktXSgHEYAIdT065nV3o7URzfpADMfkQznJdQMFCmGGJTzxKqusY
	goBeVPJ4ucHhnBr6k+h+KIUZI2pJ6417YcBBv570GWHVYDfvsjJdkdpQEnxX4hXPqnoMAd
	edeOa62zlQXSY/GA2T7Qo7d1rg3ao+4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1729415244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qI/lZvMyZlFeHd1wNQVuytoaogTuCh8/Fw/YRVTrrB4=;
	b=0625tNKRoK1FwXK4OYD70fcA1ZsCmF0dnUTB5kSgPrQbcr60n4s9yfZBQfqmV8FhkUo1ma
	yB69/kj9XYjoYPI60o5DLTpMaTy0lRt5l+nk6rfU8jYNUnx+1Y2R3G8qd+He8n3fpQ04lm
	P5gF2WXmJ0arNqwa1KSGQYOqvtipA0o=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Subject: 
 Re: [1/1 PATCH] batctl: ping: Add millisecond precision to ping interval
Date: Sun, 20 Oct 2024 11:07:18 +0200
Message-ID: <3513144.QJadu78ljV@sven-l14>
In-Reply-To: <20241018214713.91598-2-NoahBPeterson1997@gmail.com>
References: 
 <20241018214713.91598-1-NoahBPeterson1997@gmail.com>
 <20241018214713.91598-2-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1907750.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: QB2NVG3LF25AKRL2JVRHLTRE7LNWE3E4
X-Message-ID-Hash: QB2NVG3LF25AKRL2JVRHLTRE7LNWE3E4
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QB2NVG3LF25AKRL2JVRHLTRE7LNWE3E4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1907750.CQOukoFCf9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Date: Sun, 20 Oct 2024 11:07:18 +0200
Message-ID: <3513144.QJadu78ljV@sven-l14>
In-Reply-To: <20241018214713.91598-2-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0

On Friday, 18 October 2024 23:47:13 CEST Noah Peterson wrote:
> Modify the batctl ping utility to accept both integer and floating-point
> values for the interval between sending pings. This enhancement allows
> specifying intervals with millisecond precision.

You use nanosleep - so this would be nanoseconds. But it is unlikely that we 
would be able to send in this precise interval. So maybe rename it it 
subsecond.

> 
> For example:
> `sudo batctl ping aa:bb:cc:dd:ee:ff -i 0.5`
> 
> Also, improve error handling for invalid interval arguments.
> 
> Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
> ---
>  ping.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/ping.c b/ping.c
> index 3681e7e..104b17c 100644
> --- a/ping.c
> +++ b/ping.c
> @@ -16,6 +16,7 @@
>  #include <signal.h>
>  #include <fcntl.h>
>  #include <string.h>
> +#include <limits.h>
>  #include <math.h>
>  #include <stddef.h>
>  #include <stdint.h>

#include <time.h> missing after <sys/time.h>.

> @@ -65,14 +66,15 @@ static int ping(struct state *state, int argc, char **argv)
>  	struct bat_host *bat_host, *rr_host;
>  	ssize_t read_len;
>  	int ret = EXIT_FAILURE, res, optchar, found_args = 1;
> -	int loop_count = -1, loop_interval = 0, timeout = 1, rr = 0, i;
> +	int loop_count = -1, timeout = 1, rr = 0, i;
>  	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0, packets_loss;
> -	char *dst_string, *mac_string, *rr_string;
> -	double time_delta;
> +	char *dst_string, *mac_string, *rr_string, *end, *loop_interval = NULL;
> +	double time_delta, ping_interval = 0.0;
>  	float min = 0.0, max = 0.0, avg = 0.0, mdev = 0.0;
>  	uint8_t last_rr_cur = 0, last_rr[BATADV_RR_LEN][ETH_ALEN];
>  	size_t packet_len;
>  	int disable_translate_mac = 0;
> +	struct timespec req;
>  
>  	while ((optchar = getopt(argc, argv, "hc:i:t:RT")) != -1) {
>  		switch (optchar) {
> @@ -86,9 +88,7 @@ static int ping(struct state *state, int argc, char **argv)
>  			ping_usage();
>  			return EXIT_SUCCESS;
>  		case 'i':
> -			loop_interval = strtol(optarg, NULL , 10);
> -			if (loop_interval < 1)
> -				loop_interval = 1;
> +			loop_interval = strdup(optarg);

Why are you duplicating this string?

>  			found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);
>  			break;
>  		case 't':
> @@ -135,6 +135,25 @@ static int ping(struct state *state, int argc, char **argv)
>  		}
>  	}
>  
> +	if (loop_interval) {
> +		errno = 0;
> +		ping_interval = strtod(loop_interval, &end);
> +		free(loop_interval);
> +
> +		if (errno || end != (loop_interval + strlen(loop_interval))) {

Use after-free of loop_interval

> +			fprintf(stderr, "Error - invalid ping interval '%s'\n", (ULONG_MAX / 1000000 - 1.0));

You can't print a double as string. Please use %f, %e or %g to print a double 
value.

But the text actually suggest that you didn't want to print the calculated 
value in the first place

> +			goto out;
> +		} else if (ping_interval >= (ULONG_MAX / 1000000 - 1.0)) {

Similar to the previously calculated value - this doesn't make a lot of sense. 
You are dividing ULONG_MAX by 1e6 but we have no place where we handle 
something related to Msecs or usecs. tv_sec is in time_t and not related to 
ULONG_MAX / 1e6.

I can also not explain the -1.0 (at the moment). I first thought this was a 
bad attempt to floor the ping interval - but this would be on the wrong side 
of the comparison and there is actually a function for that. And since the 
ULONG_MAX / 1e6 seems to be random, I am unable to find the reason for this.

> +			fprintf(stderr, "Error - ping interval too large\n");
> +			goto out;
> +		} else {
> +			ping_interval = fmax(ping_interval, 0.001);
> +		}
> +
> +		req.tv_sec = (long) (ping_interval);

time_t not long

> +               req.tv_nsec = fmod(ping_interval, 1.0) * 1000000000l;

I think this would be a good place to use modf to split integral and 
fractional part.

Kind regards,
	Sven

--nextPart1907750.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZxTIRgAKCRBND3cr0xT1
y1UGAP4v5fbOcywbElH8dxWLgib1f95r+W97cSOoQIvwqPhiMQEApEgrjD6tHXcE
/UlyL0AY76Q7L5hg1DW0wO8W3y25CAI=
=AvEA
-----END PGP SIGNATURE-----

--nextPart1907750.CQOukoFCf9--



