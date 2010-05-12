Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 13 May 2010 07:25:51 +0800
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005130119.39204.lindner_marek@yahoo.de>
	<20100512173830.GA27912@kroah.com>
In-Reply-To: <20100512173830.GA27912@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005130725.51663.lindner_marek@yahoo.de>
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

On Thursday 13 May 2010 01:38:30 Greg KH wrote:
> Well, it is simple to enable configfs if you need/want batman, right?
> It's not that much extra kernel code.

If you have 4MB flash for the bootloader, bootloader config, kernel, user space 
and some data you don't want to add another filesystem just for batman.
As hardware development moves on, I defintely see more flexibility regarding 
these contraints.

           
> >                 following values:
> >                   1 - originator
> >                   2 - TQ (transmit quality) value of originator
> >                   3 - best next hop towards originator
> >                   4 - outgoing iface to reach best next hop
> >                   5 - list of alternative best next hops
> 
> Sorry, but sysfs is for "one value per file" attributes, which this one
> violates.

Actually, this is a good example for our confusion. For this table I used 
Documentation/ABI/testing/sysfs-block as an example. The very first entry looks 
exactly like ours ...

Thanks for your quick feedback!

Regards,
Marek
