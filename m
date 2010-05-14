Return-Path: <greg@kroah.com>
Date: Fri, 14 May 2010 09:10:01 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100514161001.GA29463@kroah.com>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005122056.05476.sven.eckelmann@gmx.de>
	<20100512191720.GB30678@kroah.com>
	<201005130751.06747.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005130751.06747.lindner_marek@yahoo.de>
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

On Thu, May 13, 2010 at 07:51:05AM +0800, Marek Lindner wrote:
> > The others are all single-value files, right?  Or did I miss something?
> > If they are single-value files, then yes, they can stay in sysfs, unless
> > you feel they are debug-type things, then debugfs is the place for them
> > (debugfs makes is trivial to handle single value files, even easier than
> > sysfs.)
> 
> Well, now that you mention it ..  :-)
> Next to the sysfs interface batman creates a file in /dev (/dev/batman-adv at 
> the moment) that is used to inject (debug) packets into the mesh from user 
> space. Due to our ongoing mesh abstraction effort we would need to create one 
> file per virtual mesh which is little bit messy in /dev (although doable). I'd 
> like to get it out of there - can/should we move it to debugfs ? The initial 
> reason to choose /dev was the ability get the open() and close() syscalls 
> because we need to maintain a state for each user.

Yes, that sounds like debugfs might work for you there.

Just remember the one rule of debugfs:
	There are no rules for debugfs

If you are ok with that, then by all means, use it :)

thanks,

greg k-h
