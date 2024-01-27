Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4042C46CD2
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 12:54:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 41E6083EB8
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 13:54:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706360076;
 b=nzEmC0gbQnevCMcw5dj93FPvl1eOhXrRukGUjc+Ot7iXRiQlt/eBN0eH+It5+bQkozwA5
 FDGTOL02Da+tOZMZKx9KDD7lSQ/dUPNqgFk5sgNpnGC/wgxDVEIwlxsgkH7aLJs6ASwTqed
 a+XISgxcwrxYo6DAYgLZ5UYHrRdVpLY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706360076; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jQEW3LmxljvRuNgpQg7zCR/oPRZG/vesSsOfbTpgldw=;
 b=uy71xSZn3cxc+fGg1RlO+rsg+62wNkZWMS5MbPuVxD2zAY4tTPdKynRFThoIlgmS72Noo
 1bdLCHdeAU0g6QFO0I4BjfBWJ7o9krVbgEL261wdphEfULh0YWggy9/RIBeHAOFi2cZwLwd
 Cgi3U0M58Y2jmvOP5HxDK4M6e1wJPAE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DAEA683F8B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jan 2024 13:51:25 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706359885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jQEW3LmxljvRuNgpQg7zCR/oPRZG/vesSsOfbTpgldw=;
	b=Fawtrc0Pzqvb5ixS0NYcoUZxryadVKyT+A2ciHLJlZ6P9HcmfKgH3QpVLu67I9I1s5ZTm6
	uxS7ZwsGNjB/q0QbUYIXLwNlDcAxFQbFcmdfI9DhhBMXscfER+rcIGXwSaP3/fnjcknc9Z
	hAyIzJp/4TmJRvZEpBfti5UvPQJG5Jw=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706359885; a=rsa-sha256;
	cv=none;
	b=CzmnUjaiaQUmrcJiMz/TRDDk9rLmZ5t7rXm6prEVk3lVHydZ//B7ML9Nlaa3wJqZn5zl7P
	PWI9DMoWSR6x8HVCj8EIi2JKb2gdARtNuazW9dYECdNugbtTaujLwFF0YJg6DjNIvK3dUE
	SwxgGR/XCNOb1PaCrDHcnM6F3Qy/Je0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="tg1n/FMv";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1706359885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jQEW3LmxljvRuNgpQg7zCR/oPRZG/vesSsOfbTpgldw=;
	b=tg1n/FMvlH36glrUvhtZGPBzYwodUpXTGSK4aa+hqAFEsNS0aoyhEdnwwy11Yrdm6zmGtN
	u9T9/w+0iWEUJBMjtfKtQl9P+C3ezzojJ3iFWUHxJwTghggA+eckmbCjMY682qNlFPZ8Xb
	LJ93Af6Q42q2ermE+gNhiHKVVvt290Y=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marco Dalla Torre <marco.dallato@gmail.com>
Subject: Re: [PATCH 0/6] batctl: tcpdump: Fix problems detected during fuzzing
Date: Sat, 27 Jan 2024 13:51:22 +0100
Message-ID: <2716779.mvXUDI8C0e@sven-l14>
In-Reply-To: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
References: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5749285.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: WZZGEWVBWACFXBA2E4PD52YD65GXJMNC
X-Message-ID-Hash: WZZGEWVBWACFXBA2E4PD52YD65GXJMNC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WZZGEWVBWACFXBA2E4PD52YD65GXJMNC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5749285.DvuYhMxLoT
Content-Type: multipart/mixed; boundary="nextPart12368892.O9o76ZdvQC";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marco Dalla Torre <marco.dallato@gmail.com>
Date: Sat, 27 Jan 2024 13:51:22 +0100
Message-ID: <2716779.mvXUDI8C0e@sven-l14>
References: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart12368892.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, 27 January 2024 13:48:58 CET Sven Eckelmann wrote:
> While many parts of batctl are rather simple, tcpdump is one of the most
> complex parts - which unfortunately is also dealing all the time
> with potentially harmful input. It is therefore a good idea to perform
> some tests to figure out how bad the current state of the code is. The
> findings will be presented here - including some information how other
> people can reproduce these problems.

Attached are also the actual reproducers.

Kind regards,
	Sven
--nextPart12368892.O9o76ZdvQC
Content-Disposition: attachment;
 filename="0001-parse_eth_hdr-missing-bat_hdr_len-check"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
 name="0001-parse_eth_hdr-missing-bat_hdr_len-check"

rIZ0ATUnsIZ0CDmXQwVAAHQQ//////8CrIZ0AdMnrIZ0CDmXQwVAAHT///////8CxN6v/gRDBAO6
3q8EQwU=


--nextPart12368892.O9o76ZdvQC
Content-Disposition: attachment; filename="0002-dump_batman_icmp-tp_len_check"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
 name="0002-dump_batman_icmp-tp_len_check"

Arrer/4BArrer/4DQwVDDzIPSkq6FbzQArrer/4DpgFa7A==


--nextPart12368892.O9o76ZdvQC
Content-Disposition: attachment;
 filename="0003-dump_ip-missing-ihl-validation"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
 name="0003-dump_ip-missing-ihl-validation"

ACHMtIIzrIZ0AdMgQwVCDzICACHMtIIzrIZ0AdMgBACq2W5fLXo+GEsB0yAIAAABCAAGBAACAarZ
bl8tesCoAwI=


--nextPart12368892.O9o76ZdvQC
Content-Disposition: attachment;
 filename="0004-dump_ipv6-neigh-advert-len_check"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
 name="0004-dump_ipv6-neigh-advert-len_check"

MzMgAAD7Gj7uDJ9Dht17AAAAADI6YjIAAAAAAAAAAAD7Y2FsAAAhAAHADOgDAAIFAAAAAAAgiAAA
gAAQAAE=


--nextPart12368892.O9o76ZdvQC
Content-Disposition: attachment;
 filename="0005-dump_ipv6-neigh-solicit-len_check"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
 name="0005-dump_ipv6-neigh-solicit-len_check"

////////Arrer/6Cht1gAAAAABA6//8CQwUEHTAHHP//AxQAAAAAAAAAAACdYACBgYeHh4eHh4eH
h4eHAARD


--nextPart12368892.O9o76ZdvQC
Content-Disposition: attachment; filename="0006-dump_ip-unreachable-len_check"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
 name="0006-dump_ip-unreachable-len_check"

wYZ0AdP7AP+anG7wCABG9v9T6ABAAFMBVXQIOZcLAwMDAyMDAwMDAwMDAQAAWh2y6YMQht3/AAAA
IAMDAwMDAwM6/xb/AwAAAAAAAAAAAAAAAACzf40=


--nextPart12368892.O9o76ZdvQC--

--nextPart5749285.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmW0/EoACgkQXYcKB8Em
e0ZVdw//ao9wMPzt/1kxFCOu4EdUR5pNHwiG//BOc+DbEft6mmhzZZ9JfVdjEvcm
66Dc/b7Ok023IPXE+D5AmhcnP/4s0dXS4maeSJ5YOIKScx3o1F5v/RkZOrYWs2xi
xbfWTNViif0n58Gyd1irP8U6NjgX14aqi926olAtoE0IIKVup6s4w/swuOKOQUPr
i0X3OPK12qcXbOzKNYR00dR44RLJwq7iXNX8M7HYOsdcFjcAs2Bajd1N0NVVfPH5
gLFVuaZZtkkXHAW8Nf1SUN2HnX1TFXmyFVnPFO0gtX7kzLGbzsOaLkFvOqBVAq4Q
kikI/ALFMAGoWnAJUly4pXMbxhD1s2bcXp7QN3Cn82X2UfH+LXni1J4wLvBLl9L9
q5zSVzjHj9BXYZYyER/2cZqTVKPPrucgjKRvFEmeKdd5ONEl1JXB/JJGoC84hn+z
KvpicV8MWtWCUiDQkDpiFIBgnJo0U5c+tXblSKz5OyJkJyvAtYbMVu/b7k4T8/bd
wODy6FKXb37Qa5n07cWZ9VOenULo0hPRD+yaolHoVRoZshX9bwrQP6izcVMlMVAA
AYE8zU9YEISxo1KPObZhcm7Z0e8ke/UbV+EySoTptidPHyi9GbsEChrWvTgrCnfa
w76SE93VDzbdFY20E+g7K6pVaCUohrZ9tSuI3l5+B1itDzw3+c8=
=+Fp4
-----END PGP SIGNATURE-----

--nextPart5749285.DvuYhMxLoT--



