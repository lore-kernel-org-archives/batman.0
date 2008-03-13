Message-ID: <1205401123.47d8f6235d1ae@mail.bluebottle.com>
Date: Thu, 13 Mar 2008 09:38:43 +0000
From: Bastian Bittorf <bittorf@bluebottle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] faulty dev-batman-adv.ipk
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

The data.tar.gz in the archive is
not build correct. All file-paths must
be relative, not absolute:

./usr/sbin/batmand-adv (at the moment)
usr/sbin/batmand-adv (correct)

At the first look that doesn't seem to be
a problem, but the packet-manager does
not accept that. The files are on the box,
but the manager thinks "not fully installed"
and an "ipkg files batman-adv" leads to
zero output.

Thanks in advance for fixing that 8-)

bye, Bastian Bittorf
