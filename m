Return-Path: <andrew.lunn@ascom.ch>
Date: Fri, 17 Jul 2009 09:59:43 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090717075943.GX19071@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] battools sources in SVN?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hi Folks

The wiki page: http://open-mesh.org/wiki/Download says:

# svn co http://downloads.open-mesh.net/svn/batman/trunk/
# battool (for B.A.T.M.A.N. advanced): check out the complete
  repository, cd into battool (we're using symlinks here ...)

I have a complete checkout of trunk, but there is no battool
directory:

batman/trunk$ svn info
Path: .
Repository Root: http://downloads.open-mesh.net/svn/batman
Repository UUID: 45894c77-fb22-0410-b583-ff6e7d5dbf6c
Revision: 1347
Node Kind: directory
Schedule: normal
Last Changed Author: marek
Last Changed Rev: 1347
Last Changed Date: 2009-07-16 15:15:54 +0200 (Thu, 16 Jul 2009)

batman/trunk$ ls
batctl  batman-adv-kernelland  batman-experimental
batman  batman-debug4.pl       vis

batman/trunk$ find . -name battool*
batman/trunk$

Where have the source for battool gone?

      Thanks
        Andrew
