MIME-Version: 1.0
In-Reply-To: <5161afcd0906120821w5698c18ag7b993869377e3d61@mail.gmail.com>
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<5161afcd0906111112p2cf55955o757f87dc6f75cb41@mail.gmail.com>
	<5161afcd0906111246y446d9bc4hf145a3423ff6653e@mail.gmail.com>
	<200906121913.40206.lindner_marek@yahoo.de>
	<5161afcd0906120821w5698c18ag7b993869377e3d61@mail.gmail.com>
Date: Fri, 12 Jun 2009 11:19:51 -0600
Message-ID: <5161afcd0906121019w4ec402a2ged0c622013515ea6@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman advanced in openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Some of my nodes cannot see each other...  For example, node 1 can
battool ping node 2, but node 2 cannot battool ping node 1.  All nodes
have the following:

With log_level = 11:
"cat ath0 > /proc/net/batman-adv/interfaces"
produces:
"Can't activate module: the primary interface is not active"

The node that can ping out, but not be pinged gave the following before it died:

"Could not read from deactivated interface <NULL>!"

I have looked at the source code, and I can see where these log
messages come from, but nothing else in there makes sense to me.  And
now it looks like it's working again.  This is with all of the
interfaces in ahdemo mode.
