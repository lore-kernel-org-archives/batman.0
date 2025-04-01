Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9782EC36014
	for <batman@archiver.kernel.org>; Tue,  1 Apr 2025 08:49:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E880883E72
	for <batman@archiver.kernel.org>; Tue,  1 Apr 2025 10:49:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1743497361;
 b=dKs/q58hi7xmf9dqBKI/vYIa9JqCK63c+5XmsLLvSRMJIhmME9gpPE/H7wQPHCsZHRmL1
 C+AZJOfaXZJzX0TVnT+rocS6z6bkBAKdgMb80097d2JpEtnVtBsw9BAEltQ0RGq25LYMJgs
 uPk6zIVDF+v+hdBzkVx2wcfqGF7If2I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1743497361; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WL4H1/n+KU4vDHV20Jk9Fts6NmwKIU67Olt2xVADMKQ=;
 b=uUOqciR3cfdNnUaNv8UHWtw06V0jZmVDuMgg2KoM2bAfBc8g0iy/OGrFsm39qf1QKEkAF
 tSFy3F/wafoLLxRyCyF5HGejutnEvns9BaH4yzs/tHCpZsiVaaMfoZWb5sgb22HnhTOtANl
 VI3JM0+A7g8ssqqWjxWlkQoJB89Zhm8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DA97D8090D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  1 Apr 2025 10:49:05 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1743497346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WL4H1/n+KU4vDHV20Jk9Fts6NmwKIU67Olt2xVADMKQ=;
	b=ofilkpdG2LzMV3BYXNRoFDeVI3cxVpatmnDNKldkzFLz152ARu9prnFdOb32FeLWuWJS0O
	EPexfoDE04Wf1P7ckRbBzwP4H5W/pgwWKo5SgmUuHe+3bHm507sTGnYqGwSPxSDBcWTRXH
	tu2hMjd0p2qnPJ6rpW94e7EXFzCvirg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="ECK0v/CU";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1743497346; a=rsa-sha256;
	cv=none;
	b=bVLj5uBnE1mSYVvASJcp78OWp+ke6o2koYEpqtNzfO60ZQ4DsoSHMrKfD1oeFvupisxUNe
	dTDvTl3RrjXZDCOKobe4f/xADXXQm9zUgPRJnHT8M7fbK3uQWhLXGA+UnWU3Qh3A4s96vS
	eFGe28DafWJog5fOi6px5ZZ7TFtkknE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1743497344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WL4H1/n+KU4vDHV20Jk9Fts6NmwKIU67Olt2xVADMKQ=;
	b=ECK0v/CUv5HYRLgRT7DeRHtoMrKwucrsQs2muDt0Obk5vr7SY/cKmt4bHi8EwKH/q85qbt
	fUhcG6kxBrmOcGnQKl88z/WlbIjL8Zrz6gPGvmEmeawsmNKCG1lt7o1TsCV9me/frKXqK4
	j/gQq9Bb/OBzjPpc4dkI6SGFs+j20pY=
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] batman-adv: batman-adv: handle tvlv unicast send errors
Date: Tue, 01 Apr 2025 10:48:59 +0200
Message-ID: <22646445.EfDdHjke4D@ripper>
In-Reply-To: <20250401083901.2261-1-vulab@iscas.ac.cn>
References: <20250401083901.2261-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7787093.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 7QGDU4HTFJ2DTHFHHZYSLSXVQ34VL4WI
X-Message-ID-Hash: 7QGDU4HTFJ2DTHFHHZYSLSXVQ34VL4WI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7QGDU4HTFJ2DTHFHHZYSLSXVQ34VL4WI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart7787093.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Apr 2025 10:48:59 +0200
Message-ID: <22646445.EfDdHjke4D@ripper>
In-Reply-To: <20250401083901.2261-1-vulab@iscas.ac.cn>
References: <20250401083901.2261-1-vulab@iscas.ac.cn>
MIME-Version: 1.0

On Tuesday, 1 April 2025 10:39:00 CEST Wentao Liang wrote:
> In batadv_tvlv_unicast_send(), the return value of
> batadv_send_skb_to_orig() is ignored. This could silently
> drop send failures, making it difficult to detect connectivity
> issues.
> 
> Add error checking for batadv_send_skb_to_orig() and log failures
> via batadv_dbg() to improve error visibility.

This looks more like patch you've added for printk-debugging and nothing for 
stable. And you ignore that it can also return things like -EINPROGRESS. Which 
is not an error.

You can also see that this was just for printk-debugging because the error 
class and message has nothing to do with the actual code.

> 
> Fixes: 1ad5bcb2a032 ("batman-adv: Consume skb in batadv_send_skb_to_orig")
> Cc: stable@vger.kernel.org # 4.10+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/batman-adv/tvlv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
> index 2a583215d439..f081136cc5b7 100644
> --- a/net/batman-adv/tvlv.c
> +++ b/net/batman-adv/tvlv.c
> @@ -625,6 +625,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv 
*bat_priv, const u8 *src,
>  	unsigned char *tvlv_buff;
>  	unsigned int tvlv_len;
>  	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
> +	int r;
>  
>  	orig_node = batadv_orig_hash_find(bat_priv, dst);
>  	if (!orig_node)
> @@ -657,7 +658,10 @@ void batadv_tvlv_unicast_send(struct batadv_priv 
*bat_priv, const u8 *src,
>  	tvlv_buff += sizeof(*tvlv_hdr);
>  	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
>  
> -	batadv_send_skb_to_orig(skb, orig_node, NULL);
> +	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
> +	if (r != NET_XMIT_SUCCESS)
> +		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
> +			   "Fail to send the ack.");

No, this is definitely the wrong error class. And why do you think that it is 
an ack?
>  out:
>  	batadv_orig_node_put(orig_node);
>  }
> 

Kind regards,
	Sven

--nextPart7787093.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ+uoewAKCRBND3cr0xT1
y2qlAP9WnQgyuTR1ObdOwnfoccPeZM0k100Xsm1CijZC5WAcyAD+NywbzgD5+yMk
e/XenInlVjSxcxl696zJLzJxWyD3cws=
=d3Hb
-----END PGP SIGNATURE-----

--nextPart7787093.EvYhyI6sBW--



