Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Sep 2018 12:34:35 +0200
Message-ID: <4468372.sfybEcOXZU@bentobox>
In-Reply-To: <aa797db.cdf1.165a3d64b19.Coremail.heishuihe2008@163.com>
References: <2791173.mX5NbDZpiX@sven-edge> <3183122.uSX0CgPaFQ@bentobox>
 <aa797db.cdf1.165a3d64b19.Coremail.heishuihe2008@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5713340.zuBx1cm1xP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] mcast_rate setting of wifi interface has
 significant effect to performance of V. Re:Re: Recent test result. Re:Re:
 Paper "Performance Evaluation of BATMAN-adv Wireless Mesh Network Routing
 Algorithms "
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc
Cc: Ligang LIU <heishuihe2008@163.com>, mareklindner@neomailbox.ch, b.a.t.m.a.n@lists.open-mesh.org

--nextPart5713340.zuBx1cm1xP
Content-Type: multipart/mixed; boundary="nextPart4958113.UqVHbB48dm"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart4958113.UqVHbB48dm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 4. September 2018 17:07:34 CEST Ligang LIU wrote:
[...]
> I captured frames with tcpdump and found somethings.
[..]
> The pcap files are attached in this email.
> I'm not sure whether it's proper to send them to the mailinglist,
> so I don't cc this email to the mailinglist.

The mails would have been held back and I might not have accepted them due to 
the size of the attachments. So you did everything right.

I have now added the mailing list again to the Cc

> First, there are many ELP unicast packets.
> 
> Second, there are many RTS/CTS/ACK. 
> When a node wants to send ELP unicast packets to a weak neighbor, this will happen frequently.
> While in batman-adv 4, there is only a very small amount of RTS/CTS frames.

Ack

> Third, change elp interval from 500 to 1000 will decrease ELP unicast packets
> but it does not decrease RTS/CTS too much.

Shouldn't the number of probes be reduced and thus also the RTS? It is
something which the wifi layer handles - not batman-adv.

And the duration of the RTS frames seem to be rather high (I don't say that 
these are wrong) when I've looked through the dump via

   (wlan.fc.type_subtype == 0x001b) || ((llc.type == 0x4305) && (data.data[0] == 03))

Maybe someone can check whether they make sense or not (don't have the time 
right now to do it).

> Although Antonio explained in the previous email,
> "... if you have no data over the link, sending 2 probes of
> 200bytes each every 500ms (default ELP interval) won't really eat much
> airtime, unless you have a lot of idling 1-hop neighbours",
> I think the ELP probe packets will occupy much wifi airtime,
> because wlan is working on the SHARED media.
> The transmission of ELP probe packets between idle 1-hop neighbours
> can be heard by the other nodes and their transmission have to be delayed.
> Consequently, the performance, delay and throughput, could be lowered down,
> compared to batman-adv 4.

@Antonio, you must also keep in mind that the RTS + CTS frames are transmitted 
at the lowest available rate (1Mbit/s in this case). The Ack is done with 
6Mbit/s in his dump. The broadcast is done with 18Mbit/s. The unicast stuff 
seems to be send with MCS rates.

The RTS+CTS will therefore use an amazing high number of airtime (but I didn't 
do the calculations). Attached are some estimates using Dave Taht's airtime-
pie-chart fork [1] + a modification to show the transmitter and not the 
destination host. And these numbers are the raw ones - not normalized in any 
way (so not directly comparable). Don't forget that these also don't take the
duration field of the RTS into account.

[...]
> And, my wireshrk (windows, v2.6.3) can not analize the batman-adv 5 packet.
> I find a wireshark code for batman-adv:
> https://github.com/wireshark/wireshark/blob/master/epan/dissectors/packet-batadv.c
> Is it for batman-adv 4 only?
> Do you know any plugin to do this?

It only support B.A.T.M.A.N. IV frames of different version. Feel free to 
submit the ELP and OGM2 support to wireshark (this is not necessarily directed 
to Ligang but to everyone).

Kind regards,
	Sven

[1] https://github.com/dtaht/airtime-pie-chart
--nextPart4958113.UqVHbB48dm
Content-Disposition: attachment; filename="airtime_analyzer.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="airtime_analyzer.patch"

diff --git a/airtime_analyzer.cpp b/airtime_analyzer.cpp
index ad425f2..c98b04b 100644
--- a/airtime_analyzer.cpp
+++ b/airtime_analyzer.cpp
@@ -21,8 +21,8 @@
 using namespace std;
 
 /* config options (for debugging) */
-//#define DETAILED_OUTPUT
-//#define DETAILED_OUTPUT_EXTRA
+#define DETAILED_OUTPUT
+#define DETAILED_OUTPUT_EXTRA
 
 struct radiotap_header {
 	uint8_t it_version;
@@ -36,9 +36,11 @@ struct ieee80211_hdr {
 	uint16_t duration_id;
 	uint8_t addr1[6];
 	uint8_t addr2[6];
+	/*
 	uint8_t addr3[6];
 	uint16_t seq_ctrl;
 	uint8_t addr4[6];
+	*/
 } __attribute__ ((packed));
 
 #define IEEE80211_FCTL_FTYPE 0x0c00
@@ -422,10 +424,7 @@ static void pcap_copy_handler(u_char *user, const struct pcap_pkthdr *h, const u
 	//if ((fc & IEEE80211_FCTL_FTYPE) != IEEE80211_FTYPE_DATA)
 	//	return;
 
-	if (fc & IEEE80211_FCTL_TODS)
-		memcpy(dhost.mac, wifihdr->addr3, 6);
-	else
-		memcpy(dhost.mac, wifihdr->addr1, 6);
+	memcpy(dhost.mac, wifihdr->addr2, 6);
 
 	it = macmap.find(dhost);
 	if (it == macmap.end()) {

--nextPart4958113.UqVHbB48dm
Content-Disposition: attachment; filename="mon0batman4.0903.pcap.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="mon0batman4.0903.pcap.txt"

00:00:0d:18:08:01 249
	rate: 18M: 249 (22704ms)
	duration: 22704ms
00:00:0d:18:08:02 302
	rate: 18M: 302 (28304ms)
	duration: 28304ms
00:00:0d:18:08:04 238
	rate: 18M: 238 (23800ms)
	duration: 23800ms
00:00:0d:18:08:05 289
	rate: 18M: 289 (27140ms)
	duration: 27140ms
00:00:0d:18:08:06 300
	rate: 18M: 300 (28308ms)
	duration: 28308ms
00:00:0d:18:08:07 277
	rate: 18M: 277 (25716ms)
	duration: 25716ms
00:03:7f:95:31:39 18
	rate: 1M: 18 (37332ms)
	duration: 37332ms
2c:6e:85:a7:88:c5 4
	rate: 1M: 4 (3368ms)
	duration: 3368ms
48:7d:2e:7c:b1:ed 234
	rate: 1M: 234 (457236ms)
	duration: 457236ms
ac:cf:23:e9:e2:58 6
	rate: 1M: 6 (3756ms)
	duration: 3756ms
bc:3d:85:99:5d:f8 78
	rate: 1M: 78 (177228ms)
	duration: 177228ms
da:a1:19:6c:d9:bd 1
	rate: 1M: 1 (1090ms)
	duration: 1090ms

--nextPart4958113.UqVHbB48dm
Content-Disposition: attachment; filename="mon0batman5elp1000.0903.pcap.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="mon0batman5elp1000.0903.pcap.txt"

00:00:0d:18:08:01 215
	rate: 1M: 17 (6698ms)
	rate: 6M: 25 (2200ms)
	rate: 12M: 14 (896ms)
	rate: 18M: 50 (4152ms)
	rate: 24M: 6 (312ms)
	mcs: 0, width: 20, GI: LGI: 38 (6384ms)
	mcs: 2, width: 20, GI: LGI: 18 (1440ms)
	mcs: 0, width: 40, GI: LGI: 1 (184ms)
	mcs: 0, width: 20, GI: SGI: 1 (308ms)
	mcs: 1, width: 20, GI: SGI: 20 (3440ms)
	mcs: 2, width: 20, GI: SGI: 23 (2944ms)
	mcs: 2, width: 40, GI: SGI: 2 (280ms)
	duration: 29238ms
00:00:0d:18:08:02 329
	rate: 1M: 65 (25610ms)
	rate: 12M: 1 (64ms)
	rate: 18M: 85 (7416ms)
	rate: 24M: 24 (1248ms)
	mcs: 0, width: 20, GI: LGI: 118 (19824ms)
	mcs: 9, width: 20, GI: LGI: 1 (72ms)
	mcs: 10, width: 20, GI: LGI: 4 (240ms)
	mcs: 0, width: 40, GI: LGI: 2 (368ms)
	mcs: 10, width: 40, GI: LGI: 1 (64ms)
	mcs: 0, width: 20, GI: SGI: 1 (308ms)
	mcs: 3, width: 20, GI: SGI: 1 (104ms)
	mcs: 4, width: 20, GI: SGI: 19 (1596ms)
	mcs: 10, width: 20, GI: SGI: 5 (420ms)
	mcs: 0, width: 40, GI: SGI: 2 (680ms)
	duration: 58014ms
00:00:0d:18:08:03 87
	rate: 1M: 87 (34278ms)
	duration: 34278ms
00:00:0d:18:08:04 101
	rate: 18M: 101 (10100ms)
	duration: 10100ms
00:00:0d:18:08:05 309
	rate: 1M: 40 (15760ms)
	rate: 6M: 29 (2552ms)
	rate: 12M: 27 (1728ms)
	rate: 18M: 70 (5916ms)
	rate: 24M: 9 (468ms)
	mcs: 0, width: 20, GI: LGI: 83 (13944ms)
	mcs: 2, width: 20, GI: LGI: 6 (480ms)
	mcs: 4, width: 20, GI: LGI: 1 (60ms)
	mcs: 9, width: 20, GI: LGI: 16 (1152ms)
	mcs: 0, width: 40, GI: LGI: 1 (184ms)
	mcs: 2, width: 40, GI: LGI: 2 (176ms)
	mcs: 0, width: 20, GI: SGI: 3 (924ms)
	mcs: 2, width: 20, GI: SGI: 12 (1536ms)
	mcs: 8, width: 20, GI: SGI: 1 (172ms)
	mcs: 9, width: 20, GI: SGI: 2 (208ms)
	mcs: 0, width: 40, GI: SGI: 2 (680ms)
	mcs: 2, width: 40, GI: SGI: 3 (420ms)
	mcs: 9, width: 40, GI: SGI: 2 (224ms)
	duration: 46584ms
00:00:0d:18:08:06 246
	rate: 1M: 14 (5516ms)
	rate: 6M: 9 (792ms)
	rate: 12M: 19 (1216ms)
	rate: 18M: 78 (6692ms)
	rate: 24M: 8 (416ms)
	mcs: 0, width: 20, GI: LGI: 46 (7728ms)
	mcs: 1, width: 20, GI: LGI: 20 (2080ms)
	mcs: 2, width: 20, GI: LGI: 28 (2240ms)
	mcs: 0, width: 40, GI: LGI: 1 (184ms)
	mcs: 1, width: 40, GI: LGI: 1 (112ms)
	mcs: 0, width: 20, GI: SGI: 1 (308ms)
	mcs: 1, width: 20, GI: SGI: 1 (172ms)
	mcs: 2, width: 20, GI: SGI: 16 (2048ms)
	mcs: 4, width: 20, GI: SGI: 1 (84ms)
	mcs: 0, width: 40, GI: SGI: 2 (680ms)
	mcs: 2, width: 40, GI: SGI: 1 (140ms)
	duration: 30408ms
00:00:0d:18:08:07 264
	rate: 1M: 2 (788ms)
	rate: 12M: 24 (1536ms)
	rate: 18M: 97 (8080ms)
	rate: 24M: 18 (936ms)
	mcs: 2, width: 20, GI: LGI: 20 (1600ms)
	mcs: 4, width: 20, GI: LGI: 4 (240ms)
	mcs: 6, width: 20, GI: LGI: 22 (1144ms)
	mcs: 7, width: 20, GI: LGI: 5 (260ms)
	mcs: 8, width: 20, GI: LGI: 1 (104ms)
	mcs: 10, width: 20, GI: LGI: 13 (780ms)
	mcs: 13, width: 20, GI: LGI: 1 (48ms)
	mcs: 2, width: 40, GI: LGI: 1 (88ms)
	mcs: 4, width: 40, GI: LGI: 1 (64ms)
	mcs: 10, width: 40, GI: LGI: 3 (192ms)
	mcs: 4, width: 20, GI: SGI: 8 (672ms)
	mcs: 5, width: 20, GI: SGI: 1 (72ms)
	mcs: 6, width: 20, GI: SGI: 1 (68ms)
	mcs: 10, width: 20, GI: SGI: 19 (1596ms)
	mcs: 14, width: 20, GI: SGI: 1 (52ms)
	mcs: 15, width: 20, GI: SGI: 19 (988ms)
	mcs: 6, width: 40, GI: SGI: 1 (72ms)
	mcs: 10, width: 40, GI: SGI: 2 (176ms)
	duration: 19556ms
00:03:7f:95:31:39 2
	rate: 1M: 2 (4148ms)
	duration: 4148ms
48:7d:2e:7c:b1:ed 100
	rate: 1M: 100 (195400ms)
	duration: 195400ms
b8:76:3f:a6:30:81 3
	rate: 1M: 3 (3774ms)
	duration: 3774ms
bc:3d:85:99:5d:f8 24
	rate: 1M: 24 (54576ms)
	duration: 54576ms

--nextPart4958113.UqVHbB48dm
Content-Disposition: attachment; filename="mon0batman5elp500.0903.pcap.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="mon0batman5elp500.0903.pcap.txt"

00:00:0d:18:08:01 272
	rate: 1M: 45 (17730ms)
	rate: 6M: 16 (1408ms)
	rate: 12M: 26 (1664ms)
	rate: 18M: 25 (1896ms)
	rate: 24M: 8 (416ms)
	mcs: 0, width: 20, GI: LGI: 71 (11928ms)
	mcs: 1, width: 20, GI: LGI: 1 (104ms)
	mcs: 2, width: 20, GI: LGI: 28 (2240ms)
	mcs: 0, width: 40, GI: LGI: 3 (552ms)
	mcs: 0, width: 20, GI: SGI: 2 (616ms)
	mcs: 2, width: 20, GI: SGI: 39 (4992ms)
	mcs: 8, width: 20, GI: SGI: 2 (344ms)
	mcs: 0, width: 40, GI: SGI: 5 (1700ms)
	mcs: 2, width: 40, GI: SGI: 1 (140ms)
	duration: 45730ms
00:00:0d:18:08:02 273
	rate: 1M: 20 (7880ms)
	rate: 6M: 17 (1496ms)
	rate: 18M: 70 (6012ms)
	rate: 24M: 35 (1820ms)
	mcs: 0, width: 20, GI: LGI: 66 (11088ms)
	mcs: 3, width: 20, GI: LGI: 1 (72ms)
	mcs: 9, width: 20, GI: LGI: 17 (1224ms)
	mcs: 0, width: 40, GI: LGI: 4 (736ms)
	mcs: 0, width: 20, GI: SGI: 5 (1540ms)
	mcs: 3, width: 20, GI: SGI: 26 (2704ms)
	mcs: 9, width: 20, GI: SGI: 4 (416ms)
	mcs: 0, width: 40, GI: SGI: 5 (1700ms)
	mcs: 9, width: 40, GI: SGI: 2 (224ms)
	mcs: 10, width: 40, GI: SGI: 1 (88ms)
	duration: 37000ms
00:00:0d:18:08:03 69
	rate: 1M: 69 (27186ms)
	duration: 27186ms
00:00:0d:18:08:04 67
	rate: 18M: 67 (6700ms)
	duration: 6700ms
00:00:0d:18:08:05 329
	rate: 1M: 25 (9850ms)
	rate: 6M: 25 (2200ms)
	rate: 12M: 21 (1344ms)
	rate: 18M: 51 (4172ms)
	rate: 24M: 23 (1196ms)
	mcs: 0, width: 20, GI: LGI: 70 (11760ms)
	mcs: 1, width: 20, GI: LGI: 1 (104ms)
	mcs: 2, width: 20, GI: LGI: 12 (960ms)
	mcs: 3, width: 20, GI: LGI: 5 (360ms)
	mcs: 9, width: 20, GI: LGI: 1 (72ms)
	mcs: 10, width: 20, GI: LGI: 41 (2460ms)
	mcs: 0, width: 40, GI: LGI: 1 (184ms)
	mcs: 2, width: 40, GI: LGI: 1 (88ms)
	mcs: 10, width: 40, GI: LGI: 2 (128ms)
	mcs: 0, width: 20, GI: SGI: 27 (8316ms)
	mcs: 2, width: 20, GI: SGI: 14 (1792ms)
	mcs: 3, width: 20, GI: SGI: 1 (104ms)
	mcs: 8, width: 20, GI: SGI: 1 (172ms)
	mcs: 9, width: 20, GI: SGI: 1 (104ms)
	mcs: 10, width: 20, GI: SGI: 2 (168ms)
	mcs: 0, width: 40, GI: SGI: 3 (1020ms)
	mcs: 3, width: 40, GI: SGI: 1 (112ms)
	duration: 46666ms
00:00:0d:18:08:06 274
	rate: 1M: 18 (7092ms)
	rate: 6M: 15 (1320ms)
	rate: 11M: 9 (3402ms)
	rate: 12M: 18 (1152ms)
	rate: 18M: 66 (5608ms)
	rate: 24M: 12 (624ms)
	mcs: 0, width: 20, GI: LGI: 17 (2856ms)
	mcs: 1, width: 20, GI: LGI: 25 (2600ms)
	mcs: 2, width: 20, GI: LGI: 47 (3760ms)
	mcs: 0, width: 40, GI: LGI: 4 (736ms)
	mcs: 1, width: 40, GI: LGI: 3 (336ms)
	mcs: 2, width: 40, GI: LGI: 1 (88ms)
	mcs: 0, width: 20, GI: SGI: 25 (7700ms)
	mcs: 1, width: 20, GI: SGI: 8 (1376ms)
	mcs: 0, width: 40, GI: SGI: 3 (1020ms)
	mcs: 1, width: 40, GI: SGI: 2 (376ms)
	mcs: 2, width: 40, GI: SGI: 1 (140ms)
	duration: 40186ms
00:00:0d:18:08:07 312
	rate: 1M: 2 (788ms)
	rate: 12M: 22 (1408ms)
	rate: 18M: 71 (5872ms)
	rate: 24M: 35 (1820ms)
	mcs: 4, width: 20, GI: LGI: 50 (3000ms)
	mcs: 5, width: 20, GI: LGI: 10 (560ms)
	mcs: 6, width: 20, GI: LGI: 8 (416ms)
	mcs: 9, width: 20, GI: LGI: 2 (144ms)
	mcs: 10, width: 20, GI: LGI: 10 (600ms)
	mcs: 4, width: 40, GI: LGI: 2 (128ms)
	mcs: 5, width: 40, GI: LGI: 1 (56ms)
	mcs: 6, width: 40, GI: LGI: 2 (112ms)
	mcs: 10, width: 40, GI: LGI: 1 (64ms)
	mcs: 2, width: 20, GI: SGI: 1 (128ms)
	mcs: 4, width: 20, GI: SGI: 22 (1848ms)
	mcs: 5, width: 20, GI: SGI: 15 (1080ms)
	mcs: 6, width: 20, GI: SGI: 17 (1156ms)
	mcs: 10, width: 20, GI: SGI: 2 (168ms)
	mcs: 15, width: 20, GI: SGI: 24 (1248ms)
	mcs: 4, width: 40, GI: SGI: 8 (704ms)
	mcs: 5, width: 40, GI: SGI: 2 (152ms)
	mcs: 6, width: 40, GI: SGI: 3 (216ms)
	mcs: 10, width: 40, GI: SGI: 2 (176ms)
	duration: 21844ms
00:03:7f:95:31:39 1
	rate: 1M: 1 (2074ms)
	duration: 2074ms
48:7d:2e:7c:b1:ed 66
	rate: 1M: 66 (128964ms)
	duration: 128964ms
ac:cf:23:e9:e2:58 21
	rate: 1M: 21 (13122ms)
	duration: 13122ms
bc:3d:85:99:5d:f8 30
	rate: 1M: 30 (67980ms)
	duration: 67980ms

--nextPart4958113.UqVHbB48dm--

--nextPart5713340.zuBx1cm1xP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluOX7sACgkQXYcKB8Em
e0aZDw//SdTYcuygywFOZRpFlumAQOBJbuBhBkG9yUr+bQOobmfDYMvVgAkI0Tx+
jnhKPb3uwsFdsRU0C4ytEHUUVmCOqnUFvAHXnRamhEJ3O/nio2flLE7r8ZLUgXWp
mVTF4GNb+xqV5MxNyX52+wLKgs7wmp9zH7wHwA5l3BqctQ6n1kLrAc7tMVQoh5QU
pjWTvnzqASoE3aVH77vH1RdqLBc7Bpk/1EAlyrIiHXaAPjwsk+W76UuFBaEZcg2t
/eHTM2tsXL0ww3wtI1wWq1W3/SPjplqc5tpM7Rg0XPua9QN2nIQEZO9rvMWUUjW0
MuAO8adsJw1AHORapzdPe4wqpXrMZlay3ecKHJXXwW7zv9q6RizAQv4WZKBdoNL5
F9uX9EmWjGAcb4uSFiClPMCDNOL/XviFevmPanC5SE+bV8lEybx8zY9si4RE0QQ6
t3RQuLkNmtczQk7w0vD1Q3VRhzhvvzh0wv+kzVMNtulYKpgMtEZmbpDUn1xXkSic
QH0wjOhW7nrD3CYWfqfWXwS2Ta1Ha5A3PUSRtevsG8LMk+6K/Bxi9rgeDkeXUH3A
U7j8NDFo+jiy2iAcv2EvzSDbO/BmOOXkFH9PwBDDqBAgRrgxfs+kGQPwkiWwVXT9
mG5nAV61+nEphIZg/3EKaxeHk5/77flRS0GSmi7mQdwSIe/AeQY=
=S1xw
-----END PGP SIGNATURE-----

--nextPart5713340.zuBx1cm1xP--

