Return-Path: <ordex@autistici.org>
Date: Tue, 10 May 2011 08:29:28 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110510062927.GA22075@ritirata.org>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
	<1304946150-6026-1-git-send-email-ordex@autistici.org>
	<20110510050803.GB4416@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110510050803.GB4416@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/3] batman-adv: add wrapper function
 to throw uevent in userspace
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

On mar, mag 10, 2011 at 07:08:03 +0200, Andrew Lunn wrote:
> On Mon, May 09, 2011 at 03:02:28PM +0200, Antonio Quartulli wrote:
> > Using throw_uevent() is now possible to trigger uevent signal that can
> > be recognised in userspace. Uevents will be triggered through the
> > /devices/virtual/net/{MESH_IFACE} kobject.
> 
> Hi Antonio
> 
> Since this is part of sysfs you should add a description to
> Documentation/networking/batman-adv.txt.

Ah ok, I didn't know this.
I think Marek already planned to instruct me on this part. Thank you for
reminding me!

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
