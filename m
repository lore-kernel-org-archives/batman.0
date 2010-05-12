Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 13 May 2010 07:51:05 +0800
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005122056.05476.sven.eckelmann@gmx.de>
	<20100512191720.GB30678@kroah.com>
In-Reply-To: <20100512191720.GB30678@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005130751.06747.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 13/26] staging:batman-adv: convert
	multiple /proc files to use sysfs
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
To: Greg KH <greg@kroah.com>
Cc: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

On Thursday 13 May 2010 03:17:20 Greg KH wrote:
> > This makes invalid entries in sysfs not better, but maybe helps you to
> > get in the correct mood to point us in the right direction.
> 
> I honestly don't care about older kernels, as this is all about merging
> the code into the current kernel version, not older ones :)

In addition to our our efforts of merging the code into the current version we 
offer a backward compatible module (similar to wireless-compat) which also 
works on older kernels. We would very much prefer if everybody simply used the 
latest kernel but the world is not as perfect as we wish it to be. Therefore, 
we always have to look back a bit.


> Yes, that should be quite simple.  The perf code does this today, you
> can just steal their function that handles this.  Almost all distros are
> mounting debugfs these days, so it's not really a big deal.

Debugfs looks like an option.

 
> The others are all single-value files, right?  Or did I miss something?
> If they are single-value files, then yes, they can stay in sysfs, unless
> you feel they are debug-type things, then debugfs is the place for them
> (debugfs makes is trivial to handle single value files, even easier than
> sysfs.)

Well, now that you mention it ..  :-)
Next to the sysfs interface batman creates a file in /dev (/dev/batman-adv at 
the moment) that is used to inject (debug) packets into the mesh from user 
space. Due to our ongoing mesh abstraction effort we would need to create one 
file per virtual mesh which is little bit messy in /dev (although doable). I'd 
like to get it out of there - can/should we move it to debugfs ? The initial 
reason to choose /dev was the ability get the open() and close() syscalls 
because we need to maintain a state for each user.

Regards,
Marek
