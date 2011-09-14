Return-Path: <clownix@clownix.net>
Message-ID: <c3913757cea624537f48fb88fb60e913.squirrel@clownix.net>
Date: Wed, 14 Sep 2011 18:43:36 -0500
From: clownix@clownix.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] lxc and batman
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

Hello,
I was wondering if the batman code in the kernel make batman not
compatible with lxc.

Lxc are the linux containers that permit to have virtual machines with the
least overhead (native speed) but those machines use the host's kernel.
If you know openvz, lxc is the same technology.

It would be nice to be able to have lxc compatible with batman so as to
test big networks on a single machine.

Vincent
