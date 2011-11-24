Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 24 Nov 2011 21:18:47 +0800
References: <1322131238-11036-1-git-send-email-sven@narfation.org>
	<201111242101.21710.lindner_marek@yahoo.de>
In-Reply-To: <201111242101.21710.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111242118.47604.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Move build compat stuff to
	Makefile
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

On Thursday, November 24, 2011 21:01:21 Marek Lindner wrote:
> > I looked at the new patches from ordex and thought about using the
> > Makefile from the kernel as the Makefile.kbuild in the standalone
> > distribution. The Makefile is only the user friendly compatibility layer
> > over the kbuild stuff.
> 
> I thought the main idea behind this separation was to have one Makefile for
> the kernel folks and one for the out-of-tree users ? Are they going to
> accept a single Makefile which contains more than what is needed for
> in-kernel development ?

sorry, I misread your intentions - then I discovered the patch at the end. Let 
me try this on OpenWrt.

Regards,
Marek
