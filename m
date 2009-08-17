Return-Path: <andrew.lunn@ascom.ch>
Date: Mon, 17 Aug 2009 20:36:44 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090817183644.GC20229@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] batman-adv packet.h license
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
To: lindner_marek@yahoo.de, siwu@hrz.tu-chemnitz.de
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Hi Marek, Simon

I'm writing a protocol dissector for tcpdump which understands
batman-adv packets. To do this i need to use packet.h, at least that
is the easiest way to do it. tcpdump uses the BSD license, where as
packet.h is GPL2. So it is unlikely the tcpdump maintainers would
accept packet.h as is.

As the two copyright owners of this file, is it O.K. with you to if i
change the license on this one file in my tcpdump patch to use BSD?

       Thanks
          Andrew
