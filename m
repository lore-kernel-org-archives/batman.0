Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC42AC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 13:37:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8773484414
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 15:37:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785245825;
 b=1ZUiwAwuXEpmbb086ChxE6L03rGiAbKQ7mSznTglRAEEwCSRA8ig9mlfMmiCaHr1Yulru
 AG5BmboGPvAQ2C3efMsBGbo8X7CC0QjTwtVxGb3fIGJ+JYb7s3iei9rICFrzqcJoIJrOktH
 438YVhD/1SdBK1XJqyMsIK1D0Rvb9dk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785245825; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KAdbS24dgNeDnSQPgJePFfZT7DUb1uaAd1oVO4Ehl9o=;
 b=A7HWF7pJcDN737+2mj/vDse+qpMeR/VU/phbtnUBM5aCuo1phoeHVnq0H441AVEWs3hSd
 EJocz2Iyn4icQqmb2dC4DUO2vkfXi4CTI06OD6HfgeYm8Q10Ktvo06otOBv0zQRKb+1cUGD
 4V3YwuVZqaMch/gl4X/bJR/p4S8uvBQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E2DD384219
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:33:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245627;
	b=URKVDgOG9tnLlOuIiMuTzcW6idL2I2/r3sr8K38MQVsV7zzYy28X3c5yDzVvicQTJZmDLN
	YRsk58EzYuTYuo+htmoJ2bXE88vmaPjH+PiZiGtSjSm9KFJoWehVNYJUtCIC04KczhMGUk
	ZBvag24iQ/pF6cNL7crBM5NSxwhra2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KAdbS24dgNeDnSQPgJePFfZT7DUb1uaAd1oVO4Ehl9o=;
	b=Z85anuOjzpHacZLim+nY5eGtqE2a9J9TxdYqaAksIVEtHkJjycSRrciDhq/p4ZBqpmp+Qc
	kFQ0m1c/9OR5VoqZ686oq4pnFSUpFSVhL+DKiyJMoFRIUARSCcBDxK9WbZZg6JyYYoGxiq
	0+ljD7xfJVxwQihsV+GnqYRGJ9Sc7Yg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ubRlaWnD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7A5F01FF8D;
	Tue, 28 Jul 2026 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785245623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAdbS24dgNeDnSQPgJePFfZT7DUb1uaAd1oVO4Ehl9o=;
	b=ubRlaWnDkauOxrAMoXr836jdg6qfdRv1TjEXs1D+BIN5BGEE7TEdpyfJc24jedO/OWrV8J
	nMq3n7A5EYZpf57+pKkGlptNbVJtZU9Yi3y0caNdSGb13wy8z7oIEOpVMsWkocrRmuk0Bn
	jkK6AKBtyoV9PObRqvSq6WYq1YvX4no=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 15:32:14 +0200
Subject: [PATCH 5/7] alfred: gpsd: report failures while reading the answer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-gpsd-v1-5-04288045c4e5@narfation.org>
References: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
In-Reply-To: <20260728-bugfixes-gpsd-v1-0-04288045c4e5@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3486; i=sven@narfation.org;
 h=from:subject:message-id; bh=mI0tpF2xVoIyPq/nPVGGsuYOgOz2oW6noueJmqHoty8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZ61uSrwh/42j7krI4fPrMHPb7py595TreW58e6feC4
 7pb18rWjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE5j1mZPgtupfPrbk6LPTd
 pJZDrpsOnV0ocGNBkJ3uoUXxVVO5NGYyMrw8a5j3e2/8l+fmdlJfmdpYLyQ73pup/sKhydf+8Ot
 X1gwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WUYQBYW5JXB5GSZQGJZUXOHGN6E4YZBP
X-Message-ID-Hash: WUYQBYW5JXB5GSZQGJZUXOHGN6E4YZBP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WUYQBYW5JXB5GSZQGJZUXOHGN6E4YZBP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

gpsd_receive_answer_packet() returns NULL for a:

* closed connection
* read error
* malformed packet
* unexpected answer

All of them were indistinguishable from the latter regular end of the
answer. Even on errors alfred-gpsd printed an empty (well formed document).
An error could not directly be detected by the return code.

Report the error state of the packet parsing separately and use it for the
exit code.

Fixes: 2b901d69d8fb ("alfred: Add support for passing location information over alfred.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 43a3a83..57ac9cf 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -164,7 +164,7 @@ static ssize_t read_full(int fd, void *buf, size_t count)
 }
 
 static struct gpsd_v1 *gpsd_receive_answer_packet(int sock, uint16_t *len,
-						  uint8_t *source)
+						  uint8_t *source, int *error)
 {
 	struct alfred_push_data_v0 *push;
 	static uint8_t buf[65536];
@@ -173,15 +173,29 @@ static struct gpsd_v1 *gpsd_receive_answer_packet(int sock, uint16_t *len,
 	int ret;
 	int l;
 
+	*error = -1;
+
 	ret = read_full(sock, buf, sizeof(*tlv));
-	if (ret < 0)
+	if (ret < 0) {
+		perror("read from unix socket failed");
 		return NULL;
+	}
+
+	/* end of the answer */
+	if (ret == 0) {
+		*error = 0;
+		return NULL;
+	}
 
 	if (ret < (int)sizeof(*tlv))
 		return NULL;
 
 	tlv = (struct alfred_tlv *)buf;
-	/* TODO: might return an ALFRED_STATUS_ERROR too, handle it */
+	if (tlv->type == ALFRED_STATUS_ERROR) {
+		fprintf(stderr, "Request of gpsd data failed\n");
+		return NULL;
+	}
+
 	if (tlv->type != ALFRED_PUSH_DATA)
 		return NULL;
 
@@ -209,6 +223,8 @@ static struct gpsd_v1 *gpsd_receive_answer_packet(int sock, uint16_t *len,
 	if (data->header.version != GPSD_PACKETVERSION)
 		return NULL;
 
+	*error = 0;
+
 	memcpy(source, data->source, ETH_ALEN);
 	return (struct gpsd_v1 *) data->data;
 }
@@ -219,12 +235,12 @@ static int gpsd_read_answer(struct globals *globals)
 	uint8_t source[ETH_ALEN];
 	bool first_line = true;
 	uint16_t len;
+	int ret = 0;
 
 	printf("[\n");
 
 	while ((gpsd_data = gpsd_receive_answer_packet(globals->unix_sock,
-						       &len,
-						       source)) != NULL) {
+						       &len, source, &ret)) != NULL) {
 		if (len < sizeof(*gpsd_data))
 			break;
 
@@ -246,7 +262,7 @@ static int gpsd_read_answer(struct globals *globals)
 	printf("\n]\n");
 
 
-	return 0;
+	return ret;
 }
 
 /* Standard parsing of a GPS data source spec. Taken from gpsdclient.c
@@ -300,14 +316,16 @@ static void alfred_gpsd_source_spec(const char *arg,
 
 static int gpsd_get_data(struct globals *globals)
 {
+	int ret;
+
 	globals->unix_sock = gpsd_request_data(globals);
 	if (globals->unix_sock < 0)
 		return -1;
 
-	gpsd_read_answer(globals);
+	ret = gpsd_read_answer(globals);
 	close(globals->unix_sock);
 
-	return 0;
+	return ret;
 }
 
 static void gpsd_connect_gpsd(struct globals *globals)
@@ -584,8 +602,10 @@ int main(int argc, char *argv[])
 		return gpsd_server(globals);
 		break;
 	case OPMODE_CLIENT:
-		return gpsd_get_data(globals);
-		break;
+		if (gpsd_get_data(globals) < 0)
+			return EXIT_FAILURE;
+
+		return EXIT_SUCCESS;
 	}
 
 	return EXIT_FAILURE;

-- 
2.47.3

