MIME-Version: 1.0
Date: Tue, 19 May 2009 09:27:25 -0500
Message-ID: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Kernel crashes with batgat installed
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <B.A.T.M.A.N@open-mesh.net>

I am using batman 1256 on a very recent openwrt (linux version
2.6.28.10) as well as a bit older one (linux version 2.6.26.8).

With batgat installed, I have problems with the kernel crashing when
turning the gateway on and off.  I start batman with -r 2.  If I
detect an uplink, I issue -c -g 11000.  If I lose the link, I issue -c
-r 2.  It is this final -c -r 2 that causes the kernel to either crash
with a bad page on the next process that is created, have a null
pointer error, or have a recursion error.

If I run batman without batgat, I don't get any crashes.

Everything works fine otherwise.  Except one thing that just came to
mind, I had to remove -DDEBUG_MALLOC -DMEMORY_USAGE because batman
wouldn't do anything without crashing because of magic number
problems.  Could this be because I am on Big Endian hardware?

Could anyone else see if they have the same problem?  All you have to
do is have batman running with batgat installed, start issuing batmand
-c -g 11000 ; batmand -c -r 2 multiple times and see if their system
stays stable.

Thanks.
