Return-Path: <andrew@lunn.ch>
Date: Mon, 18 Jan 2010 12:39:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100118113954.GC7844@lunn.ch>
References: <20100118112706.91160@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100118112706.91160@gmx.net>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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

> The problem comes when I try to add my little ARM based linux box
> onto the group. Again same sources used (latest stable from the
> wiki), crosscompiles fine and I can load the module as normal on the
> box. Setup goes as it should on both the device and the laptop, and
> both systems seems to be running smoothly. But my laptop can only
> see the other laptop, and the device doesn't see anyone. The
> wireless net is working and I can ping each device directly if I
> assign IP's to the 'real' interfaces, but through bat0 nothing is
> found. Any idea what is going wrong?

What do you see in /proc/net/batman-adv/originiators on the three
devices?

Is the ARM device running in big endian or little endian mode? 

Any kernel messages? 

You may want to rebuild the modules with debugging enabled, see the
README and then enable it as described in the README.

       Andrew


