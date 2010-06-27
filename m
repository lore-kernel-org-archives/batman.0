Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 27 Jun 2010 02:32:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201006270232.48439.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv debug logging (v2)
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
To: b.a.t.m.a.n@lists.open-mesh.org


Hi,

I worked through the received feedback (thanks!) my first set of patches 
provoked and improved the code. The following changes have been made:
* the log level no longer is a global variable and can be configured for each 
mesh individually
* the "unused variable" warnings have been eliminated
* now dead batctl code has been removed

I also considered making the debug log available via the standard kernel 
logging facilities but right now I can only see little value in this feature. 
We can still add it as soon as somebody complains.

Unless there are futher comments I will go ahead and commit the changes.

Regards,
Marek

