Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D708C46CD2
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 11:15:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4E99383EA3
	for <batman@archiver.kernel.org>; Tue,  2 Jan 2024 12:15:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1704194151;
 b=K906K8qc1ZlCIQQLGfohW6UAYMRIR86+/YtxhBK8JbFp5Lz81RZvVJ8GNi+HJPDdBWo76
 n/9T4th3t3qJJGBZA+bQVLGFPvkB2w3+W/XE7fSzudemyfhVcxejhmcRZXoQDfGFXXbv8DC
 xsBeyE3FGhgj1+S7qaOxGAsiRAoZXj8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1704194151; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sHHLFqfSv1YoPOHcZyNuMp1h6OmcT6ojrsDhPQ8Sb5s=;
 b=JEOQUrVQd8BFYAmfLKeh8eBfWxKMQzhzvGfg6Svx9k4ucSHtol4KFB16RnJLBJNKTHX3v
 /mTrUlKsU8coYzRdj4B/iArg44+EseLT1tDp+uoeHm5FcD3q2vJUh81njtUF7rvicrEi0RG
 0trJAIQdKbkjPFvC96RfzbFCA355Pjk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=web.de header.i=markus.elfring@web.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=web.de
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org;
 dkim=pass header.d=web.de header.i=markus.elfring@web.de; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=web.de
 policy.dmarc=quarantine
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 97CAB82628
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  2 Jan 2024 08:12:06 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1704179526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sHHLFqfSv1YoPOHcZyNuMp1h6OmcT6ojrsDhPQ8Sb5s=;
	b=d4vHSHnDhziZfR+rQNoo45QTbVbFXSb0keAL6Phy/VWw9O8ZaC+zfMgpUMs+GMRVxy8m2/
	SkgDmNoA0UEuZlYhg5vUtNHupbH8KgYd32gIThtMQbwR6ax/g571kB81ICVgOfF/3+lis1
	/fvGuEq56avx67WDNnxI3Djn+kpDma0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1704179526; a=rsa-sha256;
	cv=none;
	b=PT2+o60JsBEQX3rWOLl7+xG/NKGUpWGQ45edWvuPf6aUjRdBlhPV/Zn2zKDGtz5k1F1IUS
	UoijNk72KYD0XePOfLbN6eyTlb8XFjkSEAn4K5aKa8LUc66i0TzYz5GGAFL1AgxjTmy1Dy
	gvf4K6YUfDFHzF7HimqE5oJ4qVY2FX0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=web.de header.s=s29768273 header.b=Y8f7sCRQ;
	spf=pass (diktynna.open-mesh.org: domain of Markus.Elfring@web.de designates
 212.227.15.4 as permitted sender) smtp.mailfrom=Markus.Elfring@web.de;
	dmarc=pass (policy=quarantine) header.from=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704179508; x=1704784308; i=markus.elfring@web.de;
	bh=V53RxSn45Of6qQKpHmIQL7d5i6Uj4RYbOSBA1Ek79pU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Y8f7sCRQHnrSUdosDFxS7ot/bgBH4fRzW+edTj2Ya0s4eJKETS06OuQFjf7aYoY5
	 RwVHcX4dIh7xJRUb9cGo3OgGqV46IPVQfixd2PYq/N52LTPytLbyeewmy/tmEBBfs
	 Hy0PYVJm+9jKzkOy2cKbLgrpBiWRsOgcNLJDGNi5YYqpS3l7coJRx8M91eoWp8CmY
	 1Nt69XT7zF147mUKcgzg0qSotRbO7shjJ3R2NNwUk155W1DNDQvshJ4ftuxtlpQLJ
	 t65y1QjpiaNln8eIwa5dOVWA1v142PPfzzPOf/q1NVq9UBsM5ptZWMU2P5knZ1dBk
	 FP1FGDaxcMdSTmirzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8gP-1r4pPG3DJJ-00t5Ck; Tue, 02
 Jan 2024 08:11:47 +0100
Message-ID: <54dc53f8-5f08-4f1d-938a-c845c8ec0d44@web.de>
Date: Tue, 2 Jan 2024 08:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marek Lindner
 <mareklindner@neomailbox.ch>, Paolo Abeni <pabeni@redhat.com>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
In-Reply-To: <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Aa/rztWe/OKkxjpDmxNoqQjPyzaHKv8xKPJ8QBGSYir2aUs9wDc
 hAx5dt+2EqvulF6HrKiKtryVzbaltQ3ZrIogjp1ELjbso1QJMUZ6EjRpYtjHBUYbATrGe5e
 E0y8IJ0zU9v56pDAb3zvFfiJp0gmJ6B5ZU4w+4iWUez1RO9OaHOKoNcLjA8i0HBzqJfYE2T
 sJX/sMP4LrFkGxdZpK6Eg==
UI-OutboundReport: notjunk:1;M01:P0:7mrs2rexnTs=;nQXkY8Kc5fVXWDIu+nDG+pagpaJ
 1wDztkHmrGcwFFlSV2v0MG24Bi9GNBh9mlg91AOZ59UEeM+AlMF0mKHG2cjNwX3Tt/U/OeQb8
 vHHTFSLrVMh1DerU3CnmJ/3pQqcZkKJEaZyhnK5nRzRhJrfw37HP9PUJ8jprDAxWZb2bny1ZF
 B6L8LkmXGIEaOE2JO9xwNnubZq9xFVNyqeKDybT3gNaUJZNpiQqCwf53fuGXnUoXlxmHb9ipP
 ONwVWKMccpIi0Ug/PlUSiSVRsOM/pnKEbTqiZOQtVsLou0PySCkC1RMqLpXb2zXNkO0u13X0P
 wYrYWffNGr31GDYUxxsSzkfHywWy1aYrf4oXbnF5OuS6Z1wC0zvXbEoB0YGsyuCTtiYVZxxqW
 U7Owm6MYRYUrgQkfrDGLvDtbU31sLM7F+qMnUDN7o4DQbonULYDiFjQ/qlyKueAfHdcC9nkFV
 XbgmgC5YpDcyFGGm9sjBnc2oKrZAyf/DCqJ5Img6bWZxdXusdD3iRrYfO7oCbcAIJBEZ9CdJK
 ecyjERhAIeVwcrd4l8wzgqm1aq9qiRUz16/KKWAm060P1eBh0DEQ7D8DnXp+6iqyPHKKF2ISA
 esNU4/gjIG/FrfmGqLeikkr995V2mxavAYZrwoROp8NurE/YinQUjQuj1vdcTs62unLREa5uf
 xIlvn2prnccrwkyolxXi0bJEx7NBPir6BLrihcjr1RoWypNb73HXBen3uQOgw8nDDXJ0tX6Xa
 NfIIUQyIGncHXDzjEElrDRa3OAtvJtb8j8Da69Fe+EpatZUzVZijfOE+4RsUNJi4Bt/q5SthS
 fFxd9pQDze4uq1MJ7hTR8hMttH4XNzMbB4mCMJHJcwLH2cSBWVEa2eeQw8y4/03IUGo8hSKGB
 jasLYy632feg672vjfXxU1WuFKmLW3b2HftvYP1OpmtlOvf5sE9argmp9L7W1shC137gYaGK2
 8XvEww==
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: G2Y75LUHVZCFAP44BIYIDF4AI7ZGJNJA
X-Message-ID-Hash: G2Y75LUHVZCFAP44BIYIDF4AI7ZGJNJA
X-Mailman-Approved-At: Tue, 02 Jan 2024 12:14:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/G2Y75LUHVZCFAP44BIYIDF4AI7ZGJNJA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jan 2024 07:27:45 +0100

The kfree() function was called in one case by
the batadv_dat_forward_data() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a batadv_dat_select_candidates() call failed
  at the beginning.

* Delete the label =E2=80=9Cout=E2=80=9D which became unnecessary with thi=
s refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/batman-adv/distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distr=
ibuted-arp-table.c
index 28a939d56090..4c7e85534324 100644
=2D-- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -684,7 +684,7 @@ static bool batadv_dat_forward_data(struct batadv_priv=
 *bat_priv,

 	cand =3D batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;

 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);

@@ -728,7 +728,6 @@ static bool batadv_dat_forward_data(struct batadv_priv=
 *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}

-out:
 	kfree(cand);
 	return ret;
 }
=2D-
2.43.0

