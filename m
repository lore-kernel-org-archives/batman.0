Message-ID: <38331.85.41.146.90.1187693478.squirrel@krisma.oltrelinux.com>
Date: Tue, 21 Aug 2007 12:51:18 +0200 (CEST)
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] robin
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

Hi,

I'm using BATMAN routing algorithm on an kamikaze based firwmare,
realizing ROBIN (Routing Batman Inside) MESH: a 0-config, QoS capable mesh
software which targets Atheros AP51 devices such as Meraki Mini or Fonera.

As soon as flashed, mini-routers act as mesh-network appliances: all you
need is power-on the devices and connect almost one of these to a xDSL
DHCP capable router; users in the mesh cloud can associate with mesh nodes
APs (open and WPA-PSK protected ones) and start browsing. ROBIN comes also
with a precofigured NoDogSplash release offering firewalling and
throttling.

If you want test the ROBIN download it (images and docs) from:
http://sourceforge.net/projects/ponte2/
the tarball contains the kernel (vmlinux.gz .lzma) and the root filesystem
(jffs2-64k) needed for flashing Meraki Mini and Fonera.

Many thanks to all for suggestions, reports and bug divering!


--
Antonio
a.anselmi(at)oltrelinux(dot)com
www.blogin.it




