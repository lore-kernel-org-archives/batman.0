Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
Date: Thu, 28 Jul 2011 14:31:49 +0200
Message-ID: <CAOaDhSSaTKxP96NfHhv+aBDjOE9sm4u1fpJGoegcHeXKnsJ-Rw@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] per interface hop penalty
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hey all reading batman-adv documentation I have found the option hop
penalty that seems quite good for example with vpn links

The problem is that actual hop penalty is per node but not per
interface, the fact to have per interface hop penalty could be useful
on nodes that have both vpn and real interface and someone want to
penalize only vpn interfaces

it is possible to have that implemented soon ?

Very
