Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED27606A31C
	for <batman@archiver.kernel.org>; Sun,  8 Nov 2026 08:06:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 41627847F9
	for <batman@archiver.kernel.org>; Sun, 08 Nov 2026 09:06:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794125179;
 b=S81PRjtnhDxHnLbIfDh81r/mL1IgGMvCe6NSRqxR2F9tAdhRP97EJY2dUZ1LJmjzcWL+Y
 LvqhRgmKAS2rKMqTxB9U0JvA7T7sbf1GMKAnnTxRgKQVSCym7JL8KFaeEaDpnanz5T8ZGRM
 w9HNuS1Xtj6voVmjEdRbLGOs7K+fIB8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794125179; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=J88EOnTp6DDyQWMN+uJw6KY8yryRm72G2AQk7g82/uM=;
 b=3w9GEPofK4CTuRuKPhPonpgGlAPGjddTyqbExrJPp1vOyph0ermH+m6CHZK4NaqORIBx3
 qVxljYmlxIUDLRjYfNZVUZgSq7SG4bsXNV8bsJdC9+vZx5zP9nKT5/yLs6EhYn8XnNIM3pU
 hM1k6SKw4SsVTVn+luo69rKSgHBpb70=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=syzkaller.appspotmail.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9A568814E7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 08 Nov 2026 09:01:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794124875;
	b=VDxsZhbLg7T7Q0IMy3EyvKKFS9A8B7E+c+zrXBYfFtB3Fh2kDnbvw/+wpfks273Y61MO4t
	lrkffCg+5FwK9u2z8PVAzZIL71ZgzzCn/QrBWgNISeT5qJbfUhznTXoUWxaI0xZum3EYn8
	6Amuvt3B14tt4vuWnR3LiOQc9d1sugY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794124875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to; bh=J88EOnTp6DDyQWMN+uJw6KY8yryRm72G2AQk7g82/uM=;
	b=b0tHnkfhQuRCcgpP/20y5QiAnuxgxAf3ywLCLOjR/2EQkIgmPrSUV0lKNVLv7y60e4uLwB
	DyxoBlPoLdKNuxAdbFZL9tAASr3qdhaO2JaWkf2xbML02qzm/UIxnGVN/BZlRdpdLmjcg1
	+UUaPPDHHAwKBBzwys327nk3lKlPYc0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3PizwagkbALUntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.167.200 as permitted sender)
 smtp.mailfrom=3PizwagkbALUntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-5640a2d9708so384290b6e.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 08 Nov 2026 00:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794124863; x=1794729663;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :in-reply-to:date:mime-version:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J88EOnTp6DDyQWMN+uJw6KY8yryRm72G2AQk7g82/uM=;
        b=C4GyEyS4jYFv0Z+n/984PlokEPVhCtnMeZ86y7G9KxMzS+A1eGTmcomE384ssm5lDE
         pvxibi2mKRuJDh8Bq44mU8qFw7XbF++p7NsVxUfg2489xGFXdlDHBd1nRE+OI9P/k+kB
         6MyMVtWXfc5Tl+/DECjHnll2GO9ck/5mMfvw3+Lt03PRZdwjuoseDB5JAlowDiAOng7v
         cTFbXbIhdHY6pQKKrNksFykjVN2eXl0dfUvt5zarlhBF+c4TziwWc6EGX5+rLE2wQcTY
         YNTdvx37PXbSKALpwPoHO4drzCb8JjpgjkTVUELqiGbyxfER2TlBj9hOnMy3lFSMF3Bi
         oeHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6iVgqPoCC3BEQDlVO4oG/DrzQr/1GdM/+YOkikEeq20cnD8N0MT1DWmwOwJpmWAHVBIapLHroBAbpBw==@lists.open-mesh.org
X-Gm-Message-State: APuU4Z90+LT/9Rs/yrGULeQa2n0AkTYpB5ZigfeybWEhgLwQfng7qirJ
	LvftJP0/2s1hQZDRc0ShBhEfQaaIlHWbdAc02Voabn3xlvb82456WICkXzLnj0/MUHowc9fZWpA
	QgUQveTEuqsHLkgV5HyVvDwi14vUSbhVyBCP7AzbBKBDSybGvtqmBG7Nt9vg=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2389:b0:4e0:1d24:cec1 with SMTP id
 5614622812f47-568143748bfmr467480b6e.5.1794124862848; Sun, 08 Nov 2026
 00:01:02 -0800 (PST)
Date: Sun, 08 Nov 2026 00:01:02 -0800
In-Reply-To: <2056587.PYKUYFuaPT@sven-l14>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af02c3e.4dd4714a.f8d02.000e.GAE@google.com>
Subject: Re: [syzbot] [arm?] BUG: workqueue lockup in batadv_tt_purge
From: syzbot <syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	netdev@vger.kernel.org, omermetekaya0@gmail.com, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: 
 3PizwagkbALUntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: FRQ27M4EBDJSK65FEYOSXG2N7POQUUXV
X-Message-ID-Hash: FRQ27M4EBDJSK65FEYOSXG2N7POQUUXV
X-Mailman-Approved-At: Sun, 08 Nov 2026 09:05:56 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FRQ27M4EBDJSK65FEYOSXG2N7POQUUXV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering=
 an issue:
BUG: workqueue lockup in nsim_fib_event_work

bridge0: received packet on bridge_slave_1 with own address as source addre=
ss (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth1_to_bridge with own address as source addr=
ess (addr:aa:aa:aa:aa:aa:0c, vlan:0)
BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 stuck f=
or 34s!
Showing busy workqueues and worker pools:
workqueue events: flags=3D0x100
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D4 refcnt=3D5
    pending: nsim_dev_hwstats_traffic_work, vmstat_shepherd, 2*ovs_dp_masks=
_rebalance
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D33 refcnt=3D34
    in-flight: 26:nsim_fib_event_work for 35s nsim_fib_event_work ,4951:nsi=
m_fib_event_work for 31s ,1503:nsim_fib_event_work for 22s ,1091:nsim_fib_e=
vent_work for 15s
    pending: 3*nsim_dev_hwstats_traffic_work, 2*ovs_dp_masks_rebalance, psi=
_avgs_work, 3*ovs_dp_masks_rebalance, psi_avgs_work, drm_fb_helper_damage_w=
ork, 2*l2cap_info_timeout, psi_avgs_work, 2*l2cap_info_timeout, 4*ovs_dp_ma=
sks_rebalance, 3*rht_deferred_worker, psi_avgs_work, reg_todo, 3*nsim_fib_e=
vent_work
workqueue events_unbound: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D5 refcnt=3D6
    in-flight: 14:nsim_dev_trap_report_work for 5s
    pending: 2*nsim_dev_trap_report_work, toggle_allocation_gate, flush_mem=
cg_stats_dwork
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D15 refcnt=3D16
    in-flight: 5376:cfg80211_wiphy_work for 25s cfg80211_wiphy_work ,1178:c=
fg80211_wiphy_work for 32s cfg80211_wiphy_work ,1372:cfg80211_wiphy_work fo=
r 35s cfg80211_wiphy_work ,5377:nsim_dev_trap_report_work for 7s ,58:cfg802=
11_wiphy_work for 33s cfg80211_wiphy_work ,49:cfg80211_wiphy_work for 23s c=
fg80211_wiphy_work ,40:cfg80211_wiphy_work for 31s cfg80211_wiphy_work
    pending: 2*macvlan_process_broadcast
workqueue events_power_efficient: flags=3D0x82
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D4 refcnt=3D5
    pending: fb_flashcursor, wg_ratelimiter_gc_entries, 2*neigh_managed_wor=
k
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D3 refcnt=3D4
    in-flight: 1350:gc_worker for 16s ,144:neigh_periodic_work for 20s
    pending: do_cache_clean
workqueue events_dfl_long: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D11 refcnt=3D12
    pending: 11*defense_work_handler
workqueue netns: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D4
    in-flight: 12:cleanup_net for 36s
workqueue mm_percpu_wq: flags=3D0x108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
workqueue writeback: flags=3D0x4a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D4 MAYDAY
    in-flight: 33(RESCUER):wb_workfn for 31s
workqueue mld: flags=3D0x40108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D4
    pending: mld_dad_work
    inactive: 2*mld_dad_work
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D108
    pending: mld_dad_work
    inactive: mld_dad_work, 8*mld_ifc_work, 4*mld_dad_work, mld_ifc_work, m=
ld_dad_work, 10*mld_ifc_work, mld_dad_work, 3*mld_ifc_work, mld_dad_work, 1=
1*mld_ifc_work, mld_dad_work, mld_ifc_work, mld_dad_work, mld_ifc_work, 3*m=
ld_dad_work, 10*mld_ifc_work, 3*mld_dad_work, 7*mld_ifc_work, 2*mld_dad_wor=
k, 3*mld_ifc_work, mld_dad_work, mld_ifc_work, mld_dad_work, mld_ifc_work, =
mld_dad_work, mld_ifc_work, mld_dad_work, 17*mld_ifc_work, mld_dad_work, 3*=
mld_ifc_work, 5*mld_dad_work
workqueue ipv6_addrconf: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D248 MAYDAY
    in-flight: 2822(RESCUER):addrconf_dad_work for 0s
    pending: mayday_cursor_func
    inactive: 242*addrconf_dad_work
workqueue bat_events: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D50 MAYDAY
    in-flight: 2854(RESCUER):batadv_dat_purge for 7s
    inactive: batadv_bla_periodic_work, batadv_dat_purge, batadv_bla_period=
ic_work, batadv_dat_purge, batadv_bla_periodic_work, batadv_dat_purge, bata=
dv_bla_periodic_work, batadv_dat_purge, batadv_bla_periodic_work, batadv_iv=
_send_outstanding_bat_ogm_packet, batadv_mcast_mla_update, 4*batadv_iv_send=
_outstanding_bat_ogm_packet, batadv_purge_orig, 2*batadv_iv_send_outstandin=
g_bat_ogm_packet, 4*batadv_purge_orig, 4*batadv_iv_send_outstanding_bat_ogm=
_packet, 2*batadv_tt_purge, 4*batadv_iv_send_outstanding_bat_ogm_packet, 3*=
batadv_tt_purge, batadv_mcast_mla_update, batadv_purge_orig, batadv_iv_send=
_outstanding_bat_ogm_packet, batadv_tt_purge, 4*batadv_mcast_mla_update, ba=
tadv_dat_purge
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker, wg_packet_=
tx_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    in-flight: 4767:wg_packet_handshake_receive_worker for 21s
    pending: wg_packet_handshake_receive_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker, wg_packet_=
tx_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    in-flight: 932:wg_packet_decrypt_worker for 22s
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker, wg_packet_=
tx_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    in-flight: 4813:wg_packet_encrypt_worker for 14s
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker, wg_packet_=
tx_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker, wg_packet_=
tx_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker, wg_packet_=
tx_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker
pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D14s workers=3D6 idle:=
 4847 9 10
pool 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 hung=3D34s workers=3D9 idle:=
 24 4738 5269 5303 4950
pool 8: cpus=3D0-1 flags=3D0x6 nice=3D0 hung=3D0s workers=3D12 manager: 537=
8
Showing backtraces of busy workers in stalled worker pools:
pool 6:
task:kworker/1:1     state:R  running task     stack:0     pid:26    tgid:2=
6    ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: events nsim_fib_event_work
Call trace:


Tested on:

commit:         532df11b batman-adv: tt: batch BH re-enable during TT ..
git tree:       https://git.open-mesh.org/batadv.git disable-bh
console output: https://syzkaller.appspot.com/x/log.txt?x=3D137967a5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da3c0ea8c3fd7635=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D61b202fdc410840f0=
198
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64

Note: no patches were applied.
