Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 30 Nov 2009 07:36:51 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200911300736.51646.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman's new configuration interface
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
To: b.a.t.m.a.n@lists.open-mesh.net


Hey folks,

I have given the new interface (designed in Brussels - specs are at the bottom 
of this page: http://www.open-mesh.net/wiki/2009-10-23-batman-goes-mainline) a 
little bit of thought. The main idea is to have batman list all available 
interfaces inside of /proc/sys/net/batman-adv/interfaces to let the user 
enable/disable/configure each interface individually via sysctl or batctl.

Back then we decided to create a "mesh" folder that should contain all 
relevant meshing data such as the originator table, translation tables, vis 
data, etc. We did not consider that the sysctl interface is not made for such 
data. It easily allows to set small variables but other (read-only) 
information should be placed elsewhere.

Now, we have to rethink the location. The creator of the new interface (Linus) 
suggested to create 2 folders inside of /proc: The first folder should be part 
of sysctl and contain all files that are writeable. The other should be 
/proc/net/batman-adv and contains all read-only information.
Alternatively, we could keep everything in one folder but outside of the 
sysctl interface.

Other ideas ? Opinions ?

Regards,
Marek

