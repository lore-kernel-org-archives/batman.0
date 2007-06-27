Message-ID: <48330.85.41.146.90.1182957677.squirrel@krisma.oltrelinux.com>
Date: Wed, 27 Jun 2007 17:21:17 +0200 (CEST)
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman FONera - kamikaze
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

For what concerns ponte2 on Kamikaze the script crash the kernel: maybe
it's due to the dual SSID used by ponte2 when onfigured as repeater AP
(Kamikaze doesn't support dual SSID ?).
mesh-ponte2 use only one SSID for the VAP bat_AP (VAP acting as batman
client works in pseudo-IBSS so no SSID is needed) and maybe it can works
on Kamikaze.
However I have never tested ponte2 scripts on OpenWRT.

--
Antonio


