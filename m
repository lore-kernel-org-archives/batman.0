Return-Path: <greg@kroah.com>
Date: Thu, 6 May 2010 13:41:33 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100506204133.GA19717@kroah.com>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<1273177132-8792-14-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1273177132-8792-14-git-send-email-andrew@lunn.ch>
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marek Lindner <lindner_marek@yahoo.de>, gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

On Thu, May 06, 2010 at 10:18:39PM +0200, Andrew Lunn wrote:
> From: Marek Lindner <lindner_marek@yahoo.de>
> 
> This is the first patch in a series of patches which aim to convert
> all batman-adv /proc files to sysfs. To keep the changes in a
> digestable size it has been split up into smaller chunks. During
> the transition period batman-adv will use /proc as well as sysfs.
> 
> As a first step the following files have been converted:
> aggregate_ogm, originators, transtable_global, transtable_local

Please document all sysfs files with a Documentation/ABI/ entry.  You
can put it in the drivers/staging/batman-adv/ directory for now.

Also note, binary sysfs files are for things that are "pass-through",
not for things that you try to intrepret like I think you are doing
here.  What's wrong with configfs for something like this?

Note, I still applied the patch :)

thanks,

greg k-h
