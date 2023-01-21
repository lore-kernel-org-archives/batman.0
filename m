Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6365CC004D4
	for <batman@archiver.kernel.org>; Sat, 21 Jan 2023 17:32:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5B7D484073
	for <batman@archiver.kernel.org>; Sat, 21 Jan 2023 18:32:27 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 837F38059A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 21 Jan 2023 18:32:00 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1674322320; a=rsa-sha256;
	cv=none;
	b=iMaXIcu9waA6VzzdDBBXAJoEk5c+7bnRYRrEj0s7XHvvqUx2F2j85G+vZ4tGTnsDqfK6AZ
	DgjJMOsv8Jxn27vlTbFM5GXenZ9OvYZPARCERUDJ9m6g4XgeUwlkbqvtlNTJFFjbu93RcT
	lo06zMFEqm9gx+fd1T4l1U02OG1qsiY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="Y/yXmGik";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674322320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=UM6soR+3UI0EOE4W8jSoo3tnvUVEc5el5VKFj5gN3/Q=;
	b=ndLvV2Id1/H7V47wMY/4/ASElvbrhlim0FiFn59sUjHHGmnyiDVjs3qOXe34B4qEphg++C
	b3S8FiN0K8mYyHV25eqByu7B2fVZRAOPNysIuSHmrEMjcliBHgyKE/VRxb1i/NLy9vywA+
	dK7dX4YQ2Q09z6+t2fHKl8UiFPfRstc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1674322319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UM6soR+3UI0EOE4W8jSoo3tnvUVEc5el5VKFj5gN3/Q=;
	b=Y/yXmGikNQ2/u/OriGtPDxNoJVm00HJZLT/qYCEZ3qdUroXKUVd7tOqddIA803zwxHEX35
	c9EfU+nZJbi2ZPtKj443o9YdMyPDCL+QaFo0oveTayyzYE/tUHpa0pv0ps+eUShKbJ8BkP
	m+tBGmXperifKBfPFCsnVlrI8a3K8sw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 Jan 2023 18:31:40 +0100
Subject: [PATCH] alfred: gpsd: Fix build against gpsd 3.25
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20230121-gpsd_3-25-v1-1-03458b4c537b@narfation.org>
X-B4-Tracking: v=1; b=H4sIAHshzGMC/x2NSwqAMAwFryJZG+gXxKuISLVRs7BKAyKId7e6n
 Mc85gahzCTQVjdkOll4TwV0XcG0hrQQciwMRhmrtNG4HBIHi8ajddR4p5WLykPxxyCEYw5pWr/
 HFjh985Fp5utPdP3zvCkAg11yAAAA
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; i=sven@narfation.org;
 h=from:subject:message-id; bh=pNDcENM42iY+E5wKEucyDU5ZWlEkL3lyPVyun78waN8=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBjzCGGH0cL9OnxJbCk0k9DCBNKQanArsi/cgYWHNxg
 ih0qUQOJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCY8whhgAKCRBdhwoHwSZ7Rk/UEA
 CvtrEmyx9FHhAgLO39DEq+32yfzys+MF0gexCz70QLOLTWOhqSZrVfVLZ7/I+wKGm9v+eeFzKBONy1
 /2SeMfJkUh2RslpxyBhm213w8InvM3mFdAo+qg8wogE5ToepwTbiy+AQudsaIt4+34YfFHvnducnyb
 wwQTSQBEISQ75RplWDTujhRlPEz9bZlRF2vHYpfKuy0BC3LP+GSOupGAP+s+SerVuDkkYZ9Rk012n2
 K91OsrShJM8++WWqY20ZhhslNnuAIXPlcJ7xNjWgBHtfpv6Rnq/WyCJ4zYwxTTYAoZ3z1aGphs7Roy
 m4QxSnLfcFvhO/tFHll/ZnOE+BP04lQ3WATW5bi0no5aDzRs5sSA9LFuJx5RhFi7ehjQ5G6YxnV20l
 24FfRPWag4p60SlcQvK0KX2d9XZP5MM4ZFHQDqQRRL4E5qcpj9BseSQ7TBvdBbo119rRLa5PvNQgfd
 s4wwvjq+/UXwgD6K3NueEiFy6fAGXIV0wLqrMgwWXGdCh9/YDombG6yP3e7pds7P9hPhfKvdqjORRb
 /RlK68kXZ5ysCckoAPjJYWIgTUY4yzR+T5tHd/1buE5k0S7KHS9uZxcJ63VVBwu853/Kbxkom7Nutj
 OAZYQFIfxWEUWEfJ3TK7KSaQev8NMOWVP0p4QkcgyUgwZl/2EOK06/NaJNTw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: EMN75STFQGVFP23GZTDY6GVQLYLLIAHQ
X-Message-ID-Hash: EMN75STFQGVFP23GZTDY6GVQLYLLIAHQ
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: =?utf-8?q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EMN75STFQGVFP23GZTDY6GVQLYLLIAHQ/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

gpsd moved in commit 35fe48835da0 ("include/gps.h: Move fixsource_t into
gps.h, add into gps_data_t.") the function gpsd_source_spec + its data
structures from the private gpsdclient.h to the public API header gps.h.
But the actual API major or minor version was not increased in this
process.

It is therefore not easily possible to figure out whether the libgps API
will provide this functionality or not. To avoid a conflict during the
build, just rename fixsource_t and gpsd_source_spec.

Reported-by: Bj=C3=B8rn Forsman <bjorn.forsman@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 11 +++++++----
 gpsd/alfred-gpsd.h |  8 +++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 20b3d98..d0bd47c 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -217,8 +217,11 @@ static int gpsd_read_answer(struct globals *globals)
 	return 0;
 }
=20
-/* Standard parsing of a GPS data source spec. Taken from gpsdclient.c *=
/
-static void gpsd_source_spec(const char *arg, struct fixsource_t *source=
)
+/* Standard parsing of a GPS data source spec. Taken from gpsdclient.c
+ * remove when gpsd 3.25 is minimum supported version
+ */
+static void alfred_gpsd_source_spec(const char *arg,
+				    struct alfred_gpsd_fixsource_t *source)
 {
 	/* the casts attempt to head off a -Wwrite-strings warning */
 	source->server =3D (char *)"localhost";
@@ -425,7 +428,7 @@ static struct globals *gpsd_init(int argc, char *argv=
[])
 			gpsd_parse_location(globals, optarg);
 			break;
 		case 'g':
-			gpsd_source_spec(optarg, &globals->gpsdsource);
+			alfred_gpsd_source_spec(optarg, &globals->gpsdsource);
 			have_source =3D true;
 			break;
 		case 'u':
@@ -443,7 +446,7 @@ static struct globals *gpsd_init(int argc, char *argv=
[])
 	}
=20
 	if (globals->source =3D=3D SOURCE_GPSD && !have_source)
-		gpsd_source_spec(NULL, &globals->gpsdsource);
+		alfred_gpsd_source_spec(NULL, &globals->gpsdsource);
=20
 	if (signal(SIGPIPE, SIG_IGN) =3D=3D SIG_ERR)
 		perror("could not register SIGPIPE handler");
diff --git a/gpsd/alfred-gpsd.h b/gpsd/alfred-gpsd.h
index 38588ad..174ca14 100644
--- a/gpsd/alfred-gpsd.h
+++ b/gpsd/alfred-gpsd.h
@@ -60,8 +60,10 @@ struct gpsd_v1 {
 #define GPSD_DATA_SIZE(gpsd_data)	\
 	(sizeof(*gpsd_data) + (ntohl(gpsd_data->tpv_len)))
=20
-/* struct taken from gpsdclient.h */
-struct fixsource_t
+/* struct taken from gpsdclient.h
+ * remove when gpsd 3.25 is minimum supported version
+ */
+struct alfred_gpsd_fixsource_t
 {
 	char *spec;         /* pointer to actual storage */
 	char *server;
@@ -84,7 +86,7 @@ struct globals {
 	int unix_sock;
 	const char *unix_path;
=20
-	struct fixsource_t gpsdsource;
+	struct alfred_gpsd_fixsource_t gpsdsource;
 	struct gps_data_t gpsdata;
 	char * tpv;
 };

---
base-commit: 1ff43b3ea32b0f6cdea2440c4beaf001090370ff
change-id: 20230121-gpsd_3-25-34e854104d05

Best regards,
--=20
Sven Eckelmann <sven@narfation.org>
