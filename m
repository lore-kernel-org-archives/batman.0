Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52723C5516F
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 15:47:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C079C83FCF
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 17:47:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785512850;
 b=3mTJjXS2uENGWIRF7JLQ127jBj0RUPuGGHWWDyWUGmfvkf3dtETfUTmY0i7A97N7PF6ld
 6l36ZBVMA+WsqafsNaQPZrNL6w+Lx1QksjI743mvyd6IeW5qREsR038cnchoE70gj1Ou2xj
 +geZXaftN/ymwwcIQjndlTdZneTH9eg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785512850; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PS8O6gdxc7+G01I46NmGoVN0gyWZvVlcYIPx5sNGNVs=;
 b=FxTbPJ/D6C7yvh7naY5EbwZ90gCvAzYLJvaPp0KYDnWE3hkyuyKsFzqJe/CqWhq9gZ5/S
 35lkVvwSzsRgAAl0zvbI6x7SfeMaoaVEvMuNJ3yyhhP3HLSWgE9HHsHn/65efwdp6/jfQbz
 rdH3uuEPgMYsNkA5ELaFg21lJeNo6a8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5CC4383FCF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 17:46:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785512806;
	b=1HNBVyALJBxtkbDzewcWRkc54Fve5AbVJuFgg92CjmSgAVQXVu7taNbe8t/FjSXrI2EcN9
	QWKjIcow/G1uAAp4HafsBIQGagWf1T96q/t0eSOTNrV650VbNYwEfu6CojKBgA5EI1xioN
	gb0XJCtQSxO8b8duZe+wZjtcmkCSLC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785512806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PS8O6gdxc7+G01I46NmGoVN0gyWZvVlcYIPx5sNGNVs=;
	b=Bcs7d8lA95mIkwAFTkwfHWl+rY55Z7GFj5W82XcXTfpHQvvEJHvJmKLNidiWSTv9W0hYUQ
	IShRNF6YLizcm2vcJhKHjvp72iM+7iMq+Tl1jt8nb3pRbb1oOPqiUFtUCXeor4CAqrLz66
	MmrKXm5mK7AGzGfuVJ8s3L11UDRJeOw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=r2nhWypA;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 71A2A20CB8;
	Fri, 31 Jul 2026 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785512791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS8O6gdxc7+G01I46NmGoVN0gyWZvVlcYIPx5sNGNVs=;
	b=r2nhWypAlmjHRfoxiQIBoEbMV9+1cl+CsFK87rM2rk7CnLvVn+rfZSjJUlMb192GjvZzaa
	j0IHBececJQpw6t0Cmv8IbfAzRz8UXC0po7VZx349RtyoTrFrheKESHz0pBo3CHW0aFoVT
	5ffOz6odyuwpdFYjXfds6uspwf8BBjk=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] batman-adv: reject unrepresentable multicast TVLV
 offsets
From: Sven Eckelmann <sven@narfation.org>
To: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 sven@narfation.org
Cc: David Lee <david.lee@trailofbits.com>, Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
In-Reply-To: <20260731135222.566367-1-david.lee@trailofbits.com>
References: <20260731135222.566367-1-david.lee@trailofbits.com>
Date: Fri, 31 Jul 2026 17:46:08 +0200
Message-Id: <178551276854.62695.15966621050711216654.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4888; i=sven@narfation.org;
 h=from:subject:message-id; bh=MD9a4OcmbhugiNYlfmAkxZ5XVh6TqtLUn7h9BWYxL4A=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk5h30VMv7IT1hx+Kkhz/eKuOffAnbc2C69nKHDRIDnU
 LlJpOODjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEPkxiZLhv/+zq60fhLc8Z
 RFYXap8L9J0izxvPYfD2lt7+bIXV5aGMDM+Mthzu0bgdcG9W64RJ9RYpy2Z8/XA7NmsXi23uvG1
 X5zADAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UPJZG3TXAQ3HOLSI5XNXM2WYILSCO6VF
X-Message-ID-Hash: UPJZG3TXAQ3HOLSI5XNXM2WYILSCO6VF
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UPJZG3TXAQ3HOLSI5XNXM2WYILSCO6VF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, 31 Jul 2026 13:52:22 +0000, David Lee <david.lee@trailofbits.com> wrote:
> The network and transport header fields in struct sk_buff are 16-bit
> offsets from skb->head, and U16_MAX is reserved as the unset transport
> header value. batadv_tvlv_call_handler() sets both fields without checking
> that the end of a received multicast TVLV is representable.
> 
> A sufficiently large TVLV therefore wraps the transport header offset.
> skb_network_header_len() then returns a bogus large length, allowing
> batadv_mcast_forw_packet() to access memory beyond the skb data.

Ok, we end up here with transport_header < network_header. This is then
wrapping in

static inline u32 skb_network_header_len(const struct sk_buff *skb)
{
	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
	return skb->transport_header - skb->network_header;
}

to a really large value.

And as result, following allows larger tvlv_lens than are actually practical
possible:

	/* check if full tracker tvlv is within skb length */
	tvlv_len = sizeof(*mcast_tracker) + ETH_ALEN * num_dests;
	if (tvlv_len > skb_network_header_len(skb))
		return -EINVAL;

Just because tvlv_len is insane large, correct?


@netdev: Just to sidetrack a little bit: I am wondering if `transport_header <
network_header` should also be handled in skb_network_header_len() (and similar
functions)? And if the return value of u32 should be reduced to u16.

In this specific case, a return value of u16 would have returned the correct
result instead of the insane large length - but trigger and WARN_ON_ONCE for
transport_header == U16_MAX case.

> 
> Reject multicast TVLVs whose absolute end offset cannot be represented
> before changing either header field.
> 
> Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
> 
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber

This is not how we write the tags section of a commit message. The "Bug
found..." looks like it was accidentally added and doesn't belong here. And it
seems like this was only added by you for the patches you've send out today:

https://lore.kernel.org/all/?q=Bug%20found%20and%20triaged%20by%20OpenAI%20Security%20Research%20and


See https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
for more documentation how you can document such things.

How do you want to procede here? Because the rest looks good.

>
>
> diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
> index 5600aaf00627c..8354c62bd86a7 100644
> --- a/net/batman-adv/tvlv.c
> +++ b/net/batman-adv/tvlv.c
> @@ -437,6 +437,9 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
>  			return NET_RX_SUCCESS;
>  
>  		tvlv_offset = (unsigned char *)tvlv_value - skb->data;
> +		if (skb_headroom(skb) + tvlv_offset + tvlv_value_len >= U16_MAX)
> +			return -EINVAL;
> +

Just for documentation purposes:

This is (skb->data - skb->head) + tvlv_offset + tvlv_value_len

The calculation in skb_set_transport_header():

offset = skb->data - skb->head
offset += (tvlv_offset + tvlv_value_len)

>  		skb_set_network_header(skb, tvlv_offset);
>  		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
>  

Just a lazy way to show that the return value u16 returns more sane results:

 #include <stdint.h>
 #include <stdio.h>

// #define RETURN_TEST_TYPE uint32_t
 #define RETURN_TEST_TYPE uint16_t

uint16_t network_header(unsigned long headroom, const int offset)
{
	return headroom + offset;
}

uint16_t transport_header(unsigned long headroom, const int offset)
{
	return headroom + offset;
}

RETURN_TEST_TYPE network_header_len(uint16_t network_header, uint16_t transport_header)
{
	// ignore this for now: DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
	return transport_header - network_header;
}

int main(void)
{
        unsigned int tvlv_value_len;
        unsigned int tvlv_offset;
	unsigned int headroom;
	uint16_t transport;
	uint16_t network;
	unsigned int t;

	for (headroom = 0; headroom < 65535; headroom++) {
		for (tvlv_offset = 0; tvlv_offset < 65535; tvlv_offset++) {
			for (tvlv_value_len = 0; tvlv_value_len < 65535; tvlv_value_len++) {
				network = network_header(headroom, tvlv_offset);
				transport = transport_header(headroom,
                                                             tvlv_offset + tvlv_value_len);
				t = network_header_len(network, transport);

				if (t != tvlv_value_len)
					printf("Failed for headroom %u tvlv_offset %u, expected %u, seen %u\n",
					       headroom, tvlv_offset, tvlv_value_len, t);
			}
		}
	}

	return 0;
}

-- 
Sven Eckelmann <sven@narfation.org>
