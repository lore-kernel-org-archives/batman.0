Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51BEC46CD2
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 12:49:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E5F9183E5C
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 13:49:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706359784;
 b=iiRBCI9MyCRr8/RA6LO8rIgRQSRq5wJMoU9a9JaktLBLumpDzG87ewHqlhvSGAyQXB/SB
 vGSni10TVknCyBGMMawMdz4IPKoABTEmVsCfN5NQlhZ07xKIZseZdVS8mxHzute3pZvmjlX
 ntzulNJV7DiMhHA5d+Pblq3gFlhHKoo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706359784; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=i0xy7LRvH595pXaiSXc8liWg7NADrmJQCYUQeBw96Eo=;
 b=rMG7L3dVjMH3cKnPFndzJHO280X3ERXqw3ZIS23izkwLy/62nik6lddxGk2dmaNugVD/u
 HOJxNjThr0K3oSc9lI4Yuwcbk1KE5ePCCA9lRAKpULb4Oc5AT1HNjQbcmMEjqh/uzpdLq7U
 xw9h+6YOs5o1ijmQlo57LyUKaOoMNkY=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D1EA58072E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jan 2024 13:49:39 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706359779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=i0xy7LRvH595pXaiSXc8liWg7NADrmJQCYUQeBw96Eo=;
	b=A1EyN3LORiXmTBNk3o/ru5Ela6oOojBJmjykgQxNQopDmRf3le5nekZCcoP4DoDtb4b4Ip
	7bwPOYkuoClbhlOq30RxtlqjNmhGrrPm39RkON+gs/5FeDwZtVHGp8xMnh3mHUFd3tyd2K
	kbuXT2l1RcGrGZmkOnZTWyOOYA6q2UE=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706359779; a=rsa-sha256;
	cv=none;
	b=gwICVALc0/szcqbN7BCrJ4F+m/n4zOGjkM/vDZwsGI0/1W2dAs2zvRvihThnslhFY2OCZa
	DVAQNc/YypHTwOjUn7iTOZMQDFIu1S+Iv33ZNeZRE2eGtidlLhSIIpfL4N/r4nmsm61Lvd
	rmLkbKS5g7sGTsjSk2GxqBRk1Vz9/A4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fUiOt61P;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1706359779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i0xy7LRvH595pXaiSXc8liWg7NADrmJQCYUQeBw96Eo=;
	b=fUiOt61PMYldHtWG6hsiqkQuTrJJv2X2SAHMFX5AoG8TrPUmxNUY9msVi8meykyY0/p51R
	/b8lcmV0RM2k2V7e7ZyBmeetl6YsmSiy67Am6SNTgqjJt7a0LW0sf9RAiVxcXKLa1gMGrf
	8a9NRBG0NEBiwMcbZZs9j4hpO0pc6NI=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/6] batctl: tcpdump: Fix problems detected during fuzzing
Date: Sat, 27 Jan 2024 13:48:58 +0100
Message-Id: <20240127-tcpdump_fuzzing-v1-0-fbc1e1d3fec1@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALr7tGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNz3ZLkgpTS3IL4tNKqqsy8dF1zYzNzcxNLA7M0MwMloK6CotS0zAq
 widGxtbUANg8Vg2EAAAA=
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Marco Dalla Torre <marco.dallato@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4304; i=sven@narfation.org;
 h=from:subject:message-id; bh=Gctws76SgzuUReEQIC+A7UJRsOtVgpl2HCDZ4dmiedk=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBltPvg+i8h9lF/6yHWhwn4mwKjJ+rLxe5vz3wDV
 g56AsypluqJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZbT74AAKCRBdhwoHwSZ7
 RrjED/4iZxR9LtYZjlrxKAnDGhwMk4gDMwFlpS0TblTPuB7IWNgaIWKmHEqaXO8h+sgalBOhEUS
 PTS4wvgGEXvku6EKoQpnRV7xbjDA7iPLtVC4aG3DCDknsIBkohKwrIVTX4JO9x7jepOCJdDD4fR
 r3vjv3ZBSEGdnEuoTxEjrpIihu6xqa65N3NFySKttZ7o2biXwJvywUG0THeIxP6InQWCiMikdWq
 zCPFCkY4FJVE/HcQpkOZUBDwKdDR0S0JoqJDL5PcNR3yYPqSkpNqDqdYUDwEVawUtuX2uSIdQqm
 3Flq5anp/BVcY/ggvdiOFq/ZTEQY8ZhJv/sVCHnXdC4spQy5ErMzBwP6a4tWbB5YCm0wcDMxSLG
 DwNt0L+Y9kq8PULJuBvAU+Cdics+9QBKcD6vlanBOH/avZoQyDj6kkaLtTJ8X5wM01k8/lVjGos
 yULK9xkZObEXdVJ44lWrNUQaSvSyLBt2QyZeP6HbnC5ltFHmpZY1vHlN8mnzdUV5OQPtAwDhT5E
 BxW8v3iallXoBOxxLthoEP9t3VURV0hoG+dS6JLKX5/u29xMUIQuYj3mBAsG2bSMSkosY+HNv6d
 J5sangFheHFtWYjWnTxayVW36OwjWL29ndw1CliPgmtBePkS9IXq+WsEBFQkjox7bGXv6kgtR+S
 A87VvB8YrMcFtqw==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 33UQBIDFONXA22B7EMCGOA6YMN3QYVFR
X-Message-ID-Hash: 33UQBIDFONXA22B7EMCGOA6YMN3QYVFR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/33UQBIDFONXA22B7EMCGOA6YMN3QYVFR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

While many parts of batctl are rather simple, tcpdump is one of the most
complex parts - which unfortunately is also dealing all the time
with potentially harmful input. It is therefore a good idea to perform
some tests to figure out how bad the current state of the code is. The
findings will be presented here - including some information how other
people can reproduce these problems.

With afl++, it is possible to fuzz batctl tcpdump and find parsing errors
(easier). But it needs an entry point to actually send data to. So for
simplicity, a fuzzme subcommand was added which just gets new data from
afl++ and then runs the main ethernet parsing function.

  diff --git a/split_pcap.py b/split_pcap.py
  new file mode 100755
  index 0000000000000000000000000000000000000000..11a1f5ce8ec60fac141693b0449d5c3955f9ad28
  --- /dev/null
  +++ b/split_pcap.py
  @@ -0,0 +1,21 @@
  +#!/usr/bin/env python3
  +
  +import sys
  +
  +from hashlib import sha256
  +from scapy.utils import rdpcap
  +
  +
  +def main():
  +    for pcap in sys.argv[1:]:
  +        packets = rdpcap(pcap)
  +        for packet in packets:
  +            m = sha256()
  +            m.update(packet.load)
  +            fname = m.hexdigest()
  +            with open(fname, "wb") as f:
  +                f.write(packet.load)
  +
  +
  +if __name__ == "__main__":
  +    main()
  diff --git a/tcpdump.c b/tcpdump.c
  index 5e7c76c69bd192d7485958aafabc0e9264b41b90..d340af986f99bdf2e8e6dae0d91a641bc80e82a2 100644
  --- a/tcpdump.c
  +++ b/tcpdump.c
  @@ -1556,3 +1556,41 @@ static int tcpdump(struct state *state __maybe_unused, int argc, char **argv)
   
   COMMAND(SUBCOMMAND, tcpdump, "td", 0, NULL,
   	"<interface>       \ttcpdump layer 2 traffic on the given interface");
  +
  +__AFL_FUZZ_INIT();
  +
  +static int fuzzme(struct state *state __maybe_unused, int argc, char **argv)
  +{
  +	dump_level = dump_level_all;
  +
  +#ifdef __AFL_HAVE_MANUAL_CONTROL
  +	__AFL_INIT();
  +#endif
  +
  +	unsigned char *buf = __AFL_FUZZ_TESTCASE_BUF;
  +	while (__AFL_LOOP(10000)) {
  +		int len = __AFL_FUZZ_TESTCASE_LEN;
  +
  +		/* safety check from tcpdump */
  +		if ((size_t)len < sizeof(struct ether_header))
  +			continue;
  +
  +		/* move into new buffer to allow ASAN to detect invalid memory access */
  +		unsigned char *p = malloc(len);
  +		if (!p)
  +			continue;
  +
  +		memcpy(p, buf, len);
  +
  +		/* function under test */
  +		parse_eth_hdr(p, len, 0, 0);
  +
  +		/* drop buffer from asan */
  +		free(p);
  +	}
  +
  +	return 0;
  +}
  +
  +COMMAND(SUBCOMMAND, fuzzme, "fz", 0, NULL,

To build the fuzzing test, it is necessary to build batctl slightly
differently:

  make clean
  export AFL_USE_ASAN=1; CC=afl-clang-fast make V=s

And the some input files (containing raw ethernet fames have to be
generated from existing pcaps):

  mkdir in
  cd in
  ../split_pcap.py ~/wireshark-batman-adv/tests/*
  cd ..

And then multiple afl++ fuzzer instances can be started.

  if [ -z "${STY}" ]; then
      echo "must be started inside a screen session" >&2
      exit 1
  fi

  for i in $(seq 1 $(nproc)); do
      start_mode=-M
      [ "${i}" = "1" ] || start_mode=-S
      screen afl-fuzz "${start_mode}" "fuzzer${i}" -i in -o out ./batctl fuzzme
  done

The crashes can then be analyzed further by sending them to the fuzzme
subcommand:

   ./batctl fuzzme < out/fuzzer1/crashes/id:000000,sig:06,src:000528,time:12,execs:23992,op:havoc,rep:8

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (6):
      batctl: tcpdump: Fix missing sanity check for batman-adv header
      batctl: tcpdump: Add missing throughput header length check
      batctl: tcpdump: Fix IPv4 header length check
      batctl: tcpdump: Add missing ICMPv6 Neighbor Advert length check
      batctl: tcpdump: Add missing ICMPv6 Neighbor Solicit length check
      batctl: tcpdump: Fix ICMPv4 inner IPv4 header length check

 tcpdump.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)
---
base-commit: a57de3183e67ec27cf96f1761e69d542e6dfac03
change-id: 20240127-tcpdump_fuzzing-736774906f60

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

