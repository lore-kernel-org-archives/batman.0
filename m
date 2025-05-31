Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB45C5B543
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 08:31:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 635E58478B
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 10:31:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1748680293;
 b=I/i9kylfncBW4AAKABvSs8ls3GdilImvmDz3cV4DTPqaCCMIwkPEoBAxeV2jVGc6PcEzh
 lt7m4ncpwvE7gJ7kATFJ/bATaowy7j6c4farh1sZ4YCSUv2oUU33tZiRZCc8ZCJ+whheuju
 SyJTLa95ogqDw2Qz/TMnIbVvwtC8B24=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1748680293; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jll3XeKX99pWqsCTGFwx78r84HFnraGM4zNForfuar4=;
 b=aA6ebCvoYsWmtKEcxUFvQki2g9GE9Cqr+SfaZnVKbI/vP5JHhXzVvJlVJvssU31OnjEbb
 yfxOf90a91Pwe6OD6ZR53ZlAPA6dFmCUxfajIEEYDiwAgzFX1CoQ+ZgxzHrQPT2AWXu5lM1
 KdK/Avpb08eyOdz3Csqu09+ezvCzLdo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D6CD88434E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 May 2025 10:31:12 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1748680282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jll3XeKX99pWqsCTGFwx78r84HFnraGM4zNForfuar4=;
	b=HMEFx16NYeKOMG8lcWxsUEcIPJWrnPlqOoA22oREI0Bv6jifYeCQk2ZQdE5K3Xcn2ecbFF
	BWRdT8Hy4zCKu9UatukvQYlU/9K8AtDFW6bucgnPtL2YI3xeeQ84nTwQlD9zg+mr3pIy6/
	AOLszgm8har+ohxkfi/jAezvuzw282Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="i3bZKa+/";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1748680282; a=rsa-sha256;
	cv=none;
	b=Xpkm8/5kw8pwgOG2wrxro30GkksHAaXoVYuRwsOh1fZESr3DNsfqVPTp95Tv+TBNUXTfww
	siJOD9MIMQ4BqzRRmZDFFVqgQt76+ieyF2J+B3DnOYPyBh8pLko1AilO3XIFfxPYaYZhgV
	q+GO6mok6YjruAULK/0VJMgddac2834=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748680271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jll3XeKX99pWqsCTGFwx78r84HFnraGM4zNForfuar4=;
	b=i3bZKa+/0lAKv8gR00vmayeK2aJiwvdrqTxJxAaXTEBLkXOwvbc+zORX/B0oIwems0YMAN
	tu5Sv+Sn0Pl2VSVzj8GwBCls8lvt8IS8RO+QwBCo8vYYPt+Ib5EHQmEFIACe0fAeXvF+NY
	oiW/bKeKsUqSJdNcoLoAa9ErZ/nl78A=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH batadv 1/5] batman-adv: store hard_iface as iflink private data
Date: Sat, 31 May 2025 10:31:07 +0200
Message-ID: <4075596.ElGaqSPkdT@sven-desktop>
In-Reply-To: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6691312.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 7FO2OLFATPP3X7BW7CGI3RVUKMPZOZ3F
X-Message-ID-Hash: 7FO2OLFATPP3X7BW7CGI3RVUKMPZOZ3F
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7FO2OLFATPP3X7BW7CGI3RVUKMPZOZ3F/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6691312.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 10:31:07 +0200
Message-ID: <4075596.ElGaqSPkdT@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:28 CEST Matthias Schiffer wrote:
> By passing the hard_iface to netdev_master_upper_dev_link() as private
> data, we can iterate over hardifs of a mesh interface more efficiently
> using netdev_for_each_lower_private*() (instead of iterating over the
> global hardif list). In addition, this will enable resolving a hardif
> from its netdev using netdev_lower_dev_get_private() and getting rid of
> the global list altogether in the following patches.
> 
> A similar approach can be seen in the bonding driver.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  net/batman-adv/bat_algo.h       |  1 -
>  net/batman-adv/bat_iv_ogm.c     | 25 +++++++--------------
>  net/batman-adv/bat_v.c          |  6 ++---
>  net/batman-adv/bat_v_elp.c      |  7 ++----
>  net/batman-adv/bat_v_ogm.c      | 12 ++++------
>  net/batman-adv/hard-interface.c | 39 ++++++++++++---------------------
>  net/batman-adv/main.c           |  6 ++---
>  net/batman-adv/mesh-interface.c |  6 ++---
>  net/batman-adv/multicast.c      |  6 ++---
>  net/batman-adv/netlink.c        |  6 ++---
>  net/batman-adv/originator.c     |  6 ++---
>  net/batman-adv/send.c           |  6 ++---
>  12 files changed, 43 insertions(+), 83 deletions(-)

Looks mostly good - I just want to modify the includes slightly (if it is ok for you):

index c165dede..ba5bea4c 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -14,6 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 898c71b5..cdd1ccfe 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -11,7 +11,6 @@

 #include <linux/netlink.h>
 #include <linux/skbuff.h>
-#include <linux/types.h>

 extern char batadv_routing_algo[];

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 56b6216f..8df2dcc2 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -35,7 +35,6 @@
 #include <net/cfg80211.h>
 #include <uapi/linux/batadv_packet.h>

-#include "bat_algo.h"
 #include "bat_v_ogm.h"
 #include "hard-interface.h"
 #include "log.h"
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 5c955ac2..cab83d37 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -22,7 +22,6 @@
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
-#include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
@@ -33,7 +32,6 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/batadv_packet.h>

-#include "bat_algo.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index af1e644b..d41ce799 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
-#include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 35d7ecee..5afb1b70 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -20,7 +20,6 @@
 #include <linux/if_vlan.h>
 #include <linux/init.h>
 #include <linux/limits.h>
-#include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 5e4168f8..c13e05d3 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -29,7 +29,6 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/batadv_packet.h>

-#include "bat_algo.h"
 #include "distributed-arp-table.h"
 #include "fragmentation.h"
 #include "gateway_client.h"
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 788fcfd1..a9929948 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -21,7 +21,6 @@
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
-#include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>

Thanks,
	Sven
--nextPart6691312.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDq+SwAKCRBND3cr0xT1
y3drAQC++qUIxjP/5zx4qVUE0mPTESzY622rxoVLLdoMxpjWmwEAxQfC0Aj4rQZN
/JLZqkC1kiWXGPIigQVmK6Q+O3cnYQw=
=0ODT
-----END PGP SIGNATURE-----

--nextPart6691312.GXAFRqVoOG--



