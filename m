Return-Path: <post@tiwoc.de>
Message-ID: <4B8FBA40.3070806@tiwoc.de>
Date: Thu, 04 Mar 2010 14:48:48 +0100
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <4B8FA639.5000502@tiwoc.de>
	<201003042049.25362.lindner_marek@yahoo.de>
In-Reply-To: <201003042049.25362.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: avoid parsing bat-hosts multiple
 times
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

Marek Lindner schrieb:
> However, I wonder whether it would be better to let realpath() allocate the 
> normalized file path buffer instead of using the static normalized array, simply 
> to save some disk space. What do you think ?

Yes, would be better; I didn't think about this issue. I'll send an
updated patch in a few seconds.

Regards,
Daniel
