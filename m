Return-Path: <post@tiwoc.de>
Message-ID: <4BF55C08.7010704@tiwoc.de>
Date: Thu, 20 May 2010 17:58:00 +0200
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Correct mdev calculation in ping
	subcommand
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Fixes the calculation of the mean absolute deviation (mdev)
of the roundtrip times. mdev was previously calculated by
computing the difference of maximum and minimum round trip times.

The calculation is now done using the same formula as in the iputils
ping program.

Signed-off-by: Daniel Seither <post@tiwoc.de>
---
Index: ping.c
===================================================================
--- ping.c	(revision 1659)
+++ ping.c	(working copy)
@@ -76,7 +76,7 @@
 	unsigned int seq_counter = 0, packets_out = 0, packets_in = 0, packets_loss;
 	char *dst_string, *mac_string, *rr_string;
 	double time_delta;
-	float min = 0.0, max = 0.0, avg = 0.0;
+	float min = 0.0, max = 0.0, avg = 0.0, mdev = 0.0;
 	uint8_t last_rr_cur = 0, last_rr[BAT_RR_LEN][ETH_ALEN];
 	size_t packet_len;

@@ -260,6 +260,7 @@
 			if (time_delta > max)
 				max = time_delta;
 			avg += time_delta;
+			mdev += time_delta * time_delta;
 			packets_in++;
 			break;
 		case DESTINATION_UNREACHABLE:
@@ -289,11 +290,20 @@
 	else
 		packets_loss = ((packets_out - packets_in) * 100) / packets_out;

+	if (packets_in) {
+		avg /= packets_in;
+		mdev /= packets_in;
+		mdev = sqrt(mdev - avg * avg);
+	} else {
+		avg = 0.0;
+		mdev = 0.0;
+	}
+
 	printf("--- %s ping statistics ---\n", dst_string);
 	printf("%u packets transmitted, %u received, %u%% packet loss\n",
 		packets_out, packets_in, packets_loss);
 	printf("rtt min/avg/max/mdev = %.3f/%.3f/%.3f/%.3f ms\n",
-		min, (packets_in ? (avg / packets_in) : 0.000), max, (max - min));
+		min, avg, max, mdev);

 	ret = EXIT_SUCCESS;

