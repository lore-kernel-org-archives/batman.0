Return-Path: <andrew@lunn.ch>
Date: Wed, 23 Jun 2010 18:18:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100623161818.GO15420@lunn.ch>
References: <201006231620.11058.lindner_marek@yahoo.de>
	<1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
	<20100623152359.GL15420@lunn.ch>
	<201006231803.22675.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201006231803.22675.lindner_marek@yahoo.de>
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

> Sven is in the progress of revising the "ordinary" printks to make them more 
> "kernel-ish". 
> Or do you think that normal kernel hackers would be interested in seeing the 
> routing debug messages in the standard kernel log as well ?

The kernel log is the normal place to expect debug output. I think
most normal kernel people will be surprised to find it is not there,
but somewhere else. It adds very little overhead to keep supporting
the kernel log for normal kernel hackers, so i would keep it. Maybe
have debug values 1 and 2 send debug messages to the kernel, and 256
and 512 to the circular log. Then everybody is happy.

    Andrew
