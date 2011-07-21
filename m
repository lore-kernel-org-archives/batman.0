Return-Path: <andrew@lunn.ch>
Date: Thu, 21 Jul 2011 12:20:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110721102000.GA9313@lunn.ch>
References: <CA+qXHzNUGtLUpFqOmvKge05wLYyyoCpkTJG4HKwkd+Zzv81hYQ@mail.gmail.com>
	<2942004.kRGEbDgGH5@sven-laptop.home.narfation.org>
	<CA+qXHzN2x3CL7aH7T-OJKEE0tfs7kgOVoqtUpNZJyecrywRJWg@mail.gmail.com>
	<8523816.3y33SjpCxy@sven-laptop.home.narfation.org>
	<CA+qXHzOAVeGYcnqjz_=goW2Yzc+oJ5y1GpAYDcH8EeGZssL=wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+qXHzOAVeGYcnqjz_=goW2Yzc+oJ5y1GpAYDcH8EeGZssL=wA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Filtering BATMAN-ADV packet
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

On Thu, Jul 21, 2011 at 05:14:28PM +0800, Nik M. Anas Kamarudin wrote:
> AP mode? Sry, forget to tell, i using in ad-hoc mode. Maybe i explain
> more. I try to test batman-adv in MANET. In order to doing that, i
> need to make a scenario that have changing in topology. That why i
> need to filter some batman-adv packet, if not i need to move the node
> myself in and out of wireless range.  So, anyone have any idea how to
> filter batman-adv packet?

Hi Nik

You might want to consider using a network simulator/emulator. Use a
number of user mode linux nodes, or qemu nodes, connected together
using a virtual network. You can control the packets losses, paths
etc, much easier and dynamically.

Take a look at this page for an example:

http://www.open-mesh.org/wiki/open-mesh/Emulation

	Andrew
