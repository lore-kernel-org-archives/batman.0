Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9205E77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 07:59:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 39A0F83FEB
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 08:59:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735977544;
 b=YMXGDEMT86q8UjHAi+KY8thPx90gcQG2K3AD3SqmJmEEecdRX4e7v2rMDouJ3P+ps5XpM
 t6oeew+rLDHVORKvIUpSjgNlhCgpXuI6wRNjKN3ScAWi/Rdqku8FJM3zoTlddV0ZMBOUHVh
 W37UPxeOz5n4bcGC1t/+LEv9BcqYK1w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735977544; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ljBmFKGiBBKIp+Tf5L0cV3RjiXQTiLXUvIu/c9pMnME=;
 b=DzPujaeypb5HEWB6lKyIdr7xKrS4qjZYKfA+mSlFqPZbQD+nRLVQ2B4hRsdocbXdLkolM
 sOIhkgW1ClxuswY0Z5VvSThIkdJ4CYT5ZBXpIthQCEicAVYnitk3jGO+x34excRBUTtYbxK
 w70ZCOYlUNoprKWZiAGwjCY8ZmND/S4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 98AE381619
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 08:58:48 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735977528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ljBmFKGiBBKIp+Tf5L0cV3RjiXQTiLXUvIu/c9pMnME=;
	b=rhtgAH712YWy+QvrrOcaUhHET/artTjznVPdPsEZ+29etlddX5hwMTWVJcwJHu5NnJenJF
	057xKsVAe77V9cVQH31Jr3LY4ukZO8XMRacAAEm6V07dcJCVc78WCXg6N15uVUm5uEmlYx
	ewH2vkSc5Wby73KaphQJxG67qvWXy/w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=F0Uq+yKj;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735977528; a=rsa-sha256;
	cv=none;
	b=G9UPEArrYi+4uHKETCh8V4bMrnhnfZyjJePLY/as0RMJl4wzJIlCs/MbRxJNVE+Dj40NZU
	9+stxMk/MVxSjT+IBjB7kcFgAUm4edYXxCCrBWO8m3DcQo+914ah51g5Xz1+A2tdekhKEO
	+tvCyCoDwATwU2kiF23Kcz4RIwnmoEo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1735977527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljBmFKGiBBKIp+Tf5L0cV3RjiXQTiLXUvIu/c9pMnME=;
	b=F0Uq+yKjeSZv6myu3dMfiSrl75gJ+XYDF5zXv8tQ0ymtG+8wgNkSTeR5tgCzjJi2NjEL8v
	lRAsdxBsMcOU37x0HcrAVUeN+GZMlj9MJAsY/FSZdQshmDPFfTfEIHwwoS2pyLu2fAYCmv
	3fQVLNi5LQfhVq+sApxFzcfRIUbsRNE=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>,
 Noah Peterson <noahbpeterson1997@gmail.com>,
 Noah Peterson <noahbpeterson1997@gmail.com>
Subject: Re: [PATCH] batctl: ping: Add subsecond precision to ping interval
Date: Sat, 04 Jan 2025 08:58:40 +0100
Message-ID: <4102985.kQq0lBPeGt@sven-l14>
In-Reply-To: <20250104013645.53012-1-NoahBPeterson1997@gmail.com>
References: <20250104013645.53012-1-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3855424.iIbC2pHGDl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: YW6NZ2O4M4LC4DIHZ3YDKTE2O2NUL25D
X-Message-ID-Hash: YW6NZ2O4M4LC4DIHZ3YDKTE2O2NUL25D
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YW6NZ2O4M4LC4DIHZ3YDKTE2O2NUL25D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3855424.iIbC2pHGDl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sat, 04 Jan 2025 08:58:40 +0100
Message-ID: <4102985.kQq0lBPeGt@sven-l14>
In-Reply-To: <20250104013645.53012-1-NoahBPeterson1997@gmail.com>
References: <20250104013645.53012-1-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0

On Saturday, 4 January 2025 02:36:45 GMT+1 Noah Peterson wrote:
> Modify the batctl ping utility to accept both integer and floating-point
> values for the interval between sending pings. This enhancement allows
> specifying intervals with subsecond precision.
> 
> For example:
> `sudo batctl ping aa:bb:cc:dd:ee:ff -i 0.5`
> 
> Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
> ---
> v4: Rebasing on latest commit, reformatting into reverse X-mas tree order based
> on feedback from Sven <sven@narfation.org>

Patch was not marked as v4 in the Subject line

> v3: Rebasing on latest commit, reformatting code based on comments by Sven
> <sven@narfation.org>
> v2: Fixing use-after-free, adding a missing header file, noted by Sven
> <sven@narfation.org>

All the changelogs you added after the v1 are basically wrong (or incomplete)

[...]
> +                       found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);

ERROR: "(foo*)" should be "(foo *)"
#63: FILE: ping.c:120:
+                       found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);

ERROR: space prohibited before that close parenthesis ')'
#63: FILE: ping.c:120:
+                       found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);


Please change it back to the original form.

> @@ -178,7 +191,7 @@ static int ping(struct state *state, int argc, char **argv)
>  	}
>  
>  	printf("PING %s (%s) %zu(%zu) bytes of data\n", dst_string, mac_string,
> -	       packet_len, packet_len + 28);
> +		packet_len, packet_len + 28);
>  
>  	while (!is_aborted) {
>  		tv.tv_sec = timeout;

This has nothing to do with the thing this patch is supposed to do. And it is 
also misaligning things. Please stop this.

> @@ -224,7 +237,7 @@ static int ping(struct state *state, int argc, char **argv)
>  
>  		if ((size_t)read_len < packet_len) {
>  			printf("Warning - dropping received packet as it is smaller than expected (%zu): %zd\n",
> -			       packet_len, read_len);
> +				packet_len, read_len);
>  			goto sleep;
>  		}
>  

This has nothing to do with the thing this patch is supposed to do. And it is 
also misaligning things. Please stop this.

> @@ -236,10 +249,10 @@ static int ping(struct state *state, int argc, char **argv)
>  		case BATADV_ECHO_REPLY:
>  			time_delta = end_timer();
>  			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms",
> -			       read_len, dst_string,
> -			       ntohs(icmp_packet_in.seqno),
> -			       icmp_packet_in.ttl,
> -			       time_delta);
> +					read_len, dst_string,
> +					ntohs(icmp_packet_in.seqno),
> +					icmp_packet_in.ttl,
> +					time_delta);
>  
>  			if (read_len == sizeof(struct batadv_icmp_packet_rr)) {
>  				if (last_rr_cur == icmp_packet_in.rr_cur &&

This has nothing to do with the thing this patch is supposed to do. And it is 
also misaligning things. Please stop this.


> @@ -328,9 +341,9 @@ static int ping(struct state *state, int argc, char **argv)
>  
>  	printf("--- %s ping statistics ---\n", dst_string);
>  	printf("%u packets transmitted, %u received, %u%% packet loss\n",
> -	       packets_out, packets_in, packets_loss);
> +		packets_out, packets_in, packets_loss);
>  	printf("rtt min/avg/max/mdev = %.3f/%.3f/%.3f/%.3f ms\n",
> -	       min, avg, max, mdev);
> +		min, avg, max, mdev);
>  
>  	if (packets_in)
>  		ret = EXIT_SUCCESS;

This has nothing to do with the thing this patch is supposed to do. And it is 
also misaligning things. Please stop this.

Kind regards,
	Sven

--nextPart3855424.iIbC2pHGDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ3jqMAAKCRBND3cr0xT1
y2m9AQCX0vP4Ck/gvAH+LWd9NuwkcHKrBaFKP8WPJJqJsoLg+QD9HyFyNRGYeHIq
fpE9VvD5iyJ0kuMJoCikG7UZjGaCNQo=
=c28h
-----END PGP SIGNATURE-----

--nextPart3855424.iIbC2pHGDl--



