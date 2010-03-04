Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 4 Mar 2010 23:35:09 +0800
References: <4B8FBAAA.7060406@tiwoc.de>
	<201003042309.05473.lindner_marek@yahoo.de>
In-Reply-To: <201003042309.05473.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201003042335.09788.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] no need to check for NULL before calling free()
	(was: [PATCH v2] batctl: avoid parsing bat-hosts multiple times)
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

On Thursday 04 March 2010 23:09:05 Marek Lindner wrote:
> I added a small check add the end of the patch to make sure that we don't
> attempt to free a NULL pointer.

Sven just informed me that this is not necessary - free() also accepts a NULL 
pointer. Shockingly I was not aware of that. It seems I'm not the only one 
since even manpages do it wrong (e.g. man 3 getline).  :-)

Cheers,
Marek
