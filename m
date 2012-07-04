Return-Path: <martin@hundeboll.net>
Message-ID: <4FF4CAC3.5090106@hundeboll.net>
Date: Thu, 05 Jul 2012 00:59:15 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050004070300020906080906"
Subject: [B.A.T.M.A.N.] tt log
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is a multi-part message in MIME format.
--------------050004070300020906080906
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Antonio

I encountered the tt loop in kvm this evening, so I captured some tiny logs for you. The topology is a small chain:
n1 <-> n2 <-> n3 <-> n4

The nodes run clean batman-adv from master (5deb69f60f388055982a1da6dce876049f86841d) with no catwoman or whatever compiled in :)

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net

--------------050004070300020906080906
Content-Type: text/x-log;
 name="n1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="n1.log"

root@n1:/# [   17.980968] batman_adv: bat0: Adding interface: eth0
[   17.982191] batman_adv: bat0: Interface activated: eth0
[   18.109976] batman_adv: bat0: fragmentation: Changing from: enabled to: disabled
[   18.112955] batman_adv: bat0: log_level: Changing from: 0 to: 4

root@n1:/# batctl log
[4294688626] Creating new global tt entry: 5a:9b:03:86:07:21 (via fe:fe:00:0a:02:01)
[4294690286] Creating new global tt entry: a2:8d:c2:0e:e8:80 (via fe:fe:00:0a:03:01)
[4294690316] Routing TT_RESPONSE to n3 [.]
[4294690326] Routing TT_RESPONSE to n3 [.]
[4294690326] Routing TT_RESPONSE to n3 [.]
[4294690326] Routing TT_RESPONSE to n3 [.]
[4294690326] Routing TT_RESPONSE to n3 [.]
[4294690336] Routing TT_RESPONSE to n3 [.]
[4294690336] Routing TT_RESPONSE to n3 [.]
[4294690336] Routing TT_RESPONSE to n3 [.]
[4294690336] Routing TT_RESPONSE to n3 [.]
[4294690336] Routing TT_RESPONSE to n3 [.]
[4294690336] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690346] Routing TT_RESPONSE to n3 [.]
[4294690356] Routing TT_RESPONSE to n3 [.]
[4294690356] Routing TT_RESPONSE to n3 [.]
[4294692416] Routing TT_RESPONSE to n4 [.]
[4294692426] Routing TT_RESPONSE to n4 [.]
[4294692426] Routing TT_RESPONSE to n4 [.]
[4294692426] Routing TT_RESPONSE to n4 [.]
[4294692426] Routing TT_RESPONSE to n4 [.]
[4294692426] Routing TT_RESPONSE to n4 [.]
[4294692426] Routing TT_RESPONSE to n4 [.]
[4294692426] Routing TT_RESPONSE to n4 [.]
[4294692426] Routing TT_RESPONSE to n4 [.]
[4294692426] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692436] Routing TT_RESPONSE to n4 [.]
[4294692736] TT inconsistency for fe:fe:00:0a:04:01. Need to retrieve the correct information (ttvn: 1 last_ttvn: 0 crc: 47084 last_crc: 0 num_changes: 0)
[4294692736] Sending TT_REQUEST to n4 via n2 [.]
a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294692786] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294692786] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693366] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693366] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294693376] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294693376] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694036] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694036] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694046] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694046] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694046] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694046] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694066] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694066] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694066] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694066] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694066] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694066] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694066] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694066] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694066] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694066] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694066] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694066] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694066] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694066] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694066] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694066] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694066] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694066] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01)
[4294694076] Received TT_RESPONSE from n4 for ttvn 1 t_size: 1 [.]
[4294694076] Creating new global tt entry: b6:95:47:cf:29:75 (via fe:fe:00:0a:04:01

--------------050004070300020906080906
Content-Type: text/x-log;
 name="n2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="n2.log"

root@n2:/# [   17.990957] batman_adv: bat0: Adding interface: eth0
[   17.992282] batman_adv: bat0: Interface activated: eth0
[   18.115544] batman_adv: bat0: fragmentation: Changing from: enabled to: disabled
[   18.118179] batman_adv: bat0: log_level: Changing from: 0 to: 4
root@n2:/# batctl log
:0a:01:01 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692696] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692706] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692716] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]
[4294692726] Routing TT_RESPONSE to n1 [.]

--------------050004070300020906080906
Content-Type: text/x-log;
 name="n3.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="n3.log"

root@n3:/# [   17.282255] batman_adv: bat0: Adding interface: eth0
[   17.285191] batman_adv: bat0: Interface activated: eth0
[   17.416937] batman_adv: bat0: fragmentation: Changing from: enabled to: disabled
[   17.419506] batman_adv: bat0: log_level: Changing from: 0 to: 4

root@n3:/# batctl log
:0a:01:01 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691396] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691406] Routing TT_RESPONSE to n1 [.]
[4294691416] Routing TT_RESPONSE to n1 [.]
[4294691416] Routing TT_RESPONSE to n1 [.]
[4294691416] Routing TT_RESPONSE to n1 [.]
[4294691416] Routing TT_RESPONSE to n1 [.]
[4294691416] Routing TT_RESPONSE to n1 [.]
[4294691416] Routing TT_RESPONSE to n1 [.]
[4294691416] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691426] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]
[4294691436] Routing TT_RESPONSE to n1 [.]

--------------050004070300020906080906
Content-Type: text/x-log;
 name="n4.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="n4.log"

root@n4:/# [   17.132166] batman_adv: bat0: Adding interface: eth0
[   17.143990] batman_adv: bat0: Interface activated: eth0
[   17.268470] batman_adv: bat0: fragmentation: Changing from: enabled to: disabled
[   17.271378] batman_adv: bat0: log_level: Changing from: 0 to: 4

root@n4:/# batctl log
:0a:01:01 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690886] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690896] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]
[4294690906] Routing TT_RESPONSE to n1 [.]

--------------050004070300020906080906--
