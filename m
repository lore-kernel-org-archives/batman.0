Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
Date: Fri, 19 Jun 2009 16:17:23 -0600
Message-ID: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] HTTP transfers greater than 1000 bytes fail
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: BATMAN mailing list <b.a.t.m.a.n@lists.open-mesh.net>

Two Linux boxes, each plugged in via Ethernet to a BATMAN node (two
nodes).  The nodes talk batman-advanced to each other via WiFi.  The
Linux boxes can ping each other all day long.  Both Linux boxes have
Apache running.  Downloading a file via HTTP works only if the file is
smaller than or equal to exactly 1,145 bytes.  TFTP file transfers are
halting, but they get through (4 megabytes took a couple of minutes).

This happens with both r1176 and r1298 on OpenWrt.
