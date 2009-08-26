Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 26 Aug 2009 16:51:16 +0800
References: <20090826064151.GE21827@ma.tech.ascom.ch>
	<200908261001.31814.sven.eckelmann@gmx.de>
In-Reply-To: <200908261001.31814.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200908261651.16980.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] List policy for none subscribers
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Wednesday 26 August 2009 16:01:27 Sven Eckelmann wrote:
> It is the name of the protocol and it doesn't make sense to have two
> complete different B.A.T.M.A.N. things with the exact name hanging around.
> One in the mainline kernel and one in here for layer 3 stuff. I have also
> personally a problem with the algorithm and the layer 3 protocol having the
> same name - but with completely different version numbering scheme.

You are right - the situation still is a bit messy. I think Andrew has a point 
saying that "adv" might be rejected. I even could imagine that the name 
"batman" causes some irritation. ;-)

A while back Justin Dean suggested a new name for the protocol:
stateless proactive adhoc networking protocol
Does not sound too bad in my opinion. Other opinions ?


> To the wiki stuff. The policy was long time correct if I remember it
> correct (send my first stuff without being subscribed). Maybe it was
> accidentally changed when the administrator upgraded the mailing list/mail
> stuff.

Yes, it was configured as described in the wiki but nobody was checking the 
moderator requests which made the problem worse as some people thought their 
mail will be handled at some point. Instead they were hanging there forever.
I just forgot to adjust the wiki.


> > Should /proc/net/batman-adv/interface be replaced with an IOCTL interface
> > similar to brctl?
>
> How to design the kernel<->userspace interface that it doesn't end like
> wireless-tools?

I'm not so familiar with the iwconfig situation you seem to refer to. Could you 
outline the issues ?


> I found also some other things and also told that Marek - but I think that
> not everything was included in the patch I send some weeks ago. Maybe it
> was only to break printk statements to fit in 80 chars per line, but I am
> not sure right now.

Yes, you found a way to break a long string into smaller pieces although I 
can't quite remember how you did it.  ;-)


> And as my position as random guy I want to thank you for contacting Greg
> G-K

Thanks from me as well! 

Regards,
Marek
