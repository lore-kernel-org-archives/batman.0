Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  7 May 2013 14:51:00 +0200
Message-Id: <1367931069-7177-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/9] Adding size relevant build options
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

Hi,

I was talking with Marek and Simon about build options which may be size
relevant. The first change is to allow the linker to check for unused code
sections. The second change is to let the compiler use get the whole source
code instead of only one source file during the final compilation step (ok,
it is originally the link step).

These changes reduce the size on an amd64 (default Debian settings with -O2) by
around 25%. The size reduction on MIPSel (default OpenWRT settings with -Os)
were only by 6%-10%. Marek were still interested and asked me to submit the
changes.

Kind regards,
	Sven
