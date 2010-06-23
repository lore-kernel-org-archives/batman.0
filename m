Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 23 Jun 2010 18:03:22 +0200
References: <201006231620.11058.lindner_marek@yahoo.de>
	<1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
	<20100623152359.GL15420@lunn.ch>
In-Reply-To: <20100623152359.GL15420@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201006231803.22675.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add routing debug log
	accessible via debugfs
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Wednesday 23 June 2010 17:23:59 Andrew Lunn wrote:
> > -		if (bat_debug_type(type))				\
> > -			printk(KERN_DEBUG "batman-adv:" fmt, ## arg);	\
> 
> did you think about keeping this? Maybe use some of the spare bits of
> debug to indicate what goes into the circular buffer and what goes to
> the kernel log?
> 
> I don't see the two schemes are mutually exclusive. "Normal" kernel
> hackers will look in the normal kernel logging places and could be a
> bit surprised when its not there.

Sven is in the progress of revising the "ordinary" printks to make them more 
"kernel-ish". 
Or do you think that normal kernel hackers would be interested in seeing the 
routing debug messages in the standard kernel log as well ?

Regards,
Marek
