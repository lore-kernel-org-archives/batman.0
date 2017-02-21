Return-Path: <andrew@lunn.ch>
Date: Tue, 21 Feb 2017 17:24:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20170221162435.GC25818@lunn.ch>
References: <33547cb0-a540-e0b9-ffc7-99ac67c3d516@viisauksena.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33547cb0-a540-e0b9-ffc7-99ac67c3d516@viisauksena.de>
Subject: Re: [B.A.T.M.A.N.] Interface limit 127 in bat0?!
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> |Error - can't write to file
> '/sys/class/net/gre127/batman_adv/mesh_iface': Cannot allocate memory|

As the message suggests, you are out of memory. This is not a BATMAN
limit, it is a limit from the amount of RAM you have in your device.

       Andrew
