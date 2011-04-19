Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
Date: Tue, 19 Apr 2011 09:39:38 +0200
Message-ID: <BANLkTin=6SArq_5+n7SMRHfX2p-RGgsomA@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] batman-adv vis_data
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

Hi!

In Pisa we are switching to batman-adv for our mesh, we use the
version packaged in openwrt.

But it seems that the output of vd is not conform to specification in
this page  http://www.open-mesh.org/wiki/batman-adv/VisAdv

especially the box representing a node is painted only for the node
where you call 'batctl vd dot'

here you can see what is happening
http://eigenlab.org/batman-adv_status.php to simplify visualization i
am generating it with 'batctl vd dot -H'
