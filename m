Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B663CCAC5B5
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 08:45:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3DF8884257
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 10:45:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1759049152;
 b=pZntnVWso7VxescYwMu4A0wd7GeL+Ry8wS/B43yv4jf6Ll4KVpTSe1LZmE6/d7Wu7xeWJ
 rBe6wHc4MiLb2BpKNmwBpi7kp9Svobona2vZfnhiknOG9bWSRCejMzf7cwaoCS8eZQwh50V
 s7OwbWC0B9MjjnY9HxM7yU4EpJxfwOA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1759049152; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jM7Ox3+Ul4dOIfVByBI3tj0o8LxVWBiiGDPq1t2V7FY=;
 b=nbr9q2cNIm/geFVka8Dll8vQHOjoGv27wYSTOdQE6HlPHEEeXI9To+TO3IMNGyqZKlCBE
 q/hTyzQ/TkvzG9FyDX+xnGnbntXqTfr8qYtdDNXTE1/fPhkHUY5WOUdQw5nv1bhcFPqgMaF
 UiCiyKSFuJfuyRqTeIqGVPWET0/iNwM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D6D0E80449
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Sep 2025 10:45:15 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1759049125; a=rsa-sha256;
	cv=none;
	b=pfYyoaV2jhdMfkEa/wFTGXs6Fb+nv+De10iCVQIjQZWaJvL/UaV7G+8N/iWAXv6w8EtfMz
	g/0954X+kKrrdRnvqvzS6koDVuuObdSakKiqdj9P0hsB2Mrzx0KZZL7A3byL/rZnkGmn+H
	QEOIr+gOJKab/01v6+xx6MO3Qs0I8q8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=P91IYOJk;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1759049125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jM7Ox3+Ul4dOIfVByBI3tj0o8LxVWBiiGDPq1t2V7FY=;
	b=LdZFf8lmIinKng3tflrkg4kHQ6YhtC1B/DE949MkMXewOYfFUNbY2Vp3bDdIH8+LvQbC1S
	/yDvYcKxCYC8dudtsa0TvOqSHfmAabXtAs+At1Zi7pWLEngYuNwkGjBlTJxapLAsvJ1Urz
	NnhNZ5Z4NxaBg2olsNvBX/kFurGDlds=
Received: by dvalin.narfation.org (Postfix) id 246D82054D;
	Sun, 28 Sep 2025 08:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1759049115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jM7Ox3+Ul4dOIfVByBI3tj0o8LxVWBiiGDPq1t2V7FY=;
	b=P91IYOJk5Q6yuHqV/tJlwva9JKaGlRMiHSULbqaKZbKROaV3t6vufMNH7avrjFIftjczDl
	sFYDKaWHVJAcmGfIQ2H0BNwUgOHthtNYhvE2fY1/Zi4yKIRuWlYF7bBH5I3pnxcz5U7Rdy
	lsTc5Se3ircXO/eh6PS2hbILQXR/M4I=
From: Sven Eckelmann <sven@narfation.org>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH net-next 3/4] batman-adv: keep skb crc32 helper local in
 BLA
Date: Sun, 28 Sep 2025 10:45:12 +0200
Message-ID: <2878689.BEx9A2HvPv@sven-desktop>
In-Reply-To: <20250927205552.GD9798@quark>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
 <20250916122441.89246-4-sw@simonwunderlich.de> <20250927205552.GD9798@quark>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15571232.tv2OnDr8pf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: J7LQ5GFEC2IMSEU4GMLTCODRYMTRGZN2
X-Message-ID-Hash: J7LQ5GFEC2IMSEU4GMLTCODRYMTRGZN2
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/J7LQ5GFEC2IMSEU4GMLTCODRYMTRGZN2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart15571232.tv2OnDr8pf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 28 Sep 2025 10:45:12 +0200
Message-ID: <2878689.BEx9A2HvPv@sven-desktop>
In-Reply-To: <20250927205552.GD9798@quark>
MIME-Version: 1.0

On Saturday, 27 September 2025 22:55:52 CEST Eric Biggers wrote:
> Hi,
> 
> On Tue, Sep 16, 2025 at 02:24:40PM +0200, Simon Wunderlich wrote:
> > +static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
> > +{
> > +	unsigned int to = skb->len;
> > +	unsigned int consumed = 0;
> > +	struct skb_seq_state st;
> > +	unsigned int from;
> > +	unsigned int len;
> > +	const u8 *data;
> > +	u32 crc = 0;
> > +
> > +	from = (unsigned int)(payload_ptr - skb->data);
> > +
> > +	skb_prepare_seq_read(skb, from, to, &st);
> > +	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
> > +		crc = crc32c(crc, data, len);
> > +		consumed += len;
> > +	}
> > +
> > +	return htonl(crc);
> > +}
> 
> Has using skb_crc32c() been considered here?

No. At the time this was written (v3.8), skb_crc32c (v6.16) didnt exist. Also 
its predecessor __skb_checksum only started its existence in v3.13. And no one 
noticed it as candidate to replace batadv_skb_crc32 with

And this patch here was just moving the function between two places - so not 
introducing new code.

Do you want to submit a patch to integrate your new function in batman-adv? I 
only performed a quick-and-dirty test to see if it returns the same results 
and it seemed to do its job fine.

diff --git c/net/batman-adv/Kconfig w/net/batman-adv/Kconfig
index c299e2bc..58c408b7 100644
--- c/net/batman-adv/Kconfig
+++ w/net/batman-adv/Kconfig
@@ -35,6 +35,7 @@ config BATMAN_ADV_BLA
 	bool "Bridge Loop Avoidance"
 	depends on BATMAN_ADV && INET
 	select CRC16
+	select NET_CRC32C
 	default y
 	help
 	  This option enables BLA (Bridge Loop Avoidance), a mechanism
diff --git c/net/batman-adv/bridge_loop_avoidance.c w/net/batman-adv/bridge_loop_avoidance.c
index b992ba12..eef40b6f 100644
--- c/net/batman-adv/bridge_loop_avoidance.c
+++ w/net/batman-adv/bridge_loop_avoidance.c
@@ -12,7 +12,6 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc16.h>
-#include <linux/crc32.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -1585,45 +1584,11 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
-/**
- * batadv_skb_crc32() - calculate CRC32 of the whole packet and skip bytes in
- *  the header
- * @skb: skb pointing to fragmented socket buffers
- * @payload_ptr: Pointer to position inside the head buffer of the skb
- *  marking the start of the data to be CRC'ed
- *
- * payload_ptr must always point to an address in the skb head buffer and not to
- * a fragment.
- *
- * Return: big endian crc32c of the checksummed data
- */
-static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
-{
-	unsigned int to = skb->len;
-	unsigned int consumed = 0;
-	struct skb_seq_state st;
-	unsigned int from;
-	unsigned int len;
-	const u8 *data;
-	u32 crc = 0;
-
-	from = (unsigned int)(payload_ptr - skb->data);
-
-	skb_prepare_seq_read(skb, from, to, &st);
-	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
-		crc = crc32c(crc, data, len);
-		consumed += len;
-	}
-
-	return htonl(crc);
-}
-
 /**
  * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: contains the multicast packet to be checked
- * @payload_ptr: pointer to position inside the head buffer of the skb
- *  marking the start of the data to be CRC'ed
+ * @payload_offset: offset in the skb, marking the start of the data to be CRC'ed
  * @orig: originator mac address, NULL if unknown
  *
  * Check if it is on our broadcast list. Another gateway might have sent the
@@ -1638,16 +1603,18 @@ static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
  * Return: true if a packet is in the duplicate list, false otherwise.
  */
 static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
-				     struct sk_buff *skb, u8 *payload_ptr,
+				     struct sk_buff *skb, int payload_offset,
 				     const u8 *orig)
 {
 	struct batadv_bcast_duplist_entry *entry;
 	bool ret = false;
+	int payload_len;
 	int i, curr;
 	__be32 crc;
 
 	/* calculate the crc ... */
-	crc = batadv_skb_crc32(skb, payload_ptr);
+	payload_len = skb->len - payload_offset;
+	crc = htonl(skb_crc32c(skb, payload_offset, payload_len, 0));
 
 	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1727,7 +1694,7 @@ static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
 static bool batadv_bla_check_ucast_duplist(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb)
 {
-	return batadv_bla_check_duplist(bat_priv, skb, (u8 *)skb->data, NULL);
+	return batadv_bla_check_duplist(bat_priv, skb, 0, NULL);
 }
 
 /**
@@ -1745,12 +1712,10 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb)
 {
 	struct batadv_bcast_packet *bcast_packet;
-	u8 *payload_ptr;
 
 	bcast_packet = (struct batadv_bcast_packet *)skb->data;
-	payload_ptr = (u8 *)(bcast_packet + 1);
 
-	return batadv_bla_check_duplist(bat_priv, skb, payload_ptr,
+	return batadv_bla_check_duplist(bat_priv, skb, sizeof(*bcast_packet),
 					bcast_packet->orig);
 }
 

Regards,
	Sven
--nextPart15571232.tv2OnDr8pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaNj1mAAKCRBND3cr0xT1
y5DIAQDuvVj4HaKlvbXTdpeXUycI3OUfV9GO4+sBWl2SsCPocgD/QH0XR1Po0lGU
NHIZEee3ff9REwUiuSxuBTzCr8noDQA=
=bykD
-----END PGP SIGNATURE-----

--nextPart15571232.tv2OnDr8pf--



