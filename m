Return-Path: <thomas.tiotto@outlook.com>
Message-ID: <BLU436-SMTP19879B76605F30F2F0DC95DE32C0@phx.gbl>
From: Thomas Tiotto <thomas.tiotto@outlook.com>
Date: Wed, 22 Jun 2016 15:49:48 +0200
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] question regarding batmand convergence time
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

Good day=2C
I'm currently finishing writing my bachelor thesis whose topic is mesh
networks. =C2=A0I have been running batmand and comparing it in performance
to olsrd=3B one metric I can't seem to be able to measure=2C though=2C is
network convergence time=2C i.e.=2C the time it takes for a new node to be
discovered when connected and forgotten when disconnected from the
network. =C2=A0This is due to the fact that batmand doesn't seem to display
updated information in the same way that olsrd does (with
DebugLevel=3D2). =C2=A0I've tried looking at the routing tables but these a=
lso
aren't updated when a host disconnects and get purged after some time
has passed.
Is there any way I can get a real time view of the network to calculate
the time it takes for a host to be discovered/forgotten?

Thanks=2C

Thomas Tiotto
Universit=C3=A0 degli Studi di Milano

