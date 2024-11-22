Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA63E69191
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 21:18:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 834378402C
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 22:18:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732310288;
 b=cS+zVIxd+i0XDpUcLZvvjshkNyes+T7V4xEYmB3//Nd41U/gyVx5NxW3ZkeaOHLVQeVr9
 lvQ2VPXoEAYsxEu0ZhHFbmsVEvB1ESyqo4M5xhQZlkal5LS7RsPqEEEYSWZL24NsgBKGVmv
 u5RaWUjiw5WsGTwkjFaUKlb2EEzDU1Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732310288; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ziyi/LR1pTEtUbE7aY0hDp8ENYMyLNPOuVnNJ1/eM/Q=;
 b=wyn/MQAVvdorWu4VS/m6aYfwEaai3WidA8Wo8I/aMlVowGThu5Fp1XuMc/dBV+KOvoUm3
 D9YfPO4OYllvO7O8du5vPHlG+beZXw9ScXPswGl6XWpfn4enxaB5jGbhqEWR0yok+mYW2eK
 k+vYGS+HaB1zqYQOBQg+ryqmSV6btE0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D32B381841
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 22 Nov 2024 22:12:41 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732309961; a=rsa-sha256;
	cv=none;
	b=zhy7GuMX1C4NbKdJTwFy+FzVWyPio48KojpnA3kSEEalTUZx/Rq6fmwq+1A5b9mwGxDSOt
	PNUfOyonz+iXBLl3MIQnbjWQ20SmjRYhByRyIp0exmpx03gvuIwshtuvVXPxSJ6WzcsGFE
	A9WcbMxEwFdD+pxgLzqnc1ccMIxNlLY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=WLqaEtXY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of mr.nuke.me@gmail.com designates
 2607:f8b0:4864:20::231 as permitted sender)
 smtp.mailfrom=mr.nuke.me@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732309961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Ziyi/LR1pTEtUbE7aY0hDp8ENYMyLNPOuVnNJ1/eM/Q=;
	b=XBeiqSV7bd9l4WYJhRxhFtvRnlsD+rfXqMTHnH8xQeg5KfEglCcbPCN08sCho+hI/1z91g
	xVMiYi7GRibk3CKv+5d6tZ+Vt+eAdZ+WQhTdEmUBtQGCuY0xKfq1ADq5N8JhWJR+1UC/o7
	0Egpia61pJGmCYeHqIbkIF1l2GoRM1E=
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e601b6a33aso1653729b6e.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 22 Nov 2024 13:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732309960; x=1732914760;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ziyi/LR1pTEtUbE7aY0hDp8ENYMyLNPOuVnNJ1/eM/Q=;
        b=WLqaEtXYKQvwD9q9setnmwS/fpJ5bJdqfEjzJHh9SBEJYRran6ymEgQLNGXsqhWoRI
         P4296Mbor1FiDhnF1hNJdh01NjnSgWK46sacomG8Li5n/uEs8HnBfX4Xmy1OBG+i8MiO
         ZNFpPwHMtmCLKJsZnRZJtoUPshD90h1U4aJMf9NTTl1awwJ3y7iMF2HGvWOqhOndJi+8
         tIHcw5WJvG/+s+6KY5oYi6i2EOkUIthKs0DuM1lOMomKoMm5dOvLSXHkO5T0Q8SS3dlr
         WgY6t/+Tgf7a6e/f/dmKXR7sbQYVAwhqmftj5ZvUI+bii8OBeYirsNevE8qCDenUBQcL
         eFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732309960; x=1732914760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ziyi/LR1pTEtUbE7aY0hDp8ENYMyLNPOuVnNJ1/eM/Q=;
        b=WTyayNXnwtB2T0RWhMEkVTz8vHgIgLzWq84Up4R9orb+tC9WKG69o+WhMrUouWpai8
         mka4Sbt/xU3ggviMm5GcsFa1O8E5zbYDLtVjQPRnhrvG1SFpAOr5uKYq4Iw+ZZmMMA7G
         j6VMu2cD1nEE4vBtB6Kq8pitxV30E74pUU4qrtQYKaK94lQ/CMzEuykl1balqglNd5nG
         qokw+qObTZC+4whaYfaPUvW0ZZlLV50EdaDHrwaOrzXIxr4TaroUNE6GBFN68K5UnXZk
         v3dAchclMHZ1woCvRy/tfal5WNMoHgP+ngjw1OA8wit6RVo/QTRJbUn4NWgcTzzYziz8
         rTMg==
X-Gm-Message-State: AOJu0Yxgd9Fn4foGrtZP3zjaMkgg6yxvctBQiD1Mkm+95eBjYlQFOzjX
	48HO23cPR+Qhi76gJcygwjNzmyZ0rE4zFdBBfpvXbPqGsZaWQrc/8xzYk24M
X-Gm-Gg: ASbGncvxr9oWiN7eU2gsMZRHswGURjKNu5yUz03vGsqYJPFcjDQ6WyO5cl0tqxJCs2i
	aMiSqjPNNlR3/V0B7336MeuBUAW6NSGC/W5Wy6Ryvq9FRuqawEznXL47papVcejNky1PdxyAskZ
	pUV4ZdDoFZvYjm/5EvEvDl+E7/sdH4MSCVaz8w2BqLYwGXhSJSuyzESDanfVIoDllS0bBhsIQNC
	oKiTCEzDkfv9iASa3l3l5ve3jG4NmYrYvnu5rgDvgF/14zt1Aq29W29BV4E6wdWZ+mBf0xflzPz
	XH6nsYt/Fv8=
X-Google-Smtp-Source: 
 AGHT+IHctevqsRvZKHXDtuBDl3M7/nLp6eDs9VU4RGd7Kmhq84DYl3u4gDz5A6HnNwAojmqo0eT27Q==
X-Received: by 2002:a05:6808:2192:b0:3e7:ec60:2d71 with SMTP id
 5614622812f47-3e915aef058mr3777368b6e.33.1732309959981;
        Fri, 22 Nov 2024 13:12:39 -0800 (PST)
Received: from nuclearis4.lan (c-98-57-15-22.hsd1.tx.comcast.net.
 [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e914eea429sm581339b6e.29.2024.11.22.13.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:12:38 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH] batctl: Remove redundant check_root_or_die()
Date: Fri, 22 Nov 2024 15:12:35 -0600
Message-ID: <20241122211235.2993017-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mr.nuke.me@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: UJTTDOM3ZHOI4KNACXWTBF4PFC3ONWSR
X-Message-ID-Hash: UJTTDOM3ZHOI4KNACXWTBF4PFC3ONWSR
X-Mailman-Approved-At: Fri, 22 Nov 2024 22:17:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UJTTDOM3ZHOI4KNACXWTBF4PFC3ONWSR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Without running as root, batctl would abort. However, this check has
zero value as it is redundant. The kernel will warn us if we don't
have permission to manipulate networking via netlink:

    $ ./batctl if create ra BATMAN_V
    Error - failed to add create batman-adv interface: Operation not permitted

Without this check, it is possible to change networking settings
without root with the CAP_NET_ADMIN permission:

    $ sudo setcap cap_net_admin+eip ./batctl
    $ ./batctl if create ra BATMAN_V
    $ ./batctl if add enp6s0
    $ ./batctl if
    enp6s0: active

Thus, do not force batctl to run as root. Let the system admin and or
user decide how to manage permissions. For those that run batctl as
root, nothing changes.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 debug.c           | 2 --
 functions.c       | 8 --------
 functions.h       | 1 -
 genl_json.c       | 2 --
 gw_mode.c         | 2 --
 interface.c       | 2 --
 loglevel.c        | 2 --
 ping.c            | 2 --
 routing_algo.c    | 2 --
 sys.c             | 2 --
 tcpdump.c         | 2 --
 throughputmeter.c | 2 --
 traceroute.c      | 2 --
 translate.c       | 2 --
 14 files changed, 33 deletions(-)

diff --git a/debug.c b/debug.c
index 2fa8975..5629e1f 100644
--- a/debug.c
+++ b/debug.c
@@ -144,8 +144,6 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 		}
 	}
 
-	check_root_or_die("batctl");
-
 	if (read_opt & UNICAST_ONLY && read_opt & MULTICAST_ONLY) {
 		fprintf(stderr, "Error - '-u' and '-m' are exclusive options\n");
 		debug_table_usage(state);
diff --git a/functions.c b/functions.c
index 482bdf5..bf6057c 100644
--- a/functions.c
+++ b/functions.c
@@ -946,14 +946,6 @@ void get_random_bytes(void *buf, size_t buflen)
 	get_random_bytes_fallback(buf, buflen);
 }
 
-void check_root_or_die(const char *cmd)
-{
-	if (geteuid() != 0) {
-		fprintf(stderr, "Error - you must be root to run '%s' !\n", cmd);
-		exit(EXIT_FAILURE);
-	}
-}
-
 int parse_bool(const char *val, bool *res)
 {
 	if (strcasecmp(val, "0") == 0 ||
diff --git a/functions.h b/functions.h
index 860d9f4..b85bbf1 100644
--- a/functions.h
+++ b/functions.h
@@ -60,7 +60,6 @@ int check_mesh_iface(struct state *state);
 int check_mesh_iface_ownership(struct state *state, char *hard_iface);
 
 void get_random_bytes(void *buf, size_t buflen);
-void check_root_or_die(const char *cmd);
 
 int parse_bool(const char *val, bool *res);
 bool parse_throughput(char *buff, const char *description,
diff --git a/genl_json.c b/genl_json.c
index b61acdb..855a218 100644
--- a/genl_json.c
+++ b/genl_json.c
@@ -598,8 +598,6 @@ int handle_json_query(struct state *state, int argc, char **argv)
 		}
 	}
 
-	check_root_or_die("batctl");
-
 	err = netlink_print_query_json(state, json_query);
 
 	return err;
diff --git a/gw_mode.c b/gw_mode.c
index 6261a9d..1b102a3 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -299,8 +299,6 @@ static int gw_mode(struct state *state, int argc, char **argv)
 	if (argc == 1)
 		return gw_read_setting(state);
 
-	check_root_or_die("batctl gw_mode");
-
 	res = parse_gw(state, argc, argv);
 	if (res < 0)
 		return EXIT_FAILURE;
diff --git a/interface.c b/interface.c
index d115247..6f70468 100644
--- a/interface.c
+++ b/interface.c
@@ -436,8 +436,6 @@ static int interface(struct state *state, int argc, char **argv)
 	if (rest_argc == 0)
 		return print_interfaces(state);
 
-	check_root_or_die("batctl interface");
-
 	if ((strcmp(rest_argv[0], "add") != 0) && (strcmp(rest_argv[0], "a") != 0) &&
 	    (strcmp(rest_argv[0], "del") != 0) && (strcmp(rest_argv[0], "d") != 0) &&
 	    (strcmp(rest_argv[0], "create") != 0) && (strcmp(rest_argv[0], "c") != 0) &&
diff --git a/loglevel.c b/loglevel.c
index b7ca14f..ab6f033 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -128,8 +128,6 @@ static int loglevel(struct state *state, int argc, char **argv)
 	}
 
 	if (argc != 1) {
-		check_root_or_die("batctl loglevel");
-
 		for (i = 1; i < argc; i++) {
 			if (strcmp(argv[i], "none") == 0) {
 				log_level_globals.log_level = 0;
diff --git a/ping.c b/ping.c
index 4cc8e00..f2f6c41 100644
--- a/ping.c
+++ b/ping.c
@@ -132,8 +132,6 @@ static int ping(struct state *state, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	check_root_or_die("batctl ping");
-
 	dst_string = argv[found_args];
 	bat_hosts_init(0);
 	bat_host = bat_hosts_find_by_name(dst_string);
diff --git a/routing_algo.c b/routing_algo.c
index 5d29418..8d1b63e 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -279,8 +279,6 @@ static int routing_algo(struct state *state, int argc, char **argv)
 		}
 	}
 
-	check_root_or_die("batctl routing_algo");
-
 	if (argc == 2)
 		return write_default_ra(SYS_SELECTED_RA_PATH, argv[1]);
 
diff --git a/sys.c b/sys.c
index dbbdeb3..dcef51f 100644
--- a/sys.c
+++ b/sys.c
@@ -245,8 +245,6 @@ int handle_sys_setting(struct state *state, int argc, char **argv)
 	if (argc == 1)
 		return sys_read_setting(state);
 
-	check_root_or_die("batctl");
-
 	if (settings->parse) {
 		res = settings->parse(state, argc, argv);
 		if (res < 0)
diff --git a/tcpdump.c b/tcpdump.c
index 3b9ded5..d4e805d 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1539,8 +1539,6 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	check_root_or_die("batctl tcpdump");
-
 	bat_hosts_init(read_opt);
 
 	signal(SIGINT, sig_handler);
diff --git a/throughputmeter.c b/throughputmeter.c
index f3aa09a..4f3dc50 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -352,8 +352,6 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	check_root_or_die("batctl throughputmeter");
-
 	dst_string = argv[found_args];
 	bat_hosts_init(read_opt);
 	bat_host = bat_hosts_find_by_name(dst_string);
diff --git a/traceroute.c b/traceroute.c
index 4a6f4cf..2409c30 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -83,8 +83,6 @@ static int traceroute(struct state *state, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	check_root_or_die("batctl traceroute");
-
 	dst_string = argv[found_args];
 	bat_hosts_init(read_opt);
 	bat_host = bat_hosts_find_by_name(dst_string);
diff --git a/translate.c b/translate.c
index 9228863..0101724 100644
--- a/translate.c
+++ b/translate.c
@@ -32,8 +32,6 @@ static int translate(struct state *state, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	check_root_or_die("batctl translate");
-
 	dst_string = argv[1];
 	bat_hosts_init(0);
 	bat_host = bat_hosts_find_by_name(dst_string);
-- 
2.47.0

