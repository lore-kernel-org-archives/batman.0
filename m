Return-Path: <andrew@lunn.ch>
Date: Wed, 12 May 2010 21:43:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100512194309.GE4946@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<1273177132-8792-14-git-send-email-andrew@lunn.ch>
	<20100506204133.GA19717@kroah.com>
	<201005130119.39204.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005130119.39204.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Greg KH <greg@kroah.com>, gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

> Regarding the question which kernel configuration interface to use,
> we would be more than happy to receive some guidance. At this point
> we are rather unsure which of the many (procfs/sysfs/configfs/etc)
> filesystems are we supposed to go forward with.

Does it even need to be a filesystem? 

cfg80211 uses netlink. 
ifconfig seems to use ioctl calls.

What over APIs are available for passing configuration and tables of
status information back and forth?

Tomorrow is a holiday in the part of the world i live in, and it is
supposed to be raining. Sounds like ideal conditions for doing a bit
of research and then comparing and contrasting our options...

   Andrew

