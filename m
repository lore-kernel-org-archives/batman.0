Return-Path: <andrew.lunn@ascom.ch>
Date: Wed, 26 Aug 2009 08:49:54 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090826064954.GG21827@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Getting batman into staging
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Hi Folks

Here is the email i sent to Greg KH about getting into staging

     Andrew

----------------------------------------------------------------------

> Hi Greg
>
> I've decided to take on the challenge of getting batman-advanced into
> mainline. This is a challenge since as to date all i've had committed
> to mainline are a few USB querks for devices i happen to have.
>
> B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is a
> routing protocol for multi-hop ad-hoc mesh networks. It can be used
> over wireless and wired links. Batman is used for example in Berlin to
> provide their "Freifunknetzes", free wireless network, and in many
> other cities.
>
> The project website can be found at:
>
> http://www.open-mesh.org/
>
> My first question would be is this something that can go into
> staging?  It is not a device driver or a filesystem which seems to
> be the major usage for staging. The only exception i found to this
> is the openPOWERLINK protocol stack. Batman layers on top of the
> wireless and wired network devices, exporting a virtual network
> device for accessing the resulting mesh.  The nice thing about
> batman is that it is completely contained. It does not need any
> patches anywhere else, which does fit with the staging model.
>
> The source code is currently in a subversion repository:
>
> http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland/
>
> I also have a list of things which i think need doing:
>
> Finish stripping out debug_log.
>
> Make batctl, the user space configuration tool, standalone.
>
> Maybe make batctl _The_ tool for configuration and status and
> depreciate direct /proc access, so that we can restructure it without
> too much pain for users.
>
> Take out the dot_draw/josm formatting in /proc/net/batman-adv/vis and
> put it into userspace as part of batctl.
>
> Think if /proc/net/batman-adv should be renamed /proc/net/bat0 giving
> the option of /proc/net/bat1 etc in the future?
>
> Should /proc/net/batman-adv/interface be replaced with an IOCTL interface
> similar to brctl?
>
> Maybe move orig_interval, aggregate_ogm and write half of vis to
> /sys/class/batman/bat0/?
>
> Investigate if there is a generic linux hash algorithm which should be used?
>
> Strip out all backward compatibility support to older kernels.
>
> Make use of printk %pM support.
>
> The code is however sparse clean and checkpatch only complains about a
> few lines being longer than 80 characters. Most of these are printk
> like statements.
>
> My second question would be when is the right time to get into
> staging? 
>
> Should i work on all these issues first? Or can it go into staging
> with some of these issues in a TODO file, to be joined by new issues
> as the code is reviewed by more experts?

