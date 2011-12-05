Return-Path: <andrew@lunn.ch>
Date: Mon, 5 Dec 2011 15:25:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111205142553.GE10131@lunn.ch>
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<201112051935.06611.lindner_marek@yahoo.de>
	<20111205121342.GD10131@lunn.ch>
	<201112052138.55069.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201112052138.55069.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] switch routing algorithm at runtime
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

> The mesh is not going down when you bring down bat0. You can do whatever you 
> want with bat0 - the mesh continues to operate normally. Only when a hard-
> interface goes down the routing information relying on that very interface are 
> purged.

Ah, O.K. My understanding was wrong.
 
> Here comes the chicken & egg problem: We can't have bat0 and its routing 
> algorithm selection before we did not add at least one hard-interface.

Lets see if i have the call chain correct:

store_mesh_iface()->hardif_enable_interface()->softif_create()->mesh_init()

It is mesh_init() that really starts the mesh going, but there is no
real need to start it until the first hard interface is added.

So maybe we could spit this into two separate operations.

1) Create the software interface
2) Add a hard interface and start the mesh, if not already started.

So maybe two new sysfs files are needed:

/sys/class/net/batman_adv/add_mesh
/sys/class/net/batman_adv/rm_mesh

echo the name of a soft interface, bat0, into the add_mesh file and
the softif_create() function would be called for it, but not
mesh_init(). 

hardif_enable_interface() would see if the soft interface exists, as
it currently does, so keeping backwards compatibility. If it does not
exist, call softif_create. Then check if the soft interface has been
started. Maybe add another atomic to priv, started, which mesh_init()
can increment.

    Andrew
